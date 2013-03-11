unit Sel_Mail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, DBTables, AlexUtils;

type
  TSelMail = class(TForm)
    DBContact: TDBGrid;
    LTitlu: TLabel;
    Query: TQuery;
    DS: TDataSource;
    ECauta: TEdit;
    LClient: TLabel;
    procedure FormShow(Sender: TObject);
    procedure DBContactKeyPress(Sender: TObject; var Key: Char);
    procedure DBContactDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure DBContactDblClick(Sender: TObject);
    procedure ECautaKeyPress(Sender: TObject; var Key: Char);
    procedure ECautaExit(Sender: TObject);
    procedure DBContactKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure AttachFiles;
  private
    { Private declarations }
  public
    { Public declarations }
    AttachedFiles: TStringList;
    function Start(CodFC: string; ID_Actiune: string): integer; overload;
  end;

var
  SelMail: TSelMail;
  sCodFC: string;
  sDenFur: string;
  ID: string;

implementation

uses Send_Mail, FMain, Fur_Detail;

{$R *.dfm}

procedure TSelMail.AttachFiles;
var
  I: integer;
begin
  for I := 0 to AttachedFiles.Count - 1 do begin
    SendMail.LAtasamente.Items.Add(ExtractFileName(AttachedFiles[I]) + Blanks + '|' + AttachedFiles[I]);
  end;
end;

procedure TSelMail.DBContactDblClick(Sender: TObject);
var
  Temp: TStringList;
  I: integer;
  TempQ: TQuery;
  Aux: string;
  SQL: string;
begin
  if ID = 'FMAIL' then begin
    if Assigned(FurDetail) then
      FurDetail.Hint := Query.FieldByName('EMAIL').Text;
      Exit;
  end; //EMAIL
  with SendMail do begin
    Start(TStringList.Create, 0);
    LAdrese.Items.Add(Query.FieldByName('DENUMIRE').Text + ' <' + Query.FieldByName('EMAIL').Text + '>');
    if ID = 'F' then begin
      ESubiect.Text := 'D-Soft - Fisa dvs. pe perioada ' + LTitlu.Hint;
      AttachFiles
    end;
    if ID = 'E' then begin
      ESubiect.Text := 'D-Soft - Extras de cont la data de ' + LTitlu.Hint;
      AttachFiles
    end;
    if ID = 'FA' then begin
      Temp := TStringList.Create;
      Temp.CommaText := LTitlu.Hint;
      if Temp.Count = 1 then begin
        ESubiect.Text := 'D-Soft - Factura nr. ' + LTitlu.Hint;
        AttachFiles
      end else begin
        ESubiect.Text := 'D-Soft - Facturile nr. ';
        for I := 0 to Temp.Count - 1 do begin
          Aux := Temp[I];
          Delete(Aux, 1, Pos('|', Aux));
          if I = Temp.Count - 1 then  //Not to add a useless comma after the last invoice
            ESubiect.Text := ESubiect.Text + StringReplace(Aux, '!', '/', [])
          else
            ESubiect.Text := ESubiect.Text + StringReplace(Aux, '!', '/', []) + ', ';
        end;
        AttachFiles;
      end;
      Temp.Free;
    end;
    if ID = 'B' then begin
      Mesaj.Lines.Add('ATENTIE! Acesta este un mesaj generat automat de calculator.');
      Mesaj.Lines.Add('');
      Mesaj.Lines.Add('Catre:');
      Mesaj.Lines.Add('S.C. ' + sDenFur);
      Mesaj.Lines.Add('');
      Mesaj.Lines.Add('Va aducem la cunostinta ca incepand cu data de ' + FormatDateTime('dd.mm.yyyy',  Now) +
                      ' contractul dvs nr: ' + LClient.Hint + ' a fost temporar suspendat pentru neplata urmatoarelor facturi:');
      Mesaj.Lines.Add('');
      TempQ := TQuery.Create(SelMail);
      TempQ.DatabaseName := MainForm.DB.DatabaseName;
      SQL := '';
//      for I := 0 to MainForm.CGest.Items.Count - 1 do
      SQL := SQL +
        'SELECT NRDFC, CONCAT(SUBSTRING(DATAFC,1,2),".",SUBSTRING(DATAFC,3   ,2),".",SUBSTRING(DATAFC,5,4)) AS DATAFC, SUMADB, (SUMADB - SUMACR) AS SUMA, ' +
        'REPLACE(REPLACE(REPLACE(REPLACE("' + MainForm.CGest.Text + '","quality","QUALITY SOFT"),"fsoftware","DAVID SOFTWARE"),"fservices","DAVID SOFT SERVICES"),"fdsoft","D-SOFT") AS FIRMA ' +
        'FROM `' + MainForm.CGest.Text + '`.`FRES' + SDate + '` ' +
        'WHERE (CONTFC="4111") AND ((SUMADB - SUMACR) <> 0) AND (CODFC = "' + sCodFC + '") UNION ALL ';
      SQL := Copy(SQL, 1, Length(SQL) - 11);
      TempQ.SQL.Text := SQL;
      TempQ.Open;
      ESubiect.Text := 'S.C. ' + TempQ.FieldByName('FIRMA').AsString + ' SRL - URGENT: Notificare - mesaj generat automat';
      for I := 0 to TempQ.RecordCount - 1 do begin
        Mesaj.Lines.Add('Fact. ' + TempQ.FieldByName('NRDFC').AsString + '/' + TempQ.FieldByName('DATAFC').AsString +
        ' in valoare de ' + TempQ.FieldByName('SUMADB').AsString + ' RON din care mai aveti de achitat ' + TempQ.FieldByName('SUMA').AsString + ' RON.');
        TempQ.Next;
      end;
      Mesaj.Lines.Add('-----------------------------------------------------------------------------');
      TempQ.SQL.Text := 'SELECT SUM(SUMA) AS TOTAL FROM (' + SQL + ') AS TEMP3';
      TempQ.Open;
      Mesaj.Lines.Add('Sold total neachitat: ' + TempQ.FieldByName('TOTAL').AsString + 'RON.');
      Mesaj.Lines.Add('');
      Mesaj.Lines.Add('Acest lucru inseamna ca nu veti mai primi actualizari la programele achizitionate de la firma noastra.');
      Mesaj.Lines.Add('Va rugam ca in cel mai scurt timp sa achitati aceste facturi si sa ne aduceti la cunostinta acest fapt.');
      Mesaj.Lines.Add('<NO_SIG>');
      //Msg.ReceiptRecipient.Text := 'boot2150@yahoo.com';//UMail;
    end;
    if ID = 'DB' then begin
      ESubiect.Text := 'D-Soft - Actualizari programe';
      if Pos('C', Query.FieldByName('MODULE').AsString) <> 0 then
        LAtasamente.Items.Add('CTB2000.ZIP' + Blanks + '|' + Locations.Grup1);
      if Pos('G', Query.FieldByName('MODULE').AsString) <> 0 then
        LAtasamente.Items.Add('FACT200A.ZIP' + Blanks + '|' + Locations.Grup2);
      if Pos('S', Query.FieldByName('MODULE').AsString) <> 0 then
        LAtasamente.Items.Add('SAL_EXE.ZIP' + Blanks + '|' + Locations.Grup3);
      if Pos('M', Query.FieldByName('MODULE').AsString) <> 0 then
        LAtasamente.Items.Add('MIFIX.ZIP' + Blanks + '|' + Locations.Grup4);
      if Pos('F', Query.FieldByName('MODULE').AsString) <> 0 then
        LAtasamente.Items.Add('FARM2000.ZIP' + Blanks + '|' + Locations.Grup5);
      if Pos('Rc', Query.FieldByName('MODULE').AsString) <> 0 then
        LAtasamente.Items.Add('NIR_EXE.ZIP' + Blanks + '|' + Locations.Grup7);
    end;
    ShowModal;
    Free;
  end;
end;

procedure TSelMail.DBContactDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  ARect: TRect;
  S: string;
begin
  ARect := Rect;
  if Rect.Top = 0 then Exit;
  S := StringReplace(Column.Field.Text, '&', '&&', [rfReplaceAll]);
  //S := Column.Field.Text;
  if DBContact.Fields[DBContact.FieldCount - 2].AsString = 'B' then
      DBContact.Canvas.Brush.Color := clRed;
  (Sender as TDBGrid).Canvas.FillRect(Rect);
  ARect.Left := Rect.Left + 2;
  DrawText((Sender as TDBGrid).Canvas.Handle, PChar(S), Length(S), ARect, 0);
end;

procedure TSelMail.DBContactKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then begin
    if ssCtrl in Shift then begin
      SQLExec(MainForm.QTemp,
        'DELETE FROM DBCABCONTA.FACT_DEFAULT WHERE CODFUR="' + sCodFC +'"');
      SQLExec(MainForm.QTemp,
        'INSERT INTO DBCABCONTA.FACT_DEFAULT (CODFUR, EMAIL) VALUES ("' +
          sCodFC + '", "' + Query.FieldByName('EMAIL').Text + '")');
    end;
    DBContactDblClick(Self);
    Close;
  end;
end;

procedure TSelMail.DBContactKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in [' ', #13]) then begin
    with ECauta do begin
      Visible := True;
      Text := Key;
      Query.Locate('DENUMIRE', ECauta.Text, [loCaseInsensitive, loPartialKey]);
      SetFocus;
      SelStart := 2;
    end;
  end;
  
end;

procedure TSelMail.ECautaExit(Sender: TObject);
begin
  ECauta.Visible := False;
  ECauta.Tag := 0;
end;

procedure TSelMail.ECautaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then begin DBContact.SetFocus; Exit; end
  else
    Query.Locate('DENUMIRE', ECauta.Text + Key, [loCaseInsensitive, loPartialKey])
end;

procedure TSelMail.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(AttachedFiles) then
    AttachedFiles.Free;
end;

procedure TSelMail.FormCreate(Sender: TObject);
begin
  AttachedFiles := TStringList.Create;
end;

procedure TSelMail.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then Close;
end;

procedure TSelMail.FormShow(Sender: TObject);
var
  SQL: string;
begin
  SQL := '';
  SQL := SQL +
      'SELECT F.CODFC, F.DENFC AS DENUMIRE, EMAIL, TEL, CONCAT(IF(CODCONTRACTE&2=2,"C",""), IF(CODCONTRACTE&4=4,"G",""), IF(CODCONTRACTE&8=8,"S",""), ' +
        'IF(CODCONTRACTE&16=16,"M",""), IF(CODCONTRACTE&32=32,"F",""), IF(CODCONTRACTE&64=64,"Gw",""), ' +
        'IF(CODCONTRACTE&128=128,"Rc",""), IF(CODCONTRACTE&256=256,"Ex",""), IF(CODCONTRACTE&512=512,"Gr",""), IF(CODCONTRACTE&1024=1024,"Bk","")) AS MODULE, F.DENFC AS ID, SECTIA AS STARE, CODCONTRACTE ' +
      'FROM `DBCABCONTA`.`FUR` F INNER JOIN (' +
        'SELECT * FROM (SELECT * FROM (' +
          'SELECT SECTIA, CODFUR FROM `FDSOFT`.`FUR` WHERE CODFUR="' + sCodFC + '" UNION ALL ' +
          'SELECT SECTIA, CODFUR FROM `FSOFTWARE`.`FUR` WHERE CODFUR="' + sCodFC + '" UNION ALL ' +
          'SELECT SECTIA, CODFUR FROM `QUALITY`.`FUR` WHERE CODFUR="' + sCodFC + '" UNION ALL ' +
          'SELECT SECTIA, CODFUR FROM `FSERVICES`.`FUR` WHERE CODFUR="' + sCodFC + '" ' +
        ')AS F1 GROUP BY CODFUR) AS FUR INNER JOIN ' +
        '(SELECT * FROM (' +
          'SELECT CODFUR, CODCONTRACTE, DATAIN, DATAOUT FROM `fdsoft`.`CONTRACTE` UNION ALL ' +
          'SELECT CODFUR, CODCONTRACTE, DATAIN, DATAOUT FROM `fsoftware`.`CONTRACTE` UNION ALL ' +
          'SELECT CODFUR, CODCONTRACTE, DATAIN, DATAOUT FROM `QUALITY`.`CONTRACTE` UNION ALL ' +
          'SELECT CODFUR, CODCONTRACTE, DATAIN, DATAOUT FROM `FSERVICES`.`CONTRACTE` ' +
        ') AS CONTRACTE ) GEST ON FUR.CODFUR = GEST.CODFUR )' +
        'AS C ON F.CODFC=C.CODFUR ' +
      'WHERE EMAIL <> "" UNION ALL ';
  SQL := SQL +
      'SELECT F.CODFC, CONCAT(F.DENFC, " - ", C.DENFC) AS DENUMIRE, C.EMAIL, C.TEL, CONCAT(IF(C.CODCONTRACTE&2=2,"C",""), IF(C.CODCONTRACTE&4=4,"G",""), IF(C.CODCONTRACTE&8=8,"S",""), ' +
      'IF(C.CODCONTRACTE&16=16,"M",""), IF(C.CODCONTRACTE&32=32,"F",""), IF(C.CODCONTRACTE&64=64,"Gw",""), ' +
      'IF(C.CODCONTRACTE&128=128,"Rc",""), IF(C.CODCONTRACTE&256=256,"Ex",""), IF(C.CODCONTRACTE&512=512,"Gr",""), IF(C.CODCONTRACTE&1024=1024,"Bk","")) AS MODULE, F.DENFC AS ID, SECTIA AS STARE, GEST.CODCONTRACTE ' +
      'FROM `DBCABCONTA`.`FUR` F INNER JOIN DBCABCONTA.CONTACT C USING(CODFC) INNER JOIN (' +
        'SELECT * FROM (SELECT * FROM (' +
          'SELECT SECTIA, CODFUR FROM `FDSOFT`.`FUR` WHERE CODFUR="' + sCodFC + '" UNION ALL ' +
          'SELECT SECTIA, CODFUR FROM `FSOFTWARE`.`FUR` WHERE CODFUR="' + sCodFC + '" UNION ALL ' +
          'SELECT SECTIA, CODFUR FROM `QUALITY`.`FUR` WHERE CODFUR="' + sCodFC + '" UNION ALL ' +
          'SELECT SECTIA, CODFUR FROM `FSERVICES`.`FUR` WHERE CODFUR="' + sCodFC + '" ' +
        ')AS F1 GROUP BY CODFUR) AS FUR INNER JOIN ' +
        '(SELECT * FROM (' +
          'SELECT CODFUR, CODCONTRACTE, DATAIN, DATAOUT FROM `fdsoft`.`CONTRACTE` UNION ALL ' +
          'SELECT CODFUR, CODCONTRACTE, DATAIN, DATAOUT FROM `fsoftware`.`CONTRACTE` UNION ALL ' +
          'SELECT CODFUR, CODCONTRACTE, DATAIN, DATAOUT FROM `QUALITY`.`CONTRACTE` UNION ALL ' +
          'SELECT CODFUR, CODCONTRACTE, DATAIN, DATAOUT FROM `FSERVICES`.`CONTRACTE` ' +
        ') AS CONTRACTE) C ON FUR.CODFUR = C.CODFUR )' +
        'AS GEST ON F.CODFC=GEST.CODFUR ' +
      'WHERE C.EMAIL <> "" ORDER BY DENUMIRE ';
  Query.SQL.Text := SQL;
  Query.Open;
  Color := MainForm.Color;
  if Query.RecordCount = 0 then begin
    SQL := '';
    SQL := SQL +
        'SELECT F.CODFC, F.DENFC AS DENUMIRE, EMAIL, TEL, 0 AS MODULE, F.DENFC AS ID, "" AS STARE, 0 AS CODCONTRACTE ' +
        'FROM `DBCABCONTA`.`FUR` F ' +
        'UNION ALL ';
    SQL := SQL +
        'SELECT F.CODFC, CONCAT(F.DENFC, " - ", C.DENFC) AS DENUMIRE, C.EMAIL, C.TEL, 0 AS MODULE, F.DENFC AS ID, "" AS STARE, 0 AS CODCONTRACTE ' +
        'FROM `DBCABCONTA`.`FUR` F INNER JOIN DBCABCONTA.CONTACT C USING(CODFC) ' +
        'ORDER BY DENUMIRE ';
    Query.SQL.Text := SQL;
    Query.Open;
  end else begin
    ClientHeight := DBContact.Top + (Query.RecordCount) * 16 + 29 + 3;
    DBContact.Height := (Query.RecordCount) * 16 + 29;
  end;
  sDenFur := LClient.Caption;
  LClient.Caption := StringReplace(LClient.Caption, '&', '&&', [rfReplaceAll]);
end;

function TSelMail.Start(CodFC: string; ID_Actiune: string): integer;
begin
  SelMail := TSelMail.Create(Application);
  ID := ID_Actiune;
  sCodFC := CodFC;
end;

end.
