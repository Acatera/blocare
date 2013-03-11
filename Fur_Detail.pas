unit Fur_Detail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB, DBTables, StdCtrls, ExtCtrls, Menus, RpDefine,
  RvLDCompiler, RpCon, RpConDS, RpConBDE, RpRender, RpRenderPDF, RpRave,
  RpBase, RpSystem, AlexUtils, smslabel, ToolWin, ComCtrls, acCoolBar, sPanel,
  pngimage, sEdit, Buttons, PngSpeedButton, pngFunctions, ImgList, acAlphaImageList, sSpeedButton, PngImageList;

type
  THDbGrid = class(TDBGrid);
  TMyDetails = record
    CodFur: string;
    DenFur: string;
    Stare: string;
    Firma: string;
    LLAA: string;
    NrFact: string;
    Clasa: integer;
    Suma: string;
  end;
  TFurDetail = class(TForm)
    QFact: TQuery;
    DS: TDataSource;
    QContracte: TQuery;
    DSC: TDataSource;
    MQuery: TQuery;
    DSM: TDataSource;
    FactMenu: TPopupMenu;
    L1: TMenuItem;
    rimitemail1: TMenuItem;
    pDetails: TsPanel;
    pTop: TsCoolBar;
    LDenFur: mslabelFX;
    LCodFiscal: mslabelFX;
    LAdresa: mslabelFX;
    IUnblocked: TImage;
    IBlocked: TImage;
    IBlockable: TImage;
    pInvoices: TsPanel;
    LFacturi: TLabel;
    CBAll: TCheckBox;
    DBFact: TDBGrid;
    LNrFact: TLabel;
    LTotal: TLabel;
    pToolbar: TsPanel;
    Btn_Fisa: TButton;
    Btn_Extras: TButton;
    Btn_Mail: TButton;
    Btn_Jurnal: TButton;
    Btn_Rulaj: TButton;
    pContract: TsPanel;
    LContract: TLabel;
    DBContract: TDBGrid;
    pModules: TsPanel;
    LModule: TLabel;
    DBModule: TDBGrid;
    EMail: mslabelFX;
    EEMail: TsEdit;
    pHasPaid: TsPanel;
    mslabelFX1: mslabelFX;
    btnConta: TPngSpeedButton;
    btnGest: TPngSpeedButton;
    btnSalarii: TPngSpeedButton;
    btnMFix: TPngSpeedButton;
    btnRCasa: TPngSpeedButton;
    btnExchange: TPngSpeedButton;
    btnFarm: TPngSpeedButton;
    btnWin: TPngSpeedButton;
    btnRestaurant: TPngSpeedButton;
    btnBackup: TPngSpeedButton;
    CBAll2: TCheckBox;
    btnExpand: TsSpeedButton;
    iExpand: TsAlphaImageList;
    procedure SnatchEmail;
    procedure GetData;
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
    procedure Btn_RulajClick(Sender: TObject);
    procedure EEMailEnter(Sender: TObject);
    procedure EEMailExit(Sender: TObject);
    procedure EEMailKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBModuleDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure EMailClick(Sender: TObject);
    procedure EEMailKeyPress(Sender: TObject; var Key: Char);
    procedure btnExpandClick(Sender: TObject);
    procedure CBAll2Click(Sender: TObject);
  protected
    procedure DrawForm(Sender: TObject);
  private
    { Private declarations }
  public
    CodFur: string;
    function Start(LLAA, CodFur, DenFur, Stare, NrFact, Suma, Firma: string): integer;
    { Public declarations }
  end;

var
  Detail: TMyDetails;
  FurDetail: TFurDetail;
  SQL: string;
  SQLCon: string;
  Selections: TStringList;
  sCodFC: string;
  FontColor: integer;
  MedianColor: integer;
  BkColor: integer;

implementation

uses
  Fisa_Client, Extras_Cont, Temp_Rap, Sel_Mail, FMain, Jur_Clienti, Dialog,
  Fur_Panel;

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

procedure TFurDetail.CBAll2Click(Sender: TObject);
begin
  CBAll.Checked := CBAll2.Checked; 
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
  DoSQL(QFact, 'SELECT SUM(SUMA) SOLD, COUNT(NRDFC) NR_FACT FROM (' + SQL + ') AS TEMP');
  if QFact.RecordCount <> 0 then begin
    try
      LNrFact.Caption := 'Numar facturi: ' + QFact.FieldByName('NR_FACT').AsString;
      LTotal.Caption := 'Total sold: ' + QFact.FieldByName('SOLD').AsString + ' RON';
    except
      on E: Exception do begin
        FDialog.Start('Eroare', 'Am intampinat o eroare.'#13'Detalii:'#13 + E.Message, fdOk, mtError);
        Exit;
      end;
    end;
  end;
  DoSQL(QFact, SQL);
  DrawForm(Sender);
end;

procedure TFurDetail.DBContractDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  ARect: TRect;
  S: string;
begin
  ARect := Rect;
  if Rect.Top = 0 then Exit;

  {if DBContract.DataSource.DataSet.FieldByName('ID').AsInteger mod 2 = 0 then
    DBContract.Canvas.Brush.Color := Colors.Odd
  else DBContract.Canvas.Brush.Color := Colors.Even;}

  S := Column.Field.Text;
  if (S = '') then Exit;

  if DBContract.DataSource.DataSet.FieldByName('VALAB').AsString = 'E' then
      DBContract.Canvas.Font.Color := MedianColor//RGB(112, 112, 112)
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
  //if DBFact.DataSource.DataSet.FieldByName('ID').AsInteger mod 2 = 0 then
  //  DBFact.Canvas.Brush.Color := Colors.Odd//$00E28F7B
  //else DBFact.Canvas.Brush.Color := Colors.Even;//$00E2A596;
  DBFact.Canvas.Font.Color := FontColor;
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
    if S = '0' then (Sender as TDBGrid).Canvas.Font.Color := MedianColor;
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
  if EEmail.Text = '' then
    EMail.Caption := 'e-Mail: [..tzacaniti acilea..]'
  else
    EMail.Caption := 'e-Mail: ' + EEMail.Text;
  EEMail.Visible := False;  
  SelectNext(EEmail, True, True);
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

procedure TFurDetail.EEMailKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) or (Key = #27) then begin
    Key := #0;
    EEMailExit(Sender);
  end;
end;

procedure TFurDetail.EMailClick(Sender: TObject);
var
  s: string;
begin
  EEmail.Text := Copy(EMail.Caption, 9);
  if EEmail.Text = '[..tzacaniti acilea..]' then EEmail.Text := '';
  EEMail.Visible := True;
  EEmail.SetFocus;
end;

procedure TFurDetail.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ModalResult := mrOk;
  if FurPanel <> nil then
    FreeAndNil(FurPanel);
end;

procedure TFurDetail.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
    if EEMail.Focused then begin
      Key := #0;
      SelectNext(EEmail, True, True);
    end else
      Close;
end;

procedure TFurDetail.DrawForm(Sender: TObject);
var
  MaxHeight: integer;
begin
  if QFact.RecordCount = 0 then begin
    pHasPaid.Visible := True;
    CBAll2.Checked := False;
    pInvoices.Visible := False;
  end else begin
    pInvoices.Visible := True;
    pHasPaid.Visible := False;
    MaxHeight := iif(QFact.RecordCount > 10, 10, QFact.RecordCount);
    DBFact.Height := (MaxHeight) * TStringGrid(DBFact).DefaultRowHeight + 29;
    pInvoices.Height := DBFact.Top + DBFact.Height + 26;
  end;

  if not QContracte.Active then Exit;
  
  if QContracte.RecordCount = 0 then begin
    pContract.Visible := False;
  end else begin
    DBContract.Height := (QContracte.RecordCount) * TStringGrid(DBContract).DefaultRowHeight + 30;
    pContract.Height := DBContract.Top + DBContract.Height + 3;
  end;

  if MQuery.RecordCount = 0 then begin
    pModules.Visible := False;
  end else begin
    DBModule.Height := (MQuery.RecordCount) * TStringGrid(DBModule).DefaultRowHeight + 30;
    pModules.Height := DBModule.Top + DBModule.Height + 3;
  end;
  if pHasPaid.Visible then MaxHeight := pHasPaid.Top + pHasPaid.Height;
  if pInvoices.Visible then MaxHeight := pInvoices.Top + pInvoices.Height;
  if pContract.Visible then MaxHeight := pContract.Top + pContract.Height;
  if pModules.Visible then MaxHeight := pModules.Top + pModules.Height;
  Self.ClientHeight := MaxHeight;
  Self.Position := poMainFormCenter;
  Self.Top := MainForm.Top + (MainForm.Height div 2) - (Self.Height div 2);
end;

procedure TFurDetail.SnatchEmail;
var
  Temp: string;
begin
  DoSQL(QFact,
    'SELECT ' +
      'IF(COD_FISCAL <> "", COD_FISCAL, FUR.CODFUR) COD_FISCAL, DENFUR, ADRF, IFNULL(FD.EMAIL, "") EMAIL, SECTIA, ' +
      'IF(LOCALITATE<>"",CONCAT(", ",LOCALITATE,", "),", ") LOCALITATE, JUDET, CLASA ' +
    'FROM ' + Detail.Firma + '.FUR LEFT JOIN DBCABCONTA.FACT_DEFAULT FD USING(CODFUR) ' +
    'WHERE FUR.CODFUR="' + Detail.CodFur + '"');
  if QFact.RecordCount <> 0 then begin
    try
      LDenFur.Caption := StringReplace(QFact.FieldByName('DENFUR').AsString, '&', '&&', [rfReplaceAll]);
      LCodFiscal.Caption := 'Cod fiscal: ' + QFact.FieldByName('COD_FISCAL').AsString;
      LAdresa.Caption :=
        'Adresa: ' + QFact.FieldByName('ADRF').AsString +
                     QFact.FieldByName('LOCALITATE').AsString + 
                     QFact.FieldByName('JUDET').AsString ;
      if QFact.FieldByName('SECTIA').AsString = 'B' then
        IBlocked.Visible := True
      else
        IUnblocked.Visible := True;
      Temp := QFact.FieldByName('EMAIL').AsString;
      if Temp = '' then begin
        EMail.Caption := 'e-Mail: [..tzacaniti acilea..]';
      end else begin
        EMail.Caption := 'e-Mail: ' + Temp;
      end;
      Temp := QFact.FieldByName('CLASA').AsString;
      if Temp = '' then Temp := '0';
      Detail.Clasa := s2i(Temp);
    except
      on E: Exception do begin
        FDialog.Start('Eroare', 'Am intampinat o eroare.'#13'Detalii:'#13 + E.Message, fdOk, mtError);
        Exit;
      end;
    end;
  end else begin
    LDenFur.Caption := StringReplace(Detail.DenFur, '&', '&&', [rfReplaceAll]);
    LCodFiscal.Caption := 'Cod fiscal: ' + Detail.CodFur;
  end;
  CBAllClick(Self);
end;

procedure TFurDetail.GetData;
var
  qt: TQuery;
  i: integer;
  s: string;
begin
  DoSQL(QFact,'SET @NR_CRT := 0');
  DoSQL(QFact,SQL);
  DoSQL(QContracte, 'SELECT SUM(SUMA) SOLD, COUNT(NRDFC) NR_FACT FROM (' + SQL + ') AS TEMP');
  if QContracte.RecordCount <> 0 then begin
    try
      LNrFact.Caption := 'Numar facturi: ' + QContracte.FieldByName('NR_FACT').AsString;
      LTotal.Caption := 'Total sold: ' + QContracte.FieldByName('SOLD').AsString + ' RON';
      if (QContracte.FieldByName('NR_FACT').AsInteger * Detail.Clasa) >= s2i(MainForm.Options.Values['NR_FACT']) then
        IBlockable.Visible := True;

    except
      on E: EDatabaseError do begin
        FDialog.Start('Eroare', 'Am intampinat o eroare.'#13'Detalii:'#13 + E.Message, fdOk, mtError);
        Exit;
      end;
    end;
  end;
  DoSQL(QContracte, SQLCon);
  DoSQL(MQuery, 'SELECT CODFUR, SUM(C),SUM(G),SUM(S),SUM(M),SUM(F),SUM(GW),SUM(RC),SUM(EX),SUM(GR) ' +
                'FROM DBCABCONTA.AL_MIV WHERE CODFUR="' + Detail.CodFur + '" GROUP BY CODFUR');

  s := '';              
  for I := 0 to MainForm.CGest.Items.Count - 1 do
    s := s + 'SELECT CODCONTRACTE ' +
              'FROM ' + MainForm.CGest.Items[i] + '.CONTRACTE ' +
              'WHERE (CODFUR="' + Detail.CodFur + '") AND (DATAOUT > DATE_FORMAT(NOW(),"%Y%m%d")) AND ' +
                '(DATAIN < DATE_FORMAT(NOW(),"%Y%m%d")) UNION ALL ';
  s := Copy(s, 1, Length(s) - 11);
  try
    qt := TQuery.Create(FurDetail);
    qt.DatabaseName := MainForm.DB.DatabaseName;
    DoSQL(qt, s);
    if qt.RecordCount <> 0 then
      while not qt.eof do begin
        try
          i := qt.FieldByName('CODCONTRACTE').AsInteger;
          if i and 1024 = 1024 then btnBackup.PngOptions := [];
          if i and 512 = 512 then btnRestaurant.PngOptions := [];
          if i and 256 = 256 then btnExchange.PngOptions := [];
          if i and 128 = 128 then btnRCasa.PngOptions := [];
          if i and 64 = 64 then btnWin.PngOptions := [];
          if i and 32 = 32 then btnFarm.PngOptions := [];
          if i and 16 = 16 then btnMFix.PngOptions := [];
          if i and 8 = 8 then btnSalarii.PngOptions := [];
          if i and 4 = 4 then btnGest.PngOptions := [];
          if i and 2 = 2 then btnConta.PngOptions := [];
        except
          on E: EDatabaseError do begin
            FDialog.Start('Eroare', 'Am intampinat o eroare.'#13'Detalii:'#13 + E.Message, fdOk, mtError);
            Exit;
          end;
        end;
        qt.Next;
      end;
   finally
    qt.Free;
  end;
end;

procedure TFurDetail.FormShow(Sender: TObject);
begin
  if MainForm.Options.Values['VER_DEF_EMAIL'] <> '1' then begin
    DoSQL(QFact,
      'CREATE TABLE IF NOT EXISTS `DBCABCONTA`.`FACT_DEFAULT` (' +
      '  `CODFUR` varchar(15) NOT NULL default "", ' +
      '  `EMAIL` varchar(50) NOT NULL default "", ' +
      '  PRIMARY KEY  (`CODFUR`), ' +
      '  KEY `CODFUR` (`CODFUR`), ' +
      '  KEY `EMAIL` (`EMAIL`) ' +
      ') ENGINE=InnoDB DEFAULT CHARSET=latin1');
    MainForm.Options.Values['VER_DEF_EMAIL'] := '1';
  end;

  FontColor := MainForm.FontColor;
  BkColor := MainForm.BkColor;
  MedianColor := GetMedianColor(FontColor, BkColor, 30);

  SnatchEmail;
  GetData;
  DrawForm(nil);
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
  FirmaTrezo:string;
  FirmaBancaTR:string;
  FirmaCapSocial: string;
  FirmaIntocmit: string;
  Temp: string;
  Firma: TFirma;
begin
  Temp := GetCurrentDir;
  Q1 := TQuery.Create(MainForm);
  Q1.DatabaseName := MainForm.DB.DatabaseName;
  dbName := DBFact.Fields[0].AsString;
  dbName := StringReplace(StringReplace(StringReplace(StringReplace(dbName, 'D-SOFT', 'fdsoft', []), 'QUALITY SOFT', 'quality', []), 'DAVID SOFTWARE', 'fsoftware', []), 'DAVID SOFT SERVICES', 'fservices', []);

  Firma := GetFirmaFromDBName(dbName);
  
  NrFact := DBFact.Fields[1].AsString;
  DataFact := DBFact.Fields[2].AsString;
  DataFact := Copy(DataFact, 1, 2) + Copy(DataFact, 4, 2) + Copy(DataFact, 7, 4);
  Q1.SQL.Text :=
    'SELECT SUM(VALOARE) AS TOTALBAZA, SUM(VAL_TVA) AS TOTALTVA, SUM(VALOARE + VAL_TVA) AS TOTALFACT ' +
    'FROM `' + dbName + '`.`MIV' + Copy(DataFact, 3, 2) + Copy(DataFact, 7, 2) + '` ' + 
    'WHERE (NUMAR = "' + NrFact + '") AND (TIP_DOC = "1")';
  Q1.Open;
  TotalBaza := FloatToStrF(Q1.FieldByName('TOTALBAZA').AsFloat, ffFixed, 14, 2);
//  TotalBaza := Q1.FieldByName('TOTALBAZA').AsString;
//  if Pos(DecimalSeparator, TotalBaza) = 0 then TotalBaza := TotalBaza + DecimalSeparator + '00';
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
      SetParam('TOTAL_ARTICOLE', i2s(Q1.RecordCount));
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
    SetParam('TOTAL_ARTICOLE', i2s(Q1.RecordCount));
    SetParam('IMAGE', Temp + '\Images\' + dbName + '.bmp');
    SetParam('SIGIMAGE', Temp + '\Images\sig' + dbName + '.bmp');
    ExecuteReport('Report2');
    Close;
  end;
  TempRap.Free;
  Q1.Free;
  SetCurrentDir(Temp);
end;

procedure TFurDetail.btnExpandClick(Sender: TObject);
var
  msg: string;
begin
  try
    if Assigned(FurPanel) then begin
      FreeAndNil(FurPanel);
      btnExpand.ImageIndex := 0;
    end else begin
      FurPanel.Start(Self, 0);
      btnExpand.ImageIndex := 1;
    end;
  except
    on e: Exception do begin
      msg := 'Am intampinat o eroare.'#13#13'Detalii:'#13 + E.Message+ #13'FurPanel:' +
             iif(FurPanel = nil,'nil','');
      if FurPanel <> nil then
        msg := iif(FurPanel.Visible, 'visible','');
      FDialog.Start('Eroare', msg, fdOk, mtError);
    end
  end;
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
    'SELECT CONCAT(NUMAR, "/", CONCAT(SUBSTRING(DATA,7,2),".",SUBSTRING(DATA,5,2),".",SUBSTRING(DATA,1,4))) NR, ' +
    'CONCAT(CONCAT(SUBSTRING(DATAIN,7,2),".",SUBSTRING(DATAIN,5,2),".",SUBSTRING(DATAIN,1,4)), "-",' +
      'CONCAT(SUBSTRING(DATAOUT,7,2),".",SUBSTRING(DATAOUT,5,2),".",SUBSTRING(DATAOUT,1,4))) DURATA, ' +
    'IF(CLASA=12,"Anual",IF(CLASA=6,"Sem.",IF(CLASA=3,"Trim.",IF(CLASA=1,"Lunar","N/A")))) FRECV, ' +
    'CONCAT(VALOARE, " ", TIPVALUT) VAL, ' +
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
  FurDetail.CodFur := Codfur;
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
