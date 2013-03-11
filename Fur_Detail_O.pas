unit Fur_Detail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB, DBTables, StdCtrls, ExtCtrls, Menus, RpDefine,
  RvLDCompiler, RpCon, RpConDS, RpConBDE, RpRender, RpRenderPDF, RpRave,
  RpBase, RpSystem, AlexUtils;

type
  TFirma = record
    Denumire: string;
    CUI: string;
    NrOrdRegCom: string;
    Sediu: string;
    Judet: string;
    Cont: string;
    Banca: string;
    CapSocial: string;
  end;
  THDbGrid = class(TDBGrid);
  TMyDetails = record
    CodFur: string;
    DenFur: string;
    Stare: string;
    Firma: string;
    LLAA: string;
    NrFact: string;
    Suma: string;
  end;
  TFurDetail = class(TForm)
    QFact: TQuery;
    DS: TDataSource;
    DBFact: TDBGrid;
    ECOD_FISCAL: TLabeledEdit;
    EDENFUR: TLabeledEdit;
    LTotal: TLabel;
    LNrFact: TLabel;
    LLaZi: TLabel;
    DBContract: TDBGrid;
    LContract: TLabel;
    Btn_Fisa: TButton;
    LFacturi: TLabel;
    QContracte: TQuery;
    DSC: TDataSource;
    EStare: TShape;
    Label1: TLabel;
    Btn_Extras: TButton;
    DBModule: TDBGrid;
    LModule: TLabel;
    MQuery: TQuery;
    DSM: TDataSource;
    FactMenu: TPopupMenu;
    L1: TMenuItem;
    rimitemail1: TMenuItem;
    Btn_Mail: TButton;
    Btn_Jurnal: TButton;
    CBAll: TCheckBox;
    Btn_Rulaj: TButton;
    EEMail: TLabeledEdit;
    procedure SnatchEmail;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ECOD_FISCALKeyPress(Sender: TObject; var Key: Char);
    procedure DBContractDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Btn_FisaClick(Sender: TObject);
    procedure DBContractMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Btn_ExtrasClick(Sender: TObject);
    procedure Trimitemail1Click(Sender: TObject);
    procedure L1Click(Sender: TObject);
    procedure DBFactDblClick(Sender: TObject);
    procedure DBFactKeyPress(Sender: TObject; var Key: Char);
    procedure MakeInvoice(dbName, NrFact, DataFact, fFileName: string);
    procedure DBFactDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Btn_MailClick(Sender: TObject);
    procedure Btn_JurnalClick(Sender: TObject);
    procedure CBAllClick(Sender: TObject);
    procedure ReDrawForm(Sender: TObject);
    procedure Btn_RulajClick(Sender: TObject);
    procedure EEMailEnter(Sender: TObject);
    procedure EEMailExit(Sender: TObject);
    procedure EEMailKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBModuleDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
  public
    function Start(LLAA, CodFur, DenFur, Stare, NrFact, Suma, Firma: string): integer;
    { Public declarations }
  end;

var
  FurDetail: TFurDetail;
  SQL: string;
  SQLCon: string;
  Detail: TMyDetails;
  Firma: TFirma;
  Selections: TStringList;
  sCodFC: string;

implementation

uses Fisa_Client, Extras_Cont, Temp_Rap, Sel_Mail, FMain, Jur_Clienti;

procedure TFurDetail.Btn_ExtrasClick(Sender: TObject);
begin
  ExtrasCont := TExtrasCont.Create(Self);
  ExtrasCont.Color := MainForm.Color;
  ExtrasCont.A1.Hint := Detail.Firma;
  ExtrasCont.Z1.Hint := Detail.CodFur;
  ExtrasCont.ShowModal;
  ExtrasCont.Free;
  SnatchEmail;
end;

procedure TFurDetail.Btn_FisaClick(Sender: TObject);
begin
  FisaClient.Start(Detail.CodFur, Detail.DenFur, Detail.Firma);
  SnatchEmail;
end;

procedure TFurDetail.Btn_JurnalClick(Sender: TObject);
begin
  JurClienti.Start(Detail.CodFur, Detail.DenFur, Detail.Firma, '');
end;

procedure TFurDetail.Btn_MailClick(Sender: TObject);
begin
  SelMail.Start(Detail.CodFur, '');
  SelMail.LClient.Caption := Detail.DenFur;
  SelMail.ShowModal;
  SelMail.Free;
  SnatchEmail;
end;

procedure TFurDetail.Btn_RulajClick(Sender: TObject);
var
  Y: word;
  M: word;
  D: word;
begin
  FisaClient := TFisaClient.Create(Application);
  Fisa_Client.sCodFur := Detail.CodFur;
  Fisa_Client.sDenFur := Detail.DenFur;
  Fisa_Client.sFirma := Detail.Firma;
  with FisaClient do begin
    Caption := 'Rulajul clientului selectat in luna curenta...';
    Z1.Text := '01';
    L1.Text := Copy(sDate,1,2);
    A1.Text := '20' + Copy(sDate,3,2);
    DecodeDate(Now, Y, M, D);
    if M = 2 then  //if(( year % 4 == 0 && year % 100 != 0 ) || year % 400 = 0 )
      if (((Y mod 4) = 0) and ((Y mod 100) <> 0)) or ((Y mod 400) = 0) then Z2.Text := '29'
      else Z2.Text := '28'
    else
      if (M < 8) then
        if((M mod 2) = 0) then Z2.Text := '30'
        else Z2.Text := '31'
      else if((M mod 2) = 0) then Z2.Text := '31'
        else Z2.Text := '30';
    L2.Text := L1.Text;
    A2.Text := A1.Text;
    Z1.Visible := False;
    L1.Visible := False;
    A1.Visible := False;
    Z2.Visible := False;
    L2.Visible := False;
    A2.Visible := False;
    Label1.Visible := False;
    Label2.Caption := Detail.DenFur + ' - rulaj luna ' + L1.Text + '/' + A1.Text;
    Label3.Caption := Label2.Caption;
    DBFact.Top := 34;
    Btn_Afiseaza.Visible := False;
    CGest.Visible := False;
    Btn_Renunta.Caption := '&Ok';
    Btn_Renunta.Top := DBFact.Height + 40;
    Btn_Renunta.Left := (Width - Btn_Renunta.Width) div 2;
    Height := Btn_Renunta.Top + 31;
    CGest.Items.CommaText := MainForm.CGest.Items.CommaText;
    CGest.ItemIndex := CGest.Items.IndexOf(Detail.Firma);
    Btn_Afiseaza.Tag := 1; //will disable SetFocus
    Btn_AfiseazaClick(Self);
  end;
  FisaClient.ShowModal;
  FisaClient.Free;
end;

procedure TFurDetail.CBAllClick(Sender: TObject);
var
  I: integer;
begin
  SQL := '';
  SQLExec(QFact,'SET @NR_FACT := 0');
  if CBAll.Checked then begin
    for I := 0 to MainForm.CGest.Items.Count - 1 do
      SQL := SQL +
      'SELECT U.NUMAR NRDFC, CONCAT(SUBSTRING(U.DATA,1,2),".",SUBSTRING(U.DATA,3,2),".",SUBSTRING(U.DATA,5,4)) DATAFC, U.VALOARE SUMADB, IFNULL(SUMACR, U.VALOARE) SUMACR, ' +
        'ROUND(U.VALOARE - IF(F.SUMACR IS NULL, U.VALOARE, F.SUMACR),2) SUMA, ' +
        'REPLACE(REPLACE(REPLACE(REPLACE("' + MainForm.CGest.Items[I] + '","quality","QUALITY SOFT"),"fsoftware","DAVID SOFTWARE"),"fservices","DAVID SOFT SERVICES"),"fdsoft","D-SOFT") AS FIRMA, ' +
        '@NR_CRT := @NR_CRT + 1 ID ' +
      'FROM `' + MainForm.CGest.Items[I] + '`.`UMIV` U LEFT JOIN `' + MainForm.CGest.Items[I] + '`.`FRES' + sDate + '` F ON U.CODFUR = F.CODFC AND U.NUMAR = F.NRDFC ' +
      'WHERE IF(F.CONTFC IS NULL, U.CONT_COR LIKE "4111%", F.CONTFC LIKE "4111%") AND (U.CODFUR = "' + Detail.CodFur + '") UNION ALL ';
    SQL := Copy(SQL, 1, Length(SQL) - 11) + ' ORDER BY CONCAT(MID(DATAFC,7,4),MID(DATAFC,4,2),MID(DATAFC,1,2)) DESC';
  end else begin
    for I := 0 to MainForm.CGest.Items.Count - 1 do
      SQL := SQL +
      'SELECT NRDFC, CONCAT(SUBSTRING(DATAFC,1,2),".",SUBSTRING(DATAFC,3,2),".",SUBSTRING(DATAFC,5,4)) AS DATAFC, SUMADB, SUMACR, (SUMADB - SUMACR) AS SUMA, ' +
      'REPLACE(REPLACE(REPLACE(REPLACE("' + MainForm.CGest.Items[I] + '","quality","QUALITY SOFT"),"fsoftware","DAVID SOFTWARE"),"fservices","DAVID SOFT SERVICES"),"fdsoft","D-SOFT") AS FIRMA, ' +
      '@NR_CRT := @NR_CRT + 1 ID ' +
      'FROM `' + MainForm.CGest.Items[I] + '`.`FRES' + sDate + '` ' +
      'WHERE (CONTFC LIKE "4111%") AND ((SUMADB - SUMACR) <> 0) AND (CODFC = "' + Detail.CodFur + '") UNION ALL ';
    SQL := Copy(SQL, 1, Length(SQL) - 11) + ' ORDER BY CONCAT(MID(DATAFC,7,4),MID(DATAFC,4,2),MID(DATAFC,1,2)) DESC';
  end;
  ReDrawForm(Sender);
end;

procedure TFurDetail.DBContractDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  ARect: TRect;
  S: string;
begin
  ARect := Rect;
  if Rect.Top = 0 then Exit;

  if DBContract.DataSource.DataSet.FieldByName('ID').AsInteger mod 2 = 0 then
    DBContract.Canvas.Brush.Color := Colors.Odd//$00E28F7B
  else DBContract.Canvas.Brush.Color := Colors.Even;//$00E2A596;

  S := Column.Field.Text;

  if DBContract.DataSource.DataSet.FieldByName('VALAB').AsString = 'E' then
      DBContract.Canvas.Font.Color := RGB(112, 112, 112)
  else begin
    if Detail.Stare = 'B' then
      DBContract.Canvas.Font.Color := RGB(192, 64, 64);
    DBContract.Canvas.Font.Style := [fsBold];
  end;

  (Sender as TDBGrid).Canvas.FillRect(Rect);
  ARect.Left := Rect.Left + 2;
  DrawText((Sender as TDBGrid).Canvas.Handle, PChar(S), Length(S), ARect, 1);
end;

procedure TFurDetail.DBContractMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  GridCoord: TGridCoord;
  DBGrid: TDBGrid;
  SavedActiveRec: integer;
begin
  DBGrid := TDBGrid(Sender);
  GridCoord := DBGrid.MouseCoord(X, Y);
  if (GridCoord.X > 0) and (GridCoord.X < DBGrid.Columns.Count) and (GridCoord.Y > 0) then
  begin
    SavedActiveRec := THDbGrid(DBGrid).DataLink.ActiveRecord;
    THDbGrid(DBGrid).DataLink.ActiveRecord := GridCoord.Y - 1;
    DBGrid.Hint := DBContract.Columns[7].Field.AsString;
    THDbGrid(DBGrid).DataLink.ActiveRecord := SavedActiveRec;
  end
  else
    DBGrid.Hint := '';
end;

procedure TFurDetail.DBFactDblClick(Sender: TObject);
begin
  L1Click(Self);
end;

procedure TFurDetail.DBFactDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  S: string;
  ARect: TRect;
  Temp: string;
begin
  ARect := Rect;
  if Rect.Top = 0 then Exit;
  if DBFact.DataSource.DataSet.FieldByName('ID').AsInteger mod 2 = 0 then
    DBFact.Canvas.Brush.Color := Colors.Odd//$00E28F7B
  else DBFact.Canvas.Brush.Color := Colors.Even;//$00E2A596;

  S := StringReplace(Column.Field.Text, '&', '&&', [rfReplaceAll]);
  if Selections.IndexOf(DBFact.Fields[0].Text + '|' + DBFact.Fields[1].Text + '!' + DBFact.Fields[2].Text) >= 0 then begin
    (Sender as TDBGrid).Canvas.Brush.Color := Colors.Selection;//$00C08000;
    if Column.Field.Index <> 2 then (Sender as TDBGrid).Canvas.Font.Color := clWhite;
  end;
  if gdSelected in State then (Sender as TDBGrid).Canvas.Brush.Color := Colors.Cursor;
  (Sender as TDBGrid).Canvas.FillRect(Rect);
  ARect.Left := Rect.Left + 2;

  Temp := DBFact.DataSource.DataSet.FieldByName('DATAFC').AsString;
  if Copy(Temp, 9, 2) < Copy(SDate, 3, 2) then begin
    (Sender as TDBGrid).Canvas.Font.Color := RGB(192,64,64);
    if DBFact.DataSource.DataSet.FieldByName('SUMA').AsInteger <> 0 then
      (Sender as TDBGrid).Canvas.Font.Style := [fsBold];
  end;

  if Column.Index < 3 then
    DrawText((Sender as TDBGrid).Canvas.Handle, PChar(S), Length(S), ARect, 1);

  if Column.Index >= 3 then begin
    if S = '0' then (Sender as TDBGrid).Canvas.Font.Color := RGB(112,112,112);
    S := FloatToStrF(s2f(S),ffFixed, 15,2);
    DrawText((Sender as TDBGrid).Canvas.Handle, PChar(S), Length(S), ARect, 2)
  end;
end;

procedure TFurDetail.DBFactKeyPress(Sender: TObject; var Key: Char);
var
  Aux: string;
begin
  if Key = #13 then L1Click(Self);
  if Key = ' ' then begin
    Aux := DBFact.Fields[0].Text + '|' + DBFact.Fields[1].Text + '!' + DBFact.Fields[2].Text;
    if Selections.IndexOf(Aux) >= 0 then begin
      Selections.Delete(Selections.IndexOf(Aux));
    end else begin
      Selections.Add(Aux);
    end;
    QFact.Next;
  end;
end;

procedure TFurDetail.DBModuleDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  ARect: TRect;
  S: string;
begin
  ARect := Rect;
  if Rect.Top = 0 then Exit;

  S := Column.Field.Text;

  if (S = '0') then S := '-';
  (Sender as TDBGrid).Canvas.FillRect(Rect);
  ARect.Left := Rect.Left + 2;
  DrawText((Sender as TDBGrid).Canvas.Handle, PChar(S), Length(S), ARect, 1);
end;

procedure TFurDetail.ECOD_FISCALKeyPress(Sender: TObject; var Key: Char);
begin
  Key := #0;
end;

procedure TFurDetail.EEMailEnter(Sender: TObject);
begin
  if EEMail.Text = 'nu aveti selectata nici o adresa' then
    EEMail.Text := '';
  EEmail.Font.Color := clWindowText;
  EEmail.Font.Style := []
end;

procedure TFurDetail.EEMailExit(Sender: TObject);
begin                            //Refresh Email!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  SQLExec(MainForm.QTemp,
    'DELETE FROM DBCABCONTA.FACT_DEFAULT WHERE CODFUR="' + Detail.CodFur +'"');
  SQLExec(MainForm.QTemp,
    'INSERT INTO DBCABCONTA.FACT_DEFAULT (CODFUR, EMAIL) VALUES ("' +
      Detail.CodFur + '", "' + EEMail.Text + '")');
  if EEmail.Text = '' then begin
    EEmail.Font.Color := RGB(128,128,128);
    EEmail.Font.Style := [fsItalic];
    EEMail.Text := 'nu aveti selectata nici o adresa';
  end;
end;

procedure TFurDetail.EEMailKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key =VK_F6 then begin
    Self.Hint := '';
    SelMail.Start(Detail.CodFur, 'FMAIL');
    SelMail.LClient.Caption := Detail.DenFur;
    SelMail.ShowModal;
    SelMail.Free;
    if Self.Hint <> '' then begin
      EEmail.Text := Self.Hint;
    end;
  end;
end;

procedure TFurDetail.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ModalResult := mrOk;
end;

procedure TFurDetail.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then Close;
end;

procedure TFurDetail.ReDrawForm(Sender: TObject);
var
  MaxHeigth: word;
begin
  SQLExec(QFact,'SET @NR_CRT := 0');
  SQLOpen(QFact,SQL);
  if QFact.RecordCount = 0 then begin
    DBFact.Visible := False;
    LFacturi.Visible := False;
    LNrFact.Visible := False;
    LTotal.Visible := False;
    LContract.Top := 77;
    DBContract.Top := 94;
    Btn_Fisa.Top := 67;
    Btn_Extras.Top := 67;
    Btn_Mail.Top := 67;
    Btn_Jurnal.Top := 67;
    Btn_Rulaj.Top := 67;
  end else begin
    if QFact.RecordCount > 10 then
      MaxHeigth := 10
    else
      MaxHeigth := QFact.RecordCount;
    LLaZi.Visible := False;
    DBFact.Visible := True;
    LFacturi.Visible := True;
    LNrFact.Visible := True;
    LTotal.Visible := True;
    LTotal.Left := ClientWidth - LTotal.Width - 3;
    DBFact.Height := (MaxHeigth) * 16 + 29;
    LNrFact.Top := DBFact.Top + DBFact.Height;
    LTotal.Top := LNrFact.Top;
    Btn_Fisa.Top := LNrFact.Top + LNrFact.Height + 2;
    Btn_Extras.Top := Btn_Fisa.Top;
    Btn_Mail.Top := Btn_Fisa.Top;
    Btn_Jurnal.Top := Btn_Fisa.Top;
    Btn_Rulaj.Top := Btn_Fisa.Top;
    LContract.Top := LNrFact.Top + 36;
    DBContract.Top := LContract.Top + 17;
    FurDetail.ClientHeight := DBContract.Top + DBContract.Height + 3;
  end;
  QContracte.SQL.Text := 'SELECT SUM(SUMA), COUNT(NRDFC) FROM (' + SQL + ') AS TEMP';
  QContracte.Active := True;
  LNrFact.Caption := 'Numar facturi: ' + QContracte.Fields[1].AsString;
  LTotal.Caption := 'Total sold: ' + QContracte.Fields[0].AsString + ' RON';
  QContracte.SQL.Text := SQLCon;
  QContracte.Active := True;
  if QContracte.RecordCount = 0 then begin
    DBContract.Visible := False;
    LContract.Visible := False;
    FurDetail.ClientHeight := Btn_Fisa.Top + Btn_Fisa.Height + 3;
  end else
    DBContract.Height := (QContracte.RecordCount) * 16 + 29;
  if DBContract.Visible then ClientHeight := DBContract.Top + DBContract.Height + 3
  else ClientHeight := Btn_Fisa.Top + Btn_Fisa.Height + 3;
  MQuery.SQL.Text := 'SELECT CODFUR, SUM(C),SUM(G),SUM(S),SUM(M),SUM(F),SUM(GW),SUM(RC),SUM(EX),SUM(GR) FROM DBCABCONTA.AL_MIV WHERE CODFUR="' + Detail.CodFur + '" GROUP BY CODFUR';
  MQuery.Open;
  if MQuery.RecordCount = 0 then begin
    DBModule.Visible := False;
    LModule.Visible := False;
    if DBContract.Visible then ClientHeight := DBContract.Top + DBContract.Height + 3
    else ClientHeight := Btn_Fisa.Top + Btn_Fisa.Height + 3;
  end else begin
    if DBContract.Visible then begin
      LModule.Top := DBContract.Height + DBContract.Top + 12;
      DBModule.Top := LModule.Top + 17;
      ClientHeight := DBModule.Top + 47;
    end
    else begin
      if DBFact.Visible then begin
        LModule.Top := LNrFact.Top + 36;
        DBModule.Top := LModule.Top + 17;
        ClientHeight := DBModule.Top + 47;
      end else begin
        LModule.Top := 77;
        DBModule.Top := 94;
        ClientHeight := DBModule.Top + 47;
      end;
    end;
  end;
end;

procedure TFurDetail.SnatchEmail;
var
  Temp: string;
begin
  SQLOpen(QFact,
    'SELECT ' +
      'IF(COD_FISCAL <> "", COD_FISCAL, FUR.CODFUR) COD_FISCAL, DENFUR, IFNULL(FD.EMAIL, "") EMAIL ' +
    'FROM ' + Detail.Firma + '.FUR LEFT JOIN DBCABCONTA.FACT_DEFAULT FD USING(CODFUR) ' +
    'WHERE FUR.CODFUR="' + Detail.CodFur + '"');
  if QFact.RecordCount <> 0 then begin
    ECOD_FISCAL.Text := QFact.FieldByName('COD_FISCAL').AsString;
    EDENFUR.Text := QFact.FieldByName('DENFUR').AsString;
    Temp := QFact.FieldByName('EMAIL').AsString;
    if Temp = '' then begin
      EEMail.Text := 'nu aveti selectata nici o adresa';
      EEmail.Font.Color := RGB(128,128,128);
      EEmail.Font.Style := [fsItalic]
    end else begin
      EEMail.Text := Temp;
      ECOD_FISCAL.Text := Detail.CodFur;
      EDENFUR.Text := Detail.DenFur;
    end;
  end;
  CBAllClick(Self);
end;

procedure TFurDetail.FormShow(Sender: TObject);
begin
  FurDetail.Color := MainForm.Color;

  if MainForm.Options.Values['VER_DEF_EMAIL'] <> '1' then begin
    SQLExec(QFact,
      'CREATE TABLE IF NOT EXISTS `DBCABCONTA`.`FACT_DEFAULT` (' +
      '  `CODFUR` varchar(15) NOT NULL default "", ' +
      '  `EMAIL` varchar(50) NOT NULL default "", ' +
      '  PRIMARY KEY  (`CODFUR`), ' +
      '  KEY `CODFUR` (`CODFUR`), ' +
      '  KEY `EMAIL` (`EMAIL`) ' +
      ') ENGINE=InnoDB DEFAULT CHARSET=latin1');
    MainForm.Options.Values['VER_DEF_EMAIL'] := '1';
  end;

  SnatchEmail;

  if Detail.Stare = 'B' then begin
    ESTARE.Brush.Color := clRed;
    EStare.Hint := 'Client blocat'
  end;

  DBFact.Color := Colors.Even;
  DBContract.Color := Colors.Even;
  DBModule.Color := Colors.Even;

  ECOD_FISCAL.Color := Colors.Even;
  EDENFUR.Color := Colors.Even;
  EEMail.Color := Colors.Even;

  ReDrawForm(Sender);
end;

procedure TFurDetail.L1Click(Sender: TObject);
var
  Q1: TQuery;
  TotalBaza: string;
  TotalTVA: string;
  TotalFact: string;
  TempRap: TTempRap;
  dbName: string;
  NrFact: string;
  DataFact: string;
  CursValuta: string;
  TipValuta: string;
  FirmaSerie: string;
  FirmaDenfur: string;
  FirmaCUI: string;
  FirmaNrOrdReg: string;
  FirmaSediu: string;
  FirmaJudet: string;
  FirmaCont: string;
  FirmaBanca: string;
  FirmaCapSocial: string;
  FirmaIntocmit: string;
  FirmaTrezo:string;
  FirmaBancaTR:string;
  Temp: string;
begin
  Temp := GetCurrentDir;
  Q1 := TQuery.Create(MainForm);
  Q1.DatabaseName := MainForm.DB.DatabaseName;
  dbName := DBFact.Fields[0].AsString;
  dbName := StringReplace(StringReplace(StringReplace(StringReplace(dbName, 'D-SOFT', 'fdsoft', []), 'QUALITY SOFT', 'quality', []), 'DAVID SOFTWARE', 'fsoftware', []), 'DAVID SOFT SERVICES', 'fservices', []);
  if dbName = 'fdsoft' then begin
    FirmaSerie := 'TM DST';
    FirmaDenfur := 'S.C. D-SOFT SRL';
    FirmaCUI := 'RO1819101';
    FirmaNrOrdReg := 'J35/2230/1992';
    FirmaSediu := 'B-DUL L. REBREANU, NR 53';
    FirmaJudet := 'TIMIS';
    FirmaCont := 'RO78BACX0000000186498000';
    FirmaBanca := 'UNICREDIT TIRIAC BANK';
    FirmaTrezo := 'RO92TREZ6215069XXX002049';
    FirmaBancaTr := 'TREZORERIA TIMISOARA';
    FirmaCapSocial := '16.720 RON';
    FirmaIntocmit := 'Document intocmit de: Milovan Teodora CNP: 2730504354739 C.I.: TM 638621';
  end;
  if dbName = 'fsoftware' then begin
    FirmaSerie := 'TM DSW';
    FirmaDenfur := 'S.C. DAVID SOFTWARE SRL';
    FirmaCUI := 'RO14302491';
    FirmaNrOrdReg := 'J35/1316/2001';
    FirmaSediu := 'B-DUL L. REBREANU, NR 53';
    FirmaJudet := 'TIMIS';
    FirmaCont := 'RO74BACX0000000186481000';
    FirmaBanca := 'UNICREDIT TIRIAC BANK';
    FirmaTrezo := 'RO38TREZ6215069XXX006513';
    FirmaBancaTr := 'TREZORERIA TIMISOARA';
    FirmaCapSocial := '200 RON';
    FirmaIntocmit := 'Document intocmit de: Rujan Monica CNP: 2710310352631 C.I.: TM 288392';
  end;
  if dbName = 'fservices' then begin
    FirmaSerie := 'TM SRV';
    FirmaDenfur := 'S.C. DAVID SOFT SERVICES SRL';
    FirmaCUI := 'RO18025890';
    FirmaNrOrdReg := 'J35/3222/2005';
    FirmaSediu := 'B-DUL L. REBREANU, NR 53';
    FirmaJudet := 'TIMIS';
    FirmaCont := 'RO93BACX0000000234116000';
    FirmaBanca := 'UNICREDIT TIRIAC BANK';
    FirmaCapSocial := '200 RON';
    FirmaIntocmit := 'Document intocmit de: David Anca Simona CNP: 2770429354783 C.I.: TM 522703';
  end;
  if dbName = 'quality' then begin
    FirmaSerie := 'TM QUS';
    FirmaDenfur := 'S.C. QUALITY SOFT SRL';
    FirmaCUI := 'RO24192396';
    FirmaNrOrdReg := 'J35/2602/2008';
    FirmaSediu := 'B-DUL L. REBREANU, NR 53';
    FirmaJudet := 'TIMIS';
    FirmaCont := 'RO02BACX0000000244708001';
    FirmaBanca := 'UNICREDIT TIRIAC BANK';
    FirmaCapSocial := '200 RON';
    FirmaIntocmit := 'Document intocmit de: David Anca Simona CNP: 2770429354783 C.I.: TM 522703';
  end;
  NrFact := DBFact.Fields[1].AsString;
  DataFact := DBFact.Fields[2].AsString;
  DataFact := Copy(DataFact, 1, 2) + Copy(DataFact, 4, 2) + Copy(DataFact, 7, 4);
  Q1.SQL.Text :=
    'SELECT SUM(VALOARE) AS TOTALBAZA, SUM(VAL_TVA) AS TOTALTVA, SUM(VALOARE + VAL_TVA) AS TOTALFACT ' +
    'FROM `' + dbName + '`.`MIV' + Copy(DataFact, 3, 2) + Copy(DataFact, 7, 2) + '` WHERE NUMAR = "' + NrFact + '"';
  Q1.Open;
  TotalBaza := Q1.FieldByName('TOTALBAZA').AsString;
  if Pos(DecimalSeparator, TotalBaza) = 0 then TotalBaza := TotalBaza + DecimalSeparator + '00';
  TotalTVA := Q1.FieldByName('TOTALTVA').AsString;
  if Pos(DecimalSeparator, TotalTVA) = 0 then TotalTVA := TotalTVA + DecimalSeparator + '00';
  TotalFact := Q1.FieldByName('TOTALFACT').AsString;
  if Pos(DecimalSeparator, TotalFact) = 0 then TotalFact := TotalFact + DecimalSeparator + '00';
  Q1.SQL.Text :=
    'SELECT * FROM `' + dbName + '`.`FUR` WHERE CODFUR="' + Detail.CodFur + '"';
  Q1.Open;
  if Q1.FieldByName('CONT_DM').AsString <> '' then TipValuta := 'EUR';
  if Q1.FieldByName('CONT_USD').AsString <> '' then TipValuta := 'USD';
  Q1.SQL.Text :=
    'SELECT * ' +
    'FROM `' + dbName + '`.`CURS` WHERE ADATA = ("' + Copy(DataFact, 5, 4) + Copy(DataFact, 3, 2) + Copy(DataFact, 1, 2) + '") AND (COD_VALUTA = "' + TipValuta + '")';
  Q1.Open;
  CursValuta := Q1.FieldByName('CURS1').AsString;
  Q1.SQL.Text :=
    'SELECT * ' +
    'FROM `' + dbName + '`.`MIV' + Copy(DataFact, 3, 2) + Copy(DataFact, 7, 2) + '` LEFT JOIN `' + dbName + '`.`FUR` USING(CODFUR) ' +
    'WHERE NUMAR = "' + NrFact + '"';
  Q1.Open;
  TempRap := TTempRap.Create(MainForm);
  TempRap.R1.Query := Q1;
    with TempRap.RP do begin
      ProjectFile := 'Factura.rav';
      TempRap.RS.DefaultDest := rdPreview;
      Open;
      SetParam('NRCRT', '0');
      SetParam('FIRMA_DENFUR', FirmaDenfur);
      SetParam('FIRMA_CUI', FirmaCUI);
      SetParam('FIRMA_NRORDREG', FirmaNrOrdReg);
      SetParam('FIRMA_ADR', FirmaSediu);
      SetParam('FIRMA_JUDET', FirmaJudet);
      SetParam('FIRMA_CONT', FirmaCont);
      SetParam('FIRMA_BANCA', FirmaBanca);
      SetParam('FIRMA_TREZO', FirmaTrezo);
      SetParam('FIRMA_BANCA_TR', FirmaBancaTR);
      SetParam('FIRMA_CAPSOC', FirmaCapSocial);
      SetParam('FIRMA_SERIE', FirmaSerie);
      SetParam('INTOCMIT', FirmaIntocmit);
      SetParam('TOTAL_BAZA', TotalBaza);
      SetParam('TOTAL_TVA', TotalTVA);
      SetParam('TOTAL_FACT', TotalFact);
      SetParam('CURS_VALUTA', CursValuta);
      SetParam('TIP_VALUTA', 'Curs ' + TipValuta + ':');
      SetParam('NRCRT', '0');
      SetParam('IMAGE', Temp + '\Images\' + dbName + '.bmp');
      SetParam('SIGIMAGE', Temp + '\Images\sig' + dbName + '.bmp');
      ExecuteReport('Report2');
      Close;
    end;
  TempRap.Free;
  Q1.Free;
  SetCurrentDir(Temp);
end;

procedure TFurDetail.MakeInvoice(dbName, NrFact, DataFact, fFileName: string);
var
  Q1: TQuery;
  TotalBaza: string;
  TotalTVA: string;
  TotalFact: string;
  TempRap: TTempRap;
  CursValuta: string;
  TipValuta: string;
  FirmaDenfur: string;
  FirmaCUI: string;
  FirmaNrOrdReg: string;
  FirmaSediu: string;
  FirmaJudet: string;
  FirmaCont: string;
  FirmaBanca: string;
  FirmaTrezo:string;
  FirmaBancaTR:string;
  FirmaCapSocial: string;
  FirmaIntocmit: string;
  Temp: string;
begin
  Temp := GetCurrentDir;
  Q1 := TQuery.Create(MainForm);
  Q1.DatabaseName := MainForm.DB.DatabaseName;
  if dbName = 'fdsoft' then begin
    FirmaDenfur := 'S.C. D-SOFT SRL';
    FirmaCUI := 'RO1819101';
    FirmaNrOrdReg := 'J35/2230/1992';
    FirmaSediu := 'B-DUL L. REBREANU, NR 53';
    FirmaJudet := 'TIMIS';
    FirmaCont := 'RO78BACX0000000186498000';
    FirmaBanca := 'UNICREDIT TIRIAC BANK';
    FirmaTrezo := 'RO92TREZ6215069XXX002049';
    FirmaBancaTr := 'TREZORERIA TIMISOARA';
    FirmaCapSocial := '16.720 RON';
    FirmaIntocmit := 'Document intocmit de: Milovan Teodora CNP: 2730504354739 C.I.: TM 638621';
  end;
    if dbName = 'fsoftware' then begin
    FirmaDenfur := 'S.C. DAVID SOFTWARE SRL';
    FirmaCUI := 'RO14302491';
    FirmaNrOrdReg := 'J35/1316/2001';
    FirmaSediu := 'B-DUL L. REBREANU, NR 53';
    FirmaJudet := 'TIMIS';
    FirmaCont := 'RO74BACX0000000186481000';
    FirmaBanca := 'UNICREDIT TIRIAC BANK';
    FirmaTrezo := 'RO38TREZ6215069XXX006513';
    FirmaBancaTr := 'TREZORERIA TIMISOARA';
    FirmaCapSocial := '200 RON';
    FirmaIntocmit := 'Document intocmit de: Rujan Monica CNP: 2710310352631 C.I.: TM 288392';
  end;
    if dbName = 'fservices' then begin
    FirmaDenfur := 'S.C. DAVID SOFT SERVICES SRL';
    FirmaCUI := 'RO18025890';
    FirmaNrOrdReg := 'J35/3222/2005';
    FirmaSediu := 'B-DUL L. REBREANU, NR 53';
    FirmaJudet := 'TIMIS';
    FirmaCont := 'RO93BACX0000000234116000';
    FirmaBanca := 'UNICREDIT TIRIAC BANK';
    FirmaCapSocial := '200 RON';
    FirmaIntocmit := 'Document intocmit de: David Anca Simona CNP: 2770429354783 C.I.: TM 522703';
  end;
    if dbName = 'quality' then begin
    FirmaDenfur := 'S.C. QUALITY SOFT SRL';
    FirmaCUI := 'RO24192396';
    FirmaNrOrdReg := 'J35/2602/2008';
    FirmaSediu := 'B-DUL L. REBREANU, NR 53';
    FirmaJudet := 'TIMIS';
    FirmaCont := 'RO02BACX0000000244708001';
    FirmaBanca := 'UNICREDIT TIRIAC BANK';
    FirmaCapSocial := '200 RON';
    FirmaIntocmit := 'Document intocmit de: David Anca Simona CNP: 2770429354783 C.I.: TM 522703';
  end;
  if Length(DataFact) = 10 then
    DataFact := Copy(DataFact, 1, 2) + Copy(DataFact, 4, 2) + Copy(DataFact, 7, 4);
  Q1.SQL.Text :=
    'SELECT SUM(VALOARE) AS TOTALBAZA, SUM(VAL_TVA) AS TOTALTVA, SUM(VALOARE + VAL_TVA) AS TOTALFACT ' +
    'FROM `' + dbName + '`.`MIV' + Copy(DataFact, 3, 2) + Copy(DataFact, 7, 2) + '` WHERE NUMAR = "' + NrFact + '"';
  Q1.Open;
  TotalBaza := Q1.FieldByName('TOTALBAZA').AsString;
  if Pos(DecimalSeparator, TotalBaza) = 0 then TotalBaza := TotalBaza + DecimalSeparator + '00';
  TotalTVA := Q1.FieldByName('TOTALTVA').AsString;
  if Pos(DecimalSeparator, TotalTVA) = 0 then TotalTVA := TotalTVA + DecimalSeparator + '00';
  TotalFact := Q1.FieldByName('TOTALFACT').AsString;
  if Pos(DecimalSeparator, TotalFact) = 0 then TotalFact := TotalFact + DecimalSeparator + '00';
  Q1.SQL.Text :=
    'SELECT * FROM `' + dbName + '`.`FUR` WHERE CODFUR="' + Detail.CodFur + '"';
  Q1.Open;
  if Q1.FieldByName('CONT_DM').AsString <> '' then TipValuta := 'EUR';
  if Q1.FieldByName('CONT_USD').AsString <> '' then TipValuta := 'USD';
  Q1.SQL.Text :=
    'SELECT * ' +
    'FROM `' + dbName + '`.`CURS` WHERE ADATA = ("' + Copy(DataFact, 5, 4) + Copy(DataFact, 3, 2) + Copy(DataFact, 1, 2) + '") AND (COD_VALUTA = "' + TipValuta + '")';
  Q1.Open;
  CursValuta := Q1.FieldByName('CURS1').AsString;
  Q1.SQL.Text :=
    'SELECT * ' +
    'FROM `' + dbName + '`.`MIV' + Copy(DataFact, 3, 2) + Copy(DataFact, 7, 2) + '` LEFT JOIN `' + dbName + '`.`FUR` USING(CODFUR) ' +
    'WHERE NUMAR = "' + NrFact + '"';
  Q1.Open;
  TempRap := TTempRap.Create(MainForm);
  TempRap.R1.Query := Q1;
  TempRap.RP.ProjectFile := 'Factura.rav';
  with TempRap.RS do begin
    OutputFileName:= GetCurrentDir + '\' + fFileName;
    DefaultDest := rdFile;
    DoNativeOutput:= False;
    RenderObject:= TempRap.RR_PDF;
  end;
  with TempRap.RP do begin
    Open;
    SetParam('FIRMA_DENFUR', FirmaDenfur);
    SetParam('FIRMA_CUI', FirmaCUI);
    SetParam('FIRMA_NRORDREG', FirmaNrOrdReg);
    SetParam('FIRMA_ADR', FirmaSediu);
    SetParam('FIRMA_JUDET', FirmaJudet);
    SetParam('FIRMA_CONT', FirmaCont);
    SetParam('FIRMA_BANCA', FirmaBanca);
    SetParam('FIRMA_TREZO', FirmaTrezo);
    SetParam('FIRMA_BANCA_TR', FirmaBancaTR);
    SetParam('FIRMA_CAPSOC', FirmaCapSocial);
    SetParam('INTOCMIT', FirmaIntocmit);
    SetParam('TOTAL_BAZA', TotalBaza);
    SetParam('TOTAL_TVA', TotalTVA);
    SetParam('TOTAL_FACT', TotalFact);
    SetParam('CURS_VALUTA', CursValuta);
    SetParam('TIP_VALUTA', 'Curs ' + TipValuta + ':');
    SetParam('NRCRT', '0');
    SetParam('IMAGE', Temp + '\Images\' + dbName + '.bmp');
    SetParam('SIGIMAGE', Temp + '\Images\sig' + dbName + '.bmp');
    ExecuteReport('Report2');
    Close;
  end;
  TempRap.Free;
  Q1.Free;
  SetCurrentDir(Temp);
end;

procedure TFurDetail.Trimitemail1Click(Sender: TObject);
var
  Aux: string;
  I: Integer;
  InvoiceNo: string;
  InvoiceDate: string;
  dbFirm: string;
  CurDir: string;
begin
  CurDir := GetCurrentDir;
  if Selections.Count = 0 then begin
    Selections.Add(DBFact.Fields[0].Text + '|' + DBFact.Fields[1].Text + '!' + DBFact.Fields[2].Text);
    DBFact.Tag := 1;
  end;

  SelMail.Start(Detail.CodFur, 'FA'); //Need it here to initialize Attachments

  for I := 0 to Selections.Count - 1 do begin
    Aux := Selections[I];
    dbFirm := Copy(Aux, 1, Pos('|', Aux) - 1);
    Delete(Aux, 1, Pos('|', Aux));
    InvoiceNo := Copy(Aux, 1, Pos('!', Aux) - 1);
    Delete(Aux, 1, Pos('!', Aux));
    InvoiceDate := Aux;
    dbFirm := StringReplace(StringReplace(StringReplace(StringReplace(dbFirm, 'D-SOFT', 'fdsoft', []), 'QUALITY SOFT', 'quality', []), 'DAVID SOFTWARE', 'fsoftware', []), 'DAVID SOFT SERVICES', 'fservices', []);
    MakeInvoice(dbFirm, InvoiceNo, InvoiceDate, 'TempFile_Fact' + InvoiceNo + '.pdf');
    SelMail.AttachedFiles.Add(GetCurrentDir + '\TempFile_Fact' + InvoiceNo + '.pdf');
  end;

  if Selections.Count = 1 then
    SelMail.LTitlu.Hint := InvoiceNo + '/' + InvoiceDate
  else
    SelMail.LTitlu.Hint := Selections.CommaText;
  SelMail.LClient.Caption := StringReplace(Detail.DenFur, '&', '&&', [rfReplaceAll]);
  SelMail.ShowModal;
  SelMail.Free;
  if DBFact.Tag = 1 then begin
    Selections.Clear;
    DBFact.Tag := 0;
  end;
  SetCurrentDir(CurDir);
end;

function TFurDetail.Start(LLAA, CodFur, DenFur, Stare, NrFact, Suma, Firma: string): integer;
var
  I: Integer;
begin
  FurDetail := TFurDetail.Create(Application);
  Selections := TStringList.Create;
  SQL := '';
  for I := 0 to MainForm.CGest.Items.Count - 1 do
    SQL := SQL +
    'SELECT ' +
      'NRDFC, CONCAT(MID(DATAFC,1,2),".",MID(DATAFC,3,2),".",MID(DATAFC,5,4)) AS DATAFC, ' +
      'SUMADB, SUMACR, (SUMADB - SUMACR) AS SUMA, ' +
      'REPLACE(REPLACE(REPLACE(REPLACE("' + MainForm.CGest.Items[I] + '","quality","QUALITY SOFT"), ' +
        '"fsoftware","DAVID SOFTWARE"),"fservices","DAVID SOFT SERVICES"),"fdsoft","D-SOFT") AS FIRMA, @NR_CRT := @NR_CRT + 1 ID ' +
    'FROM `' + MainForm.CGest.Items[I] + '`.`FRES' + LLAA + '` ' +
    'WHERE (CONTFC="4111") AND ((SUMADB - SUMACR) <> 0) AND (CODFC = "' + CodFur + '") UNION ALL ';
  SQL := Copy(SQL, 1, Length(SQL) - 11) + ' ORDER BY FIRMA ASC, CONCAT(MID(DATAFC,7,4),MID(DATAFC,4,2),MID(DATAFC,1,2)) DESC';
  SQLCon := '';
  for I := 0 to MainForm.CGest.Items.Count - 1 do
    SQLCon := SQLCon +
    'SELECT CONCAT(NUMAR, " / ", CONCAT(SUBSTRING(DATA,7,2),".",SUBSTRING(DATA,5,2),".",SUBSTRING(DATA,1,4))), ' +
    'CONCAT(CONCAT(SUBSTRING(DATAIN,7,2),".",SUBSTRING(DATAIN,5,2),".",SUBSTRING(DATAIN,1,4)), " - ",' +
      'CONCAT(SUBSTRING(DATAOUT,7,2),".",SUBSTRING(DATAOUT,5,2),".",SUBSTRING(DATAOUT,1,4))), ' +
    'IF(CLASA=12,"Anual",IF(CLASA=6,"Sem.",IF(CLASA=3,"Trim.",IF(CLASA=1,"Lunar","N/A")))), ' +
    'CONCAT(VALOARE, " ", TIPVALUT), ' +
    'CONCAT(IF(CODCONTRACTE&2=2,"C",""), IF(CODCONTRACTE&4=4,"G",""), IF(CODCONTRACTE&8=8,"S",""), ' +
      'IF(CODCONTRACTE&16=16,"M",""), IF(CODCONTRACTE&32=32,"Fa",""), IF(CODCONTRACTE&64=64,"Gw",""), ' +
      'IF(CODCONTRACTE&128=128,"Rc",""), IF(CODCONTRACTE&256=256,"Ex",""), IF(CODCONTRACTE&512=512,"Gr",""), IF(CODCONTRACTE&1024=1024,"Bk","")) AS CONTRACT, ' +
    'REPLACE(REPLACE(REPLACE(REPLACE("' + MainForm.CGest.Items[I] + '","quality","QUALITY SOFT"),"fsoftware","DAVID SOFTWARE"),"fservices","DAVID SOFT SERVICES"),"fdsoft","D-SOFT"), ' +
    'IF(CONCAT(SUBSTRING(DATAOUT,3,2),SUBSTRING(DATAOUT,5,2))<"' + Copy(LLAA, 3, 2) + Copy(LLAA, 1, 2) + '","E","V") VALAB, OBS, @NR_CRT := @NR_CRT + 1 ID ' +
    'FROM `' + MainForm.CGest.Items[I] + '`.`CONTRACTE` ' +
    'WHERE CODFUR = "' + CodFur + '" ' +
    'UNION ALL ';
  SQLCon := Copy(SQLCon, 1, Length(SQLCon) - 11) + ' ORDER BY VALAB DESC';
  Detail.CodFur := CodFur;
  Detail.DenFur := DenFur;
  Detail.Stare := Stare;
  Detail.Firma := Firma;
  Detail.LLAA := LLAA;
  Detail.NrFact := NrFact;
  Detail.Suma := Suma;
  FurDetail.ShowModal;
  FurDetail.Free;
  Selections.Free;
end;

{$R *.dfm}

end.
