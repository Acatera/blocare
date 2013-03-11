unit Editare;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DB, DBGrids, AlexUtils, Constants, RbDrawCore,
  RbButton, DBTables;

type
  TFEditare = class(TForm)
    CTable: TComboBox;
    MSQL: TMemo;
    DBGrid: TDBGrid;
    LDatabase: TLabel;
    LTable: TLabel;
    LSQL: TLabel;
    Btn_Txt: TRbButton;
    CDatabase: TComboBox;
    Btn_TblValues: TRbButton;
    DSave: TSaveDialog;
    Memo: TMemo;
    Q: TQuery;
    DS: TDataSource;
    QTemp: TQuery;
  function Start(Title, Code: string): integer;
  procedure LoadDatabases;
  procedure LoadTables;
  procedure DBGridDrawDataCell(Sender: TObject; const Rect: TRect;
    Field: TField; State: TGridDrawState);
  procedure Btn_ExecutaClick(Sender: TObject);
  procedure MSQLKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CDatabaseChange(Sender: TObject);
    procedure Btn_TblValuesClick(Sender: TObject);
    procedure Btn_TxtClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure DBGridDblClick(Sender: TObject);
    procedure MemoExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGridMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure DBGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FEditare: TFEditare;
  TITLE: string;
  DBName: string;

implementation

uses FMain, Dialog;

{$R *.dfm}

function TFEditare.Start(Title, Code: string): integer;
begin
  FEditare := TFEditare.Create(Application);
  with FEditare do begin
    LoadDatabases;
    Caption := Title;
    QTemp.SQL.Clear;
    ShowModal;
  end;
  FEditare.Free;
end;

procedure TFEditare.MemoExit(Sender: TObject);
begin
  Memo.Lines.Clear;
  Memo.Visible := False;
end;

procedure TFEditare.MSQLKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F9 then Btn_ExecutaClick(Self);
end;

procedure TFEditare.Btn_ExecutaClick(Sender: TObject);
var
  bTemp: boolean;
  Temp: string;
  Aux: string;
begin
  Aux := 'SELECTSHOWDESCRIBE';
  bTemp := QTemp.RequestLive;
  Temp := TrimLeft(MSQL.Lines.Text);
  if Temp[1] = '*' then begin
    QTemp.RequestLive := True;
    Delete(Temp, 1, 1);
  end;
  if Pos((UpperCase(Copy(Temp, 1, Pos(' ', Temp) - 1))), Aux) = 0 then begin
    QTemp.SQL.Text := Temp;
    QTemp.ExecSQL;
  end else begin
    QTemp.SQL.Text := 'SET @ROW_ID = 0';
    QTemp.ExecSQL;
    QTemp.SQL.Text := StringReplace(Temp, ' FROM',', @ROW_ID := @ROW_ID + 1 ROW_ID FROM',[rfIgnoreCase]);
    QTemp.Open
  end;
  QTemp.RequestLive := bTemp;  
end;

procedure TFEditare.Btn_TblValuesClick(Sender: TObject);
begin
  QTemp.SQL.Text := 'SELECT * FROM `' + CDatabase.Text + '`.`' + CTable.Text + '`';
  QTemp.Open;
end;

procedure TFEditare.Btn_TxtClick(Sender: TObject);
var
  Temp: string;
  TXTFile: TextFile;
  I: Integer;
  SelText: string;
  SelField: string;
begin
  if QTemp.Eof then begin
    FDialog.Start('Atentie', 'Nu exista date de salvat.', fdOk, mtWarning);
    Exit;
  end;
  Temp := GetCurrentDir;
  DSave.Title := 'Salvare fisier text...';
  DSave.InitialDir := GetCurrentDir;
  if not DSave.Execute then Exit;
  if DSave.FileName = '' then Exit;
  SetCurrentDir(Temp);
  if FileExists(DSave.FileName) then
    if FDialog.Start('Atentie', 'Fisierul exista deja. Doriti sa-l suprascrieti?', fdBtn_Yes or fdBtn_No, mtConfirmation) = fdBtn_No then Exit;
  AssignFile(TXTFile, DSave.FileName);
  Rewrite(TXTFile);
  SelText := DBGrid.SelectedField.Text;
  SelField := DBGrid.SelectedField.FullName;
  QTemp.First;
  while not QTemp.Eof do begin
    Temp := QTemp.Fields[0].AsString;
    for I := 1 to QTemp.FieldCount - 1 do
      Temp := Temp + #9 + QTemp.Fields[I].AsString;
    WriteLn(TXTFile, Temp);
    QTemp.Next;
  end;
  CloseFile(TXTFile);
  if SelField <> '' then DBGrid.DataSource.DataSet.Locate(SelField, SelText, [loCaseInsensitive])
end;

procedure TFEditare.CDatabaseChange(Sender: TObject);
begin
  LoadTables;
end;

procedure TFEditare.DBGridDblClick(Sender: TObject);
begin
  if DBGrid.SelectedField.Text = '(MEMO)' then begin
    Memo.Visible := True;
    Memo.Lines := StringToTStrings(DBGrid.SelectedField.AsString, #10);
  end;
end;

procedure TFEditare.DBGridDrawDataCell(Sender: TObject; const Rect: TRect;
  Field: TField; State: TGridDrawState);
var
  S: string;
  ARect: TRect;
begin
  ARect := Rect;
  if Rect.Top = 0 then Exit;
  with (Sender as TDBGrid).Canvas.Brush do begin
    if gdSelected in State then begin
      Color := Colors.Cursor
    end else begin
      if (QTemp.FieldByName('ROW_ID').AsInteger mod 2 = 1) then
        Color := Colors.Odd
        else Color := Colors.Even;
    end;
  end;
  S := StringReplace(Field.Text, '&', '&&', [rfReplaceAll]);
  (Sender as TDBGrid).Canvas.FillRect(Rect);
  ARect.Left := Rect.Left + 2;
  DrawText((Sender as TDBGrid).Canvas.Handle, PChar(S), Length(S), ARect, 0);
end;

procedure TFEditare.DBGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 (Sender as TDBGrid).Invalidate;
end;

procedure TFEditare.DBGridMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  (Sender as TDBGrid).Invalidate;
end;

procedure TFEditare.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then Close;
end;

procedure TFEditare.FormShow(Sender: TObject);
begin
  FEditare.Color := MainForm.Color;
  DBGrid.FixedColor := MainForm.DBGest.FixedColor;
end;

procedure TFEditare.LoadDatabases;
begin
  CDatabase.Items.Clear;
  Q.SQL.Text := 'SHOW DATABASES';
  Q.Open;
  Q.First;
  while not Q.Eof do begin
    CDatabase.Items.Add(Q.Fields[0].AsString);
    Q.Next;
  end;
  if CDatabase.Items.IndexOf(MainForm.CGest.Text) >= 0 then
    CDatabase.ItemIndex := CDatabase.Items.IndexOf(MainForm.CGest.Text)
  else
    CDatabase.ItemIndex := 0;
  LoadTables;
end;

procedure TFEditare.LoadTables;
begin
  CTable.Items.Clear;
  Q.SQL.Text := 'SHOW TABLES IN `' + CDatabase.Text + '`';
  Q.Open;
  Q.First;
  while not Q.Eof do begin
    CTable.Items.Add(Q.Fields[0].AsString);
    Q.Next;
  end;
  CTable.ItemIndex := 0;
end;

end.
