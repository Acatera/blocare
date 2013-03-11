unit FMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, Grids, DBGrids, StdCtrls, ExtCtrls, IniFiles, Buttons,
  Registry, {Aligrid, }StrUtils, Menus, AppEvnts, ComCtrls,
  {tmsAdvGridExcel,} ComObj, TLHelp32, PsAPI, RpCon, RpConDS, RpConBDE,
  RpRender, RpRenderPDF, RpBase, RpSystem, RpDefine, RpRave, RpRenderCanvas,
  RpRenderPreview, AlexUtils, PngImage;

type
  TColors = record
    FormColor: TColor;
    HeaderColor: TColor;
    FooterColor: TColor;
  end;
  TLocations = record
    Grup1: string;
    Grup2: string;
    Grup3: string;
    Grup4: string;
    Grup5: string;
    Grup6: string;
    Grup7: string;
    Grup8: string;
    Grup9: string;
  end;
  THDbGrid = class(TDBGrid);
  TMainForm = class(TForm)
    PManager: TPanel;
    DBManager: TDBGrid;
    Btn_Send: TButton;
    CGroups: TComboBox;
    Btn_Export: TButton;
    EManagerCauta: TEdit;
    Button1: TButton;
    CAlias: TComboBox;
    Btn_MDebloc: TButton;
    Btn_MBlocSel: TButton;
    CManager: TComboBox;
    CBlocati: TCheckBox;
    LGrupuri: TLabel;
    Btn_MFiltru: TSpeedButton;
    Label2: TLabel;
    Label1: TLabel;
    LMSelected: TLabel;
    LManager: TLabel;
    PBottom: TPanel;
    QManager: TQuery;
    DSManager: TDataSource;
    PopupManager: TPopupMenu;
    dsManager1: TMenuItem;
    PGest: TPanel;
    LGest: TLabel;
    LSelected: TLabel;
    LDBGest: TLabel;
    Btn_Filtru: TSpeedButton;
    LFact: TLabel;
    LTotal: TLabel;
    CGest: TComboBox;
    DBGest: TDBGrid;
    Btn_BlocSel: TButton;
    ENrFact: TLabeledEdit;
    Btn_SelCli: TButton;
    Btn_Debloc: TButton;
    EGestCauta: TEdit;
    CBContract: TCheckBox;
    CCU0: TCheckBox;
    CFirme: TComboBox;
    Btn_BlocAuto: TButton;
    Btn_Balanta: TButton;
    Btn_Extrase: TButton;
    QGest: TQuery;
    DB: TDatabase;
    DSGest: TDataSource;
    QTemp: TQuery;
    Tray: TTrayIcon;
    PopupMenu1: TPopupMenu;
    Arata1: TMenuItem;
    Inchide1: TMenuItem;
    AppEv: TApplicationEvents;
    DQuery: TQuery;
    Btn_2Luni: TSpeedButton;
    Timer: TTimer;
    Btn_Refresh: TSpeedButton;
    Btn_JurCli: TButton;
    Btn_Fact: TButton;
    Btn_ExtraseB: TButton;
    Btn_Sent: TButton;
    pUp: TPanel;
    pbUp: TPaintBox;
    IAccount: TImage;
    IAccountO: TImage;
    IBalanta: TImage;
    IBalantaO: TImage;
    IBlock: TImage;
    IBlockO: TImage;
    IExit: TImage;
    IExitO: TImage;
    IExport: TImage;
    IExportO: TImage;
    IJournals: TImage;
    IJournalsO: TImage;
    IMail: TImage;
    IMailO: TImage;
    IPrint: TImage;
    IPrintO: TImage;
    ISelect: TImage;
    ISelectO: TImage;
    ISendAccount: TImage;
    ISendAccountO: TImage;
    ISent: TImage;
    ISentO: TImage;
    IUnBlock: TImage;
    IUnBlockO: TImage;
    pDown: TPanel;
    pbDown: TPaintBox;
    lStatus: TLabel;
    IDown: TImage;
    IDownOver: TImage;
    IUp: TImage;
    IUpOver: TImage;
    pToolbar: TPanel;
    pbToolbar: TPaintBox;
    procedure DBDrawDataCell(Sender: TObject; const Rect: TRect;
      Field: TField; State: TGridDrawState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure CGestChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGestKeyPress(Sender: TObject; var Key: Char);
    procedure Btn_SelCliClick(Sender: TObject);
    procedure Btn_BlocSelClick(Sender: TObject);
    procedure Btn_BlocAutoClick(Sender: TObject);
    procedure CManagerChange(Sender: TObject);
    procedure DBManagerKeyPress(Sender: TObject; var Key: Char);
    procedure Btn_MBlocSelClick(Sender: TObject);
    procedure Btn_MDeblocClick(Sender: TObject);
    procedure Btn_DeblocClick(Sender: TObject);
    procedure ENrFactChange(Sender: TObject);
    procedure ENrFactKeyPress(Sender: TObject; var Key: Char);
    procedure Btn_FiltruClick(Sender: TObject);
    procedure Btn_MFiltruClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CAliasChange(Sender: TObject);
    procedure DBManagerMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure EGestCautaExit(Sender: TObject);
    procedure EGestCautaKeyPress(Sender: TObject; var Key: Char);
    procedure EManagerCautaKeyPress(Sender: TObject; var Key: Char);
    procedure EManagerCautaExit(Sender: TObject);
    procedure DBGestKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CBContractClick(Sender: TObject);
    procedure CCU0Click(Sender: TObject);
    procedure SetFilter;
    procedure Arata1Click(Sender: TObject);
    procedure Inchide1Click(Sender: TObject);
    procedure AppEvMinimize(Sender: TObject);
    procedure WMHotkey(var msg: TWMHotKey); message WM_HOTKEY;
    procedure CFirmePopulate;
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CFirmeKeyPress(Sender: TObject; var Key: Char);
    procedure CFirmeExit(Sender: TObject);
    procedure DBManagerKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Btn_ExportClick(Sender: TObject);
    procedure DBGestMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure EGestCautaEnter(Sender: TObject);
    procedure ENrFactEnter(Sender: TObject);
    procedure DBGestDblClick(Sender: TObject);
    procedure dsManager1Click(Sender: TObject);
    procedure ManagerResize;
    procedure GestResize;
    function GetGroups: TStringList;
    procedure CGroupsChange(Sender: TObject);
    procedure DBManagerDblClick(Sender: TObject);
    procedure Btn_SendClick(Sender: TObject);
    procedure Btn_BalantaClick(Sender: TObject);
    procedure CBlocatiClick(Sender: TObject);
    procedure Btn_ExtraseClick(Sender: TObject);
    procedure DoDBGrids(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CAliasClick(Sender: TObject);
    procedure DoSchedule;
    procedure ScheduleExpire(NrZile: integer);
    procedure ScheduleRefresh;
    procedure Btn_2LuniClick(Sender: TObject);
    procedure Btn_RefreshClick(Sender: TObject);
    procedure Btn_JurCliClick(Sender: TObject);
    procedure Btn_FactClick(Sender: TObject);
    procedure Btn_ExtraseBClick(Sender: TObject);
    procedure Btn_FiltruMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Btn_SentClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure pbUpPaint(Sender: TObject);
    procedure ImageMouseLeave(Sender: TObject);
    procedure ImageEnter(Sender: TObject);
    procedure ImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure EventMapper(OnObject: string);
    procedure IExitClick(Sender: TObject);
    procedure pbDownPaint(Sender: TObject);
    procedure pbToolbarPaint(Sender: TObject);
  private
    { Private declarations }
  public
    TUMail: string;
    TPMail: string;
    LastMailID: integer;
    ThreadsRunning: integer;
    ThreadCancel: boolean;
    procedure DoThreadTerminate(Sender: TObject);
  end;

const
  Blanks: string = '                                                                                               ' +
                   '                                                                                               ' +
                   '                                                                                               ';  

var
  MainForm: TMainForm;
  GestSQL: string;
  ManagerSQL: string;
  BManagerSQL: string;
  GestColWidths: string;
  ManagerColWidths: string;
  GestCurIndex : boolean;
  GestDB: string;
  CGestIndex: integer;
  ManagerDB: String;
  CManagerIndex: integer;
  Selections: TStringList;
  MSelections: TStringList;
  SelRow: integer;
  MSelRow: integer;
  Alias: string;
  SDate: string;
  QGestRec: integer;
  QManagerRec: integer;
  SumTotal: Double;
  Contract: string;
  HavingFact: string;
  UnionAll: Widestring;
  GestFieldCount: integer;
  ManagerFieldCount: integer;
  Fundal: integer;
  PozCur: integer;
  RandSel: integer;
  Titlu: integer;
  RandImpar: integer;
  RandPar: integer;
  iContract: integer;
  Blocat: integer;
  NrFact: integer;
  DBGestCoordY: integer;
  AManagerSQL: string;
  Groups: TStringList;
  WhereModule: string;
  Fur: string;
  Contracte: string;
  CuBlocati: string;
  UMail: string;
  PMail: string;
  PortMail: integer;
  Locations: TLocations;
  ListaAngajati: string;
  Signature: TStringList;
  HK1: integer;
  HK2: integer;
  GestVisible: boolean;
  ManagerVisible: boolean;
  DoRefresh: integer;
  DoExpire: integer;
  DoVerify: integer;
  JurUser: string;
  Treshold: double;

implementation

uses Color, Fur_Detail, Fisa_Client, E_Mail, Send_Mail, Temp_Rap, Extras_Cont,
  Add_Modify, FSesizari, FOptiuni, Sel_Mail, Dialog, Jur_Clienti, Jur_C_Clienti,
  ListareFacturi, Extrase, Editare, Sent_Mail;

{$R *.dfm}

function TMainForm.GetGroups: TStringList;
var
  MyQ: TQuery;
  Temp: string;
  I: integer;
begin
  MyQ := TQuery.Create(MainForm);
  MyQ.DatabaseName := DB.DatabaseName;
  MyQ.SQL.Text := 'SELECT DESCRIERE FROM `FDSOFT`.`GENERAL` WHERE COD = "BTTIP_FUR"';
  MyQ.Active := True;
  Temp := MyQ.Fields[0].AsString;
  Temp := StringReplace(Temp, #13 + #10, ',', [rfReplaceAll]);
  Groups.CommaText := Temp;
  Groups[0] := 'TOTI';
  for I := 1 to Groups.Count - 1 do
    Groups[I] := Copy(Groups[I], 3) + '                                                                        |' + Copy(Groups[I], 1, Pos('=', Groups[I]));
  Groups[Groups.Count - 1] := '----------------------------------';
  Groups.Add('IMPORTATI');
  //Groups.Add('MANAGER VECHI');
  Result := Groups;
end;

procedure TMainForm.ManagerResize;
var
  I: integer;
  Temp: integer;
begin            //1-Misu, 0-Eu nou
  if QManager.Tag = 1 then begin
    for I := 0 to 7 do
      DBManager.Columns[I].Width := Ord(ManagerColWidths[I + 1]);
    DBManager.Columns[5].Visible := False;
    DBManager.Columns[6].Visible := False;
    DBManager.Columns[7].Visible := False;
  end else begin
    Temp := 0;
    for I := 0 to 4 do
      Temp := Temp + Ord(ManagerColWidths[I + 1]);
    for I := 0 to 4 do
      //DBManager.Columns[I].Width := Ord(ManagerColWidths[I + 1]);
      DBManager.Columns[I].Width := Round((DBManager.Width - 22) * Ord(ManagerColWidths[I + 1]) / Temp);
    DBManager.Columns[5].Visible := False;
    DBManager.Columns[6].Visible := False;
    DBManager.Columns[7].Visible := False;
  end;
end;

procedure TMainForm.GestResize;
var
  I: integer;
  Temp: integer;
begin
  Temp := 0;
  for I := 0 to 8 do
    Temp := Temp + Ord(GestColWidths[I + 1]);
  for I := 0 to 8 do
    //DBGest.Columns[I].Width := Ord(GestColWidths[I + 1]);
    DBGest.Columns[I].Width := Round((DBGest.Width - 22) * Ord(GestColWidths[I + 1]) / Temp) //percentage
end;

procedure TMainForm.WMHotkey(var msg: TWMHotKey);
begin
  if msg.HotKey = HK1 then begin
    if IsIconic(Application.Handle) then Application.Restore
    else MainForm.Visible := True;
    SetForegroundWindow(MainForm.Handle);
  end;
  if msg.HotKey = HK2 then begin
    AddModify.Start('PAROLA');
   end;
end;

procedure TMainForm.AppEvMinimize(Sender: TObject);
begin
  Application.Restore;
  MainForm.Visible := False;
end;

procedure TMainForm.Arata1Click(Sender: TObject);
begin
  MainForm.Visible := True;
  BringToFront;
end;

procedure TMainForm.Btn_2LuniClick(Sender: TObject);
var
  Temp: string;
begin
  Temp := AddModify.Start('NRZILE');
  if Temp <> '' then begin
    ScheduleExpire(StrToInt(Temp));
    DBManager.SetFocus;
  end;
end;

procedure TMainForm.Btn_BalantaClick(Sender: TObject);
var
  Q1: TQuery;
  Q2: TQuery;
  SoldTotal: string;
  TempRap: TTempRap;
begin
  Q1 := TQuery.Create(MainForm);
  Q1.DatabaseName := DB.DatabaseName;
  Q1.SQL.Text :=
    'SELECT SUM(SUMADB-SUMACR) FROM `' + CGest.Text + '`.`FRES' + SDate + '` WHERE CONTFC="4111"';
  Q1.Open;
  SoldTotal := Q1.Fields[0].AsString;
  Q1.SQL.Text :=
    'SELECT CODFUR, DENFUR, COD_FISCAL, NRDFC, DATAFC, ROUND(SUM(SUMADB-SUMACR),2) AS SUMA ' +
    'FROM `' + CGest.Text + '`.`FRES' + SDate + '` LEFT JOIN `' + CGest.Text + '`.`FUR` ON CODFC = CODFUR ' +
    'WHERE (CONTFC = "4111") AND ((SUMADB-SUMACR) <> 0) GROUP BY CODFUR  ORDER BY DENFUR';
  Q2 := TQuery.Create(MainForm);
  Q2.DatabaseName := DB.DatabaseName;
  Q2.SQL.Text :=
    'SELECT CODFC, CONCAT(NRDFC, " / ", CONCAT(SUBSTRING(DATAFC,1,2),".",SUBSTRING(DATAFC,3,2),".",SUBSTRING(DATAFC,5,4))) AS FACT, ' +
    'EXPLIC, ROUND((SUMADB-SUMACR),2) AS SUMA ' +
    'FROM `' + CGest.Text + '`.`FRES' + SDate + '` LEFT JOIN `' + CGest.Text + '`.`FUR` ON CODFC = CODFUR ' +
    'WHERE (CONTFC="4111") AND ((SUMADB-SUMACR) <> 0) ORDER BY DENFUR, CONCAT(SUBSTRING(DATAFC, 5,4),SUBSTRING(DATAFC, 3,2),SUBSTRING(DATAFC, 1,2))';
  TempRap := TTempRap.Create(MainForm);
  TempRap.R1.Query := Q1;
  TempRap.R2.Query := Q2;
  with TempRap.RP do begin
      ProjectFile := 'Balanta.rav';
      TempRap.RS.DefaultDest := rdPreview;
      Open;
      SetParam('TOTAL', SoldTotal);
      SetParam('DATA', Copy(SDate,1,2) + '/20' + Copy(SDate,3,2));
      SetParam('FIRMA', CGest.Text);
      ExecuteReport('Report1');
      Close;
    end;
  TempRap.Free;
  Q1.Free;
  Q2.Free;
end;

procedure TMainForm.Btn_BlocAutoClick(Sender: TObject);
var
  TempSQL: string;
begin
  TempSQL := 'SELECT GROUP_CONCAT(CODFC) FROM (SELECT CODFC, COUNT(CODFC) AS NRFACT, ' +
             'SUM(SUMADB-SUMACR) AS SUMA FROM `' + CGest.Text + '`.`FRES' + SDate + '` WHERE ((SUMADB-SUMACR < -10) OR (SUMADB-SUMACR > 10)) AND (CONTFC = "4111") ' +
             'GROUP BY CODFC) AS TEMP LEFT JOIN `' + CGest.Text + '`.`FUR` ON CODFUR=CODFC WHERE (SUMA <> 0) AND (NRFACT >= 4) AND ' +
             '((CONT_USD <> "") OR (CONT_DM <> "" ))';
  QTemp.SQL.Text := TempSQL;
  QTemp.Active := True;
  TempSQL := 'UPDATE `' + CGest.Text + '`.`FUR` SET SECTIA = "B" WHERE CODFUR IN ("' + StringReplace(QTemp.Fields[0].AsString, ',', '","', [rfReplaceAll]) + '")';
  QTemp.SQL.Text := TempSQL;
  //if MessageDlg('Esti sigur ca vrei asta?', mtWarning, mbYesNo, 0) = mrYes then QTemp.ExecSQL;
  if FDialog.Start('Atentie', 'Sunteti sigur(a) ca doriti asta?', fdBtn_Yes or fdBtn_No, mtConfirmation) = fdBtn_Yes then QTemp.ExecSQL;
  
  Selections.Clear;
end;

procedure TMainForm.Btn_BlocSelClick(Sender: TObject);
var
  I: integer;
  J: integer;
  SQL: string;
begin
  if Selections.Count = 0 then begin FDialog.Start('Atentie', 'Nu ati selectat nimic.', fdOk, mtWarning); Exit; end;
  QTemp.Active := False;
  QTemp.SQL.Text := 'UPDATE `' + CGest.Text + '`.`FUR` SET SECTIA = "B", FCULOARE = "B" WHERE CODFUR IN (' + StringReplace('"' + StringReplace(Selections.CommaText, ',', '","', [rfReplaceAll]) + '")', '""', '"', [rfReplaceAll]);
  //if MessageDlg('Esti sigur ca vrei asta?', mtWarning, mbYesNo, 0) = mrYes then begin //Blocheaza si trimite mail
  if FDialog.Start('Atentie', 'Sunteti sigur(a) ca doriti asta?', fdBtn_Yes or fdBtn_No, mtConfirmation) = fdBtn_Yes then begin
    QTemp.ExecSQL;
    for I := 0 to Selections.Count - 1 do begin
      SelMail.Start(Selections[I], 'B');
      SQL := 'SELECT CODFUR, DENFUR, NR_LICENTA, SECTIA AS STARE, COUNT(CODFUR) AS NRFACT, SUM(SUMADB-SUMACR) AS SUMA, FIRMA, CONTRACT ' +
             'FROM (SELECT * FROM (';
      for J := 0 to MainForm.CGest.Items.Count - 1 do
        SQL := SQL +
          'SELECT CODFUR, DENFUR, NR_LICENTA, SECTIA, SUMADB, SUMACR, "' + MainForm.CGest.Items[J] + '" AS FIRMA, CONCAT(CONT_DM, CONT_USD) AS CONTRACT ' +
          'FROM `' + MainForm.CGest.Items[j] + '`.`FUR` INNER JOIN `' + MainForm.CGest.Items[J] + '`.`FRES' + SDate + '` ON CODFUR = CODFC ' +
          'WHERE (CONTFC LIKE "4111") AND ((SUMADB-SUMACR) <> 0) AND (CODFUR = "' + Selections[I] + '") UNION ALL ';
      SQL := Copy(SQL, 1, Length(SQL) - 11) + ') AS TEMP ORDER BY CONTRACT DESC) AS TEMP2 GROUP BY CODFUR';
      QTemp.SQL.Text := SQL;
      QTemp.Open;
      SelMail.LClient.Caption := QTemp.FieldByName('DENFUR').AsString;
      SelMail.LTitlu.Hint := SDate;
      SelMail.LClient.Hint := QTemp.FieldByName('NR_LICENTA').AsString;
      SelMail.ShowModal;
      SelMail.Free;
    end;
  end;
  CGestChange(Self);
  if QManager.Tag = 0 then
    CGroupsChange(Self);
  Selections.Clear;
end;

procedure TMainForm.Btn_DeblocClick(Sender: TObject);
var
  I: integer;
  Temp: string;
begin
  if Selections.Count = 0 then begin FDialog.Start('Atentie', 'Nu ati selectat nimic.', fdOk, mtWarning); Exit; end;
  QTemp.Active := False;
  QTemp.SQL.Text := 'UPDATE `' + CGest.Text + '`.`FUR` SET SECTIA = " ", FCULOARE = " " WHERE CODFUR IN (' + StringReplace('"' + StringReplace(Selections.CommaText, ',', '","', [rfReplaceAll]) + '")', '""', '"', [rfReplaceAll]);
  //if MessageDlg('Esti sigur ca vrei asta?', mtWarning, mbYesNo, 0) = mrYes then begin //Deblocheaza si trimite actualizari
  if FDialog.Start('Atentie', 'Sunteti sigur(a) ca doriti asta?', fdBtn_Yes or fdBtn_No, mtConfirmation) = fdBtn_Yes then begin
    QTemp.ExecSQL;
    for I := 0 to Selections.Count - 1 do begin
      SelMail.Start(Selections[I], 'DB');
      QTemp.SQL.Text := 'SELECT CODFUR, DENFUR FROM `' + CGest.Text + '`.`FUR` WHERE CODFUR = "' + Selections[I] + '"';
      QTemp.Open;
      SelMail.LClient.Caption := QTemp.FieldByName('DENFUR').AsString;
      SelMail.ShowModal;
      SelMail.Free;
    end;
  end;
  CGestChange(Self);
  if QManager.Tag = 0 then
    CGroupsChange(Self);
  Selections.Clear;
end;

procedure TMainForm.Btn_ExportClick(Sender: TObject);
var
  XApp: Variant;
  Sheet: Variant;
  R, C: Integer;
  FieldName: Integer;
begin
  DBManager.Tag := 0;
  Btn_MFiltruClick(Self);
  try
    begin
      XApp := CreateOleObject('Excel.Application');
      XApp.Visible := True;
    end;
  except
    //MessageDlg('Nu aveti instalat programul Excel.', mtError, [mbOk],0);
    FDialog.Start('Atentie', 'Nu aveti instalat programul Excel.', fdOk, mtError);
    Exit;
  end;
  XApp.WorkBooks.Add(-4167);  //open a new blank workbook
  XApp.WorkBooks[1].WorkSheets[1].Name := 'Lista contacte';
  Sheet := XApp.WorkBooks[1].WorkSheets['Lista contacte'];
  for FieldName := 1 to 4 do
    Sheet.Cells[1, FieldName] := QManager.Fields[FieldName].FieldName;
  Sheet.Range['A1:D1'].Font.Bold := True;
  Sheet.Range['A1:D1'].HorizontalAlignment := -4108;
  //Data feed
  QManager.First;
  for R := 0 to QManager.RecordCount-1 do
    begin
      for C := 1 to 4 do
        Sheet.Cells[R + 2, C] := QManager.Fields[C].AsString;
      QManager.Next;
    end;
  Sheet.Range['A1:D1'].EntireColumn.AutoFit;
end;

procedure TMainForm.Btn_ExtraseBClick(Sender: TObject);
begin
  FExtrase.Start(CGest.Text);
end;

procedure TMainForm.Btn_ExtraseClick(Sender: TObject);
var
  I: Integer;
  Q1: TQuery;
begin
  if DBGest.Tag <> 0 then Exit;
  for I := 0 to Selections.Count - 1 do begin
    ExtrasCont := TExtrasCont.Create(Self);
    with ExtrasCont do begin
      A1.Hint := CGest.Text;
      Z1.Hint := Selections[I];
      CActions.ItemIndex := 2;
      GetDetails;
      A1.Text := '2009';
      Btn_AfiseazaClick(Self);
    end;
    ExtrasCont.Free;
  end;
end;

procedure TMainForm.Btn_FactClick(Sender: TObject);
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
  FirmaDenfur: string;
  FirmaCUI: string;
  FirmaNrOrdReg: string;
  FirmaSediu: string;
  FirmaJudet: string;
  FirmaCont: string;
  FirmaBanca: string;
  FirmaCapSocial: string;
  FirmaIntocmit: string;
  Temp: string;
  QMiv: TQuery;
begin
  ListFact.Start(CGest.Text,'');
  Exit;
  Temp := GetCurrentDir;
  Q1 := TQuery.Create(MainForm);
  Q1.DatabaseName := MainForm.DB.DatabaseName;
  QMiv := TQuery.Create(MainForm);
  QMiv.DatabaseName := MainForm.DB.DatabaseName;
  dbName := CGest.Text;
//  dbName := StringReplace(StringReplace(StringReplace(StringReplace(dbName, 'D-SOFT', 'fdsoft', []), 'QUALITY SOFT', 'quality', []), 'DAVID SOFTWARE', 'fsoftware', []), 'DAVID SOFT SERVICES', 'fservices', []);
  if dbName = 'fdsoft' then begin
    FirmaDenfur := 'S.C. D-SOFT SRL';
    FirmaCUI := 'RO1818101';
    FirmaNrOrdReg := 'J35/2230/1992';
    FirmaSediu := 'B-DUL L. REBREANU, NR 53';
    FirmaJudet := 'TIMIS';
    FirmaCont := 'RO78BACX0000000186498000';
    FirmaBanca := 'UNICREDIT TIRIAC BANK';
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
  QMiv.SQL.Text :=
    'SELECT NUMAR, DATA, SUM(VALOARE) AS TOTALBAZA, SUM(VAL_TVA) AS TOTALTVA, SUM(VALOARE + VAL_TVA) AS TOTALFACT ' +
    'FROM `' + dbName + '`.`MIV' + Copy(DataFact, 3, 2) + Copy(DataFact, 7, 2);
//  NrFact := DBFact.Fields[1].AsString;
//  DataFact := DBFact.Fields[2].AsString;
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
  QMiv.Free;
  SetCurrentDir(Temp);
end;

procedure TMainForm.Btn_FiltruClick(Sender: TObject);
var
  TempSQL : string;
begin
  SumTotal := 0;
  TempSQL := 'SELECT DENFUR, CODFC, SECTIA, NRFACT, SUMA FROM (SELECT CODFC, COUNT(CODFC) AS NRFACT, ' +
             'SUM(SUMADB-SUMACR) AS SUMA FROM `' + CGest.Text + '`.`FRES' + SDate + '` WHERE (CONTFC = "4111") ' +
             'GROUP BY CODFC) AS TEMP LEFT JOIN `' + CGest.Text + '`.`FUR` ON CODFUR=CODFC WHERE (SUMA <> 0) AND (NRFACT * CLASA >= ' + ENrFact.Text +') AND ' +
             '((CONT_USD <> "") OR (CONT_DM <> "" )) ORDER BY SECTIA, DENFUR';
  if QGest.Tag = 1 then begin
    QGest.Tag := 0;
    HavingFact := ' ';
    UnionAll := 'UNION ALL ' +
                'SELECT CODFUR AS `Cod Fiscal`, DENFUR AS `Denumire`, CONCAT(CONT_DM, CONT_USD), ' +
                'SECTIA AS `St.`, 0 AS `#`, 0 AS `Sold`, " " AS `Data`, CLASA AS `L`' +
                //', " " AS DATE_DOC ' +
                'FROM `' + CGest.Text + '`.`FUR` ' +
                'WHERE (CODFUR NOT IN ' +
                  '(SELECT CODFC FROM `' + CGest.Text + '`.`FRES' + SDate + '` ' +
                  'WHERE ((SUMADB-SUMACR) <> 0)) ' +
                Contract + ') ORDER BY DENUMIRE';
    SetFilter;
    CGestChange(Self);
    QTemp.SQL.Text := 'SELECT SUM(`#`), SUM(Sold) FROM (' + GestSQL + ') AS TEMP2';
    QTemp.Active := True;
    LFact.Caption := 'Facturi neachitate: ' + QTemp.Fields[0].AsString;
    Btn_Filtru.Font.Style := [];
  end
  else begin
    QGest.Tag := 1;
//    if HavingFact = '<SHIFT>' then 
    HavingFact := iif(HavingFact = '<SHIFT>','HAVING SECTIA = "B"','HAVING (COUNT(CODFUR) * CLASA >=' + ENrFact.Text + ') ');
//    HavingFact := 'HAVING (COUNT(CODFUR) * CLASA >=' + ENrFact.Text + ') ';
    //QGest.Filter := '[#] >= ' + ENrFact.Text;
    //QGest.Filtered := True;
    UnionAll := ' ORDER BY DENUMIRE';
    SetFilter;
    CGestChange(Self);
    QTemp.SQL.Text := 'SELECT SUM(`NRFACT`), SUM(SUMA) FROM (' + TempSQL + ') AS TEMP2';
    QTemp.Active := True;
    LFact.Caption := 'Facturi neachitate: ' + QTemp.Fields[0].AsString;
    LTotal.Caption := 'Suma totala: ' + QTemp.Fields[1].AsString + ' RON';
    Btn_Filtru.Font.Style := [fsBold];
  end;
  DBGest.DataSource := nil;
  QGest.First;
  while not QGest.Eof do begin
    if Selections.IndexOf(QGest.Fields[0].AsString) >= 0then SumTotal := SumTotal + QGest.Fields[4].AsFloat;
    QGest.Next;
  end;
  QGest.First;
  DBGest.DataSource := DSGest;
  LTotal.Caption := 'Suma totala: ' + FloatToStr(SumTotal) + ' RON';
  QTemp.SQL.Text := TempSQL;
  QTemp.Active := True;
  QGestRec := QGest.RecordCount;
  LGest.Caption := IntToStr(QTemp.RecordCount) + '/' + IntToStr(QGest.RecordCount) + ' �nregistr�ri.';
  LTotal.Left := DBGest.Left + DBGest.Width - LTotal.Width;
  GestResize;
  DBGest.Tag := 0;
  ////////////
end;

procedure TMainForm.Btn_FiltruMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ssShift in Shift then HavingFact := '<SHIFT>';
end;

procedure TMainForm.Btn_JurCliClick(Sender: TObject);
begin
  JurCClienti.Start('');
end;

procedure TMainForm.Btn_MBlocSelClick(Sender: TObject);
var
  I: integer;
  Temp: string;
begin
  Temp := QManager.Fields[0].AsString;
  if MSelections.Count = 0 then begin FDialog.Start('Atentie', 'Nu ati selectat nimic.', fdOk, mtWarning); Exit; end;
  DBManager.DataSource := nil;
  QManager.First;
  while not QManager.Eof do begin
    if MSelections.IndexOf(QManager.Fields[0].AsString + '|' + QManager.Fields[7].Text) >= 0 then begin
      QTemp.Active := False;
      QTemp.SQL.Text := 'INSERT INTO `' + CManager.Text + '`.`BLOCATI` (IDFURCLI, GRUPURI, TABELA, LOCATIE) VALUES (' +
      QManager.Fields[0].AsString + ',"' + QManager.Fields[5].AsString + '","' + QManager.Fields[6].AsString + '","' +
      QManager.Fields[7].AsString + '")';
      QTemp.ExecSQL;
      QTemp.Active := False;
      I := MSelections.IndexOf(QManager.Fields[0].AsString + '|' + QManager.Fields[7].Text);
      if QManager.Fields[6].AsString = 'CONTACTE' then
        QTemp.SQL.Text := 'UPDATE `' + CManager.Text + '`.`CONTACTE` SET GRUPURI = "|12|" WHERE (IDFURCLI = ' + Copy(MSelections[I], 1, Pos('|', MSelections[I]) - 1) +
        ') AND (NUME = "' + QManager.Fields[7].AsString + '")'
      else
        QTemp.SQL.Text := 'UPDATE `' + CManager.Text + '`.`LOCATII` SET GRUPURI = "|12|" WHERE (IDFURCLI = ' + Copy(MSelections[I], 1, Pos('|', MSelections[I]) - 1) +
        ') AND (LOCATIE = "' + QManager.Fields[7].AsString + '")';
      QTemp.ExecSQL;
    end;
    QManager.Next;
  end;
  DBManager.DataSource := DSManager;
  CManagerChange(Self);
  QManager.Locate('IDFURCLI', Temp, []);
end;

procedure TMainForm.Btn_MDeblocClick(Sender: TObject);
var
  Aux: string;
  Table: string;
  Locatii: string;
  Temp: string;
begin
  Temp := QManager.Fields[0].AsString;
  if MSelections.Count = 0 then begin FDialog.Start('Atentie', 'Nu ati selectat nimic.', fdOk, mtWarning); Exit; end;
  DBManager.DataSource := nil;
  QManager.First;
  while not QManager.Eof do begin
    if MSelections.IndexOf(QManager.Fields[0].AsString + '|' + QManager.Fields[7].Text) >= 0 then begin
      QTemp.SQL.Text := 'SELECT GRUPURI, LOCATIE, TABELA FROM `' + CManager.Text + '`.`BLOCATI` WHERE (IDFURCLI = ' + QManager.Fields[0].AsString +
                        ') AND (LOCATIE = "' + QManager.Fields[7].AsString + '")';
      QTemp.Open;
      Aux := QTemp.Fields[0].Text;
      Table := QTemp.Fields[2].Text;
      Locatii := QTemp.Fields[1].Text;
      QTemp.Active := False;
      if Table = 'CONTACTE' then begin
        QTemp.SQL.Text := 'UPDATE `' + CManager.Text + '`.`CONTACTE` SET GRUPURI = "' + Aux + '" WHERE (IDFURCLI = ' + QManager.Fields[0].AsString +
                          ') AND (NUME = "' + Locatii + '")';
        QTemp.ExecSQL;
        QTemp.Active := False;
      end else begin
        QTemp.SQL.Text := 'UPDATE `' + CManager.Text + '`.`LOCATII` SET GRUPURI = "' + Aux + '" WHERE (IDFURCLI = ' + QManager.Fields[0].AsString +
                          ') AND (LOCATIE = "' + Locatii + '")';
        QTemp.ExecSQL;
        QTemp.Active := False;
      end;
      QTemp.SQL.Text := 'DELETE FROM `' + CManager.Text + '`.`BLOCATI` WHERE (IDFURCLI = ' + QManager.Fields[0].AsString + ') AND (LOCATIE = "' + Locatii + '")';
      QTemp.ExecSQL;
    end;
    QManager.Next
  end;
  DBManager.DataSource := DSManager;
  CManagerChange(Self);
  QManager.Locate('IDFURCLI', Temp, []);
end;

procedure TMainForm.Btn_MFiltruClick(Sender: TObject);
begin
  if QManager.Tag = 0 then begin//Mine  ////////////////////////////////
    if DBManager.Tag = 1 then begin
      QManager.SQL.Text := AManagerSQL;
      QManager.Active := True;
      ManagerResize;
      DBManager.Tag := 0;
      LManager.Caption := IntToStr(QManager.RecordCount) + ' �nregistr�ri.';
      LMSelected.Caption := IntToStr(MSelections.Count) + ' selectate.';
      LMSelected.Left := DBManager.Left + DBManager.Width - LMSelected.Width;
      LManager.Caption := IntToStr(QManager.RecordCount) + ' �nregistr�ri.';
      Btn_MFiltru.Font.Style := [];
    end
    else begin
      if MSelections.Count = 0 then Exit;

      //QManager.Filter := 'EMAIL <> ' + QuotedStr('');
  //    QManager.Filter := 'CONCAT(IDFURCLI, "|", LOCATIE) IN ("' + StringReplace(MSelections.CommaText, ',', '","', [rfReplaceAll]);
  //Aux := QManager.Fields[0].Text + '|' + QManager.FieldByName('ID').Text + '$' + QManager.FieldByName('DENUMIRE').Text + '!' + QManager.FieldByName('EMAIL').Text
      QManager.SQL.Text := 'SELECT * FROM (' +  AManagerSQL + ') AS TEMP WHERE CONCAT(CODFC, "|", ID,"$",DENUMIRE,"!",EMAIL) IN ' + StringReplace('("' + StringReplace(MSelections.CommaText, ',', '","', [rfReplaceAll]) + '")', '""', '"', [rfReplaceAll]);
      QManager.Active := True;
      ManagerResize;
      DBManager.Tag := 1;
      LManager.Caption := IntToStr(QManager.RecordCount) + ' �nregistr�ri.';
      LMSelected.Caption := IntToStr(MSelections.Count) + ' selectate.';
      LMSelected.Left := DBManager.Left + DBManager.Width - LMSelected.Width;
      LManager.Caption := IntToStr(QManager.RecordCount) + ' �nregistr�ri.';
      Btn_MFiltru.Font.Style := [fsBold];
    end;
  end else begin //Misu  ///////////////////////////////////////
    if DBManager.Tag = 1 then begin
      QManager.SQL.Text := BManagerSQL;
      QManager.Active := True;
      ManagerResize;
      DBManager.Tag := 0;
      LManager.Caption := IntToStr(QManager.RecordCount) + ' �nregistr�ri.';
      LMSelected.Caption := IntToStr(MSelections.Count) + ' selectate.';
      LMSelected.Left := DBManager.Left + DBManager.Width - LMSelected.Width;
      LManager.Caption := IntToStr(QManager.RecordCount) + ' �nregistr�ri.';
      Btn_MFiltru.Font.Style := [];
    end
    else begin
      if MSelections.Count = 0 then Exit;

      //QManager.Filter := 'EMAIL <> ' + QuotedStr('');
  //    QManager.Filter := 'CONCAT(IDFURCLI, "|", LOCATIE) IN ("' + StringReplace(MSelections.CommaText, ',', '","', [rfReplaceAll]);
      QManager.SQL.Text := 'SELECT * FROM (' +  BManagerSQL + ') AS TEMP WHERE CONCAT(IDFURCLI, "|", LOCATIE,"$",DENUMIRE,"!",EMAIL) IN ' + StringReplace('("' + StringReplace(MSelections.CommaText, ',', '","', [rfReplaceAll]) + '")', '""', '"', [rfReplaceAll]);
      QManager.Active := True;
      ManagerResize;
      DBManager.Tag := 1;
      LManager.Caption := IntToStr(QManager.RecordCount) + ' �nregistr�ri.';
      LMSelected.Caption := IntToStr(MSelections.Count) + ' selectate.';
      LMSelected.Left := DBManager.Left + DBManager.Width - LMSelected.Width;
      LManager.Caption := IntToStr(QManager.RecordCount) + ' �nregistr�ri.';
      Btn_MFiltru.Font.Style := [fsBold];
    end;
  end;
end;

procedure TMainForm.Btn_RefreshClick(Sender: TObject);
begin
  ScheduleRefresh;
end;

procedure TMainForm.Btn_SelCliClick(Sender: TObject);
var
  Temp: string;
  I: integer;
begin
  Temp := QGest.Fields[0].Text;
  DBGest.DataSource := nil;
  QGest.First;
  Selections.Clear;
  while not QGest.Eof do begin
    if QGest.Fields[4].AsInteger >= StrToInt(ENrFact.Text) then
      Selections.Add(QGest.Fields[0].AsString);
    QGest.Next;
  end;
  QGest.First;
  DBGest.DataSource := DSGest;
  GestResize;
  QGest.Locate('COD FISCAL', Temp, [])
end;

procedure TMainForm.Btn_SendClick(Sender: TObject);
begin
  SendMail.Start(MSelections, CGroups.ItemIndex);
  SendMail.ShowModal;
  SendMail.Free;
end;

procedure TMainForm.Btn_SentClick(Sender: TObject);
begin
  SentMail.Start();
end;

procedure TMainForm.Button1Click(Sender: TObject);
begin
  CAlias.Visible := not CAlias.Visible;
end;

procedure TMainForm.CAliasChange(Sender: TObject);
begin
  DB.Connected := False;
  DB.AliasName := CAlias.Text;
  DB.Connected := True;
  if GestVisible then
    CGestChange(Self);
  CGroups.Items := GetGroups;
  CGroups.ItemIndex := 0;
  if ManagerVisible then
    CManagerChange(Self);
end;

procedure TMainForm.CAliasClick(Sender: TObject);
begin
  CAlias.Visible := False;
  Button1.SetFocus;
end;

procedure TMainForm.CBContractClick(Sender: TObject);
begin
  SetFilter;
  CGestChange(Self);
end;

procedure TMainForm.CBlocatiClick(Sender: TObject);
begin
  if CGroups.ItemIndex = 0 then begin CuBlocati := ''; Exit; end;
 { else
    if CBlocati.Checked then CuBlocati := ''
    else CuBlocati := ' AND (SECTIA <> "B")';  }
  CGroupsChange(Self);
end;
         // :*   >:d<
procedure TMainForm.CCU0Click(Sender: TObject);
begin
  SetFilter;
  CGestChange(Self);
end;

procedure TMainForm.SetFilter;
begin
  if CBContract.Checked then Contract := 'AND ((CONT_USD <> "") OR (CONT_DM <> ""))'
//  else Contract := ' (1 = 1)';
  else Contract := '';
  if (CCU0.Checked) and (QGest.Tag <> 1) then
    UnionAll := 'UNION ALL ' +
                'SELECT CODFUR AS `Cod Fiscal`, DENFUR AS `Denumire`, CONCAT(CONT_DM, CONT_USD), ' +
                'SECTIA AS `St.`, 0 AS `#`, 0 AS `Sold`, " " AS `Data`, CLASA AS `L`, CONCAT(IF(FTIP&2=2,"C",""), ' +
                  'IF(FTIP&4=4,"G",""), IF(FTIP&8=8,"S",""), IF(FTIP&16=16,"M",""), IF(FTIP&32=32,"F",""), ' +
                  'IF(FTIP&64=64,"Gw",""), IF(FTIP&128=128,"Rc",""), IF(FTIP&256=256,"Ex",""), IF(FTIP&512=512,"Gr","")) AS `Co` ' +
              //  '" " AS DATE_DOC ' +
                'FROM `' + CGest.Text + '`.`FUR` ' +
                'WHERE (CODFUR NOT IN ' +
                  '(SELECT CODFC FROM `' + CGest.Text + '`.`FRES' + SDate + '` ' +
                  'WHERE ((SUMADB-SUMACR) <> 0)) ' +
                Contract + ') ORDER BY DENUMIRE'
  else UnionAll := ' ORDER BY DENUMIRE';
end;

procedure TMainForm.CGestChange(Sender: TObject);
var
  TempSQL: string;
begin
  if not GestVisible then Exit;
  SumTotal := 0;
  if (CCU0.Checked) and (QGest.Tag <> 1) then
    UnionAll := 'UNION ALL ' +
                'SELECT CODFUR AS `Cod Fiscal`, DENFUR AS `Denumire`, CONCAT(CONT_DM, CONT_USD), ' +
                'SECTIA AS `St.`, 0 AS `#`, 0 AS `Sold`, " " AS `Data`, CLASA AS `L`, CONCAT(IF(FTIP&2=2,"C",""), ' +
                  'IF(FTIP&4=4,"G",""), IF(FTIP&8=8,"S",""), IF(FTIP&16=16,"M",""), IF(FTIP&32=32,"F",""), ' +
                  'IF(FTIP&64=64,"Gw",""), IF(FTIP&128=128,"Rc",""), IF(FTIP&256=256,"Ex",""), IF(FTIP&512=512,"Gr","")) AS `Co` ' +
              //  '" " AS DATE_DOC ' +
                'FROM `' + CGest.Text + '`.`FUR` ' +
                'WHERE (CODFUR NOT IN ' +
                  '(SELECT CODFC FROM `' + CGest.Text + '`.`FRES' + SDate + '` ' +
                  'WHERE ((SUMADB-SUMACR) <> 0)) ' +
                Contract + ') ORDER BY DENUMIRE'
  else UnionAll := ' ORDER BY DENUMIRE';
  GestSQL := 'SELECT CODFUR AS `Cod Fiscal`, DENFUR AS `Denumire`, CONTRACT AS `$`, SECTIA AS `St.`, ' +
             'COUNT(CODFUR) AS `#`, SUM(SUMA) AS `Sold`, ' +
             'CONCAT(SUBSTRING(MIN(DATADOC),7,2), ".", SUBSTRING(MIN(DATADOC),5,2), ".", SUBSTRING(MIN(DATADOC),1,4)) AS `Data`, ' +
             'CLASA AS `I`, CONCAT(IF(FTIP&2=2,"C",""), IF(FTIP&4=4,"G",""), IF(FTIP&8=8,"S",""), IF(FTIP&16=16,"M",""), IF(FTIP&32=32,"F",""), IF(FTIP&64=64,"Gw",""), IF(FTIP&128=128,"Rc",""), IF(FTIP&256=256,"Ex",""), IF(FTIP&512=512,"Gr","")) AS `Co` ' +
            // 'GROUP_CONCAT("Nr. ", NRDFC, " / ", DATA,  " - ", SUMA, " RON" ORDER BY DATADOC) AS DATE_DOC ' +
             'FROM (SELECT FTIP, NRDFC, CODFUR, DENFUR, CONCAT(CONT_DM, CONT_USD) AS CONTRACT, (SUMADB-SUMACR) AS SUMA, SECTIA, ' +
             //  'CONCAT(SUBSTRING(DATAFC, 1, 2), ".", SUBSTRING(DATAFC, 3, 2), ".", SUBSTRING(DATAFC,5, 4)) AS DATA, ' +
               'CONCAT(SUBSTRING(DATAFC,5,4), SUBSTRING(DATAFC,3,2), SUBSTRING(DATAFC,1,2)) AS DATADOC, CLASA ' +
               'FROM `' + CGest.Text + '`.`FUR` LEFT JOIN `' + CGest.Text + '`.`FRES' + SDate + '` ON CODFUR=CODFC ' +
               'WHERE (CONTFC="4111") AND ((SUMADB-SUMACR) <> 0) ' + Contract +
               'ORDER BY  CONCAT(SUBSTRING(DATAFC,5,4),SUBSTRING(DATAFC,3,2),SUBSTRING(DATAFC,1,2))) AS TEMP ' +
              'GROUP BY CODFUR ' + HavingFact +
             UnionAll;
  QGest.SQL.Text := GestSQL;
  QGest.Active := True;
  TempSQL := 'SELECT DENFUR, CODFC, SECTIA, NRFACT, SUMA FROM (SELECT CODFC, COUNT(CODFC) AS NRFACT, ' +
             'SUM(SUMADB-SUMACR) AS SUMA FROM `' + CGest.Text + '`.`FRES' + SDate + '` WHERE ((SUMADB-SUMACR < -10) OR (SUMADB-SUMACR > 10)) AND (CONTFC = "4111") ' +
             'GROUP BY CODFC) AS TEMP LEFT JOIN `' + CGest.Text + '`.`FUR` ON CODFUR=CODFC WHERE (SUMA <> 0) AND (NRFACT >= ' + ENrFact.Text +') AND ' +
             '((CONT_USD <> "") OR (CONT_DM <> "" )) ORDER BY SECTIA, DENFUR';
  QTemp.SQL.Text := TempSQL;
  QTemp.Active := True;
  QGestRec := QGest.RecordCount;
  LGest.Caption := IntToStr(QTemp.RecordCount) + '/' + IntToStr(QGest.RecordCount) + ' �nregistr�ri.';
  if QGest.Filtered then begin
    TempSQL := 'SELECT DENFUR, CODFC, SECTIA, NRFACT, SUMA FROM (SELECT CODFC, COUNT(CODFC) AS NRFACT, ' +
               'SUM(SUMADB-SUMACR) AS SUMA FROM `' + CGest.Text + '`.`FRES' + SDate + '` WHERE ((SUMADB-SUMACR < -10) OR (SUMADB-SUMACR > 10)) AND (CONTFC = "4111") ' +
               'GROUP BY CODFC) AS TEMP LEFT JOIN `' + CGest.Text + '`.`FUR` ON CODFUR=CODFC WHERE (SUMA <> 0) AND (NRFACT >= ' + ENrFact.Text +') AND ' +
               '((CONT_USD <> "") OR (CONT_DM <> "" )) ORDER BY SECTIA, DENFUR';
    QTemp.SQL.Text := 'SELECT SUM(`NRFACT`), SUM(SUMA) FROM (' + TempSQL + ') AS TEMP2';
    QTemp.Active := True;
    LFact.Caption := 'Facturi neachitate: ' + QTemp.Fields[0].AsString;
  end else begin
    QTemp.SQL.Text := 'SELECT SUM(`#`), SUM(Sold) FROM (' + GestSQL + ') AS TEMP2';
    QTemp.Active := True;
    LFact.Caption := 'Facturi neachitate: ' + QTemp.Fields[0].AsString;
    LTotal.Caption := 'Suma totala: ' + QTemp.Fields[1].AsString + ' RON';
  end;
  GestResize;
  //DBGest.Columns[DBGest.Columns.Count - 1].Visible := False;
//  DBGest.Columns[DBGest.Columns.Count - 2].Visible := False;  
  Selections.Clear;
  LTotal.Caption := 'Suma totala: ' + FloatToStr(SumTotal) + ' RON';
  LTotal.Left := DBGest.Left + DBGest.Width - LTotal.Width;
  LSelected.Caption := IntToStr(Selections.Count) + ' selectate.';
  LSelected.Left := DBGest.Left + DBGest.Width - LSelected.Width;
  DBGest.Tag := 0;
end;

procedure TMainForm.CGroupsChange(Sender: TObject);
var
  I: Integer;
begin
  {if CGroups.ItemIndex = CGroups.Items.Count - 1 then begin //Manager vechi
    ManagerSQL := 'SELECT FUR.IDFURCLI, CONCAT(UPPER(DENUMIRE), " - ", UPPER(NUME)) AS `Denumire`, EMAIL AS `eMail`, NUMAR AS `Telefon`, replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(grupuri, "|2|", ""), "|8|", ""), ' +
                '"|12|", "T"), "|6|", ""), "|4|", ""), "|13|", ""), "|10|", "F"), "|1|", "S"), "|3|", "F"), "|5|", "M"), "|9|", "G"), "|11|", "C"), "|", "") AS ' +
                '`Grup`, GRUPURI, "CONTACTE" AS TABELA, NUME AS LOCATIE FROM `' + CManager.Text + '`.`CONTACTE` C JOIN `' + CManager.Text + '`.`FURCLI` FUR ON C.IDFURCLI = FUR.IDFURCLI UNION ALL ' +
                'SELECT FUR.IDFURCLI, UPPER(DENUMIRE) AS `Denumire`, EMAIL AS `eMail`, TELEFON AS `Telefon`, replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(grupuri, "|2|", ""), "|8|", ""), ' +
                '"|12|", "T"), "|6|", ""), "|4|", ""), "|13|", ""), "|10|", "F"), "|1|", "S"), "|3|", "F"), "|5|", "M"), "|9|", "G"), "|11|", "C"), "|", "") AS ' +
                '`Grup`, GRUPURI, "LOCATII" AS TABELA, LOCATIE FROM `' + CManager.Text + '`.`LOCATII` L JOIN `' + CManager.Text + '`.`FURCLI` FUR ON L.IDFURCLI = FUR.IDFURCLI ORDER BY DENUMIRE';
    Exit;
  end;     }
  if CGroups.ItemIndex = CGroups.Items.Count - 1 then begin //Contacte importate
    AManagerSQL := '';
    AManagerSQL := AManagerSQL +
        'SELECT F.CODFC, F.DENFC AS DENUMIRE, EMAIL, TEL, 0 AS MODULE, F.DENFC AS ID, "" AS STARE, 0 AS CODCONTRACTE ' +
        'FROM `DBCABCONTA`.`FUR` F ' +
        'UNION ALL ';
    AManagerSQL := AManagerSQL +
        'SELECT F.CODFC, CONCAT(F.DENFC, " - ", C.DENFC) AS DENUMIRE, C.EMAIL, C.TEL, 0 AS MODULE, F.DENFC AS ID, "" AS STARE, 0 AS CODCONTRACTE ' +
        'FROM `DBCABCONTA`.`FUR` F INNER JOIN DBCABCONTA.CONTACT C USING(CODFC) ' +
        'ORDER BY DENUMIRE ';
    CManagerChange(Self);
    QManagerRec := QManager.RecordCount;
    Exit;
  end;
  if CGroups.ItemIndex = 0 then begin
    WhereModule := '';
    CBlocati.Checked := False
  end else begin
    if CBlocati.Checked then CuBlocati := ''
    else CuBlocati := ' AND (SECTIA <> "B")'; 
    WhereModule := ' AND (C.CODCONTRACTE&' + IntToStr(1 shl CGroups.ItemIndex) + '=' + IntToStr(1 shl CGroups.ItemIndex) + ')' + CuBlocati;
  end;
  AManagerSQL := '';
  AManagerSQL := AManagerSQL +
      'SELECT F.CODFC, F.DENFC AS DENUMIRE, EMAIL, TEL, CONCAT(IF(CODCONTRACTE&2=2,"C",""), IF(CODCONTRACTE&4=4,"G",""), IF(CODCONTRACTE&8=8,"S",""), ' +
        'IF(CODCONTRACTE&16=16,"M",""), IF(CODCONTRACTE&32=32,"F",""), IF(CODCONTRACTE&64=64,"Gw",""), ' +
        'IF(CODCONTRACTE&128=128,"Rc",""), IF(CODCONTRACTE&256=256,"Ex",""), IF(CODCONTRACTE&512=512,"Gr","")) AS MODULE, F.DENFC AS ID, SECTIA AS STARE, CODCONTRACTE ' +
      'FROM `DBCABCONTA`.`FUR` F INNER JOIN (' +
        'SELECT * FROM (' +
          {'SELECT SECTIA, CODFUR FROM `FDSOFT`.`FUR` WHERE CONCAT(CONT_DM, CONT_USD) <> "" UNION ALL ' +
          'SELECT SECTIA, CODFUR FROM `FSOFTWARE`.`FUR` WHERE CONCAT(CONT_DM, CONT_USD) <> "" UNION ALL ' +
          'SELECT SECTIA, CODFUR FROM `QUALITY`.`FUR` WHERE CONCAT(CONT_DM, CONT_USD) <> "" UNION ALL ' +
          'SELECT SECTIA, CODFUR FROM `FSERVICES`.`FUR` WHERE CONCAT(CONT_DM, CONT_USD) <> "" ' +    }
          Fur +
        ') AS FUR INNER JOIN ' +
        '(SELECT * FROM (' +
          {'SELECT CODFUR, CODCONTRACTE, DATAIN, DATAOUT FROM `fdsoft`.`CONTRACTE` WHERE (SUBSTRING(DATAIN, 3,4) <= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") AND (SUBSTRING(DATAOUT, 3,2) >= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") UNION ALL ' +
          'SELECT CODFUR, CODCONTRACTE, DATAIN, DATAOUT FROM `fsoftware`.`CONTRACTE` WHERE (SUBSTRING(DATAIN, 3,4) <= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") AND (SUBSTRING(DATAOUT, 3,2) >= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") UNION ALL ' +
          'SELECT CODFUR, CODCONTRACTE, DATAIN, DATAOUT FROM `QUALITY`.`CONTRACTE` WHERE (SUBSTRING(DATAIN, 3,4) <= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") AND (SUBSTRING(DATAOUT, 3,2) >= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") UNION ALL ' +
          'SELECT CODFUR, CODCONTRACTE, DATAIN, DATAOUT FROM `FSERVICES`.`CONTRACTE` WHERE (SUBSTRING(DATAIN, 3,4) <= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") AND (SUBSTRING(DATAOUT, 3,2) >= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") ' +}
          Contracte +
        ') AS CONTRACTE) GEST ON FUR.CODFUR = GEST.CODFUR )' +
        'AS C ON F.CODFC=C.CODFUR ' +
      'WHERE (1=1) ' + WhereModule + ' UNION ALL ';
  AManagerSQL := AManagerSQL +
      'SELECT F.CODFC, CONCAT(F.DENFC, " - ", C.DENFC) AS DENUMIRE, C.EMAIL, C.TEL, CONCAT(IF(C.CODCONTRACTE&2=2,"C",""), IF(C.CODCONTRACTE&4=4,"G",""), IF(C.CODCONTRACTE&8=8,"S",""), ' +
      'IF(C.CODCONTRACTE&16=16,"M",""), IF(C.CODCONTRACTE&32=32,"F",""), IF(C.CODCONTRACTE&64=64,"Gw",""), ' +
      'IF(C.CODCONTRACTE&128=128,"Rc",""), IF(C.CODCONTRACTE&256=256,"Ex",""), IF(C.CODCONTRACTE&512=512,"Gr","")) AS MODULE, F.DENFC AS ID, SECTIA AS STARE, GEST.CODCONTRACTE ' +
      'FROM `DBCABCONTA`.`FUR` F INNER JOIN DBCABCONTA.CONTACT C USING(CODFC) INNER JOIN (' +
        'SELECT * FROM (' +
          {'SELECT SECTIA, CODFUR FROM `FDSOFT`.`FUR` WHERE  (CONCAT(CONT_DM, CONT_USD) <> "") UNION ALL ' +
          'SELECT SECTIA, CODFUR FROM `FSOFTWARE`.`FUR` WHERE  (CONCAT(CONT_DM, CONT_USD) <> "") UNION ALL ' +
          'SELECT SECTIA, CODFUR FROM `QUALITY`.`FUR` WHERE  (CONCAT(CONT_DM, CONT_USD) <> "") UNION ALL ' +
          'SELECT SECTIA, CODFUR FROM `FSERVICES`.`FUR` WHERE  (CONCAT(CONT_DM, CONT_USD) <> "") ' +     }
          Fur +
        ') AS FUR INNER JOIN ' +
        '(SELECT * FROM (' +
          {'SELECT CODFUR, CODCONTRACTE, DATAIN, DATAOUT FROM `fdsoft`.`CONTRACTE` WHERE (SUBSTRING(DATAIN, 3,4) <= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") AND (SUBSTRING(DATAOUT, 3,2) >= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") UNION ALL ' +
          'SELECT CODFUR, CODCONTRACTE, DATAIN, DATAOUT FROM `fsoftware`.`CONTRACTE` WHERE (SUBSTRING(DATAIN, 3,4) <= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") AND (SUBSTRING(DATAOUT, 3,2) >= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") UNION ALL ' +
          'SELECT CODFUR, CODCONTRACTE, DATAIN, DATAOUT FROM `QUALITY`.`CONTRACTE` WHERE (SUBSTRING(DATAIN, 3,4) <= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") AND (SUBSTRING(DATAOUT, 3,2) >= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") UNION ALL ' +
          'SELECT CODFUR, CODCONTRACTE, DATAIN, DATAOUT FROM `FSERVICES`.`CONTRACTE` WHERE (SUBSTRING(DATAIN, 3,4) <= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") AND (SUBSTRING(DATAOUT, 3,2) >= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") ' +}
          Contracte + 
        ') AS CONTRACTE) C ON FUR.CODFUR = C.CODFUR )' +
        'AS GEST ON F.CODFC=GEST.CODFUR ' +
      'WHERE (1=1) ' + WhereModule + ' ORDER BY DENUMIRE ';
  CManagerChange(Self);
  QManagerRec := QManager.RecordCount;
end;

procedure TMainForm.CManagerChange(Sender: TObject);
begin
  ManagerSQL := 'SELECT FUR.IDFURCLI, CONCAT(UPPER(DENUMIRE), " - ", UPPER(NUME)) AS `Denumire`, EMAIL AS `eMail`, NUMAR AS `Telefon`, replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(grupuri, "|2|", ""), "|8|", ""), ' +
                '"|12|", "T"), "|6|", ""), "|4|", ""), "|13|", ""), "|10|", "F"), "|1|", "S"), "|3|", "F"), "|5|", "M"), "|9|", "G"), "|11|", "C"), "|", "") AS ' +
                '`Grup`, GRUPURI, "CONTACTE" AS TABELA, NUME AS LOCATIE FROM `' + CManager.Text + '`.`CONTACTE` C JOIN `' + CManager.Text + '`.`FURCLI` FUR ON C.IDFURCLI = FUR.IDFURCLI UNION ALL ' +
                'SELECT FUR.IDFURCLI, UPPER(DENUMIRE) AS `Denumire`, EMAIL AS `eMail`, TELEFON AS `Telefon`, replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(grupuri, "|2|", ""), "|8|", ""), ' +
                '"|12|", "T"), "|6|", ""), "|4|", ""), "|13|", ""), "|10|", "F"), "|1|", "S"), "|3|", "F"), "|5|", "M"), "|9|", "G"), "|11|", "C"), "|", "") AS ' +
                '`Grup`, GRUPURI, "LOCATII" AS TABELA, LOCATIE FROM `' + CManager.Text + '`.`LOCATII` L JOIN `' + CManager.Text + '`.`FURCLI` FUR ON L.IDFURCLI = FUR.IDFURCLI ORDER BY DENUMIRE';
  BManagerSQL := ManagerSQL;
  if dsManager1.Checked then begin
    QManager.SQL.Text := ManagerSQL;
    QManager.Tag := 1;
  end else begin
    QManager.Tag := 0;
    QManager.SQL.Text := AManagerSQL;
  end;
  QManager.Active := True;
  QTemp.Active := False;
  if dsManager1.Checked then begin
    QTemp.SQL.Text := 'CREATE TABLE IF NOT EXISTS `' + CManager.Text + '`.`BLOCATI` (`IDFURCLI` int(10), `GRUPURI` varchar(255), `LOCATIE` varchar(255), `TABELA` varchar(255)) ENGINE=MyISAM DEFAULT CHARSET=latin1';
    QTemp.ExecSQL;
  end;
  ManagerResize; //Resize
  MSelections.Clear;
  LManager.Caption := IntToStr(QManager.RecordCount) + ' �nregistr�ri.';
  LMSelected.Caption := IntToStr(MSelections.Count) + ' selectate.';
  LMSelected.Left := DBManager.Left + DBManager.Width - LMSelected.Width;
  QManagerRec := QManager.RecordCount;
end;

procedure TMainForm.DBDrawDataCell(Sender: TObject; const Rect: TRect;
  Field: TField; State: TGridDrawState);
var
  S: string;
  ARect: TRect;
begin
  if (Sender as TDBGrid).DataSource.DataSet.RecordCount = 0 then Exit;

  ARect := Rect;
  if Rect.Top = 0 then Exit;
  if Field.Index = 0 then GestCurIndex := not GestCurIndex;
  //if (Rect.Top mod 2) = 0 then GestCurIndex := not GestCurIndex;
  with (Sender as TDBGrid).Canvas.Brush do
    //$00C5654D
    //else
      if GestCurIndex then
        Color := RandImpar//$00E28F7B
      else Color := RandPar;//$00E2A596;
  S := StringReplace(Field.Text, '&', '&&', [rfReplaceAll]);
  if (Sender as TDBGrid).Name = 'DBGest' then begin
    if Selections.IndexOf(QGest.Fields[0].Text) >= 0 then begin
      (Sender as TDBGrid).Canvas.Brush.Color := RandSel;//$00C08000;
      if Field.Index <> 2 then (Sender as TDBGrid).Canvas.Font.Color := clWhite;
    end;
    if (Field.Index = 2) and (S <> '') then
      (Sender as TDBGrid).Canvas.Brush.Color := iContract;//$00C7FADA;
    if (Field.Index = 3) and (S = 'B') then
      (Sender as TDBGrid).Canvas.Brush.Color := Blocat;//$00A0A5FF;
    if (Field.Index = 4) and (StrToInt(S) >= StrToInt(ENrFact.Text)) then
      (Sender as TDBGrid).Canvas.Brush.Color := NrFact;//$00A0A5FF;
  end else  //DBManager
    if QManager.Tag = 1 then begin
      if MSelections.IndexOf(QManager.Fields[0].Text + '|' + QManager.Fields[QManager.FieldCount - 1].Text + '$' + QManager.FieldByName('DENUMIRE').Text + '!' + QManager.FieldByName('EMAIL').Text) >= 0 then begin
        (Sender as TDBGrid).Canvas.Brush.Color := RandSel;//$00C08000;
        (Sender as TDBGrid).Canvas.Font.Color := clWhite;
      end
    end else
      if MSelections.IndexOf(QManager.Fields[0].Text + '|' + QManager.FieldByName('ID').Text + '$' + QManager.FieldByName('DENUMIRE').Text + '!' + QManager.FieldByName('EMAIL').Text) >= 0 then begin
        (Sender as TDBGrid).Canvas.Brush.Color := RandSel;//$00C08000;
        (Sender as TDBGrid).Canvas.Font.Color := clWhite;
      end else
        if DBManager.Fields[DBManager.FieldCount - 2].AsString = 'B' then
          (Sender as TDBGrid).Canvas.Brush.Color := Blocat;//$00A0A5FF;
  if gdSelected in State then (Sender as TDBGrid).Canvas.Brush.Color := PozCur;
  (Sender as TDBGrid).Canvas.FillRect(Rect);
  ARect.Left := Rect.Left + 2;
  DrawText((Sender as TDBGrid).Canvas.Handle, PChar(S), Length(S), ARect, 0);
end;

procedure TMainForm.DBGestDblClick(Sender: TObject);
var
  Temp: string;
begin
  Temp := Copy(DBGest.Fields[1].AsString, 1, Pos(' - ', DBGest.Fields[1].AsString) - 1);
//  Delete(Temp, Pos('SRL - ', Temp) + 3, 50);//Must add another column in F1 section for this to work proprelly
  if DBGest.Tag = 0 then
    FurDetail.Start(SDate, DBGest.Fields[0].AsString, DBGest.Fields[1].AsString, DBGest.Fields[3].AsString, DBGest.Fields[4].AsString, DBGest.Fields[5].AsString, CGest.Text)
  else
    FurDetail.Start(SDate, DBGest.Fields[0].AsString, {DBGest.Fields[1].AsString}Temp, DBGest.Fields[3].AsString, DBGest.Fields[4].AsString, DBGest.Fields[5].AsString, DBGest.Columns[DBGest.Columns.Count - 1].Field.AsString);
end;

procedure TMainForm.DBGestKeyPress(Sender: TObject; var Key: Char);
var
  Aux: string;
  I: integer;
begin
  if Key = #27 then Exit;
  if not (Key in ['*', ' ', #13]) then begin
    EGestCauta.Visible := True;
    EGestCauta.Width := DBGest.Width;
    EGestCauta.Text := Key;
    QGest.Locate('Denumire', EGestCauta.Text, [loCaseInsensitive, loPartialKey]);
    EGestCauta.SetFocus;
    EGestCauta.SelStart := 2;
  end;
  if Key = '*' then begin
    SumTotal := 0;
    if (QGestRec = Selections.Count) and (QGestRec <> 0) then begin
      Selections.Clear;
      DBGest.DataSource := nil;
      DBGest.DataSource := DSGest;
    end else begin
      Selections.Clear;
      DBGest.DataSource := nil;
      QGest.First;
      while not QGest.Eof do begin
        Selections.Add(QGest.Fields[0].Text);
        SumTotal := SumTotal + QGest.Fields[4].AsFloat;
        QGest.Next;
      end;
      QGest.First;
      DBGest.DataSource := DSGest;
    end;
  end;
  if Key = ' ' then begin
    Aux := QGest.Fields[0].Text;
    if Selections.IndexOf(Aux) >= 0 then begin
      Selections.Delete(Selections.IndexOf(Aux));
      SumTotal := SumTotal - QGest.FieldByName('SOLD').AsFloat;
    end else begin
      if QGest.FieldByName('St.').AsString <> 'B' then begin
      QTemp.SQL.Text :=
        'SELECT COUNT(CODFC) NR ' +
        'FROM `' + CGest.Text + '`.`FRES' + SDate + '` ' +
        'WHERE ABS(SUMADB - SUMACR ) > ' + FloatToStr(Treshold) +
          ' AND CODFC = "' + DBGest.Columns[0].Field.AsString + '"';
      QTemp.Open;
      if QTemp.FieldByName('NR').AsInteger < QGest.FieldByName('#').AsInteger then
        FDialog.Start('Atentie', 'Clientul selectat are o factura restanta'#13'cu soldul mai mic decat pragul selectat!', fdOk, mtWarning);
      end;
      Selections.Add(Aux);
      SumTotal := SumTotal + QGest.FieldByName('SOLD').AsFloat;
    end;
    QGest.Next;
  end;
  if Key = #13 then DBGestDblClick(Self);  
  for I := 0 to 5 do
    DBGest.Columns[I].Width := Ord(GestColWidths[I + 1]);
  LSelected.Caption := IntToStr(Selections.Count) + ' selectate.';
  LSelected.Left := DBGest.Left + DBGest.Width - LSelected.Width;
  LTotal.Caption := 'Suma totala: ' + FloatToStr(SumTotal) + ' RON';
  LTotal.Left := DBGest.Left + DBGest.Width - LTotal.Width;
end;

procedure TMainForm.DBGestKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F7 then begin
    EGestCauta.Visible := True;
    EGestCauta.Tag := 112;
    EGestCauta.Width := DBGest.Width;
    EGestCauta.Text := '';
    EGestCauta.SetFocus;
    EGestCauta.SelStart := 2;
  end;
end;

procedure TMainForm.DBGestMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  GridCoord: TGridCoord;
  DBGrid: TDBGrid;
  SavedActiveRec: integer;
  SQL: string;
begin
  if GestVisible then begin
    DBGrid := TDBGrid(Sender);
    if DBGestCoordY = DBGrid.MouseCoord(X, Y).Y then Exit
    else
      DBGestCoordY := DBGrid.MouseCoord(X, Y).Y;
    Application.CancelHint;
    GridCoord := DBGrid.MouseCoord(X, Y);
    if (GridCoord.X > 2) and (GridCoord.X < DBGrid.Columns.Count) and (DBGrid.Columns[GridCoord.X].FieldName <> 'I') and (GridCoord.Y > 0) then
    begin
      SavedActiveRec := THDbGrid(DBGrid).DataLink.ActiveRecord;
      THDbGrid(DBGrid).DataLink.ActiveRecord := GridCoord.Y - 1;
      if DBGest.Tag = 0 then
        SQL := 'SELECT GROUP_CONCAT("Nr. ", NRDFC, " / ", DATA,  " - ", SUMA, " RON" ORDER BY DATADOC) FROM (' +
                 'SELECT NRDFC, ' +
                 '(SUMADB - SUMACR) AS SUMA, CONCAT(SUBSTRING(DATAFC, 1, 2), ".", SUBSTRING(DATAFC, 3, 2), ".", SUBSTRING(DATAFC,5, 4)) AS DATA, ' +
                 'CONCAT(SUBSTRING(DATAFC,5,4), SUBSTRING(DATAFC,3,2), SUBSTRING(DATAFC,1,2)) AS DATADOC ' +
                 'FROM `' + CGest.Text + '`.`FRES' + SDate + '` ' +
                 'WHERE ((SUMADB-SUMACR) <> 0) AND (CODFC = "' + DBGrid.Columns[0].Field.AsString + '") AND (CONTFC="4111")) AS TEMP'
      else
        SQL := 'SELECT GROUP_CONCAT("Nr. ", NRDFC, " / ", DATA,  " - ", SUMA, " RON" ORDER BY DATADOC) FROM (' +
                 'SELECT NRDFC, ' +
                 '(SUMADB - SUMACR) AS SUMA, CONCAT(SUBSTRING(DATAFC, 1, 2), ".", SUBSTRING(DATAFC, 3, 2), ".", SUBSTRING(DATAFC,5, 4)) AS DATA, ' +
                 'CONCAT(SUBSTRING(DATAFC,5,4), SUBSTRING(DATAFC,3,2), SUBSTRING(DATAFC,1,2)) AS DATADOC ' +
                 'FROM `' + DBGrid.Columns[DBGrid.Columns.Count - 1].Field.AsString + '`.`FRES' + SDate + '` ' +
                 'WHERE ((SUMADB-SUMACR) <> 0) AND (CODFC = "' + DBGrid.Columns[0].Field.AsString + '") AND (CONTFC="4111")) AS TEMP';
      DQuery.SQL.Text := SQL;
      DQuery.Active := True;
      //DBGrid.Hint := StringReplace(DBGrid.Columns[DBGrid.Columns.Count - 1].Field.AsString, ',', #13, [rfReplaceAll]);
      DBGrid.Hint := StringReplace(DQuery.Fields[0].AsString, ',', #13, [rfReplaceAll]);
      THDbGrid(DBGrid).DataLink.ActiveRecord := SavedActiveRec;
    end
    else begin
      DBGrid.Hint := '';
      Application.CancelHint
    end;
  end;
end;

procedure TMainForm.DBManagerDblClick(Sender: TObject);
var
  Aux: integer;
begin
  Aux := 0;
  if MSelections.Count = 0 then begin
    MSelections.Add(QManager.Fields[0].Text + '|' + QManager.Fields[QManager.FieldCount - 1].Text + '$' + QManager.FieldByName('DENUMIRE').Text + '!' + QManager.FieldByName('EMAIL').Text);
    Aux := 1;
  end;
  Btn_SendClick(Self);
  if Aux = 1 then MSelections.Clear;
end;

procedure TMainForm.DBManagerKeyPress(Sender: TObject; var Key: Char);
var
  Aux: string;
begin
  if Key = #27 then Exit;
  if not (Key in ['*', ' ', #13, '+']) then begin
    EManagerCauta.Visible := True;
    EManagerCauta.Left := DBManager.Left;
    EManagerCauta.Width := DBManager.Width;
    EManagerCauta.Text := Key;
    QManager.Locate('Denumire', EManagerCauta.Text, [loCaseInsensitive, loPartialKey]);
    EManagerCauta.SetFocus;
    EManagerCauta.SelStart := 2;
  end;
  if Key = ' ' then begin
    if QManager.Tag = 0 then
      Aux := QManager.Fields[0].Text + '|' + QManager.FieldByName('ID').Text + '$' + QManager.FieldByName('DENUMIRE').Text + '!' + QManager.FieldByName('EMAIL').Text
    else
      Aux := QManager.Fields[0].Text + '|' + QManager.Fields[QManager.FieldCount - 1].Text + '$' + QManager.FieldByName('DENUMIRE').Text + '!' + QManager.FieldByName('EMAIL').Text;
    if MSelections.IndexOf(Aux) >= 0 then MSelections.Delete(MSelections.IndexOf(Aux))
    else MSelections.Add(Aux);
    QManager.Next;
  end;
  if Key = '*' then begin
    if (QManagerRec = MSelections.Count) and (QManagerRec <> 0) then begin
      MSelections.Clear;
      DBManager.DataSource := nil;
      DBManager.DataSource := DSManager;
      ManagerResize;
    end else begin
      MSelections.Clear;
      DBManager.DataSource := nil;
      QManager.First;
      while not QManager.Eof do begin
        MSelections.Add(QManager.Fields[0].Text + '|' + QManager.FieldByName('ID').Text + '$' + QManager.FieldByName('DENUMIRE').Text + '!' + QManager.FieldByName('EMAIL').Text);
        //SumTotal := SumTotal + QGest.Fields[4].AsFloat;
        QManager.Next;
      end;
      QManager.First;
      DBManager.DataSource := DSManager;
      ManagerResize;
    end;
  end;
  if Key = #13 then DBManagerDblClick(Self);
  
  LMSelected.Caption := IntToStr(MSelections.Count) + ' selectate.';
  LMSelected.Left := DBManager.Left + DBManager.Width - LMSelected.Width;
end;

procedure TMainForm.DBManagerKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_F4) and not (ssAlt in Shift) then begin
    EMail.Start('#', '', 0);
    CGroupsChange(Self);
  end;
  if Key = VK_F6 then begin
    if QManager.Tag = 0 then
      EMail.Start(QManager.Fields[0].AsString, QManager.Fields[QManager.FieldCount - 2].AsString, QManager.Fields[QManager.FieldCount - 1].AsInteger);
    CGroupsChange(Self);
  end;
  if Key = VK_F7 then begin
    EManagerCauta.Visible := True;
    EManagerCauta.Tag := 112;
    EManagerCauta.Width := DBManager.Width;
    EManagerCauta.Text := '';
    EManagerCauta.SetFocus;
    EManagerCauta.SelStart := 2;
  end;
end;

procedure TMainForm.DBManagerMouseMove(Sender: TObject; Shift: TShiftState; X,
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
    DBGrid.Hint := DBGrid.Columns[GridCoord.X].Field.AsString;
    THDbGrid(DBGrid).DataLink.ActiveRecord := SavedActiveRec;
  end
  else
    DBGrid.Hint := '';
end;

procedure TMainForm.dsManager1Click(Sender: TObject);
begin
  dsManager1.Checked := not dsManager1.Checked;
  if dsManager1.Checked then begin
    QManager.Tag := 1;
    QManager.SQL.Text := BManagersql;
    QManager.Active := True;
    CManager.Visible := True;
    Label2.Visible := True;
    Btn_MBlocSel.Visible := True;
    Btn_MDebloc.Visible := True;
    LGrupuri.Visible := False;
    CGroups.Visible := False;
    CBlocati.Visible := False;
  end else begin
    CManager.Visible := False;
    QManager.Tag := 0;
    QManager.SQL.Text := AManagerSQL;
    QManager.Active := True;
    Label2.Visible := False;
    Btn_MBlocSel.Visible := False;
    Btn_MDebloc.Visible := False;
    LGrupuri.Visible := True;
    CGroups.Visible := True;
    CBlocati.Visible := True;
  end;
  MSelections.Clear;
  ManagerResize;
end;

procedure TMainForm.EGestCautaEnter(Sender: TObject);
begin
  if (Sender as TEdit).Tag = 112 then (Sender as TEdit).Color := $00DE924B
  else (Sender as TEdit).Color := clSkyBlue;
end;

procedure TMainForm.EGestCautaExit(Sender: TObject);
begin
  EGestCauta.Tag := 0;
  EGestCauta.Visible := False;
end;

procedure TMainForm.EGestCautaKeyPress(Sender: TObject; var Key: Char);
var
  I : integer;
begin
  if Key = #13 then
    if EGestCauta.Tag <> 112 then begin DBGest.SetFocus; Exit; end
    else begin
      GestSQL := '';
      for I := 0 to CGest.Items.Count - 1 do
        GestSQL := GestSQL +
                   'SELECT CODFUR AS `Cod Fiscal`, CONCAT(DENFUR, " - ' + CGest.Items[I] + '") AS `Denumire`, CONTRACT AS `$`, ' +
                   'SECTIA AS `St.`, COUNT(CODFUR) AS `#`, SUM(SUMA) AS `Sold`, ' +
                   'CONCAT(SUBSTRING(MIN(DATADOC),7,2), ".", SUBSTRING(MIN(DATADOC),5,2), ".", SUBSTRING(MIN(DATADOC),1,4)) AS `Data`, ' +
                   'CLASA AS `I`, CONCAT(IF(FTIP&2=2,"C",""), IF(FTIP&4=4,"G",""), IF(FTIP&8=8,"S",""), IF(FTIP&16=16,"M",""), IF(FTIP&32=32,"F",""), IF(FTIP&64=64,"Gw",""), IF(FTIP&128=128,"Rc",""), IF(FTIP&256=256,"Ex",""), IF(FTIP&512=512,"Gr","")) AS `Co`, ' + //GROUP_CONCAT("Nr. ", NRDFC, " / ", DATA,  " - ", SUMA, " RON" ORDER BY DATADOC) AS DATE_DOC ' +
                   '"' + CGest.Items[I] + '" AS FIRMA ' +
                   'FROM (SELECT NRDFC, FTIP, CODFUR, DENFUR, CONCAT(CONT_DM, CONT_USD) AS CONTRACT, (SUMADB-SUMACR) AS SUMA, SECTIA, ' +
                     'CONCAT(SUBSTRING(DATAFC, 1, 2), ".", SUBSTRING(DATAFC, 3, 2), ".", SUBSTRING(DATAFC,5, 4)) AS DATA, ' +
                     'CONCAT(SUBSTRING(DATAFC,5,4), SUBSTRING(DATAFC,3,2), SUBSTRING(DATAFC,1,2)) AS DATADOC, CLASA ' +
                     'FROM `' + CGest.Items[I] + '`.`FUR` LEFT JOIN `' + CGest.Items[I] + '`.`FRES' + SDate + '` ON CODFUR=CODFC ' +
                     'WHERE (CONTFC="4111") AND ((SUMADB-SUMACR) <> 0) AND (DENFUR LIKE "%' + EGestCauta.Text + '%") ' +
                     'ORDER BY  CONCAT(SUBSTRING(DATAFC,5,4),SUBSTRING(DATAFC,3,2),SUBSTRING(DATAFC,1,2))) AS TEMP ' +
                     'GROUP BY CODFUR UNION ALL ' +
                   'SELECT CODFUR AS `Cod Fiscal`, CONCAT(DENFUR, " - ' + CGest.Items[I] + '") AS `Denumire`, ' +
                   'CONCAT(CONT_DM, CONT_USD) AS `$`, SECTIA AS `St.`, 0 AS `#`, 0 AS `Sold`, " " AS `Data`, CLASA AS `L`, ' +
                   'CONCAT(IF(FTIP&2=2,"C",""), IF(FTIP&4=4,"G",""), IF(FTIP&8=8,"S",""), IF(FTIP&16=16,"M",""), IF(FTIP&32=32,"F",""), IF(FTIP&64=64,"Gw",""), IF(FTIP&128=128,"Rc",""), IF(FTIP&256=256,"Ex",""), IF(FTIP&512=512,"Gr","")) AS `Co`, ' +
                   '"' + CGest.Items[I] + '" AS FIRMA ' +
                   'FROM `' + CGest.Items[I] + '`.`FUR` ' +
                   'WHERE (DENFUR LIKE "%' + EGestCauta.Text + '%") AND (CODFUR NOT IN ' +
                     '(SELECT CODFC FROM `' + CGest.Items[I] + '`.`FRES' + SDate + '` ' +
                     'WHERE ((SUMADB-SUMACR) <> 0)))' +
                   ' UNION ALL ';
        GestSQL := Copy(GestSQL, 1, Length(GestSQL) - 11) + ' ORDER BY DENUMIRE';
        QGest.SQL.Text := GestSQL;
        QGest.Active := True;
        QGestRec := QGest.RecordCount;
        EGestCauta.Tag := 0;
        GestResize;
        DBGest.Columns[DBGest.Columns.Count - 1].Visible := False;
        //DBGest.Columns[DBGest.Columns.Count - 2].Visible := False;
        DBGest.SetFocus;
        DBGest.Tag := 1;
    end;
  if EGestCauta.Tag <> 112 then
    QGest.Locate('Denumire', EGestCauta.Text + Key, [loCaseInsensitive, loPartialKey]);
end;

procedure TMainForm.EManagerCautaExit(Sender: TObject);
begin
  EManagerCauta.Visible := False;
  EManagerCauta.Tag := 0;
end;

procedure TMainForm.EManagerCautaKeyPress(Sender: TObject; var Key: Char);
var
  I: integer;
begin
  if Key = #13 then
    if EManagerCauta.Tag <> 112 then begin DBManager.SetFocus; Exit; end
    else begin
      if QManager.Tag = 1 then begin
        ManagerSQL := 'SELECT FUR.IDFURCLI, CONCAT(UPPER(DENUMIRE), " - ", UPPER(NUME)) AS `Denumire`, EMAIL AS `eMail`, NUMAR AS `Telefon`, replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(grupuri, "|2|", ""), "|8|", ""), ' +
                      '"|12|", "T"), "|6|", ""), "|4|", ""), "|13|", ""), "|10|", "F"), "|1|", "S"), "|3|", "F"), "|5|", "M"), "|9|", "G"), "|11|", "C"), "|", "") AS ' +
                      '`Grup`, GRUPURI, "CONTACTE" AS TABELA, NUME AS LOCATIE FROM `' + CManager.Text + '`.`CONTACTE` C JOIN `' + CManager.Text + '`.`FURCLI` FUR ON C.IDFURCLI = FUR.IDFURCLI WHERE (CONCAT(UPPER(DENUMIRE), " - ", UPPER(NUME)) LIKE "%' + EManagerCauta.Text + '%") OR (EMAIL LIKE "%' + EManagerCauta.Text + '%") UNION ALL ' +
                      'SELECT FUR.IDFURCLI, UPPER(DENUMIRE) AS `Denumire`, EMAIL AS `eMail`, TELEFON AS `Telefon`, replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(grupuri, "|2|", ""), "|8|", ""), ' +
                      '"|12|", "T"), "|6|", ""), "|4|", ""), "|13|", ""), "|10|", "F"), "|1|", "S"), "|3|", "F"), "|5|", "M"), "|9|", "G"), "|11|", "C"), "|", "") AS ' +
                      '`Grup`, GRUPURI, "LOCATII" AS TABELA, LOCATIE FROM `' + CManager.Text + '`.`LOCATII` L JOIN `' + CManager.Text + '`.`FURCLI` FUR ON L.IDFURCLI = FUR.IDFURCLI WHERE (DENUMIRE LIKE "%' + EManagerCauta.Text + '%") OR (EMAIL LIKE "%' + EManagerCauta.Text + '%") ORDER BY DENUMIRE';
        QManager.SQL.Text := ManagerSQL;
      end else begin
        if CGroups.ItemIndex = CGroups.Items.Count - 1 then begin
          AManagerSQL := '';
          AManagerSQL := AManagerSQL +
              'SELECT F.CODFC, F.DENFC AS DENUMIRE, EMAIL, TEL, 0 AS MODULE, F.DENFC AS ID, "" AS STARE, 0 AS CODCONTRACTE ' +
              'FROM `DBCABCONTA`.`FUR` F ' +
              'WHERE (DENFC LIKE "%' + EManagerCauta.Text + '%") OR (EMAIL LIKE "%' + EManagerCauta.Text + '%") UNION ALL ';
          AManagerSQL := AManagerSQL +
              'SELECT F.CODFC, CONCAT(F.DENFC, " - ", C.DENFC) AS DENUMIRE, C.EMAIL, C.TEL, 0 AS MODULE, F.DENFC AS ID, "" AS STARE, 0 AS CODCONTRACTE ' +
              'FROM `DBCABCONTA`.`FUR` F INNER JOIN DBCABCONTA.CONTACT C USING(CODFC) ' +
              'WHERE (CONCAT(F.DENFC, " - ", C.DENFC) LIKE "%' + EManagerCauta.Text + '%") OR (C.EMAIL LIKE "%' + EManagerCauta.Text + '%") ORDER BY DENUMIRE ';
          QManager.SQL.Text := AManagerSQL;
        end else begin
          AManagerSQL := '';
          AManagerSQL := AManagerSQL +
            'SELECT F.CODFC, F.DENFC AS DENUMIRE, EMAIL, TEL, CONCAT(IF(CODCONTRACTE&2=2,"C",""), IF(CODCONTRACTE&4=4,"G",""), IF(CODCONTRACTE&8=8,"S",""), ' +
              'IF(CODCONTRACTE&16=16,"M",""), IF(CODCONTRACTE&32=32,"F",""), IF(CODCONTRACTE&64=64,"Gw",""), ' +
              'IF(CODCONTRACTE&128=128,"Rc",""), IF(CODCONTRACTE&256=256,"Ex",""), IF(CODCONTRACTE&512=512,"Gr","")) AS  MODULE, F.DENFC AS ID, SECTIA AS STARE, CODCONTRACTE ' +
            'FROM `DBCABCONTA`.`FUR` F INNER JOIN (' +
              'SELECT * FROM (' +
                {'SELECT SECTIA, CODFUR FROM `FDSOFT`.`FUR` WHERE  (CONCAT(CONT_DM, CONT_USD) <> "") UNION ALL ' +
                'SELECT SECTIA, CODFUR FROM `FSOFTWARE`.`FUR` WHERE  (CONCAT(CONT_DM, CONT_USD) <> "") UNION ALL ' +
                'SELECT SECTIA, CODFUR FROM `QUALITY`.`FUR` WHERE  (CONCAT(CONT_DM, CONT_USD) <> "") UNION ALL ' +
                'SELECT SECTIA, CODFUR FROM `FSERVICES`.`FUR` WHERE  (CONCAT(CONT_DM, CONT_USD) <> "") ' +     }
                Fur +
              ') AS FUR INNER JOIN ' +
              '(SELECT * FROM (' +
                {'SELECT CODFUR, CODCONTRACTE, DATAIN, DATAOUT FROM `fdsoft`.`CONTRACTE` WHERE (SUBSTRING(DATAIN, 3,4) <= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") AND (SUBSTRING(DATAOUT, 3,2) >= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") UNION ALL ' +
                'SELECT CODFUR, CODCONTRACTE, DATAIN, DATAOUT FROM `fsoftware`.`CONTRACTE` WHERE (SUBSTRING(DATAIN, 3,4) <= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") AND (SUBSTRING(DATAOUT, 3,2) >= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") UNION ALL ' +
                'SELECT CODFUR, CODCONTRACTE, DATAIN, DATAOUT FROM `QUALITY`.`CONTRACTE` WHERE (SUBSTRING(DATAIN, 3,4) <= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") AND (SUBSTRING(DATAOUT, 3,2) >= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") UNION ALL ' +
                'SELECT CODFUR, CODCONTRACTE, DATAIN, DATAOUT FROM `FSERVICES`.`CONTRACTE` WHERE (SUBSTRING(DATAIN, 3,4) <= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") AND (SUBSTRING(DATAOUT, 3,2) >= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") ' +}
                Contracte +
              ') AS CONTRACTE) C ON FUR.CODFUR = C.CODFUR )' +
              'AS GEST ON F.CODFC=GEST.CODFUR ' +
            'WHERE (DENFC LIKE "%' + EManagerCauta.Text + '%") OR (EMAIL LIKE "%' + EManagerCauta.Text + '%") UNION ALL ';
          AManagerSQL := AManagerSQL +
            'SELECT F.CODFC, CONCAT(F.DENFC, " - ", C.DENFC) AS DENUMIRE, C.EMAIL, C.TEL, CONCAT(IF(C.CODCONTRACTE&2=2,"C",""), IF(C.CODCONTRACTE&4=4,"G",""), IF(C.CODCONTRACTE&8=8,"S",""), ' +
              'IF(C.CODCONTRACTE&16=16,"M",""), IF(C.CODCONTRACTE&32=32,"F",""), IF(C.CODCONTRACTE&64=64,"Gw",""), ' +
              'IF(C.CODCONTRACTE&128=128,"Rc",""), IF(C.CODCONTRACTE&256=256,"Ex",""), IF(C.CODCONTRACTE&512=512,"Gr","")) AS MODULE, F.DENFC AS ID, SECTIA AS STARE, GEST.CODCONTRACTE ' +
            'FROM `DBCABCONTA`.`FUR` F INNER JOIN DBCABCONTA.CONTACT C USING(CODFC) INNER JOIN (' +
              'SELECT * FROM (' +
                {'SELECT SECTIA, CODFUR FROM `FDSOFT`.`FUR` WHERE  (CONCAT(CONT_DM, CONT_USD) <> "") UNION ALL ' +
                'SELECT SECTIA, CODFUR FROM `FSOFTWARE`.`FUR` WHERE  (CONCAT(CONT_DM, CONT_USD) <> "") UNION ALL ' +
                'SELECT SECTIA, CODFUR FROM `QUALITY`.`FUR` WHERE  (CONCAT(CONT_DM, CONT_USD) <> "") UNION ALL ' +
                'SELECT SECTIA, CODFUR FROM `FSERVICES`.`FUR` WHERE  (CONCAT(CONT_DM, CONT_USD) <> "") ' +     }
                Fur +
              ') AS FUR INNER JOIN ' +
              '(SELECT * FROM (' +
                {'SELECT CODFUR, CODCONTRACTE, DATAIN, DATAOUT FROM `fdsoft`.`CONTRACTE` WHERE (SUBSTRING(DATAIN, 3,4) <= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") AND (SUBSTRING(DATAOUT, 3,2) >= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") UNION ALL ' +
                'SELECT CODFUR, CODCONTRACTE, DATAIN, DATAOUT FROM `fsoftware`.`CONTRACTE` WHERE (SUBSTRING(DATAIN, 3,4) <= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") AND (SUBSTRING(DATAOUT, 3,2) >= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") UNION ALL ' +
                'SELECT CODFUR, CODCONTRACTE, DATAIN, DATAOUT FROM `QUALITY`.`CONTRACTE` WHERE (SUBSTRING(DATAIN, 3,4) <= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") AND (SUBSTRING(DATAOUT, 3,2) >= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") UNION ALL ' +
                'SELECT CODFUR, CODCONTRACTE, DATAIN, DATAOUT FROM `FSERVICES`.`CONTRACTE` WHERE (SUBSTRING(DATAIN, 3,4) <= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") AND (SUBSTRING(DATAOUT, 3,2) >= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") ' +}
                Contracte +
              ') AS CONTRACTE) C ON FUR.CODFUR = C.CODFUR )' +
              'AS GEST ON F.CODFC=GEST.CODFUR ' +
            'WHERE (CONCAT(F.DENFC, " - ", C.DENFC) LIKE "%' + EManagerCauta.Text + '%") OR (C.EMAIL LIKE "%' + EManagerCauta.Text + '%") ORDER BY DENUMIRE ';
            QManager.SQL.Text := AManagerSQL;
        end;
      end;
      QManager.Active := True;
      ManagerResize;
      LManager.Caption := IntToStr(QManager.RecordCount) + ' �nregistr�ri.';
      LMSelected.Caption := IntToStr(MSelections.Count) + ' selectate.';
      LMSelected.Left := DBManager.Left + DBManager.Width - LMSelected.Width;
      DBManager.SetFocus;
    end;
  if EManagerCauta.Tag <> 112 then
    QManager.Locate('Denumire', EManagerCauta.Text + Key, [loCaseInsensitive, loPartialKey])
end;

procedure TMainForm.ENrFactChange(Sender: TObject);
begin
  if ENrFact.Text <> '' then begin
    CGestChange(Self);
    if QGest.Tag = 1 then QGest.Tag := 0    //Pastreaza starea filtrului (filtrat sau nu)
    else QGest.Tag := 1;
    Btn_FiltruClick(Self);
  end;
end;

procedure TMainForm.ENrFactEnter(Sender: TObject);
begin
  ENrFact.SelectAll;
end;

procedure TMainForm.ENrFactKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in [#8, #13, '0'..'9']) then Key := #0;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  Ini: TIniFile;
begin
  Tray.Visible := False;
  UnRegisterHotkey( Handle, 1 ) ;
  Ini := TIniFile.Create(GetCurrentDir + '\setari.ini');
  with Ini do begin
    WriteString('GestDB', 'DBs', GestDB);
    if CGest.ItemIndex = -1 then WriteInteger('GestDB', 'Index', 0)
    else WriteInteger('GestDB', 'Index', CGest.ItemIndex);
    WriteString('ManagerDB', 'DBs', ManagerDB);
    if CManager.ItemIndex = -1 then WriteInteger('ManagerDB', 'Index', 0)
    else WriteInteger('ManagerDB', 'Index', CManager.ItemIndex);

    if GestVisible then WriteInteger('GestDB', 'Visible', 1)
    else WriteInteger('GestDB', 'Visible', 0);
    if ManagerVisible then WriteInteger('ManagerDB', 'Visible', 1)
    else WriteInteger('ManagerDB', 'Visible', 0);

    WriteString('Alias', 'Name', CAlias.Text);
    WriteBool('Misc', 'CCU0', CCU0.Checked);
    WriteBool('Misc', 'CBContract', CBContract.Checked);
    WriteInteger('Colors', 'Fundal', MainForm.Color);
    WriteInteger('Colors', 'Titlu', DBGest.FixedColor);
    WriteInteger('Colors', 'PozCur', PozCur);
    WriteInteger('Colors', 'RandSel', RandSel);
    WriteInteger('Colors', 'RandImpar', RandImpar);
    WriteInteger('Colors', 'RandPar', RandPar);
    WriteInteger('Colors', 'Contract', iContract);
    WriteInteger('Colors', 'Blocat', Blocat);
    WriteInteger('Colors', 'NrFact', NrFact);
    WriteInteger('Startup', 'Refresh', DoRefresh);
    WriteInteger('Startup', 'Expire', DoExpire);
    WriteInteger('Startup', 'Verify', DoVerify);
    WriteFloat('Misc','Treshold', Treshold);
  end;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if ThreadsRunning <> 0 then begin
    CanClose := False;
    ShowMessage('Sending...');
  end;
end;

procedure TMainForm.CFirmeExit(Sender: TObject);
begin
  CFirme.Visible := False;
end;

procedure TMainForm.CFirmeKeyPress(Sender: TObject; var Key: Char);
var
  I: integer;
begin
  if Key = #13 then begin
    GestSQL := '';
    for I := 0 to CGest.Items.Count - 1 do
      GestSQL := GestSQL + 'SELECT CODFC AS `Cod Fiscal`, CONCAT(DENFUR, " - ' + CGest.Items[I] + ' - ") AS `Denumire`, SECTIA AS `St.`, NRFACT AS `#`, SUMA AS `Suma` FROM (SELECT CODFC, COUNT(CODFC) AS NRFACT, ' +
                 'SUM(SUMADB-SUMACR) AS SUMA, CLASA AS `L` FROM `' + CGest.Items[I] + '`.`FRES' + SDate + '` WHERE (((SUMADB-SUMACR < -10) OR (SUMADB-SUMACR > 10)) AND (CONTFC = "4111")) ' +
                 'GROUP BY CODFC) AS TEMP LEFT JOIN `' + CGest.Items[I] + '`.`FUR` ON CODFUR=CODFC WHERE ' + Contract + ' AND (DENFUR LIKE "%' + CFirme.Text + '%") UNION ALL ' +
                 'SELECT CODFUR, CONCAT(DENFUR, " - ' + CGest.Items[I] + ' - ") AS DENFUR, "" AS SECTIA, 0 AS NRFACT, 0 AS SUMA FROM `' + CGest.Items[I] + '`.`FUR` WHERE ' + Contract + ' AND' +
                 '(CODFUR NOT IN (SELECT CODFC FROM `' + CGest.Items[I] + '`.`FRES' + SDate + '` WHERE ((SUMADB-SUMACR < -10) OR (SUMADB-SUMACR > 10)) AND (CONTFC = "4111"))) AND (DENFUR LIKE "%' + CFirme.Text + '%") UNION ALL ';
      GestSQL := Copy(GestSQL, 1, Length(GestSQL) - 11);
      QGest.SQL.Text := GestSQL;
      QGest.Active := True;
      QGestRec := QGest.RecordCount;
      GestResize;
      DBGest.SetFocus;
  end;
end;

procedure TMainForm.CFirmePopulate;
var
  SQLText: String;
  I: integer;
begin
  SQLText := 'SELECT DISTINCT DENFUR FROM (';
  for I := 0 to CGest.Items.Count - 1 do
    SQLText := SQLText + 'SELECT DENFUR FROM `' + CGest.Items[I] + '`.`FUR` UNION ALL ';
  QTemp.SQL.Text := Copy(SQLText, 1, Length(SQLText) - 11) + ') AS TEMP ORDER BY DENFUR';
  QTemp.Active := True;
  CFirme.Items.Clear;
  QTemp.Next;
  while not QTemp.Eof do begin
    CFirme.Items.Add(QTemp.FieldByName('DENFUR').AsString);
    QTemp.Next;
  end;
  CFirme.ItemIndex := 0;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  Ini: TIniFile;
  Reg: TRegistry;
  Keys: TStringList;
  Y: word;
  M: word;
  D: word;
  MyHandle: THandle;
  Struct: TProcessEntry32;
  Temp: integer;
  I: integer;
  TempSig: string;
  LastDate: string;
begin
  ThreadsRunning := 0;
  Signature := TStringList.Create;
  Groups := TStringList.Create;
  Keys := TStringList.Create;
  Keys.Clear;
  MyHandle:=CreateToolHelp32SnapShot(TH32CS_SNAPPROCESS, 0);
  Struct.dwSize:=Sizeof(TProcessEntry32);
  if Process32First(MyHandle, Struct) then
    if (Pos('.exe', Struct.szExeFile) <> 0) then
      Keys.Add(Struct.szExeFile);
  while Process32Next(MyHandle, Struct) do
    if (Pos('.exe', Struct.szExeFile) <> 0) then
      Keys.Add(Struct.szExeFile);
  Temp := 0;
  for I := 0 to Keys.Count - 1 do
    if Keys[I] = ExtractFileName(Application.ExeName) then Inc(Temp);
  if Temp > 1 then begin
    FDialog.Start('Atentie', 'Acest program a mai fost deschis pe acest calculator.', fdOk, mtError);
    Application.Terminate;
  end;

  Application.HintPause := 150;
  Application.HintHidePause := 20000;
  Tray.Icon := Application.Icon;
  Tray.Visible := True;
  HK1 := GlobalAddAtom('Show');
  RegisterHotKey(Handle, HK1, MOD_ALT, VK_F2);
  HK2 := GlobalAddAtom('Password');
  RegisterHotKey(Handle, HK2, MOD_CONTROL, VK_F9);
  SumTotal := 0;
  DecodeDate(Now, Y, M, D);
  SDate := RightStr('0' + IntToStr(M), 2) + RightStr(IntToStr(Y), 2);
  Selections := TStringList.Create;
  MSelections := TStringList.Create;
  SelRow := 6;
  MSelRow := 6;
  Ini := TIniFile.Create(GetCurrentDir + '\setari.ini');
  with Ini do begin
    GestDB := ReadString('GestDB', 'DBs', 'fdsoft, fsoftware, fservices, quality');
    CGestIndex := ReadInteger('GestDB', 'Index', 0);
    GestVisible := ReadInteger('GestDB', 'Visible', 1) = 1;
    ManagerVisible := ReadInteger('ManagerDB', 'Visible', 1) = 1;
    ManagerDB := ReadString('ManagerDB', 'DBs', 'agenda');
    CManagerIndex := ReadInteger('ManagerDB', 'Index', 0);
    Alias := ReadString('Alias', 'Name', '');
    if ReadInteger('Misc', 'Protect', 1) <> 102822 then begin
      Btn_Debloc.Visible := False;
      Btn_BlocSel.Visible := False;
      Btn_SelCli.Visible := False;
      Btn_BlocAuto.Visible := False;
      Btn_MDebloc.Visible := False;
      Btn_MBlocSel.Visible := False;
      Btn_Extrase.Visible := False;
    end;

    LastDate := ReadString('Misc', 'LastRun', '');
    WriteString('Misc', 'LastRun', MySQLDateToStr(Now, 'YYYY-MM-DD'));

    Fundal := ReadInteger('Colors', 'Fundal', 16758711);
    MainForm.Color := Fundal;
    Titlu := ReadInteger('Colors', 'Titlu', 16744576);
    DBGest.FixedColor := Titlu;
    DBManager.FixedColor := Titlu;
    PozCur := ReadInteger('Colors', 'PozCur', 12936525);
    RandSel := ReadInteger('Colors', 'RandSel', 12615680);
    RandImpar := ReadInteger('Colors', 'RandImpar', 14847867);
    RandPar := ReadInteger('Colors', 'RandPar', 14853526);
    iContract := ReadInteger('Colors', 'Contract', 13105882);
    Blocat := ReadInteger('Colors', 'Blocat', 10528255);
    NrFact := ReadInteger('Colors', 'NrFact', 10528255);
    UMail := ReadString('Mail', 'User', 'alex@dsoft.ro');
    PMail := ReadString('Mail', 'Pass', 'ce1389e8');
    TUMail := UMail; //TThread;
    TPMail := PMail;
    PortMail := ReadInteger('Mail', 'Port', 587);
    with Locations do begin
      Grup1 := ReadString('Locations', 'Grup1', '');
      Grup2 := ReadString('Locations', 'Grup2', '');
      Grup3 := ReadString('Locations', 'Grup3', '');
      Grup4 := ReadString('Locations', 'Grup4', '');
      Grup5 := ReadString('Locations', 'Grup5', '');
      Grup6 := ReadString('Locations', 'Grup6', '');
      Grup7 := ReadString('Locations', 'Grup7', '');
      Grup8 := ReadString('Locations', 'Grup8', '');
      Grup9 := ReadString('Locations', 'Grup9', '');
    end;
    ListaAngajati := ReadString('Sesizari', 'Angajati', 'OLI,TEODORA,MISU,MONI,HORIA,D.NICOLAE,D.RODICA,SEBA,ALEX');
    TempSig := ReadString('Mail', 'Semnatura', '');
    while Pos('<BR>', TempSig) <> 0 do begin
      Signature.Add(Copy(TempSig, 1, Pos('<BR>', TempSig) - 1));
      Delete(TempSig, 1, Pos('<BR>', TempSig) + 3);
    end;
    Signature.Add(TempSig);
    MainForm.Caption := 'dsBlocare - Sunteti logat ca: ' + UMail + '.  Data selectata este: ' + Copy(SDate, 1, 2) + '/' + Copy(SDate, 3, 2);
    DoRefresh := ReadInteger('Startup', 'Refresh', 1);
    DoExpire := ReadInteger('Startup', 'Expire', 1);
    DoVerify := ReadInteger('Startup', 'Verify', 1);
    JurUser := ReadString('Sesizari', 'CodUser', 'ALEX-A,ANCA-Y,MS.DAVID-D,HORIA-H,MISU-B,MONI-M,MR.DAVID-Z,OLI-O,SEBA-S,TEO-T');
    JurUser := StringReplace(JurUser, '-', '=', [rfReplaceAll]);
    Treshold := ReadFloat('Misc','Treshold',10);
  end;
  CGest.Items.CommaText := GestDB;
  CGest.ItemIndex := CGestIndex;
  CManager.Items.CommaText := ManagerDB;
  CManager.ItemIndex := CManagerIndex;
  GestCurIndex := True;
  GestFieldCount := 6; //-1
  ManagerFieldCount := 7; //-1
  GestColWidths := Chr(70) + Chr(200) + Chr(16) + Chr(12) + Chr(12) + Chr(50) + Chr(60) + Chr(12) + Chr(42) + Chr(32);
  ManagerColWidths := Chr(1) + Chr(160) + Chr(140) + Chr(70) + Chr(80) + Chr(1) + Chr(1) + Chr(1);
  Keys.Clear;
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_CURRENT_USER;
  if Reg.OpenKey('Software\ODBC\ODBC.INI', False) then begin
     Reg.GetKeyNames(Keys);
     CAlias.Items := Keys;
  end;

  if Alias <> '' then begin
    CAlias.ItemIndex := CAlias.Items.IndexOf(Alias);
    Contract := 'AND ((CONT_USD <> "") OR (CONT_DM <> ""))';
    //
    HavingFact := ' ';
    {UnionAll := ' UNION ALL SELECT F.CODFUR, DENFUR, "" AS SECTIA, 0 AS NRFACT, 0 AS SUMA, CONCAT(SUBSTRING(DATA, 7, 2), ".", SUBSTRING(DATA, 5, 2), ".", ' +
                'SUBSTRING(DATA,1, 4)) AS `Data`, CLASA AS `L` FROM `' + CGest.Text + '`.`FUR` F ' +
                'LEFT JOIN (SELECT TEMP.CODFUR, DENUMIRE, DATA FROM (SELECT U.CODFUR, DENUMIRE, CONCAT(ANLUNA, ZIUA) AS DATA FROM `' + CGest.Text + '`.`UMIV` U ORDER BY ANLUNA ' +
                'DESC, ZIUA DESC) AS TEMP GROUP BY CODFUR ORDER BY DENUMIRE ASC) AS TEMP3 ON TEMP3.CODFUR = F.CODFUR  WHERE ' + Contract + WhereSuma +
                ' AND (F.CODFUR NOT IN (SELECT CODFC FROM `' + CGest.Text + '`.`FRES' + SDate + '` WHERE ((SUMADB-SUMACR < -10) OR (SUMADB-SUMACR > 10)) AND (CONTFC = "4111")))';}
    UnionAll := 'UNION ALL ' +
                'SELECT CODFUR AS `Cod Fiscal`, DENFUR AS `Denumire`, CONCAT(CONT_DM, CONT_USD) AS `$`, SECTIA AS `St.`, 0 AS `#`, ' +
                '0 AS `Sold`, " " AS `Data`, CLASA AS `L`, CONCAT(IF(FTIP&2=2,"C",""), IF(FTIP&4=4,"G",""), IF(FTIP&8=8,"S",""), ' +
                  'IF(FTIP&16=16,"M",""), IF(FTIP&32=32,"F",""), IF(FTIP&64=64,"Gw",""), IF(FTIP&128=128,"Rc",""), IF(FTIP&256=256,"Ex",""), ' +
                  'IF(FTIP&512=512,"Gr","")) AS `Co` ' +
               // '" " AS DATE_DOC ' +
                'FROM `' + CGest.Text + '`.`FUR` ' +
                'WHERE (CODFUR NOT IN ' +
                  '(SELECT CODFC FROM `' + CGest.Text + '`.`FRES' + SDate + '` ' +
                  'WHERE ((SUMADB-SUMACR) <> 0)) ' +
                Contract + ') ORDER BY DENUMIRE';
    //if CBlocati.Checked then
    CuBlocati := '';
    //else CuBlocati := ' AND (SECTIA <> "B")'; 
    WhereModule := '' + CuBlocati;
    I := 0;
    Fur := '';
    Contracte := '';
    for I := 0 to CGest.Items.Count - 1 do begin
      Fur := Fur +
        'SELECT SECTIA, CODFUR FROM `' + CGest.Items[I] + '`.`FUR` WHERE CONCAT(CONT_DM, CONT_USD) >= "0" UNION ALL ';
      Contracte := Contracte +
        'SELECT CODFUR, CODCONTRACTE, DATAIN, DATAOUT FROM `' + CGest.Items[I] + '`.`CONTRACTE` WHERE (SUBSTRING(DATAIN, 3,4) <= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") AND (SUBSTRING(DATAOUT, 3,4) >= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") UNION ALL ';
    end;
    Fur := Copy(Fur, 1, Length(Fur) - 11);
    Contracte := Copy(Contracte, 1, Length(Contracte) - 11);
    AManagerSQL := AManagerSQL +
      'SELECT F.CODFC, F.DENFC AS DENUMIRE, EMAIL, TEL, CONCAT(IF(CODCONTRACTE&2=2,"C",""), IF(CODCONTRACTE&4=4,"G",""), IF(CODCONTRACTE&8=8,"S",""), ' +
        'IF(CODCONTRACTE&16=16,"M",""), IF(CODCONTRACTE&32=32,"F",""), IF(CODCONTRACTE&64=64,"Gw",""), ' +
        'IF(CODCONTRACTE&128=128,"Rc",""), IF(CODCONTRACTE&256=256,"Ex",""), IF(CODCONTRACTE&512=512,"Gr","")) AS  MODULE, F.DENFC AS ID, SECTIA AS STARE, CODCONTRACTE ' +
      'FROM `DBCABCONTA`.`FUR` F INNER JOIN (' +
        'SELECT * FROM (' +
          {'SELECT SECTIA, CODFUR FROM `FDSOFT`.`FUR` WHERE  (CONCAT(CONT_DM, CONT_USD) <> "") UNION ALL ' +
          'SELECT SECTIA, CODFUR FROM `FSOFTWARE`.`FUR` WHERE  (CONCAT(CONT_DM, CONT_USD) <> "") UNION ALL ' +
          'SELECT SECTIA, CODFUR FROM `QUALITY`.`FUR` WHERE  (CONCAT(CONT_DM, CONT_USD) <> "") UNION ALL ' +
          'SELECT SECTIA, CODFUR FROM `FSERVICES`.`FUR` WHERE  (CONCAT(CONT_DM, CONT_USD) <> "") ' +     }
          Fur +
        ') AS FUR INNER JOIN ' +
        '(SELECT * FROM (' +
          {'SELECT CODFUR, CODCONTRACTE, DATAIN, DATAOUT FROM `fdsoft`.`CONTRACTE` WHERE (SUBSTRING(DATAIN, 3,4) <= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") AND (SUBSTRING(DATAOUT, 3,2) >= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") UNION ALL ' +
          'SELECT CODFUR, CODCONTRACTE, DATAIN, DATAOUT FROM `fsoftware`.`CONTRACTE` WHERE (SUBSTRING(DATAIN, 3,4) <= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") AND (SUBSTRING(DATAOUT, 3,2) >= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") UNION ALL ' +
          'SELECT CODFUR, CODCONTRACTE, DATAIN, DATAOUT FROM `QUALITY`.`CONTRACTE` WHERE (SUBSTRING(DATAIN, 3,4) <= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") AND (SUBSTRING(DATAOUT, 3,2) >= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") UNION ALL ' +
          'SELECT CODFUR, CODCONTRACTE, DATAIN, DATAOUT FROM `FSERVICES`.`CONTRACTE` WHERE (SUBSTRING(DATAIN, 3,4) <= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") AND (SUBSTRING(DATAOUT, 3,2) >= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") ' +}
          Contracte + 
        ') AS CONTRACTE) C ON FUR.CODFUR = C.CODFUR )' +
        'AS GEST ON F.CODFC=GEST.CODFUR ' +
      'WHERE (1=1) ' + WhereModule + ' UNION ALL ';
      AManagerSQL := AManagerSQL +
      'SELECT F.CODFC, CONCAT(F.DENFC, " - ", C.DENFC) AS DENUMIRE, C.EMAIL, C.TEL, CONCAT(IF(C.CODCONTRACTE&2=2,"C",""), IF(C.CODCONTRACTE&4=4,"G",""), IF(C.CODCONTRACTE&8=8,"S",""), ' +
        'IF(C.CODCONTRACTE&16=16,"M",""), IF(C.CODCONTRACTE&32=32,"F",""), IF(C.CODCONTRACTE&64=64,"Gw",""), ' +
        'IF(C.CODCONTRACTE&128=128,"Rc",""), IF(C.CODCONTRACTE&256=256,"Ex",""), IF(C.CODCONTRACTE&512=512,"Gr","")) AS MODULE, F.DENFC AS ID, SECTIA AS STARE, GEST.CODCONTRACTE ' +
      'FROM `DBCABCONTA`.`FUR` F INNER JOIN DBCABCONTA.CONTACT C USING(CODFC) INNER JOIN (' +
        'SELECT * FROM (' +
          {'SELECT SECTIA, CODFUR FROM `FDSOFT`.`FUR` WHERE  (CONCAT(CONT_DM, CONT_USD) <> "") UNION ALL ' +
          'SELECT SECTIA, CODFUR FROM `FSOFTWARE`.`FUR` WHERE  (CONCAT(CONT_DM, CONT_USD) <> "") UNION ALL ' +
          'SELECT SECTIA, CODFUR FROM `QUALITY`.`FUR` WHERE  (CONCAT(CONT_DM, CONT_USD) <> "") UNION ALL ' +
          'SELECT SECTIA, CODFUR FROM `FSERVICES`.`FUR` WHERE  (CONCAT(CONT_DM, CONT_USD) <> "") ' +     }
          Fur +
        ') AS FUR INNER JOIN ' +
        '(SELECT * FROM (' +
          {'SELECT CODFUR, CODCONTRACTE, DATAIN, DATAOUT FROM `fdsoft`.`CONTRACTE` WHERE (SUBSTRING(DATAIN, 3,4) <= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") AND (SUBSTRING(DATAOUT, 3,2) >= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") UNION ALL ' +
          'SELECT CODFUR, CODCONTRACTE, DATAIN, DATAOUT FROM `fsoftware`.`CONTRACTE` WHERE (SUBSTRING(DATAIN, 3,4) <= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") AND (SUBSTRING(DATAOUT, 3,2) >= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") UNION ALL ' +
          'SELECT CODFUR, CODCONTRACTE, DATAIN, DATAOUT FROM `QUALITY`.`CONTRACTE` WHERE (SUBSTRING(DATAIN, 3,4) <= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") AND (SUBSTRING(DATAOUT, 3,2) >= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") UNION ALL ' +
          'SELECT CODFUR, CODCONTRACTE, DATAIN, DATAOUT FROM `FSERVICES`.`CONTRACTE` WHERE (SUBSTRING(DATAIN, 3,4) <= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") AND (SUBSTRING(DATAOUT, 3,2) >= "'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'") ' +}
          Contracte + 
        ') AS CONTRACTE) C ON FUR.CODFUR = C.CODFUR )' +
        'AS GEST ON F.CODFC=GEST.CODFUR ' +
      'WHERE (1=1) ' + WhereModule + ' ORDER BY DENUMIRE ';
    CAliasChange(Self);
  end;
  CCU0.Checked := Ini.ReadBool('Misc', 'CCU0', True);
  CBContract.Checked := Ini.ReadBool('Misc', 'CBContract', True);
  Ini.Free;
  if MySQLDateToStr(Now, 'YYYY-MM-DD') > LastDate then
    DoSchedule;
end;

procedure TMainForm.DoSchedule;
begin
  if (DoExpire = 0) and ManagerVisible then ScheduleExpire(10);
  if DoRefresh = 0 then ScheduleRefresh;
//  if DoVerify <> 2 then ScheduleVerify;
end;

procedure TMainForm.ScheduleRefresh;
var
  Temp: string;
  SQL: string;
  I: Integer;
begin
  Temp := QTemp.SQL.Text;
  QTemp.SQL.Text := 'DROP TABLE IF EXISTS DBCABCONTA.BK_FUR';
  QTemp.ExecSQL;
  QTemp.SQL.Text := 'CREATE TABLE DBCABCONTA.BK_FUR SELECT * FROM DBCABCONTA.FUR';
  QTemp.ExecSQL;
  QTemp.SQL.Text := 'DELETE FROM DBCABCONTA.FUR';
  QTemp.ExecSQL;
  QTemp.SQL.Text := 'DROP TABLE IF EXISTS DBCABCONTA.BK_CONTACT';
  QTemp.ExecSQL;
  QTemp.SQL.Text := 'CREATE TABLE DBCABCONTA.BK_CONTACT SELECT * FROM DBCABCONTA.CONTACT';
  QTemp.ExecSQL;
  QTemp.SQL.Text := 'DELETE FROM DBCABCONTA.CONTACT';
  QTemp.ExecSQL;
  SQL := 'INSERT INTO `DBCABCONTA`.`FUR` SELECT DISTINCT * FROM (';
  for I := 0 to CGest.Items.Count - 1 do
    SQL := SQL +
      'SELECT CODFUR CODFC, DENFUR DENFC, ADRF ADR, IF(UPPER(EMAIL)="W","", EMAIL) EMAIL, IF(LENGTH(TELEFON) < 6, "",TELEFON) TEL, "" FAX ' +
      'FROM `' + CGest.Items[I] + '`.`FUR` ' +
      'WHERE CONCAT(EMAIL,TELEFON) NOT IN ("W","") OR (CODFUR IN (SELECT CODFUR FROM `' + CGest.Items[I] + '`.`CONTACTE` UNION ALL SELECT CODFUR FROM `' + CGest.Items[I] + '`.`CONTRACTE`)) ' +
      'UNION ALL ';
  SQL := Copy(SQL, 1, Length(SQL) - 11) + ' ORDER BY DENFC ASC, EMAIL) T GROUP BY CODFC, EMAIL ORDER BY DENFC';
  QTemp.SQL.Text := SQL;
  QTemp.ExecSQL;
  SQL := 'INSERT INTO `DBCABCONTA`.`CONTACT` (CODFC, DENFC, TEL, EMAIL, CODCONTRACTE, FAX, ADR) SELECT DISTINCT * FROM  (';
  for I := 0 to CGest.Items.Count - 1 do
    SQL := SQL +
      'SELECT CODFUR CODFC, NUME DENFC, IF(LENGTH(TELEFON) < 6, "",TELEFON) TEL, EMAIL, CODCONTRACTE, "" FAX, "" ADR ' +
      'FROM `' + CGest.Items[I] + '`.`CONTACTE` ' +
      'WHERE CONCAT(EMAIL,TELEFON) NOT IN ("W","") UNION ALL ';
  SQL := Copy(SQL, 1, Length(SQL) - 11) + ') T GROUP BY EMAIL';
  QTemp.SQL.Text := SQL;
  QTemp.ExecSQL;
end;

procedure TMainForm.ScheduleExpire(NrZile: integer);
var
  ExpireSQL: string;
  I: integer;
  Temp: string;
  tempFur: string;
  tempContracte: string;
  TestQ: TQuery;
begin
    Temp := FormatDateTime('yyyymmdd', Now + NrZile);
  for I := 0 to CGest.Items.Count - 1 do begin
    tempFur := tempFur +
      'SELECT SECTIA, CODFUR FROM `' + CGest.Items[I] + '`.`FUR` WHERE (CONCAT(CONT_DM, CONT_USD) <= "0")  UNION ALL ';
    tempContracte := tempContracte +
      'SELECT CODFUR, CODCONTRACTE, DATAIN, DATAOUT FROM `' + CGest.Items[I] + '`.`CONTRACTE` WHERE (DATAOUT >= "20'+ Copy(SDate, 3, 2) + Copy(SDate, 1, 2) +'01") AND (DATAOUT <= "'+ Temp +'") AND (NUMAR="0") UNION ALL ';
  end;
  tempFur := Copy(tempFur, 1, Length(tempFur) - 11);
  tempContracte := Copy(tempContracte, 1, Length(tempContracte) - 11);
  ExpireSQL := ExpireSQL +
    'SELECT DISTINCT F.CODFC, F.DENFC AS DENUMIRE, EMAIL, TEL, CONCAT(IF(CODCONTRACTE&2=2,"C",""), IF(CODCONTRACTE&4=4,"G",""), IF(CODCONTRACTE&8=8,"S",""), ' +
      'IF(CODCONTRACTE&16=16,"M",""), IF(CODCONTRACTE&32=32,"F",""), IF(CODCONTRACTE&64=64,"Gw",""), ' +
      'IF(CODCONTRACTE&128=128,"Rc",""), IF(CODCONTRACTE&256=256,"Ex",""), IF(CODCONTRACTE&512=512,"Gr","")) AS  MODULE, F.DENFC AS ID, SECTIA AS STARE, CODCONTRACTE ' +
    'FROM `DBCABCONTA`.`FUR` F INNER JOIN (' +
      'SELECT * FROM (' +
        tempFur +
      ') AS FUR INNER JOIN ' +
      '(SELECT * FROM (' +
        tempContracte + 
      ') AS CONTRACTE) C ON FUR.CODFUR = C.CODFUR )' +
      'AS GEST ON F.CODFC=GEST.CODFUR ' +
    'WHERE (1=1) ' + WhereModule + ' UNION ALL ';
  ExpireSQL := ExpireSQL +
    'SELECT DISTINCT F.CODFC, CONCAT(F.DENFC, " - ", C.DENFC) AS DENUMIRE, C.EMAIL, C.TEL, CONCAT(IF(C.CODCONTRACTE&2=2,"C",""), IF(C.CODCONTRACTE&4=4,"G",""), IF(C.CODCONTRACTE&8=8,"S",""), ' +
      'IF(C.CODCONTRACTE&16=16,"M",""), IF(C.CODCONTRACTE&32=32,"F",""), IF(C.CODCONTRACTE&64=64,"Gw",""), ' +
      'IF(C.CODCONTRACTE&128=128,"Rc",""), IF(C.CODCONTRACTE&256=256,"Ex",""), IF(C.CODCONTRACTE&512=512,"Gr","")) AS MODULE, F.DENFC AS ID, SECTIA AS STARE, GEST.CODCONTRACTE ' +
    'FROM `DBCABCONTA`.`FUR` F INNER JOIN DBCABCONTA.CONTACT C USING(CODFC) INNER JOIN (' +
      'SELECT * FROM (' +
        tempFur +
      ') AS FUR INNER JOIN ' +
      '(SELECT * FROM (' +
        tempContracte +
      ') AS CONTRACTE) C ON FUR.CODFUR = C.CODFUR )' +
      'AS GEST ON F.CODFC=GEST.CODFUR ' +
    'ORDER BY DENUMIRE ';
  TestQ := TQuery.Create(MainForm);
  TestQ.DatabaseName := DB.DatabaseName;
  TestQ.SQL.Text := ExpireSQL;
  TestQ.Active := True;
  if TestQ.RecordCount <> 0 then begin
    FDialog.Start('Atentionare expirare', 'Urmatorilor clienti le vor expira cele doua luni de asistenta gratuita'+#13+'Apasati butonul OK.', fdOk, mtInformation);
    Temp := AManagerSQL;
    AManagerSQL := ExpireSQL;
    CManagerChange(CManager);
    //AManagerSQL := Temp;
  end else
    FDialog.Start('Atentionare expirare', 'Nu exista clienti la care le vor expira cele doua luni de asistenta gratuita.'+#13+'Apasati butonul OK.', fdOk, mtInformation);
  TestQ.Free;  
end;

procedure TMainForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then begin
    if EGestCauta.Focused = True then begin
      EGestCautaExit(Self);
      DBGest.SetFocus;
    end
    else
      if EManagerCauta.Focused = True then begin
        EManagerCautaExit(Self);
        DBManager.SetFocus;
      end else
        MainForm.Visible := False;
  end;
end;

procedure TMainForm.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Temp: string;
  Sesizari: TSesizari;
  Culori: TCulori;
begin
  if (Chr(Key) = 'J') and (ssCtrl in Shift) then begin
    EGestCauta.Visible := False;
    if DBGest.Tag = 0 then
      JurClienti.Start(DBGest.Fields[0].AsString, DBGest.Fields[1].AsString, CGest.Text, '')
    else
      JurClienti.Start(DBGest.Fields[0].AsString, DBGest.Fields[1].AsString, DBGest.Columns[DBGest.Columns.Count - 1].Field.AsString, '');
  end;
  if (Key = VK_F2) and not (ssAlt in Shift) then begin
    JurCClienti.Start('');
  end;
  if Key = VK_F3 then begin
    Temp := AddModify.Start('DATA');
    if Temp <> '' then SDate := Temp;
    Caption := 'dsBlocare - Sunteti logat ca: ' + UMail + '.  Data selectata este: ' + Copy(SDate, 1, 2) + '/' + Copy(SDate, 3, 2);
    CGestChange(Self);
  end;
  if Key = VK_F5 then begin
    //CFirmePopulate;
    //CFirme.Visible := True;
    //CFirme.SetFocus;
    FEditare.Start('Editare','')
  end;
  if Key = VK_F10 then begin
    Sesizari.Start('');
  end;
  if Key = VK_F11 then begin
    Culori.Start;
    DBGest.Repaint;
    DBManager.Repaint;
  end;
  if (Key = VK_F12) and not (ssCtrl in Shift) then begin
    Optiuni.Start();
    DoDBGrids(Sender);
  end;
end;

procedure TMainForm.DoDBGrids(Sender: TObject);
begin
  if not GestVisible then begin
      QGest.Active := False;
      //MainForm.Constraints.MinWidth := DBGest.Width + 8 + 4;
      PManager.Width := MainForm.ClientWidth;
      PGest.Visible := False;
      PBottom.Caption := '[F2 - Jurnale] [F3 - Schimba data] [F4 - Adaugare] [F6 - Modificare] [F7 - Cautare] [Ctrl + F9 - Parole] [F10 - Sesizari] [F11 - Culori] [F12 - Optiuni]';
    end else begin
 //     DBGest.SetFocus;
      PBottom.Caption := '[F2 - Jurnale] [F3 - Schimba data] [F7 - Cautare] [Ctrl + F9 - Parole] [F10 - Sesizari] [F11 - Culori] [F12 - Optiuni]';
      CGestChange(Sender);
      GestResize;
      PGest.Visible := True;
    end;
    if not ManagerVisible then begin
      QManager.Active := False;
      PGest.Width := MainForm.ClientWidth;
      PManager.Visible := False;
      PBottom.Caption := '[F2 - Jurnale] [F3 - Schimba data] [F7 - Cautare] [Ctrl + F9 - Parole] [F10 - Sesizari] [F11 - Culori] [F12 - Optiuni]';
    end else begin
//      DBManager.SetFocus;
      PBottom.Caption := '[F2 - Jurnale] [F3 - Schimba data] [F4 - Adaugare] [F6 - Modificare] [F7 - Cautare] [Ctrl + F9 - Parole] [F10 - Sesizari] [F11 - Culori] [F12 - Optiuni]';
      CManagerChange(Sender);
      ManagerResize;
      PManager.Visible := True;
    end;
    FormResize(Sender);
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
  if GestVisible then
    if ManagerVisible then begin
      PGest.Width := ClientWidth div 2;
      PManager.Width := ClientWidth div 2;
      PManager.Left := ClientWidth div 2;
      ManagerResize;
    end
    else begin
      PGest.Width := ClientWidth;
      GestResize;
    end;
  if ManagerVisible then
    if GestVisible then begin
      PGest.Width := ClientWidth div 2;
      PManager.Width := ClientWidth div 2;
      PManager.Left := ClientWidth div 2;
      GestResize;
    end
    else begin
      PManager.Width := ClientWidth;
      ManagerResize;
    end;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  DoDBGrids(Sender);
  if GestVisible then DBGest.SetFocus
  else DBManager.SetFocus;
  Btn_Filtru.Hint := 'Filtreaza doar clientii care au cel putin X facturi restante (nr. fact. restante se completeaza in casuta  "Nr fact" de mai jos).'#13 +
                     'Tinand apasata tasta SHIFT puteti obtine un filtru doar cu cei blocati.';
end;

procedure TMainForm.Inchide1Click(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.ImageMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  AComponent: TComponent;
begin
  AComponent := FindComponent(Copy(TComponent(Sender).Name, 1, Length(TComponent(Sender).Name) - 1));
  if AComponent <> nil then begin
    TImage(AComponent).Left := TImage(AComponent).Left + 1;
    TImage(AComponent).Top := TImage(AComponent).Top + 1;
  end;
end;

procedure TMainForm.ImageMouseLeave(Sender: TObject);
begin
  TImage(Sender).Visible := False;
end;

procedure TMainForm.ImageMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  AComponent: TComponent;
begin
  AComponent := FindComponent(Copy(TComponent(Sender).Name, 1, Length(TComponent(Sender).Name) - 1));
  if AComponent <> nil then begin
    TImage(AComponent).Left := TImage(AComponent).Left - 1;
    TImage(AComponent).Top := TImage(AComponent).Top - 1;
    EventMapper(AComponent.Name);
  end;
end;

procedure TMainForm.IExitClick(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.ImageEnter(Sender: TObject);
var
  AComponent: TComponent;
  I: Integer;
begin
  for I := 0 to ComponentCount - 1 do begin
    if (Components[I] is TImage) then
      if (Components[I].Name[1] = 'I') then
        if (Components[I].Name[Length(Components[I].Name)] = 'O') then
          TImage(Components[I]).Visible := False;
  end;
  AComponent := FindComponent(TComponent(Sender).Name + 'O');
  if AComponent <> nil then
    TImage(AComponent).Visible := True;
end;

procedure TMainForm.EventMapper(OnObject: string);
begin
  if OnObject = 'IUnBlock' then Btn_DeblocClick(Self);
  if OnObject = 'IBlock' then Btn_BlocSelClick(Self);
  if OnObject = 'ISelect' then Btn_SelCliClick(Self);
  if OnObject = 'IBalanta' then Btn_BalantaClick(Self);
  if OnObject = 'IPrint' then Btn_FactClick(Self);
  if OnObject = 'IJournals' then Btn_JurCliClick(Self);
  if OnObject = 'IAccount' then Btn_ExtraseBClick(Self);
  if OnObject = 'ISendAccount' then Btn_ExtraseClick(Self);
  if OnObject = 'IMail' then Btn_SendClick(Self);
  if OnObject = 'ISent' then Btn_SentClick(Self);
  if OnObject = 'IExport' then Btn_ExportClick(Self);
  if OnObject = 'IExit' then IExitClick(Self);
end;

procedure TMainForm.pbDownPaint(Sender: TObject);
begin
  GradientHorizontalFooter(TPaintBox(Sender));
end;

procedure TMainForm.pbToolbarPaint(Sender: TObject);
begin
  GradientHorizontalMirrorExp(TPaintBox(Sender));
end;

procedure TMainForm.pbUpPaint(Sender: TObject);
begin
  GradientHorizontalMirror(TPaintBox(Sender).Canvas, TPaintBox(Sender).ClientRect, Color,'170,343,406,469,' + IntToStr(ClientWidth-52-8) );
end;

procedure TMainForm.DoThreadTerminate(Sender: TObject);
var
  MyQuery: TQuery;
begin
  //ShowMessage(Format('%p', [Sender.ClassInfo]));
  MyQuery := TQuery.Create(MainForm);
  MyQuery.DatabaseName := DB.DatabaseName;
  MyQuery.SQL.Text := 'UPDATE SENTMAIL SET SENT = "D", SENTAT = NOW() WHERE ID = ' + IntToStr(LastMailID);
  MyQuery.ExecSQL;
  ThreadsRunning := ThreadsRunning - 1;
  if Assigned(SentMail) then SentMail.FormShow(SentMail);
  MyQuery.Free;
end;

end.
