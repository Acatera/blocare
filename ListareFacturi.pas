unit ListareFacturi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, DBTables, ExtCtrls, StrUtils, RpDefine;

type
  TListFact = class(TForm)
    DBFact: TDBGrid;
    LTitle: TLabel;
    DS: TDataSource;
    Query: TQuery;
    PBottom: TPanel;
    LRecordCount: TLabel;
    CGest: TComboBox;
    LDBGest: TLabel;
    RBData: TRadioButton;
    RBNumar: TRadioButton;
    Btn_List: TButton;
    Btn_Renunta: TButton;
    Panel1: TPanel;
    Panel2: TPanel;
    LData: TLabel;
    LNumar: TLabel;
    Z1: TEdit;
    L1: TEdit;
    A1: TEdit;
    Z2: TEdit;
    L2: TEdit;
    A2: TEdit;
    ENrInc: TEdit;
    ENrSf: TEdit;
    Panel3: TPanel;
    chAuto: TCheckBox;
    chMail: TCheckBox;
    chEx1: TCheckBox;
    chEx2: TCheckBox;
    procedure FormResize(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure DBFactDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBFactKeyPress(Sender: TObject; var Key: Char);
    procedure RBDataClick(Sender: TObject);
    procedure RBNumarClick(Sender: TObject);
    procedure Z1KeyPress(Sender: TObject; var Key: Char);
    procedure Z1Exit(Sender: TObject);
    procedure Z1Enter(Sender: TObject);
    procedure ENrIncKeyPress(Sender: TObject; var Key: Char);
    procedure ENrIncExit(Sender: TObject);
    procedure ENrIncEnter(Sender: TObject);
    procedure Btn_ListClick(Sender: TObject);
    procedure Btn_RenuntaClick(Sender: TObject);
    procedure chAutoClick(Sender: TObject);
  private
  public
    function Start(Firma, Options: string): wideString;
  end;

const
  Widths = Chr(15) + Chr(85);

var
  ListFact: TListFact;
  sOptions: string;
  JurSQL: string;
  Order: string;
  Group: string;
  sFirma: string;
  ColTotalWidth: integer;
  Selections: TStringList;
  NrInc: string;
  NrSf: string;

implementation

uses FMain, Temp_Rap, Fur_Detail, Sel_Mail, AlexUtils;

{$R *.dfm}

procedure TListFact.Btn_ListClick(Sender: TObject);
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
  FirmaTrezo:string;
  FirmaBancaTR:string;
  FirmaCapSocial: string;
  FirmaIntocmit: string;
  Temp: string;
  QMiv: TQuery;
  sCodF: string;
  sDenFur: string;
  CodIn: string;
  I: integer;
  isEof: boolean;
begin
  if Selections.Count = 0 then Selections.Add(DBFact.Fields[0].AsString);
  Temp := GetCurrentDir;
  Q1 := TQuery.Create(MainForm);
  Q1.DatabaseName := MainForm.DB.DatabaseName;
  QMiv := TQuery.Create(MainForm);
  QMiv.DatabaseName := MainForm.DB.DatabaseName;
  dbName := CGest.Text;
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
  if RBNumar.Checked then CodIn := '(NUMAR BETWEEN ' + ENrInc.Text + ' AND ' + ENrSf.Text + ') '
  else CodIn := StringReplace(' (COD IN ("' + StringReplace(Selections.CommaText, ',', '","', [rfReplaceAll]) + '")) ', '""', '"', [rfReplaceAll]);

  if chAuto.Checked or chMail.Checked then begin
    QMiv.SQL.Text :=
      'SELECT M.CODFUR, NUMAR, DATA, DENFUR, CONT_DM, CONT_USD, NRSCRESA ' +
      'FROM `' + dbName + '`.`MIV' + sDate + '` M LEFT JOIN `' + dbName + '`.`FUR` USING(CODFUR)' +
      'WHERE (TIP_DOC="5") AND (NRSCRESA IN (1,2,3)) AND ' + CodIn +
      'GROUP BY NUMAR, M.CODFUR, GESTIUNE, TIP_DOC ' +
      'ORDER BY NUMAR DESC';
    QMiv.Open;

    while not QMiv.Eof do begin
      NrFact := QMiv.FieldByName('NUMAR').AsString;
      DataFact := QMiv.FieldByName('DATA').AsString;
      sCodF := QMiv.FieldByName('CODFUR').AsString;
      sDenFur := QMiv.FieldByName('DENFUR').AsString;

      SelMail.Start(sCodF, 'FA');

      FurDetail.MakeInvoice(dbName, NrFact, DataFact, 'TempFile_Fact' + NrFact + '.pdf');
      SelMail.AttachedFiles.Add(GetCurrentDir + '\TempFile_Fact' + NrFact + '.pdf');

      SelMail.LTitlu.Hint := NrFact + '/' + DataFact;
      SelMail.LClient.Caption := StringReplace(sDenFur, '&', '&&', [rfReplaceAll]);
      SelMail.ShowModal;
      SelMail.Free;

      QMiv.Next;
    end;
  end;

  TempRap := TTempRap.Create(MainForm);
  TempRap.R1.Query := Q1;

  if chAuto.Checked or chEx2.Checked then begin
    QMiv.SQL.Text :=
      'SELECT M.CODFUR, NUMAR, DATA, SUM(VALOARE) AS TOTALBAZA, SUM(VAL_TVA) AS TOTALTVA, ' +
         'SUM(VALOARE + VAL_TVA) AS TOTALFACT, DENFUR, CONT_DM, CONT_USD, NRSCRESA ' +
      'FROM `' + dbName + '`.`MIV' + sDate + '` M LEFT JOIN `' + dbName + '`.`FUR` USING(CODFUR)' +
      'WHERE (TIP_DOC="5") AND (NRSCRESA IN (0,1,2,3,4)) AND ' + CodIn +
      'GROUP BY NUMAR, M.CODFUR, GESTIUNE, TIP_DOC ' +
      'ORDER BY M.NUMAR DESC';
    QMiv.Open;

    while not QMiv.Eof do begin
      sCodF := QMiv.Fields[0].AsString;
      NrFact := QMiv.Fields[1].AsString;
      DataFact := QMiv.Fields[2].AsString;
      TotalBaza := QMiv.FieldByName('TOTALBAZA').AsString;

      if Pos(DecimalSeparator, TotalBaza) = 0 then TotalBaza := TotalBaza + DecimalSeparator + '00';
      TotalTVA := QMiv.FieldByName('TOTALTVA').AsString;
      if Pos(DecimalSeparator, TotalTVA) = 0 then TotalTVA := TotalTVA + DecimalSeparator + '00';
      TotalFact := QMiv.FieldByName('TOTALFACT').AsString;
      if Pos(DecimalSeparator, TotalFact) = 0 then TotalFact := TotalFact + DecimalSeparator + '00';

      if QMiv.FieldByName('CONT_DM').AsString <> '' then TipValuta := 'EUR';
      if QMiv.FieldByName('CONT_USD').AsString <> '' then TipValuta := 'USD';

      Q1.SQL.Text :=
        'SELECT * ' +
        'FROM `' + dbName + '`.`CURS` WHERE ADATA = ("' + Copy(DataFact, 5, 4) + Copy(DataFact, 3, 2) + Copy(DataFact, 1, 2) + '") AND (COD_VALUTA = "' + TipValuta + '")';
      Q1.Open;

      CursValuta := Q1.FieldByName('CURS1').AsString;
      Q1.SQL.Text :=
        'SELECT * ' +
        'FROM `' + dbName + '`.`MIV' + sDate + '` LEFT JOIN `' + dbName + '`.`FUR` USING(CODFUR) ' +
        'WHERE NUMAR = "' + NrFact + '"';
      Q1.Open;

      TempRap.RS.SystemSetups := [ssAllowCopies,ssAllowCollate,ssAllowDuplex,ssAllowDestPreview,ssAllowDestPrinter,ssAllowDestFile,ssAllowPrinterSetup,ssAllowPreviewSetup];
        with TempRap.RP do begin
          ProjectFile := 'Factura.rav';
          TempRap.RS.DefaultDest := rdPrinter;
          Open;
          SetParam('EXEMPLAR', 'Exemplar (2/2)');
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
          SetParam('TOTAL_ARTICOLE', i2s(Q1.RecordCount));
          SetParam('IMAGE', Temp + '\Images\' + dbName + '.bmp');
          SetParam('SIGIMAGE', Temp + '\Images\sig' + dbName + '.bmp');
          ExecuteReport('Report2');
          Close;
        end;
      QMiv.Next;
    end; //Exemplar 2 listat
  end;

  if chAuto.Checked or chEx1.Checked then begin
    Application.ProcessMessages;
    QMiv.SQL.Text :=
      'SELECT M.CODFUR, NUMAR, DATA, SUM(VALOARE) AS TOTALBAZA, SUM(VAL_TVA) AS TOTALTVA, ' +
         'SUM(VALOARE + VAL_TVA) AS TOTALFACT, DENFUR, CONT_DM, CONT_USD, NRSCRESA ' +
      'FROM `' + dbName + '`.`MIV' + sDate + '` M LEFT JOIN `' + dbName + '`.`FUR` USING(CODFUR)' +
      'WHERE (TIP_DOC="5") AND (NRSCRESA IN (0,1,2,3,4)) AND ' + CodIn +
      'GROUP BY NUMAR, M.CODFUR, GESTIUNE, TIP_DOC ' +
      'ORDER BY M.NUMAR DESC';
    QMiv.Open;
    QMiv.First;

    while not QMiv.Eof do begin
      isEof := False;
      while (QMiv.FieldByName('NRSCRESA').AsInteger = 2) and not QMiv.Eof do
        QMiv.Next;

      if not QMiv.Eof then begin //need it here because it might exit the loop with EOF=True
        sCodF := QMiv.Fields[0].AsString;
        NrFact := QMiv.Fields[1].AsString;
        DataFact := QMiv.Fields[2].AsString;
        TotalBaza := QMiv.FieldByName('TOTALBAZA').AsString;

        if Pos(DecimalSeparator, TotalBaza) = 0 then TotalBaza := TotalBaza + DecimalSeparator + '00';
        TotalTVA := QMiv.FieldByName('TOTALTVA').AsString;
        if Pos(DecimalSeparator, TotalTVA) = 0 then TotalTVA := TotalTVA + DecimalSeparator + '00';
        TotalFact := QMiv.FieldByName('TOTALFACT').AsString;
        if Pos(DecimalSeparator, TotalFact) = 0 then TotalFact := TotalFact + DecimalSeparator + '00';

        if QMiv.FieldByName('CONT_DM').AsString <> '' then TipValuta := 'EUR';
        if QMiv.FieldByName('CONT_USD').AsString <> '' then TipValuta := 'USD';

        Q1.SQL.Text :=
          'SELECT * ' +
          'FROM `' + dbName + '`.`CURS` WHERE ADATA = ("' + Copy(DataFact, 5, 4) + Copy(DataFact, 3, 2) + Copy(DataFact, 1, 2) + '") AND (COD_VALUTA = "' + TipValuta + '")';
        Q1.Open;

        CursValuta := Q1.FieldByName('CURS1').AsString;
        Q1.SQL.Text :=
          'SELECT * ' +
          'FROM `' + dbName + '`.`MIV' + sDate + '` LEFT JOIN `' + dbName + '`.`FUR` USING(CODFUR) ' +
          'WHERE NUMAR = "' + NrFact + '"';
        Q1.Open;

        TempRap.RS.SystemSetups := [ssAllowCopies,ssAllowCollate,ssAllowDuplex,ssAllowDestPreview,ssAllowDestPrinter,ssAllowDestFile,ssAllowPrinterSetup,ssAllowPreviewSetup];
          with TempRap.RP do begin
            ProjectFile := 'Factura.rav';
            TempRap.RS.DefaultDest := rdPrinter;
            Open;
            SetParam('EXEMPLAR', 'Exemplar (1/2)');
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
            SetParam('TOTAL_ARTICOLE', i2s(Q1.RecordCount));
            SetParam('IMAGE', Temp + '\Images\' + dbName + '.bmp');
            SetParam('SIGIMAGE', Temp + '\Images\sig' + dbName + '.bmp');
            ExecuteReport('Report2');
            Close;
          end;
        QMiv.Next;
      end;
    end; //Exemplar 1 listat
  end;

  Q1.Free;
  QMiv.Free;
  TempRap.Free;
  SetCurrentDir(Temp);
  Close;
end;

procedure TListFact.Btn_RenuntaClick(Sender: TObject);
begin
  Close;
end;

procedure TListFact.chAutoClick(Sender: TObject);
begin
  if chAuto.Checked then begin
    chMail.Enabled := False;
    chEx1.Enabled := False;
    chEx2.Enabled := False;
  end else begin
    chMail.Enabled := True;
    chEx1.Enabled := True;
    chEx2.Enabled := True;
  end;
end;

procedure TListFact.DBFactDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  S: string;
  ARect: TRect;
begin
  ARect := Rect;
  if Rect.Top = 0 then Exit;
  S := StringReplace(Column.Field.Text, '&', '&&', [rfReplaceAll]);
  if Selections.IndexOf(DBFact.Fields[0].Text) >= 0 then begin
    (Sender as TDBGrid).Canvas.Brush.Color := Colors.Selection;//$00C08000;
    if Column.Field.Index <> 2 then (Sender as TDBGrid).Canvas.Font.Color := clWhite;
  end;
  if gdSelected in State then (Sender as TDBGrid).Canvas.Brush.Color := Colors.Cursor;
  (Sender as TDBGrid).Canvas.FillRect(Rect);
  ARect.Left := Rect.Left + 2;
  if Column.Index = 0 then
    DrawText((Sender as TDBGrid).Canvas.Handle, PChar(S), Length(S), ARect, 2)
  else
    DrawText((Sender as TDBGrid).Canvas.Handle, PChar(S), Length(S), ARect, 0)
end;

procedure TListFact.DBFactKeyPress(Sender: TObject; var Key: Char);
var
  Aux: string;
begin
  if Key = ' ' then begin
    Aux := Query.Fields[0].Text;
    if Selections.IndexOf(Aux) >= 0 then begin
      Selections.Delete(Selections.IndexOf(Aux));
    end else begin
      Selections.Add(Aux);
    end;
    Query.Next;
  end;
  if Key = '*' then begin
    if (Query.RecordCount = Selections.Count) then begin
      Selections.Clear;
      DBFact.DataSource := nil;
      DBFact.DataSource := DS;
    end else begin
      Selections.Clear;
      DBFact.DataSource := nil;
      Query.First;
      while not Query.Eof do begin
        Selections.Add(Query.Fields[0].Text);
        Query.Next;
      end;
      Query.First;
      DBFact.DataSource := DS;
    end;
  end;
end;

procedure TListFact.ENrIncEnter(Sender: TObject);
begin
  (Sender as TMemo).Color := clWindow;
end;

procedure TListFact.ENrIncExit(Sender: TObject);
begin
  (Sender as TMemo).Color := clWindow;
end;

procedure TListFact.ENrIncKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in [#8, #13, '0'..'9']) then Key := #0;
  if Key = #13 then SelectNext(TMemo(Sender), True, True);
end;

procedure TListFact.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then Close;
end;

procedure TListFact.FormResize(Sender: TObject);
var
  I: integer;
  //iAux: integer;
begin
  ColTotalWidth := 0;
  for I := 0 to DBFact.Columns.Count - 1 do
    ColTotalWidth := ColTotalWidth + Ord(Widths[I + 1]);
  for I := 0 to DBFact.Columns.Count - 1 do
    DBFact.Columns[I].Width := Round((DBFact.Width - 30) * Ord(Widths[I + 1]) / ColTotalWidth);
end;

procedure TListFact.FormShow(Sender: TObject);
var
//  I: Integer;
  Y: word;
  M: word;
  D: word;
begin
  CGest.Items.CommaText := GestDB;
  CGest.ItemIndex := CGest.Items.IndexOf(sFirma);
  DecodeDate(Now, Y, M, D);
  M := StrToInt(Copy(SDate, 1, 2));
  Y := StrToInt(Copy(SDate, 3, 2));
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
  L1.Text := RightStr('0' + IntToStr(M), 2);
  Z1.Text := '01';
  Color := MainForm.Color;
  RBDataClick(Self);

  LData.Caption := 'Perioada de listare: 01.' + L1.Text + '.20' + A1.Text + ' - ' + Z2.Text + '.' + L2.Text + '.20' + A2.Text
  //for I := 0 to DBFact.Columns.Count - 1 do
  //  ColTotalWidth := ColTotalWidth + Ord(Widths[I + 1]);
  //for I := 0 to DBFact.Columns.Count - 1 do
  //  DBFact.Columns[I].Width := Round((DBFact.Width - 28) * Ord(Widths[I + 1]) / ColTotalWidth);
end;

procedure TListFact.RBDataClick(Sender: TObject);
begin
  LNumar.Visible := False;
  ENrInc.Visible := False;
  ENrSf.Visible := False;
  Query.SQL.Text :=
    'SELECT COD, DENUMIRE ' +
    'FROM ' + CGest.Text + '.MIV' + SDate + ' ' +
    'WHERE CONT_COR LIKE "4111%" ' +
    'GROUP BY COD ' +
    'ORDER BY DENUMIRE';
  Query.Open;
  LRecordCount.Caption := IntToStr(Query.RecordCount) + ' records.';
end;

procedure TListFact.RBNumarClick(Sender: TObject);
begin
  LNumar.Visible := True;
  ENrInc.Visible := True;
  ENrSf.Visible := True;
  Query.SQL.Text :=
    'SELECT M.NUMAR COD, F.DENFUR DENUMIRE ' +
    'FROM ' + CGest.Text + '.MIV' + SDate + ' M LEFT JOIN ' + CGest.Text + '.FUR F ON M.CODFUR = F.CODFUR ' +
    'WHERE CONT_COR LIKE "4111%" ' +
    'GROUP BY M.NUMAR ' +
    'ORDER BY M.NUMAR';
  Query.Open;
  Query.First;
  NrInc := Query.Fields[0].AsString;
  Query.Last;
  NrSf := Query.Fields[0].AsString;
  Query.First;
  ENrInc.Text := NrInc;
  ENrSf.Text := NrSf;
  LRecordCount.Caption := IntToStr(Query.RecordCount) + ' records.';
end;

function TListFact.Start(Firma, Options: string): wideString;
begin
  ListFact := TListFact.Create(Application);
  Selections := TStringList.Create;
  sOptions := Options;
  sFirma := Firma;
  ColTotalWidth := 0;
  ListFact.ShowModal;
  ListFact.Free;
  Selections.Free;
end;

procedure TListFact.Z1Enter(Sender: TObject);
begin
  (Sender as TEdit).Color := clWindow;
end;

procedure TListFact.Z1Exit(Sender: TObject);
begin
  (Sender as TEdit).Color := clWindow;
end;

procedure TListFact.Z1KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in [#8, #13, '0'..'9']) then Key := #0;
  if Key = #13 then SelectNext(TEdit(Sender), True, True);
end;

end.
