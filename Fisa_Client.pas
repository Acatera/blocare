unit Fisa_Client;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB, DBTables, StdCtrls, StrUtils, RpCon, RpConDS,
  RpConBDE, RpRender, RpRenderPDF, RpBase, RpSystem, RpDefine, RpRave,
  RpRenderCanvas, RpRenderPreview;

type
  TFisaClient = class(TForm)
    Query: TQuery;
    Z1: TEdit;
    L1: TEdit;
    A1: TEdit;
    A2: TEdit;
    L2: TEdit;
    Z2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Btn_Afiseaza: TButton;
    Btn_Renunta: TButton;
    DS: TDataSource;
    DBFact: TDBGrid;
    RP: TRvProject;
    RS: TRvSystem;
    RPDF: TRvRenderPDF;
    RQuery: TRvQueryConnection;
    CActions: TComboBox;
    LActiuni: TLabel;
    Btn_Executa: TButton;
    RPV: TRvRenderPreview;
    SD: TSaveDialog;
    RAux1: TRvQueryConnection;
    RAux2: TRvQueryConnection;
    QAux1: TQuery;
    QAux2: TQuery;
    CGest: TComboBox;
    Label3: TLabel;
    procedure Btn_RenuntaClick(Sender: TObject);
    function Start(CodFur, DenFur, Firma: string): integer;
    procedure Btn_AfiseazaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EditEnter(Sender: TObject);
    procedure EditExit(Sender: TObject);
    procedure EditKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Btn_ExecutaClick(Sender: TObject);
    procedure CActionsKeyPress(Sender: TObject; var Key: Char);
    procedure Btn_RefreshClick(Sender: TObject);
    procedure DBFactDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FisaClient: TFisaClient;
  sFirma: string;
  sCodFur: string;
  sDenFur: string;
  CodFiscal: string;
  DB: string;
  CR: string;
  SoldFinal: string;
  eLLAA: string;

implementation

uses Sel_Mail, FMain, AlexUtils;

{$R *.dfm}

function TFisaClient.Start(CodFur, DenFur, Firma: string): integer;
begin
  FisaClient := TFisaClient.Create(Application);
  sCodFur := CodFur;
  sDenFur := DenFur;
  sFirma := Firma;
  FisaClient.ClientHeight := 90;
  FisaClient.ShowModal;
  FisaClient.Free;
end;

procedure TFisaClient.EditKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in [#8, #13, '0'..'9']) then Key := #0;
  if Key = #13 then SelectNext(TEdit(Sender), True, True);
end;

procedure TFisaClient.EditExit(Sender: TObject);
begin
  (Sender as TEdit).Color := clWindow;
end;

procedure TFisaClient.EditEnter(Sender: TObject);
begin
  (Sender as TEdit).Color := DBFact.FixedColor;
end;

procedure TFisaClient.Btn_AfiseazaClick(Sender: TObject);
var
  SQL: string;
  I: integer;
  LLAA: string;
begin
  SQL := 'SELECT COD_FISCAL FROM `' + CGest.Text + '`.`FUR` WHERE CODFUR = "' + sCodFur + '"';
  Query.SQL.Text := SQL;
  Query.Active := True;
  CodFiscal := Query.Fields[0].AsString;
  L1.Tag := StrToInt(L1.Text);
  L2.Tag := StrToInt(L2.Text);
  A1.Tag := StrToInt(A1.Text);
  A2.Tag := StrToInt(A2.Text);
  L1.Tag := L1.Tag - 1;
  if L1.Tag < 1  then begin
    L1.Tag := 12;
    A1.Tag := A1.Tag - 1;
  end; 
  LLAA := RightStr('0' + IntToStr(L1.Tag), 2) + RightStr(IntToStr(A1.Tag), 2);
  SQL := 'SET @SOLD = 0';
  QAux1.SQL.Text := SQL;
  QAux1.ExecSQL;
  SQL := 'SET @DB = 0';
  QAux1.SQL.Text := SQL;
  QAux1.ExecSQL;
  SQL := 'SET @CR = 0';
  QAux1.SQL.Text := SQL;
  QAux1.ExecSQL;
  QAux1.SQL.Text :=
    'SELECT "SOLD precedent:" AS EXPLICN, " " AS CONT_COR, " " AS DEBIT, " " AS CREDIT, @SOLD AS SOLD, 0 AS FACT, ' +
      '@DB AS DB, @CR AS CR, " " AS DATAD UNION ALL ' +
    'SELECT CONCAT("Fact. ", NRDFC," / ",CONCAT(SUBSTRING(DATAFC,1,2),".",SUBSTRING(DATAFC,3,2),".",SUBSTRING(DATAFC,5,4))," - ",SUBSTRING(EXPLIC,1,1),LOWER(SUBSTRING(EXPLIC,2))) AS EXPLIC, ' +
      'CONTCOR AS CONT_COR, IF(SUMADB-SUMACR > 0, ROUND(SUMADB-SUMACR, 2), 0) AS DEBIT, IF(SUMADB-SUMACR < 0, ROUND(SUMADB-SUMACR, 2), 0) AS CREDIT, ' +
      '@SOLD := ROUND(@SOLD + (SUMADB-SUMACR),2) AS SOLD, (SUMADB-SUMACR) AS FACT, @DB := @DB + IF(SUMADB-SUMACR > 0, ROUND(SUMADB-SUMACR, 2), 0)  AS DB, ' +
      '@CR := @CR + IF(SUMADB-SUMACR < 0, ROUND(SUMADB-SUMACR, 2), 0) AS CR, DATAFC AS DATAD ' +
    'FROM `' + CGest.Text + '`.`FRES' + LLAA + '` WHERE (CODFC = "' + sCodFur + '") AND (CONTFC="4111") AND (SUMADB - SUMACR <> 0)';
//    'SELECT "Sold la sfarsitul lunii precedente:" AS EXPLICN, " " AS CONT_COR, " " AS DEBIT, " " AS CREDIT, ' +
//    '@SOLDP AS SOLDP, 0 AS FACT, @DB AS DB, @CR AS CR,  " " AS DATAD';
  QAux1.Open;
  SQL := 'SET @DB = 0';
  QAux2.SQL.Text := SQL;
  QAux2.ExecSQL;
  SQL := 'SET @CR = 0';
  QAux2.SQL.Text := SQL;
  QAux2.ExecSQL;
  Query.SQL.Text := 'SELECT SUM(SUMADB-SUMACR) FROM `' + CGest.Text + '`.`FRES' + LLAA + '` WHERE (CODFC = "' + sCodFur + '") AND (CONTFC="4111")';
  Query.Open;
  if Query.Fields[0].AsString <> '' then                                            //, @DB := @DB + DEBIT  AS DB, @CR := @CR + CREDIT AS CR
    SQL := 'SELECT EXPLIC, CONT_COR, DEBIT, CREDIT, @SOLD := ROUND(@SOLD + FACT,2) AS SOLD, FACT, @DB := @DB + DEBIT  AS DB, @CR := @CR + CREDIT AS CR FROM ('
           //'SELECT "SOLD precedent:" AS EXPLIC, " " AS CONT_COR, " " AS DEBIT, " " AS CREDIT, SUM(SUMADB-SUMACR) AS FACT, " " AS DATAD ' +
           //'FROM `' + sFirma + '`.`FRES' + LLAA + '` WHERE (CODFC = "' + sCodFur + '") AND(CONTFC="4111") UNION ALL '
  else
    SQL := 'SELECT EXPLIC, CONT_COR, DEBIT, CREDIT, @SOLD := ROUND(@SOLD + FACT,2) AS SOLD, FACT, @DB := @DB + DEBIT  AS DB, @CR := @CR + CREDIT AS CR FROM (';
          // 'SELECT "SOLD precedent:" AS EXPLIC, " " AS CONT_COR, " " AS DEBIT, " " AS CREDIT, 0 AS FACT, " " AS DATAD UNION ALL ' ;
  L1.Tag := StrToInt(L1.Text);
  L2.Tag := StrToInt(L2.Text);
  A1.Tag := StrToInt(A1.Text);
  A2.Tag := StrToInt(A2.Text);
  LLAA := RightStr('0' + IntToStr(L1.Tag), 2) + RightStr(IntToStr(A1.Tag), 2);
  for I := 1 to (A2.Tag - A1.Tag) * 12 - L1.Tag + L2.Tag + 1 do begin
    SQL := SQL +
      'SELECT CONCAT(IF(LEFT(DEBIT, 3)="512","Ord. ", ""), NRDI," / ",CONCAT(SUBSTRING(DATAI,1,2),".",SUBSTRING(DATAI,3,2),".",SUBSTRING(DATAI,5,4))," - ",SUBSTRING(EXPLICN,1,1),LOWER(SUBSTRING(EXPLICN,2))) AS EXPLIC, ' +
        'DEBIT AS CONT_COR, " " AS DEBIT, SUM(SUMA) AS CREDIT, CONCAT("-",SUM(SUMA)) AS FACT, DATAI AS DATAD ' +
      'FROM `' + CGest.Text + '`.`CM' + LLAA + '` ' +
      'WHERE (FURCLI = "' + sCodFur + '") AND (CREDIT="4111") GROUP BY NRDI, FURCLI UNION ALL ' +
      'SELECT CONCAT(IF(LEFT(DEBIT, 3)="512","Ord. ", ""), NRDI," / ",CONCAT(SUBSTRING(DATAI,1,2),".",SUBSTRING(DATAI,3,2),".",SUBSTRING(DATAI,5,4))," - ",SUBSTRING(EXPLICN,1,1),LOWER(SUBSTRING(EXPLICN,2))) AS EXPLIC, ' +
        'DEBIT AS CONT_COR, " " AS DEBIT, SUM(SUMA) AS CREDIT, CONCAT("-",SUM(SUMA)) AS FACT, DATAI AS DATAD ' +
      'FROM `' + CGest.Text + '`.`RULA' + LLAA + '` ' +
      'WHERE (FURCLI = "' + sCodFur + '") AND (CREDIT="4111") AND (INTIES<3) GROUP BY NRDI, FURCLI UNION ALL ' +
      'SELECT CONCAT("Fact. ", NUMAR," / ",CONCAT(SUBSTRING(DATA,1,2),".",SUBSTRING(DATA,3,2),".",SUBSTRING(DATA,5,4))," - ",SUBSTRING(DENUMIRE,1,1),LOWER(SUBSTRING(DENUMIRE,2))) AS EXPLIC, CONT AS CONT_COR, ' +
        'ROUND(SUM(VALOARE+VAL_TVA),2) AS DEBIT, " " AS CREDIT, ROUND(SUM(VALOARE+VAL_TVA),2) AS FACT, DATA AS DATAD ' +
      'FROM `' + CGest.Text + '`.`MIV' + LLAA + '` ' +
      'WHERE (CODFUR = "' + sCodFur + '") AND (CONT_COR="4111") AND (ANULAT <> "A") GROUP BY NUMAR, CODFUR UNION ALL ' +
      'SELECT CONCAT("Fact. ", NRDI," / ",CONCAT(SUBSTRING(DATAI,1,2),".",SUBSTRING(DATAI,3,2),".",SUBSTRING(DATAI,5,4))," - ",SUBSTRING(EXPLICN,1,1),LOWER(SUBSTRING(EXPLICN,2))) AS EXPLIC, ' +
        'CREDIT AS CONT_COR, SUM(SUMA) AS DEBIT, " " AS CREDIT, SUM(SUMA) AS FACT, DATAI AS DATAD ' +
      'FROM `' + CGest.Text + '`.`RULA' + LLAA + '` ' +
      'WHERE (FURCLI = "' + sCodFur + '") AND (DEBIT="4111") AND (INTIES<3) GROUP BY NRDI, FURCLI UNION ALL ';
      L1.Tag := L1.Tag + 1;
      if L1.Tag > 12 then begin
        L1.Tag := 1;
        A1.Tag := A1.Tag + 1;
      end;
      LLAA := RightStr('0' + IntToStr(L1.Tag), 2) + RightStr(IntToStr(A1.Tag), 2);
  end;
  SQL := Copy(SQL, 1, Length(SQL) - 11) + ' ORDER BY CONCAT(SUBSTRING(DATAD,5,4),SUBSTRING(DATAD,3,2),SUBSTRING(DATAD,1,2))) AS TEMP';
  Query.SQL.Text := SQL;
  Query.Open;
  Query.Last;
  SoldFinal := Query.Fields[4].AsString;
  DB := Query.FieldByName('DB').AsString;
  CR := Query.FieldByName('CR').AsString;
  FisaClient.ClientHeight := DBFact.Top + DBFact.Height+32;
  SQL := 'SET @SOLD = 0';
  QAux2.SQL.Text := SQL;
  QAux2.ExecSQL;
  SQL := 'SET @DB = 0';
  QAux2.SQL.Text := SQL;
  QAux2.ExecSQL;
  SQL := 'SET @CR = 0';
  QAux2.SQL.Text := SQL;
  QAux2.ExecSQL;
  QAux2.SQL.Text :=
    'SELECT CONCAT("Fact. ", NRDFC," / ",CONCAT(SUBSTRING(DATAFC,1,2),".",SUBSTRING(DATAFC,3,2),".",SUBSTRING(DATAFC,5,4))," - ",SUBSTRING(EXPLIC,1,1),LOWER(SUBSTRING(EXPLIC,2))) AS EXPLIC, ' +
      'CONTCOR AS CONT_COR, IF(SUMADB-SUMACR > 0, ROUND(SUMADB-SUMACR, 2), 0) AS DEBIT, IF(SUMADB-SUMACR < 0, ROUND(SUMADB-SUMACR, 2), 0) AS CREDIT, @SOLD := ROUND(@SOLD + (SUMADB-SUMACR),2) AS SOLD, ' +
      '(SUMADB-SUMACR) AS FACT, @DB := @DB + IF(SUMADB-SUMACR > 0, ROUND(SUMADB-SUMACR, 2), 0)  AS DB, @CR := @CR + IF(SUMADB-SUMACR < 0, ROUND(SUMADB-SUMACR, 2), 0) AS CR, DATAFC AS DATAD ' +
    'FROM `' + CGest.Text + '`.`FRES' + L2.Text +  Copy(A2.Text, 3, 2) + '` WHERE (CODFC = "' + sCodFur + '") AND (CONTFC="4111") AND (SUMADB - SUMACR <> 0)';
  QAux2.Open;
  FisaClient.Position := poMainFormCenter;
  if Btn_Afiseaza.Tag = 0 then CActions.SetFocus;
end;


procedure TFisaClient.Btn_ExecutaClick(Sender: TObject);
var
  Temp: string;
begin
  Temp := GetCurrentDir;
  RP.ProjectFile := GetCurrentDir + '\FisaClient.rav';
  if CActions.ItemIndex = 0 then begin
    with RP do begin
      RS.DefaultDest := rdPreview;
      Open;
      SetParam('PERIOADA', Z1.Text + '.' + L1.Text + '.' + A1.Text + ' - ' + Z2.Text + '.' + L2.Text + '.' + A2.Text);
      SetParam('CODFUR', CodFiscal);
      SetParam('DENFUR', sDenFur);
      SetParam('FIRMA', CGest.Text);
      SetParam('SOLD_F', SoldFinal);
      SetParam('DEB_TOTAL', DB);
      SetParam('CR_TOTAL', CR);
      ExecuteReport('Report1');
      Close;
    end;
  end;
  if CActions.ItemIndex = 1 then begin
    if SD.Execute then
      RS.OutputFileName:= SD.FileName
    else Exit;
    with RS do begin
      DefaultDest := rdFile;
      DoNativeOutput:= False;
      RenderObject:= RPDF;
      SD.InitialDir := GetCurrentDir;
    end;
    with RP do begin
      Open;
      SetParam('PERIOADA', Z1.Text + '.' + L1.Text + '.' + A1.Text + ' - ' + Z2.Text + '.' + L2.Text + '.' + A2.Text);
      SetParam('CODFUR', CodFiscal);
      SetParam('DENFUR', sDenFur);
      SetParam('FIRMA', CGest.Text);
      SetParam('SOLD_F', SoldFinal);
      SetParam('DEB_TOTAL', DB);
      SetParam('CR_TOTAL', CR);
      ExecuteReport('Report1');
      Close;
    end;
  end;
  if CActions.ItemIndex = 2 then begin
    RS.OutputFileName:= GetCurrentDir + '\TempFile_Fisa' + CodFiscal + '.pdf';
    with RS do begin
      DefaultDest := rdFile;
      DoNativeOutput:= False;
      RenderObject:= RPDF;
    end;
    with RP do begin
      Open;
      SetParam('PERIOADA', Z1.Text + '.' + L1.Text + '.' + A1.Text + ' - ' + Z2.Text + '.' + L2.Text + '.' + A2.Text);
      SetParam('CODFUR', CodFiscal);
      SetParam('DENFUR', sDenFur);
      SetParam('FIRMA', CGest.Text);
      SetParam('SOLD_F', SoldFinal);
      SetParam('DEB_TOTAL', DB);
      SetParam('CR_TOTAL', CR);
      ExecuteReport('Report1');
      Close;
    end;
    SelMail.Start(sCodFur, 'F');
    SelMail.AttachedFiles.Add(GetCurrentDir + '\TempFile_Fisa' + CodFiscal + '.pdf') ;
    SelMail.LTitlu.Hint := Z1.Text + '.' + L1.Text + '.' + A1.Text + ' - ' + Z2.Text + '.' + L2.Text + '.' + A2.Text;
    SelMail.LClient.Caption := sDenFur;
    SelMail.ShowModal;
    SelMail.Free;
    //DeleteFile(GetCurrentDir + '\Fisa' + CodFiscal + '.pdf');
  end;
  SetCurrentDir(Temp);
end;

procedure TFisaClient.Btn_RefreshClick(Sender: TObject);
begin
  Btn_AfiseazaClick(Self);
end;

procedure TFisaClient.Btn_RenuntaClick(Sender: TObject);
begin
  Close;
end;

procedure TFisaClient.CActionsKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then SelectNext(TComboBox(Sender), True, True);
end;

procedure TFisaClient.DBFactDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  ARect: TRect;
  S: string;
  S1: string;
begin
  if Query.RecordCount <= 0 then Exit;

  ARect := Rect;
  if Rect.Top = 0 then Exit;
  //S := StringReplace(Column.Field.Text, ',', #13, [rfReplaceAll]);
  S := Column.Field.AsString;
  S1 := Query.FieldByName('FACT').AsString;
  S1 := StringReplace(S1, '--', '', [rfReplaceAll]);
  if s2f(S1) < 0 then begin
    DBFact.Canvas.Brush.Color := Colors.Contract
  end else
    DBFact.Canvas.Brush.Color := Colors.Overdue;
  if gdSelected in State then begin
    (Sender as TDBGrid).Canvas.Brush.Color := Colors.Cursor;
  end;
  (Sender as TDBGrid).Canvas.FillRect(Rect);
  ARect.Left := Rect.Left;
  if (Column.Index >= 2) then
    DrawText((Sender as TDBGrid).Canvas.Handle, PChar(S), Length(S), ARect, 2)
  else
    DrawText((Sender as TDBGrid).Canvas.Handle, PChar(S), Length(S), ARect, 0);
end;

procedure TFisaClient.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then Close;
end;

procedure TFisaClient.FormShow(Sender: TObject);
var
  Y: word;
  M: word;
  D: word;
begin
  CGest.Items.CommaText := GestDB;
  CGest.ItemIndex := CGest.Items.IndexOf(sFirma);
  DecodeDate(Now, Y, M, D);
  A2.Text := IntToStr(Y);
  L2.Text := RightStr('0' + IntToStr(M), 2);
  if M = 2 then  //if(( year % 4 == 0 && year % 100 != 0 ) || year % 400 = 0 )
    if (((Y mod 4) = 0) and ((Y mod 100) <> 0)) or ((Y mod 400) = 0) then Z2.Text := '29'
    else Z2.Text := '28'
  else
    if (M < 8) then
      if((M mod 2) = 0) then Z2.Text := '30'
      else Z2.Text := '31'
    else if((M mod 2) = 0) then Z2.Text := '31'
      else Z2.Text := '30';
  A1.Text := IntToStr(Y);
  L1.Text := '01';
  Z1.Text := '01';
  Color := MainForm.Color;
  DBFact.FixedColor := MainForm.DBGest.FixedColor;
  //DBFact.Columns[2].Color := RandImpar;
  //DBFact.Columns[3].Color := RandPar;
end;

end.
