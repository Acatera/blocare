unit Jur_C_Clienti;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, DBTables, ExtCtrls;

type
  TJurCClienti = class(TForm)
    DBJurnale: TDBGrid;
    LJurnale: TLabel;
    DS: TDataSource;
    Query: TQuery;
    PBottom: TPanel;
    COrder: TComboBox;
    LOrdonare: TLabel;
    CGroup: TComboBox;
    Label1: TLabel;
    LRecordCount: TLabel;
    procedure FormResize(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure DBJurnaleDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure COrderChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function Start(Options: string): integer;
  end;

const
  Users = 'AYDHBMZOST';
  Widths = Chr(20) + Chr(30) + Chr(22) + Chr(90) + Chr(25) + Chr(25) + Chr(25) + Chr(688) + Chr(16);  

var
  JurCClienti: TJurCClienti;
  sOptions: string;
  JurSQL: string;
  tsUsers: TStringList;
  Order: string;
  Group: string;
  ColTotalWidth: integer;

implementation

uses FMain;

{$R *.dfm}

procedure TJurCClienti.COrderChange(Sender: TObject);
begin
  Order := Copy(COrder.Text, Pos('|', COrder.Text) + 1);
  Query.SQL.Text := JurSQL + Order;
  Query.Open;
  LRecordCount.Caption := IntToStr(Query.RecordCount) + ' records.';
end;

procedure TJurCClienti.DBJurnaleDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  ARect: TRect;
  S: string;
begin
  ARect := Rect;
  if Rect.Top = 0 then Exit;
  if Column <> nil then
    S := Column.Field.AsString;
  if (Column.Index = 4) and (Ord(S[1]) > 57) and (S <> '') then
    S := tsUsers.Names[Pos(S, Users) - 1];
  //ShowMessage(S);
//  ShowMessage(tsUsers.Names[1]);

  S := StringReplace(S, '&', '&&', [rfReplaceAll]);
  if DBJurnale.Fields[4].AsString = tsUsers.Values[UpperCase(Copy(UMail, 1, Pos('@', UMail) - 1))] then
    DBJurnale.Canvas.Brush.Color := Colors.Contract;
  if gdSelected in State then begin
    (Sender as TDBGrid).Canvas.Brush.Color := Colors.Cursor;
  end;
  (Sender as TDBGrid).Canvas.FillRect(Rect);
  ARect.Left := Rect.Left + 2;
  if Column.Index < 3 then
    DrawText((Sender as TDBGrid).Canvas.Handle, PChar(S), Length(S), ARect, 2);
  if (Column.Index = 3) or (Column.Index = 7) then
    DrawText((Sender as TDBGrid).Canvas.Handle, PChar(S), Length(S), ARect, 0);
  if (Column.Index > 3) and (Column.Index < 7)then
    DrawText((Sender as TDBGrid).Canvas.Handle, PChar(S), Length(S), ARect, 1);
  if (Column.Index = 8) then
    DrawText((Sender as TDBGrid).Canvas.Handle, PChar(S), Length(S), ARect, 1);
end;

procedure TJurCClienti.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then Close;
end;

procedure TJurCClienti.FormResize(Sender: TObject);
var
  I: integer;
  //iAux: integer;
begin
  ColTotalWidth := 0;
  for I := 0 to DBJurnale.Columns.Count - 1 do
    ColTotalWidth := ColTotalWidth + Ord(Widths[I + 1]);
  for I := 0 to DBJurnale.Columns.Count - 1 do
    DBJurnale.Columns[I].Width := Round((DBJurnale.Width - 30) * Ord(Widths[I + 1]) / ColTotalWidth);
end;

procedure TJurCClienti.FormShow(Sender: TObject);
var
  I: Integer;
begin
  Color := MainForm.Color;
  JurSQL := '';
  for I := 0 to MainForm.CGest.Items.Count - 1 do
    JurSQL := JurSQL + 
      'SELECT INFO3, CONCAT(RIGHT(DATA, 2), ".", MID(DATA, 5, 2), ".", LEFT(DATA, 4)) DATA, ' +
        'CONCAT(LEFT(TIMP, 2), ":", MID(TIMP, 3, 2), ":", RIGHT(TIMP, 2)) TIMP, F.DENFUR, STATIA, USER, MID(G.DESCRIERE,1,150) DESCRIERE, ' +
        'CONCAT(IF(TIP3="T", "Telefonic", ""), IF(TIP3="L", "LogMeIn", ""), IF(TIP3="S", "Sediu", ""), IF(TIP3="D", "Deplasare","")) AS TIP, ' +
        'CONCAT(IF(TIP2="V", "Scurta", ""), IF(TIP2="A", "Medie", ""), IF(TIP2="R", "Lunga", ""), IF(TIP2="N", "Foarte lunga","")) AS DURATA, DATA AS DATAI ' +
      'FROM `' + MainForm.CGest.Items[I] + '`.`LOG` L LEFT JOIN `' + MainForm.CGest.Items[I] + '`.`GENERAL` G ON G.GRUPA="JUR" AND L.INFO3=G.COD ' +
        'LEFT JOIN `' + MainForm.CGest.Items[I] + '`.`FUR` F ON L.INFO1=F.CODFUR ' +
      'WHERE L.TIP="J" UNION ALL ';
  JurSQL := Copy(JurSQL, 1, Length(JurSQL) - 11);
  Query.SQL.Text := JurSQL + ' ORDER BY DATAI DESC, TIMP DESC';
  Query.Open;
  LRecordCount.Caption := IntToStr(Query.RecordCount) + ' records.';
  //for I := 0 to DBJurnale.Columns.Count - 1 do
  //  ColTotalWidth := ColTotalWidth + Ord(Widths[I + 1]);
  //for I := 0 to DBJurnale.Columns.Count - 1 do
  //  DBJurnale.Columns[I].Width := Round((DBJurnale.Width - 28) * Ord(Widths[I + 1]) / ColTotalWidth);
end;

function TJurCClienti.Start(Options: string): integer;
begin
  JurCClienti := TJurCClienti.Create(Application);
  tsUsers := TStringList.Create;
  tsUsers.Delimiter := ',';
  tsUsers.DelimitedText := JurUser;
  sOptions := Options;
  ColTotalWidth := 0;
  JurCClienti.ShowModal;
  tsUsers.Free;
  JurCClienti.Free;
end;

end.
