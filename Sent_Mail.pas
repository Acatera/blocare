unit Sent_Mail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, Grids, DBGrids, StdCtrls, ComCtrls, RbDrawCore,
  RbProgressBar, AlexUtils, PNGImage, ExtCtrls, ImgList, Menus;

type
  THDbGrid = class(TDBGrid);
  TSentMail = class(TForm)
    DS: TDataSource;
    DBMail: TDBGrid;
    QMail: TQuery;
    Label2: TLabel;
    Label3: TLabel;
    Status: TStatusBar;
    PBar: TRbProgressBar;
    pMenu: TPopupMenu;
    rimitedinnou1: TMenuItem;
    Sterge1: TMenuItem;
    Editare1: TMenuItem;
    N1: TMenuItem;
    procedure DBMailMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure DBMailDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure QMailAfterScroll(DataSet: TDataSet);
    procedure Button1Click(Sender: TObject);
    procedure rimitedinnou1Click(Sender: TObject);
    procedure Sterge1Click(Sender: TObject);
    procedure Editare1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function Start():integer;
  end;

var
  SentMail: TSentMail;
  MailName: string;

implementation

{$R *.dfm}

uses FWait, Send_Mail, FMain, Thread_Send;

procedure TSentMail.Button1Click(Sender: TObject);
begin
  MainForm.ThreadCancel := True;
end;

procedure TSentMail.DBMailDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  ARect: TRect;
  S: string;
  tsTemp: TStringList;
  I: integer;
  MyImage: TImage;
  Temp: string;
begin
  if QMail.RecordCount <= 0 then Exit;
  
  ARect := Rect;
  if Rect.Top = 0 then Exit;
  //S := StringReplace(Column.Field.Text, ',', #13, [rfReplaceAll]);
  S := StringReplace(Column.Field.AsString, '&', '&&', [rfReplaceAll]);
  tsTemp := TStringList.Create;
  if Column.Index = 0 then begin
    Temp := iif(Column.Field.AsString = 'N', 'Fail.bmp', 'Ok.bmp');
    MyImage := TImage.Create(SentMail);
    with MyImage do begin
      Transparent := True;
      Picture.LoadFromFile(GetCurrentDir + '\Images\' + Temp);
    end;
    S := '';

    DBMail.Canvas.Brush.Color := clWindow;
    DBMail.Canvas.FillRect(Rect);
    DBMail.Canvas.StretchDraw(ARect,MyImage.Picture.Graphic);
    MyImage.Free;
    Exit;
    //DBMail.Canvas.Brush.Color := iif(Column.Field.AsString = 'N', NrFact, iContract);
  end;
  if Column.Index = 1 then begin
    tsTemp.Clear;
    tsTemp.CommaText := S;
    if tsTemp.Count > 0 then
      S := tsTemp[0];
  end;
  if Column.Index = 4 then begin
    tsTemp.Clear;
    tsTemp.CommaText := S;
    S := '';
    for I := 0 to tsTemp.Count - 1 do
      S := S + ' ' + tsTemp[I];
  end;
  if Column.Index = 6 then begin
    tsTemp.Clear;
    tsTemp.Delimiter := '#';        //de vazut de ce nu face cum trebuie
    tsTemp.DelimitedText := S;
    S := '';
    if tsTemp.IndexOf('CTB2000.ZIP' + Blanks + '|' + Locations.Grup1) >= 0 then S := S + 'C';
    if tsTemp.IndexOf('FACT200A.ZIP' + Blanks + '|' + Locations.Grup2) >= 0 then S := S + 'G';
    if tsTemp.IndexOf('SAL_EXE.ZIP' + Blanks + '|' + Locations.Grup3) >= 0 then S := S + 'S';
    if tsTemp.IndexOf('MIFIX.ZIP' + Blanks + '|' + Locations.Grup4) >= 0 then S := S + 'M';
    if tsTemp.IndexOf('FARM2000.ZIP' + Blanks + '|' + Locations.Grup5) >= 0 then S := S + 'F';
    if tsTemp.IndexOf('NIR_EXE.ZIP' + Blanks + '|' + Locations.Grup7) >= 0 then S := S + 'Rc';
    if S = '' then begin
      for I := 0 to tsTemp.Count - 1 do
        S := S + Trim(Copy(tsTemp[I], 1, Pos('|', tsTemp[I]) - 1)) + #13;
      S := Copy(S, 1, Length(S) - 1);  
    end;
  end;
  if gdSelected in State then begin
    (Sender as TDBGrid).Canvas.Brush.Color := Colors.Cursor;
  end;
  (Sender as TDBGrid).Canvas.FillRect(Rect);
  ARect.Left := Rect.Left + 1;
  ARect.Right := ARect.Right - 3;
  {if (Column.Index >= 2) then
    DrawText((Sender as TDBGrid).Canvas.Handle, PChar(S), Length(S), ARect, 0)
  else    }
    DrawText((Sender as TDBGrid).Canvas.Handle, PChar(S), Length(S), ARect, 0);
  tsTemp.Free;
end;

procedure TSentMail.DBMailMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  GridCoord: TGridCoord;
  DBGrid: TDBGrid;
  SavedActiveRec: integer;
  //SQL: string;
  HintLines: TStringList;
  I: integer;
  Temp: string;
begin
  DBGrid := TDBGrid(Sender);
  HintLines := TStringList.Create;
  GridCoord := DBGrid.MouseCoord(X, Y);
  DBGrid.Hint := '';
  Temp := '';
  if (QMail.RecordCount > 0) and (GridCoord.X >= 0) and ((GridCoord.Y >= 1) and (GridCoord.Y <= QMail.RecordCount)) then begin
    if (GridCoord.X <> 5) then begin
      SavedActiveRec := THDbGrid(DBGrid).DataLink.ActiveRecord;
      THDbGrid(DBGrid).DataLink.ActiveRecord := GridCoord.Y - 1;
      HintLines.CommaText := QMail.Fields[GridCoord.X].AsString;
      for I := 0 to HintLines.Count - 1 do
        if GridCoord.X <> 6 then
          Temp := Temp + HintLines[I] + #13
        else
          Temp := Temp + Trim(Copy(HintLines[I], 1, Pos('|', HintLines[I]) - 1)) + #13;
      Temp := Copy(Temp, 1, Length(Temp) - 1); //Last char is a #13

      DBGrid.Hint := Temp;//HintLines.DelimitedText;
      if GridCoord.X = 2 then
        DBGrid.Hint := QMail.Fields[2].AsString;
      Application.ActivateHint(Mouse.CursorPos);
      THDbGrid(DBGrid).DataLink.ActiveRecord := SavedActiveRec;
    end else begin
      DBGrid.Hint := '';
      Application.CancelHint
    end;
  end;
  HintLines.Free;
end;

procedure TSentMail.Editare1Click(Sender: TObject);
var
  QSMail: TQuery;
begin
  QSMail := TQuery.Create(SentMail);
  QSMail.DatabaseName := MainForm.DB.DatabaseName;
  QSMail.SQL.Text :=
    'SELECT REPLACE(ADRESSES,"&quot;", ''"'') ADRESSES, TITLE, REPLACE(ATACHMENTS,"&quot;", ''"'') ATACHMENTS, ' +
      'REPLACE(BODY,"&quot;", ''"'') BODY ' +
    'FROM `DBCABCONTA`.`SENTMAIL` WHERE ID = ' + QMail.FieldByName('ID').AsString;
  QSMail.Open;
  if QSMail.RecordCount <> 0 then begin
    SendMail := TSendMail.Create(SentMail);
    SendMail.Color := Color;
    SendMail.LAdrese.Items.CommaText := QSMail.FieldByName('ADRESSES').AsString;
    SendMail.ESubiect.Text := QSMail.FieldByName('TITLE').AsString;
    SendMail.LAtasamente.Items.Delimiter := '#';
    SendMail.LAtasamente.Items.DelimitedText := QSMail.FieldByName('ATACHMENTS').AsString;
    SendMail.Mesaj.Lines.CommaText := QSMail.FieldByName('BODY').AsString;
    SendMail.OnShow := nil;
    SendMail.ShowModal;
  end;
  QSMail.Free;
end;

procedure TSentMail.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then Close;
end;

procedure TSentMail.FormShow(Sender: TObject);
begin
  DBMail.SetFocus;
  QMail.SQL.Text :=
    'SELECT SENT, MID(REPLACE(ADRESSES,"&quot;", ''"''),1,250) ADRESSES, TITLE, USER, MID(REPLACE(BODY,"&quot;", ''"''),1,250) BODY, TIMESTAMP, ' +
      'MID(REPLACE(ATACHMENTS,"&quot;", ''"''),1,250) ATACHMENTS, ADRESS_COUNT, ID, SENTAT ' +
    'FROM `DBCABCONTA`.`SENTMAIL` ' +
    'ORDER BY ID DESC';
  QMail.Close;
  QMail.Open;
  QMail.Locate('ID', MainForm.LastMailID, [loCaseInsensitive]);
  if MainForm.ThreadsRunning > 0 then begin
    PBar.Visible := True;
    Status.SimpleText := '                                                   Trimit mail ' + QMail.FieldByName('TITLE').AsString + ' catre ' + QMail.FieldByName('ADRESSES').AsString + '...';
    MailName := Status.SimpleText;
    if PBar.Position = PBar.Max then PBar.Caption := 'Gata!';
  end else begin
    PBar.Visible := False;
    Status.SimpleText := '';
  end;

end;

procedure TSentMail.QMailAfterScroll(DataSet: TDataSet);
begin
  if QMail.RecordCount <> 0 then
    if MainForm.ThreadsRunning > 0 then
      Status.SimpleText := MailName
    else
      if QMail.FieldByName('SENT').AsString = 'D' then
        Status.SimpleText := 'Trimis la ' + FormatDateTime('dd MMMM yyyy ora HH:mm',QMail.FieldByName('SENTAT').AsDateTime) + ' de ' + QMail.FieldByName('USER').AsString + '.'
      else
        Status.SimpleText := 'Trimiterea mesajului nu a fost efectuata.';
end;

procedure TSentMail.rimitedinnou1Click(Sender: TObject);
var
  sAdresses: string;
  sSubject: string;
  sAtachments: string;
  sBody: string;
begin
  sAdresses := QMail.FieldByName('ADRESSES').AsString;
  sSubject := QMail.FieldByName('TITLE').AsString;
  sAtachments := QMail.FieldByName('ATACHMENTS').AsString;
  sBody := QMail.FieldByName('BODY').AsString;
  MainForm.ThreadsRunning := MainForm.ThreadsRunning + 1;
  MainForm.ThreadCancel := False;
  TMailThread.Create(Application,sAdresses, sSubject, sAtachments, sBody, QMail.FieldByName('ID').AsInteger); //OnTerminate := Procedure
end;

function TSentMail.Start():integer;
begin
  SentMail := TSentMail.Create(Application);
  SentMail.Color := MainForm.Color;
  SentMail.Show;
//  SentMail.Free;
end;

procedure TSentMail.Sterge1Click(Sender: TObject);
var
  MyQuery: TQuery;
  Temp: integer;
begin
  QMail.Next;
  Temp := QMail.FieldByName('ID').AsInteger;
  QMail.Prior;
  MyQuery := TQuery.Create(SentMail);
  MyQuery.DatabaseName := MainForm.DB.DatabaseName;
  MyQuery.SQL.Text := 'DELETE FROM SENTMAIL WHERE ID = ' + QMail.FieldByName('ID').AsString;
  MyQuery.ExecSQL;
  MyQuery.Free;
  QMail.Close;
  QMail.Open;
  QMail.Locate('ID', Temp, []);
end;

end.
