unit Extras_Cont;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RpCon, RpConDS, RpConBDE, RpRender, RpRenderPDF, RpRave,
  RpDefine, RpBase, RpSystem, StdCtrls, DB, DBTables, RvLDCompiler;

type
  TExtrasCont = class(TForm)
    R1: TRvQueryConnection;
    R2: TRvQueryConnection;
    Btn_Afiseaza: TButton;
    Btn_Renunta: TButton;
    GroupBox1: TGroupBox;
    Z1: TEdit;
    L1: TEdit;
    A1: TEdit;
    GroupBox2: TGroupBox;
    CActions: TComboBox;
    Query: TQuery;
    SD: TSaveDialog;
    RS: TRvSystem;
    RP: TRvProject;
    RPDF: TRvRenderPDF;
    procedure Btn_RenuntaClick(Sender: TObject);
    procedure Z1Enter(Sender: TObject);
    procedure Z1Exit(Sender: TObject);
    procedure Z1KeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Btn_AfiseazaClick(Sender: TObject);
    procedure GetDetails;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ExtrasCont: TExtrasCont;
  sCodFC: string;
  sDenFC: string;
  sADR: string;
  CUIClient: string;
  ContBanca: string;
  SoldTotal: string;

implementation

uses Sel_Mail, FMain, Dialog;

{$R *.dfm}

procedure TExtrasCont.Btn_AfiseazaClick(Sender: TObject);
var
  Temp: string;
  SQL: string;
begin                                                                                                                            
  Temp := GetCurrentDir;
  Query.SQL.Text :=
    'SELECT ROUND(SUM(SUMADB-SUMACR),2) AS SUMA ' +
    'FROM `' + A1.Hint + '`.`FRES' + L1.Text + Copy(A1.Text, 3, 2) + '` LEFT JOIN `' + A1.Hint + '`.`FUR` ON CODFC = CODFUR ' +
    'WHERE (CONTFC = "4111") AND ((SUMADB-SUMACR) <> 0) AND (CODFC="' + Z1.Hint + '") GROUP BY CODFUR';
  Query.Open;
  SoldTotal := Query.Fields[0].AsString;
  if SoldTotal = '' then begin
    if FDialog.Start('Atentie', 'Clientul are sold 0 la data selectata.' + #13 + 'Doriti totusi extras?', fdBtn_Yes or fdBtn_No, mtConfirmation) = fdBtn_Yes then begin
      SQL := 'SELECT "-" FACT, 0 AS SUMA, "" AS NRDIP';
      SoldTotal := '0';
    end else Exit;
  end else begin
    SQL :=
      'SELECT CONCAT("Fact. ",NRDFC, " / ", CONCAT(SUBSTRING(DATAFC,1,2),".",SUBSTRING(DATAFC,3,2),".",SUBSTRING(DATAFC,5,4))) AS FACT, ' +
      'ROUND((SUMADB-SUMACR),2) AS SUMA, IF((NRDIP<>0) AND (DATAIP <> ""),CONCAT("Achitat ", SUMACR, " RON. Data ultimei achitari ",NRDIP, "/", CONCAT(SUBSTRING(DATAIP,1,2),".",SUBSTRING(DATAIP,3,2),".",SUBSTRING(DATAIP,5,4))),"") AS NRDIP ' +
      'FROM `' + A1.Hint + '`.`FRES' + L1.Text + Copy(A1.Text, 3, 2) + '`' +
      'WHERE (CONTFC="4111") AND (SUMADB-SUMACR<>0) AND (CODFC="' + Z1.Hint + '") ORDER BY CONCAT(SUBSTRING(DATAFC, 5,4),SUBSTRING(DATAFC, 3,2),SUBSTRING(DATAFC, 1,2))';
  end;
  if Pos('.', SoldTotal) = 0 then SoldTotal := SoldTotal + '.00';
  Query.SQL.Text := SQL;
  Query.Open;
  RP.ProjectFile := GetCurrentDir + '\ExtrasCont.rav';
  //RP.SetProjectFile(GetCurrentDir + '\ExtrasCont.rav');
  if CActions.ItemIndex = 0 then begin
    with RP do begin
      RS.DefaultDest := rdPreview;
      Open;
      SetParam('DATA', Z1.Text + '.' + L1.Text + '.' + A1.Text);
      SetParam('CLIENT', sDenFC);
      SetParam('DENFUR', A1.Hint); //firma
      SetParam('ADR_CLIENT', sADR);
      SetParam('CONT_B', ContBanca);
      SetParam('SOLD_TOTAL', SoldTotal);
      SetParam('CUI_CLIENT', CUIClient);
      SetParam('IMAGE', Temp + '\Images\' + A1.Hint + '.bmp');
      ExecuteReport('Report2');
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
      SetParam('DATA', Z1.Text + '.' + L1.Text + '.' + A1.Text);
      SetParam('CLIENT', sDenFC);
      SetParam('DENFUR', A1.Hint); //firma
      SetParam('ADR_CLIENT', sADR);
      SetParam('CONT_B', ContBanca);
      SetParam('SOLD_TOTAL', SoldTotal);
      SetParam('CUI_CLIENT', CUIClient);
      SetParam('IMAGE', Temp + '\Images\' + A1.Hint + '.bmp');
      ExecuteReport('Report2');
      Close;
    end;
  end;
  if CActions.ItemIndex = 2 then begin
    RS.OutputFileName:= GetCurrentDir + '\TempFile_Extras' + Z1.Hint + '.pdf';
    with RS do begin
      DefaultDest := rdFile;
      DoNativeOutput:= False;
      RenderObject:= RPDF;
    end;
    with RP do begin
      Open;
      SetParam('DATA', Z1.Text + '.' + L1.Text + '.' + A1.Text);
      SetParam('CLIENT', sDenFC);
      SetParam('DENFUR', A1.Hint); //firma
      SetParam('ADR_CLIENT', sADR);
      SetParam('CONT_B', ContBanca);
      SetParam('SOLD_TOTAL', SoldTotal);
      SetParam('CUI_CLIENT', CUIClient);
      SetParam('IMAGE', Temp + '\Images\' + A1.Hint + '.bmp');      
      ExecuteReport('Report2');
      Close;
    end;
    SelMail.Start(Z1.Hint, 'E');
    SelMail.AttachedFiles.Add(GetCurrentDir + '\TempFile_Extras' + Z1.Hint + '.pdf');
    SelMail.LTitlu.Hint := Z1.Text + '.' + L1.Text + '.' + A1.Text; //data extrasului
    SelMail.LClient.Caption := sDenFC;
    SelMail.ShowModal;
    SelMail.Free;
    //DeleteFile(GetCurrentDir + '\TempFile_Extras' + Z1.Hint + '.pdf');
  end;
  SetCurrentDir(Temp);
end;

procedure TExtrasCont.Btn_RenuntaClick(Sender: TObject);
begin
  Close;
end;

procedure TExtrasCont.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then Close;
end;

procedure TExtrasCont.FormShow(Sender: TObject);
begin
  GetDetails;
end;

procedure TExtrasCont.GetDetails;
begin
  if L1.Text > Copy(SDate, 1, 2) then
    A1.Text := IntToStr(StrToInt('20' + Copy(SDate, 3, 2)) - 1)
  else A1.Text := '20' + Copy(SDate, 3, 2);
  Query.SQL.Text := 'SELECT DENFUR, CONCAT(ADRF, " ", LOCALITATE) AS ADR, COD_FISCAL FROM `' + A1.Hint + '`.`FUR` WHERE CODFUR="' + Z1.Hint + '"';
  Query.Open;
  sDenFC := Query.Fields[0].AsString;
  sADR := Query.Fields[1].AsString;
  CUIClient := Query.Fields[2].AsString;
  if A1.Hint = 'fdsoft' then ContBanca :=    'RO78BACX0000000186498000';
  if A1.Hint = 'fsoftware' then ContBanca := 'RO74BACX0000000186481000';
  if A1.Hint = 'fservices' then ContBanca := 'RO93BACX0000000234116000';
  if A1.Hint = 'quality' then ContBanca :=   'RO02BACX0000000244708001';
end;

procedure TExtrasCont.Z1Enter(Sender: TObject);
begin
  (Sender as TEdit).Color := MainForm.DBManager.FixedColor;
end;

procedure TExtrasCont.Z1Exit(Sender: TObject);
begin
  (Sender as TEdit).Color := clWindow;
end;

procedure TExtrasCont.Z1KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in [#8, #13, '0'..'9']) then Key := #0;
  if Key = #13 then SelectNext(TEdit(Sender), True, True);
end;

end.
