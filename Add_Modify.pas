unit Add_Modify;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TAddModify = class(TForm)
    GB: TGroupBox;
    EditBox: TLabeledEdit;
    Btn_Ok: TButton;
    LMessage: TLabel;
    procedure FormShow(Sender: TObject);
    procedure Btn_OkClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure EditBoxKeyPress(Sender: TObject; var Key: Char);
    function Parola(Denumire: string): string;
  private
    { Private declarations }
  public
    { Public declarations }
    function Start(ActionType: string): string;
  end;

var
  AddModify: TAddModify;
  EditText: string;
  Optiuni: string;

implementation

uses FMain, FWait, Dialog;

{$R *.dfm}

procedure TAddModify.Btn_OkClick(Sender: TObject);
var
  Aux : boolean;
MyForm: TWait;
begin
  Aux := True;
  if Optiuni = 'PAROLA' then begin
    MyForm := TWait.Create(AddModify);
    MyForm.Color := MainForm.Color;
    MyForm.Repaint;
    MyForm.Label1.Caption := StringReplace(Parola(EditBox.Text), '&', '&&', [rfReplaceAll]);
    MyForm.ShowModal;
  end;
  if Optiuni = 'DATA' then begin
    if Length(EditBox.Text) <> 4 then Aux := False;
    if Copy(EditBox.Text, 1, 2) > '12' then Aux := False;
    if Copy(EditBox.Text, 3, 4) > '99' then Aux := False;
    if not Aux then FDialog.Start('Atentie', 'Data introdusa nu este valida!', fdOk, mtError)
    else EditText := EditBox.Text;
  end else
    EditText := EditBox.Text;
  Close;
end;

function TAddModify.Parola(Denumire: string): string;
var
  Temp: string;
  Aux: string;
  I: integer;
begin
  Aux := '98765432';
  Temp := UpperCase(Copy(Denumire + '        ', 1, 8));
  for I := 1 to 8 do
    Temp[I] := Chr(Ord(Temp[I]) + 10 - I);
  Result := Temp[8] + Temp[2] + Temp[7] + Temp[5] + Temp[6] + Temp[3] + Temp[4] + Temp[1];
end;

procedure TAddModify.EditBoxKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then Btn_OkClick(Self);
end;

procedure TAddModify.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Optiuni = 'NRZILE' then
    if (Key > #31) and ((Key < #48) or (Key > #57)) then Key := #0;
  if Key = #27 then begin
    EditText := '';
    Close;
  end;
end;

procedure TAddModify.FormShow(Sender: TObject);
begin
  AddModify.Color := MainForm.Color;
  if Optiuni = 'DATA' then begin
    Caption := 'Schimbare data...';
    EditBox.EditLabel.Caption := 'Introduceti data in formatul LLAA:'
  end;
  if Optiuni = 'PAROLA' then begin
    Caption := 'Parola firma...';
    EditBox.EditLabel.Caption := 'Introduceti denumirea:'
  end;
  if Optiuni = 'NRZILE' then begin
    Caption := 'Filtru expirare luni gratuite...';
    EditBox.EditLabel.Caption := 'Introduceti numarul de zile la care doriti filtrul:'
  end;
  if Optiuni = 'EXTRAS' then begin
    Caption := 'Extrase clienti...';
    EditBox.EditLabel.Caption := 'Introduceti data la care doriti extrasul (LLAA):';
    Optiuni := 'DATA'; 
  end;
end;

function TAddModify.Start(ActionType: string): string;
begin
  AddModify := TAddModify.Create(Application);
  Optiuni := ActionType;
  AddModify.ShowModal;
  Result := EditText;
  AddModify.Free;
end;

end.
