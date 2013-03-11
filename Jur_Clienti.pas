unit Jur_Clienti;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, DB, DBTables, AlexUtils;

type
  TJurClienti = class(TForm)
    CTip: TListBox;
    CDurata: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    Btn_Apply: TButton;
    Btn_Renunta: TButton;
    ECOD_FISCAL: TLabeledEdit;
    EDENFUR: TLabeledEdit;
    Label3: TLabel;
    DCurenta: TDateTimePicker;
    Label4: TLabel;
    DApel: TDateTimePicker;
    Query: TQuery;
    MDescriere: TMemo;
    Label5: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Btn_RenuntaClick(Sender: TObject);
    procedure Btn_ApplyClick(Sender: TObject);
    procedure EditKeyPress(Sender: TObject; var Key: Char);
    procedure CTipKeyPress(Sender: TObject; var Key: Char);
    procedure CDurataKeyPress(Sender: TObject; var Key: Char);
    procedure CTipKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    function Start(CodFC, DenFC, Firma, Optiuni: string): integer;
  end;

const
  sTip = 'TLSD';
  sDurata = 'VARN';

var
  JurClienti: TJurClienti;
  Options: string;
  sCodFC: string;
  sDenFC: string;
  sFirma: string;

implementation

uses FMain;

{$R *.dfm}

procedure TJurClienti.Btn_ApplyClick(Sender: TObject);
var
  ID: integer;
  Temp: string;
  tsUsers: TStringList;
  //iAux: integer;
//  I: Integer;
begin
  tsUsers := TStringList.Create;
  tsUsers.Delimiter := ',';
  tsUsers.DelimitedText := JurUser;
  Query.SQL.Text := 'UPDATE `' + sFirma + '`.`WSERIE` SET SERIEC = SERIEC + 1 WHERE DENUMIRE = "FUR_JURNAL"';
  Query.ExecSQL;
  Query.SQL.Text := 'SELECT SERIEC FROM `' + sFirma + '`.`WSERIE` WHERE DENUMIRE = "FUR_JURNAL"';
  Query.Open;
  ID := Query.Fields[0].AsInteger;
  Temp := TStringsToString(MDescriere.Lines, '');
  Query.SQL.Text :=
    'INSERT INTO `' + sFirma + '`.`GENERAL` (GRUPA, COD, DESCRIERE) VALUES (' +
      '"JUR", ' +
      IntToStr(ID) + ', "' +
      Temp + '")';
  Query.ExecSQL;
  //if CTip.ItemIndex = 0 then iAux := 1
  //else iAux := 0;
  //iAux := 1 shl CTip.ItemIndex;
  //iAux := iAux + 1 shl (4 + CDurata.ItemIndex);
  Query.SQL.Text :=
    'INSERT INTO `' + sFirma + '`.`LOG` (DATA, TIMP, STATIA, USER, TIP, TIP2, TIP3, INFO1, INFO2, INFO3) VALUES (' +
      '"' + FormatDateTime('yyyymmdd', Now) + '", ' +
      '"' + FormatDateTime('hhnnss', Time) + '", ' +
      '"*", ' + //statia
      '"' + tsUsers.Values[Copy(UMail, 1, Pos('@', UMail) - 1)] + '", ' + //user
      '"J", ' + //tip
      '"' + sDurata[CDurata.ItemIndex + 1] + '", ' + //tip2
      '"' + sTip[CTip.ItemIndex + 1] + '", ' + //tip3
      '"' + sCodFC + '", ' +
      '"' + FormatDateTime('yyyymmdd', DApel.DateTime) + '", ' +
      '"' + IntToStr(ID) + '")';
   Query.ExecSQL;   
  Close;
  tsUsers.Free;
end;

procedure TJurClienti.Btn_RenuntaClick(Sender: TObject);
begin
  Close;
end;

procedure TJurClienti.CDurataKeyPress(Sender: TObject; var Key: Char);
begin
  if UpCase(Key) = #13 then SelectNext(TListBox(Sender), True, True);
  if UpCase(Key) = 'S' then CDurata.ItemIndex := 0;
  if UpCase(Key) = 'M' then CDurata.ItemIndex := 1;
  if UpCase(Key) = 'L' then CDurata.ItemIndex := 2;
  if UpCase(Key) = 'F' then CDurata.ItemIndex := 3;
end;

procedure TJurClienti.CTipKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then SelectNext(TListBox(Sender), True, True);
  if UpCase(Key) = 'T' then begin
    CTip.ItemIndex := 0;
    CDurata.ItemIndex := 0;
  end;
  if UpCase(Key) = 'L' then begin
    CTip.ItemIndex := 1;
    CDurata.ItemIndex := 1;
  end;
  if UpCase(Key) = 'C' then begin
    CTip.ItemIndex := 2;
    CDurata.ItemIndex := 1;
  end;
  if UpCase(Key) = 'D' then begin
    CTip.ItemIndex := 3;
    CDurata.ItemIndex := 2;
  end;
end;

procedure TJurClienti.CTipKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if CTip.ItemIndex = 0 then CDurata.ItemIndex := 0;
  if CTip.ItemIndex = 1 then CDurata.ItemIndex := 1;
  if CTip.ItemIndex = 2 then CDurata.ItemIndex := 1;
  if CTip.ItemIndex = 3 then CDurata.ItemIndex := 2;
end;

procedure TJurClienti.EditKeyPress(Sender: TObject; var Key: Char);
begin
  Key := #0;
end;

procedure TJurClienti.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then Close;
end;

procedure TJurClienti.FormShow(Sender: TObject);
begin
  Color := MainForm.Color;
  ECOD_FISCAL.Text := sCodFC;
  EDENFUR.Text := sDenFC;
  DCurenta.Date := Now;
  DApel.DateTime := Now;
  CTip.ItemIndex := 0;
  CDurata.ItemIndex := 0;
end;

function TJurClienti.Start(CodFC, DenFC, Firma, Optiuni: string): integer;
begin
  JurClienti := TJurClienti.Create(Application);
  sCodFC := CodFC;
  sDenFC := DenFC;
  sFirma := Firma;
  Options := Optiuni;
  JurClienti.ShowModal;
  JurClienti.Free;
end;

end.
