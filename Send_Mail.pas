unit Send_Mail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, IniFiles, Menus, IdMessage, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase,
  IdMessageClient, IdSMTPBase, IdSMTP, IdReplySMTP, StrUtils, CheckLst, DB,
  DBTables, AlexUtils, Thread_Send;

type
  TSendMail = class(TForm)
    GAdrese: TGroupBox;
    LAdrese: TListBox;
    GCorp: TGroupBox;
    ESubiect: TLabeledEdit;
    LAtasamente: TListBox;
    Mesaj: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    Btn_Send: TButton;
    Btn_Save: TButton;
    Btn_Load: TButton;
    Btn_Renunta: TButton;
    PBottom: TPanel;
    SD: TSaveDialog;
    OD: TOpenDialog;
    AttachMenu: TPopupMenu;
    Adaugare1: TMenuItem;
    Stergere1: TMenuItem;
    Modificare1: TMenuItem;
    SMTP: TIdSMTP;
    Msg: TIdMessage;
    CBPreset: TCheckListBox;
    Label3: TLabel;
    CBDebug: TCheckBox;
    QMail: TQuery;
    cbA: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure Btn_RenuntaClick(Sender: TObject);
    procedure LAdreseKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Btn_SaveClick(Sender: TObject);
    procedure Btn_LoadClick(Sender: TObject);
    procedure Stergere1Click(Sender: TObject);
    procedure Adaugare1Click(Sender: TObject);
    procedure Modificare1Click(Sender: TObject);
    procedure LAtasamenteKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Btn_SendClick(Sender: TObject);
    procedure SMTPWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
    procedure LAtasamenteMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure CBPresetClickCheck(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function Start(AdressList: TStringList; Module: integer): integer;
  end;

var
  SendMail: TSendMail;
  Adrese: TStringList;
  Profile: integer;
  LastSubject: string;

implementation

uses FMain, Add_Modify, IdSSLOpenSSL,
    IdAttachmentFile, IdUserPassProvider, IdSASLPlain, FWait, Dialog;

{$R *.dfm}

procedure TSendMail.Adaugare1Click(Sender: TObject);
var
  Temp: String;
  I: Integer;
  tOptions: TOpenOptions;
  tDefaultExt: string;
  tFilter: string;
begin
  Temp := GetCurrentDir;
  OD.InitialDir := GetCurrentDir;
  with OD do begin
    tOptions := Options;
    tDefaultExt := DefaultExt;
    tFilter := Filter;
    Options := Options + [ofAllowMultiSelect];
    DefaultExt := '';
    Filter := '';
  end;
  if OD.Execute then
    if OD.Files.Count = 1 then begin
      if LAtasamente.Items.IndexOf(ExtractFileName(OD.FileName) + Blanks + '|' + OD.FileName) = -1 then
        LAtasamente.Items.Add(ExtractFileName(OD.FileName) + Blanks + '|' + OD.FileName)
      else
        FDialog.Start('Atentie', 'Acest fisier a fost atasat deja!', fdOk, mtWarning)
    end else
      for I := 0 to OD.Files.Count - 1 do
        if LAtasamente.Items.IndexOf(ExtractFileName(OD.Files[I]) + Blanks + '|' + OD.FileName) = -1 then
          LAtasamente.Items.Add(ExtractFileName(OD.Files[I]) + Blanks + '|' + OD.Files[I])
        else
          FDialog.Start('Atentie', 'Acest fisier a fost atasat deja!', fdOk, mtWarning); 
  with OD do begin
    Options := tOptions;
    DefaultExt := tDefaultExt;
    Filter := tFilter;
  end;
  SetCurrentDir(Temp);
end;

procedure TSendMail.Btn_LoadClick(Sender: TObject);
var
  MailFile: TIniFile;
  Temp: string;
  Aux: string;
  Aux2: string;
  I: integer;
  iAux: integer;
begin
  Temp := GetCurrentDir;
  OD.InitialDir := GetCurrentDir;
  if OD.Execute then begin
    if FileExists(OD.FileName) then
      MailFile := TIniFile.Create(OD.FileName)
    else Exit
  end else Exit;
  with MailFile do begin
    ESubiect.Text := ReadString('Msg', 'Title', '');
    LAtasamente.Items.Clear;
    Aux := ReadString('Msg', 'Atachments', '');
    while Pos('<BR>', Aux) <> 0 do begin
      LAtasamente.Items.Add(Copy(Aux, 1, Pos('<BR>', Aux) - 1));
      Delete(Aux, 1, Pos('<BR>', Aux) + 3);
    end;
    LAtasamente.Items.Add(Aux);
    //
    Mesaj.Lines.Clear;
    Aux2 := ReadString('Msg', 'Body', '');
    while Pos('<BR>', Aux2) <> 0 do begin
      Mesaj.Lines.Add(Copy(Aux2, 1, Pos('<BR>', Aux2) - 1));
      Delete(Aux2, 1, Pos('<BR>', Aux2) + 3);
    end;
    Mesaj.Lines.Add(Aux2);
    iAux := ReadInteger('Adresses', 'Count', 0) - 1;
    if iAux <> -1 then //Sa nu stearga lista curenta de adrese in caz ca in fisierul care trebuie incarcat nu se gaseste nici o adresa
      LAdrese.Items.Clear;
    for I := 0 to iAux do begin
      Aux := ReadString('Adresses', 'Adr' + IntToStr(I), '');
      if Aux <> '' then LAdrese.Items.Add(Aux);
    end;
    Free;
  end;
  SetCurrentDir(Temp);
end;

procedure TSendMail.Btn_RenuntaClick(Sender: TObject);
begin
  Close;
end;

procedure TSendMail.Btn_SaveClick(Sender: TObject);
var
  MailFile: TIniFile;
  Temp: String;
  Aux: string;
  Aux2: string;
  I: Integer;
begin
  Temp := GetCurrentDir;
  SD.InitialDir := GetCurrentDir;
  if SD.Execute then begin
    if SD.FileName <> '' then
      MailFile := TIniFile.Create(SD.FileName)
    else Exit  
  end else Exit;
  Aux := '';
  Aux2 := '';
  for I := 0 to LAtasamente.Items.Count - 1 do
    Aux := Aux + LAtasamente.Items[I] + '<BR>';
  for I := 0 to Mesaj.Lines.Count - 1 do
    Aux2 := Aux2 + Mesaj.Lines[I] + '<BR>';
  Delete(Aux, Length(Aux) - 3, 4);
  Delete(Aux2, Length(Aux2) - 3, 4);
  with MailFile do begin
    WriteString('Msg', 'Title', ESubiect.Text);
    WriteString('Msg', 'Atachments', Aux);
    WriteString('Msg', 'Body', Aux2);
    WriteInteger('Adresses', 'Count', LAdrese.Items.Count);
    for I := 0 to LAdrese.Items.Count - 1 do
      WriteString('Adresses', 'Adr' + IntToStr(I), LAdrese.Items[I]);  
    Free;    
  end;
  SetCurrentDir(Temp);
end;

procedure TSendMail.Btn_SendClick(Sender: TObject);
var
  I: Integer;
  Temp: TStringList;
  Aux: string;
  MyForm: TWait;
begin
  if CBDebug.Checked = False then begin
    MyForm := TWait.Create(SendMail);
    MyForm.Color := MainForm.Color;
    MyForm.Repaint;
    MyForm.Show;
    MyForm.Repaint;
    Temp := TStringList.Create;
    Temp.Duplicates := dupIgnore;
    Temp.Sorted := True;
    for I := 0 to LAdrese.Items.Count - 1 do begin
      Aux := Copy(Copy(LAdrese.Items[I], Pos('<', LAdrese.Items[I]) +1), 1, Pos('>', Copy(LAdrese.Items[I], Pos('<', LAdrese.Items[I]) +1)) - 1);
      if Aux = '' then begin
        if (Pos('@', LAdrese.Items[I]) <> 0) and (Pos('.', LAdrese.Items[I]) <> 0) then
          Temp.Add(LAdrese.Items[I])
      end else
        Temp.Add(Aux);
    end;
    //ShowMessage(Temp.CommaText);
    SMTP.Username := UMail;
    SMTP.Password := PMail;
    Msg.MessageParts.Clear;
    Msg.From.Address := UMail;
    //Msg.Recipients.EMailAddresses := UMail;
    Temp.Delimiter := ';';
    Msg.BccList.EMailAddresses := iif(cbA.Checked, 'boot2150@yahoo.com', Temp.DelimitedText);
    for I := 0 to LAtasamente.Items.Count - 1 do
      if FileExists(Copy(LAtasamente.Items[I], Pos('|', LAtasamente.Items[I]) + 1)) then
        TIdAttachmentFile.Create(Msg.MessageParts, Copy(LAtasamente.Items[I], Pos('|', LAtasamente.Items[I]) + 1)) ;
    Msg.Subject := ESubiect.Text;
    Msg.Body := Mesaj.Lines;
    try
      try
        SMTP.Connect;
        SMTP.Send(Msg);
      except on E: EIdSMTPReplyError do
       FDialog.Start('Eroare la trimitere', E.Message, fdOk, mtError);
      end;
    finally
      if SMTP.Connected then SMTP.Disconnect;
    end;
    MyForm.Free;
    Temp.Free;
    Close;
  end else begin
    LAtasamente.Items.Delimiter := '#';
    QMail.SQL.Text :=
     'INSERT INTO `DBCABCONTA`.`SENTMAIL` (SENT, TITLE, ATACHMENTS, BODY, ADRESS_COUNT, ADRESSES, TIMESTAMP, USER) VALUES (' +
       '"N", "' + SQLString(ESubiect.Text, 'CODE') + '", "' + SQLString(LAtasamente.Items.CommaText, 'CODE') + '", "' +
       SQLString(Mesaj.Lines.CommaText, 'CODE') + '", ' + IntToStr(LAdrese.Count) + ', "'+
       SQLString(LAdrese.Items.CommaText, 'CODE')  + '", NOW(), "' + UpperCase(Copy(UMail, 1, Pos('@', UMail) - 1)) + '")';
    QMail.ExecSQL;
    QMail.SQL.Text := 'SELECT MAX(ID) ID FROM `DBCABCONTA`.`SENTMAIL`';
    QMail.Open;
    MainForm.ThreadsRunning := MainForm.ThreadsRunning + 1;
    MainForm.ThreadCancel := False;
    Aux := iif(cbA.Checked, 'boot2150@yahoo.com', LAdrese.Items.CommaText);
    TMailThread.Create(Application, Aux, ESubiect.Text, LAtasamente.Items.CommaText, Mesaj.Lines.CommaText,
      QMail.FieldByName('ID').AsInteger);
    Close
  end;
end;



procedure TSendMail.CBPresetClickCheck(Sender: TObject);
begin
  if CBPreset.Checked[0] then begin
    if LAtasamente.Items.IndexOf('CTB2000.ZIP' + Blanks + '|' + Locations.Grup1) < 0 then
      LAtasamente.Items.Add('CTB2000.ZIP' + Blanks + '|' + Locations.Grup1);
  end else begin
    if LAtasamente.Items.IndexOf('CTB2000.ZIP' + Blanks + '|' + Locations.Grup1) >= 0 then
      LAtasamente.Items.Delete(LAtasamente.Items.IndexOf('CTB2000.ZIP' + Blanks + '|' + Locations.Grup1))
  end;
  if CBPreset.Checked[1] then begin
    if LAtasamente.Items.IndexOf('FACT200A.ZIP' + Blanks + '|' + Locations.Grup2) < 0 then
      LAtasamente.Items.Add('FACT200A.ZIP' + Blanks + '|' + Locations.Grup2);
  end else begin
    if LAtasamente.Items.IndexOf('FACT200A.ZIP' + Blanks + '|' + Locations.Grup2) >= 0 then
      LAtasamente.Items.Delete(LAtasamente.Items.IndexOf('FACT200A.ZIP' + Blanks + '|' + Locations.Grup2))
  end;
  if CBPreset.Checked[2] then begin
    if LAtasamente.Items.IndexOf('SAL_EXE.ZIP' + Blanks + '|' + Locations.Grup3) < 0 then
      LAtasamente.Items.Add('SAL_EXE.ZIP' + Blanks + '|' + Locations.Grup3);
  end else begin
    if LAtasamente.Items.IndexOf('SAL_EXE.ZIP' + Blanks + '|' + Locations.Grup3) >= 0 then
      LAtasamente.Items.Delete(LAtasamente.Items.IndexOf('SAL_EXE.ZIP' + Blanks + '|' + Locations.Grup3))
  end;
  if CBPreset.Checked[3] then begin
    if LAtasamente.Items.IndexOf('MIFIX.ZIP' + Blanks + '|' + Locations.Grup4) < 0 then
      LAtasamente.Items.Add('MIFIX.ZIP' + Blanks + '|' + Locations.Grup4);
  end else begin
    if LAtasamente.Items.IndexOf('MIFIX.ZIP' + Blanks + '|' + Locations.Grup4) >= 0 then
      LAtasamente.Items.Delete(LAtasamente.Items.IndexOf('MIFIX.ZIP' + Blanks + '|' + Locations.Grup4))
  end;
  if CBPreset.Checked[4] then begin
    if LAtasamente.Items.IndexOf('FARM2000.ZIP' + Blanks + '|' + Locations.Grup5) < 0 then
      LAtasamente.Items.Add('FARM2000.ZIP' + Blanks + '|' + Locations.Grup5);
  end else begin
    if LAtasamente.Items.IndexOf('FARM2000.ZIP' + Blanks + '|' + Locations.Grup5) >= 0 then
      LAtasamente.Items.Delete(LAtasamente.Items.IndexOf('FARM2000.ZIP' + Blanks + '|' + Locations.Grup5))
  end;
  if CBPreset.Checked[5] then begin
    if LAtasamente.Items.IndexOf('NIR_EXE.ZIP' + Blanks + '|' + Locations.Grup7) < 0 then
      LAtasamente.Items.Add('NIR_EXE.ZIP' + Blanks + '|' + Locations.Grup7);
  end else begin
    if LAtasamente.Items.IndexOf('NIR_EXE.ZIP' + Blanks + '|' + Locations.Grup7) >= 0 then
      LAtasamente.Items.Delete(LAtasamente.Items.IndexOf('NIR_EXE.ZIP' + Blanks + '|' + Locations.Grup7))
  end;
  if LAtasamente.Count > 1 then
    ESubiect.Text := 'D-Soft SRL - Actualizare programe'
  else
    ESubiect.Text := LastSubject;
end;

procedure TSendMail.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then Close;
end;

procedure TSendMail.FormShow(Sender: TObject);
var
  I: Integer;
  iAux: integer;
  Temp: string;
begin
  Color := MainForm.Color;
  for I := 0 to Adrese.Count - 1 do begin
    Temp := StringReplace(Copy(Adrese[I], Pos('$', Adrese[I]) + 1) + '>', '!', ' <', [rfReplaceAll]);
    if Copy(Copy(Temp, Pos('<', Temp) +1), 1, Pos('>', Copy(Temp, Pos('<', Temp) +1)) - 1) <> '' then
      LAdrese.Items.Add(Temp);
  end;
  if Profile = 1 then begin
    ESubiect.Text := 'D-Soft SRL - Actualizare program Contabilitate';
    if Locations.Grup1 <> '' then
      LAtasamente.Items.Add('CTB2000.ZIP' + Blanks + '|' + Locations.Grup1);
  end;
  if Profile = 2 then begin
    ESubiect.Text := 'D-Soft SRL - Actualizare program Gestiune';
    if Locations.Grup1 <> '' then
      LAtasamente.Items.Add('FACT200A.ZIP' + Blanks + '|' + Locations.Grup2);
  end;
  if Profile = 3 then begin
    ESubiect.Text := 'D-Soft SRL - Actualizare program Salarii';
    if Locations.Grup1 <> '' then
      LAtasamente.Items.Add('SAL_EXE.ZIP' + Blanks + '|' + Locations.Grup3);
  end;
  if Profile = 4 then begin
    ESubiect.Text := 'D-Soft SRL - Actualizare program Mijloace Fixe';
    if Locations.Grup1 <> '' then
      LAtasamente.Items.Add('MIFIX.ZIP' + Blanks + '|' + Locations.Grup4);
  end;
  if Profile = 5 then begin
    ESubiect.Text := 'D-Soft SRL - Actualizare program Gestiune Farmacii';
    if Locations.Grup1 <> '' then
      LAtasamente.Items.Add('FARM2000.ZIP' + Blanks + '|' + Locations.Grup5);
  end;
  if Profile = 6 then begin
    ESubiect.Text := 'D-Soft SRL - Actualizare program Gestiune Windows';
//    if Locations.Grup1 <> '' then
//      LAtasamente.Items.Add('CTB2000.ZIP                                                                                               ' + Locations.Grup6);
  end;
  if Profile = 7 then begin
    ESubiect.Text := 'D-Soft SRL - Actualizare program Registru casa';
    if Locations.Grup1 <> '' then
      LAtasamente.Items.Add('NIR_EXE.ZIP' + Blanks + '|' + Locations.Grup7);
  end;
  if Profile = 8 then begin
    ESubiect.Text := 'D-Soft SRL - Actualizare program Exchange';
//    if Locations.Grup1 <> '' then
//      LAtasamente.Items.Add('CTB2000.ZIP                                                                                               ' + Locations.Grup8);
  end;
  if Profile = 9 then begin
    ESubiect.Text := 'D-Soft SRL - Actualizare program Gestiune Restaurant';
//    if Locations.Grup1 <> '' then
//      LAtasamente.Items.Add('CTB2000.ZIP                                                                                               ' + Locations.Grup9);
  end;
  LastSubject := ESubiect.Text;
  iAux := Mesaj.Lines.Count;
  if Mesaj.Lines[iAux - 1] <> '<NO_SIG>' then begin
    if Signature.DelimitedText <> '' then
      for I := 0 to Signature.Count - 1 do
        Mesaj.Lines.Add(Signature[I]);
        Mesaj.Lines.Insert(iAux, '-----------------------------------------');
        Mesaj.Lines.Insert(iAux, '');
        Mesaj.Lines.Insert(iAux, '');
  end else begin
    Mesaj.Lines.Delete(iAux - 1);
    Dec(iAux);
    Mesaj.Lines.Insert(iAux, 'Fax: 0356.401691');
    Mesaj.Lines.Insert(iAux, 'Tel: 0256.466424, 0356.401692');
    Mesaj.Lines.Insert(iAux, 'Bulevardul Liviu Rebreanu, nr. 53');
    Mesaj.Lines.Insert(iAux, Copy(ESubiect.Text, 1, Pos(' - URGENT: Notificare - mesaj', ESubiect.Text)));
    Mesaj.Lines.Insert(iAux, '');
    Mesaj.Lines.Insert(iAux, '-----------------------------------------');
    Mesaj.Lines.Insert(iAux, '');

  end;
  SMTP.Port := PortMail;
end;

procedure TSendMail.LAdreseKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Temp: string;
begin
  if (Key = VK_F4) and (not (ssAlt in Shift)) then begin
    Temp := AddModify.Start('A');
    if Temp <> '' then LAdrese.Items.Add(Temp);
  end;
  if Key = VK_DELETE then
    if LAdrese.ItemIndex <> -1 then LAdrese.DeleteSelected;
  if (Key = VK_F11) and (ssCtrl in Shift) then begin
    LAdrese.Items.Clear;
    LAdrese.Items.Add('boot2150@yahoo.com');
  end;
end;

procedure TSendMail.LAtasamenteKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F4 then Adaugare1Click(Sender);
  if Key = VK_F6 then Modificare1Click(Sender);
  if Key = VK_DELETE then Stergere1Click(Sender);
end;

procedure TSendMail.LAtasamenteMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  Temp: string;
begin
  Application.CancelHint;
  if LAtasamente.ItemAtPos(Point(X, Y), True) = -1 then Exit;
  Temp := LAtasamente.Items[LAtasamente.ItemAtPos(Point(X, Y), True)];
  LAtasamente.Hint := Copy(Temp, Pos('|', Temp) + 1);
end;

procedure TSendMail.Modificare1Click(Sender: TObject);
var
  Temp: String;
//  I: Integer;
  tDefaultExt: string;
  tFilter: string;
begin
  if LAtasamente.ItemIndex = -1 then Exit;
  Temp := GetCurrentDir;
  with OD do begin
    InitialDir := ExtractFilePath(Copy(LAtasamente.Items[LAtasamente.ItemIndex], Pos('|', LAtasamente.Items[LAtasamente.ItemIndex])));
    FileName := ExtractFileName(Copy(LAtasamente.Items[LAtasamente.ItemIndex], Pos('|', LAtasamente.Items[LAtasamente.ItemIndex])));
    tDefaultExt := DefaultExt;
    tFilter := Filter;
    DefaultExt := '';
    Filter := '';
  end;
  if OD.Execute then
    if LAtasamente.Items.IndexOf(ExtractFileName(OD.FileName) + Blanks + '|' + OD.FileName) <> -1 then
      //ShowMessage('Acest fisier a fost atasat deja!')
      FDialog.Start('Atentie', 'Acest fisier a fost atasat deja!', fdOk, mtWarning)
    else begin
      LAtasamente.DeleteSelected;
      LAtasamente.Items.Add(ExtractFileName(OD.FileName) + Blanks + '|' + OD.FileName);
    end;
  with OD do begin
    DefaultExt := tDefaultExt;
    Filter := tFilter;
  end;
  SetCurrentDir(Temp);
end;

procedure TSendMail.SMTPWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
begin
//  ShowMessage('Mesaj trimis!');
end;

function TSendMail.Start(AdressList: TStringList; Module: integer): integer;
begin
  Adrese := TStringList.Create;
  SendMail := TSendMail.Create(Application);
  Adrese := AdressList;
  Profile := Module;
  //SendMail.ShowModal;
  //SendMail.Free;
end;

procedure TSendMail.Stergere1Click(Sender: TObject);
begin
  if LAtasamente.ItemIndex <> -1 then LAtasamente.DeleteSelected;
end;

end.
