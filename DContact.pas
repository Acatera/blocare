unit DContact;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, CheckLst, DBTables;

type
  TContact = class(TForm)
    EDenFC: TLabeledEdit;
    EAdr: TLabeledEdit;
    EEMail: TLabeledEdit;
    EFax: TLabeledEdit;
    ETel: TLabeledEdit;
    Title: TLabel;
    LStare: TLabel;
    STARE: TShape;
    LModule: TLabel;
    LDenfur: TLabel;
    Btn_Salvare: TButton;
    Btn_Renunta: TButton;
    CModule: TCheckListBox;
    procedure CModuleKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure Btn_RenuntaClick(Sender: TObject);
    procedure Btn_SalvareClick(Sender: TObject);
    function Start(CodFur: string; DenFur: string; ID: string; Stare: string; Module: integer): integer;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure EditEnter(Sender: TObject);
    procedure EEMailKeyPress(Sender: TObject; var Key: Char);
    procedure EditKeyPress(Sender: TObject; var Key: Char);
    procedure ExitExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Contact: TContact;
  CodFC: string;
  DenFC: string;
  sID: string;
  Blocat: string;
  iModule: integer;
  iStare: integer;
  CQuery: TQuery;


implementation

uses FMain, Dialog;

{$R *.dfm}

function TContact.Start(CodFur: string; DenFur: string; ID: string; Stare: string; Module: integer): integer;
begin
  Contact := TContact.Create(Application);
  CodFC := CodFur;
  DenFC := DenFur;
  sID := ID;
  Blocat := Stare;
  iModule := Module;
  Contact.ShowModal;
  Contact.Free;
end;

procedure TContact.Btn_SalvareClick(Sender: TObject);
var
  I: Integer;
  iAux: integer;
begin
  iAux := 0;
  for I := 0 to CModule.Items.Count - 1 do
    if CModule.Checked[I] = True then
      iAux := iAux + 1 shl StrToInt(Copy(CModule.Items[I], Pos('|', CModule.Items[I]) + 1));
  if iStare = 1 then begin
    CQuery.SQL.Text := 'UPDATE `DBCABCONTA`.`CONTACT` SET ' +
                       'CODFC = "' + CodFC +
                       '", DENFC = "' + EDenFC.Text +
                       '", ADR = "' + EAdr.Text +
                       '", EMAIL = "' + EEMail.Text +
                       '", TEL = "' + ETel.Text +
                       '", FAX = "' + EFax.Text +
                       '", CODCONTRACTE = ' + IntToStr(iAux) + ' WHERE ID = ' + sID;
  end else begin
    CQuery.SQL.Text := 'INSERT INTO `DBCABCONTA`.`CONTACT` (CODFC, DENFC, ADR, EMAIL, TEL, FAX, CODCONTRACTE) VALUES ("' +
                       CodFC + '", "' +
                       EDenFC.Text + '", "' +
                       EAdr.Text + '", "' +
                       EEMail.Text + '", "' +
                       ETel.Text + '", "' +
                       EFax.Text + '", ' + IntToStr(iAux) + ')';
  end;
  CQuery.ExecSQL;
  Close;
end;

procedure TContact.Btn_RenuntaClick(Sender: TObject);
begin
  Close;
end;

procedure TContact.CModuleKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = ' ' then CModule.ItemIndex := CModule.ItemIndex + 1;
end;

procedure TContact.EEMailKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then SelectNext(TEdit(Sender), True, True)
  else
    Key := LowerCase(Key)[1];
end;

procedure TContact.ExitExit(Sender: TObject);
begin
  (Sender as TLabeledEdit).Color := clWindow;
  if (Sender as TLabeledEdit).Name = 'EEMail' then begin
    if (Sender as TLabeledEdit).Text <> '' then
      if (Pos('@', (Sender as TLabeledEdit).Text) <= 0) or (Pos('.', (Sender as TLabeledEdit).Text) <= 0) then begin
        FDialog.Start('Atentie', 'Adresa e-mail necorespunzatoare!' + #13 + 'Daca nu doriti e-mail la acest contact lasati campul gol', fdOk, mtWarning);
        EEMail.SetFocus;
      end;
  end;
end;

procedure TContact.EditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then SelectNext(TEdit(Sender), True, True)
  else
    Key := UpCase(Key)
end;

procedure TContact.EditEnter(Sender: TObject);
begin
  (Sender as TLabeledEdit).Color := clSkyBlue;
end;

procedure TContact.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then Close;
end;

procedure TContact.FormShow(Sender: TObject);
var
  I: Integer;
  iAux: Integer;
  ContactModule: integer;
  J: Integer;
begin
  CQuery := TQuery.Create(Contact);
  CQuery.DatabaseName := MainForm.DB.DatabaseName;
  iStare := 0;
  if sID <> '' then begin
    iStare := 1;
    Title.Caption := 'Modificare contact';
  end;
  LDenfur.Caption :=  DenFC;
  if Blocat = 'B' then begin
    STARE.Brush.Color := clRed;
    STARE.Hint := 'Client blocat';
  end;
  if iStare = 1 then begin //Modificare
    CQuery.SQL.Text := 'SELECT * FROM `DBCABCONTA`.`CONTACT` WHERE ID = ' + sID;
    CQuery.Open;
    with CQuery do begin
      EDenFC.Text := FieldByName('DENFC').AsString;
      EAdr.Text := FieldByName('ADR').AsString;
      EEMail.Text := FieldByName('EMAIL').AsString;
      ETel.Text := FieldByName('TEL').AsString;
      EFax.Text := FieldByName('FAX').AsString;
      ContactModule := FieldByName('CODCONTRACTE').AsInteger;
    end;
    for I := 1 to 9 do
      if iModule and (1 shl I) <> (1 shl I) then CModule.Checked[I - 1] := True;
    iAux := 0;
    for I := 0 to 8 do
      if CModule.Checked[iAux] = True then CModule.Items.Delete(iAux)
      else Inc(iAux);
    for I := 0 to 8 do
      if ContactModule and (1 shl I) = (1 shl I) then
        for J := 0 to CModule.Items.Count - 1 do
          if Pos(IntToStr(I), CModule.Items[J]) > 0 then CModule.Checked[J] := True;
         

  end else begin //Adaugare
    for I := 1 to 9 do
      if iModule and (1 shl I) <> (1 shl I) then CModule.Checked[I - 1] := True;
    iAux := 0;
    for I := 0 to 8 do
      if CModule.Checked[iAux] = True then CModule.Items.Delete(iAux)
      else Inc(iAux);
  end;
  Color := MainForm.Color;
end;

end.
