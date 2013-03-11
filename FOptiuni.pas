unit FOptiuni;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, ExtCtrls, AlexUtils, Buttons, sComboBox;

type
  TOptiuni = class(TForm)
    COptiuni: TCheckListBox;
    LArata: TLabel;
    Btn_Apply: TButton;
    Btn_Renunta: TButton;
    LExpire: TLabel;
    CExpire: TComboBox;
    LRefresh: TLabel;
    CRefresh: TComboBox;
    LVerCli: TLabel;
    CVerCli: TComboBox;
    ETreshold: TLabeledEdit;
    ENrFact: TLabeledEdit;
    Btn_Refresh: TSpeedButton;
    btColors: TButton;
    Panel1: TPanel;
    Btn_VerifClienti: TSpeedButton;
    btUpdate: TButton;
    cbSkins: TsComboBox;
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Btn_RenuntaClick(Sender: TObject);
    procedure Btn_ApplyClick(Sender: TObject);
    procedure Btn_RefreshClick(Sender: TObject);
    procedure btColorsClick(Sender: TObject);
    procedure Btn_VerifClientiClick(Sender: TObject);
    procedure btUpdateClick(Sender: TObject);
    procedure cbSkinsChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function Start(): integer;
  end;

var
  Optiuni: TOptiuni;

implementation

uses FMain, Dialog, Color;

{$R *.dfm}

procedure TOptiuni.btColorsClick(Sender: TObject);
begin
  Culori.Start;
  if Colors.DoRepaint then begin
    with MainForm do begin
      //pbSettings.Color := Colors.FooterColor;
      Color := Colors.FormColor;

      DBGest.FixedColor := Colors.GridTitle;
      DBManager.FixedColor := Colors.GridTitle;

      //pbSettings.Repaint;
    end;
    Application.ProcessMessages;
  end;
end;

procedure TOptiuni.Btn_ApplyClick(Sender: TObject);
begin
  if not (COptiuni.Checked[0] or COptiuni.Checked[1]) then begin
    FDialog.Start('Atentie', 'Trebuie sa selectati cel putin una dintre ele', fdOk, mtWarning);
    COptiuni.SetFocus;
    Exit;
  end;
  GestVisible := COptiuni.Checked[0];
  ManagerVisible := COptiuni.Checked[1];
  DoExpire := CExpire.ItemIndex;
  DoRefresh := CRefresh.ItemIndex;
  DoVerify := CVerCli.ItemIndex;
  Treshold := StrToFloat(ETreshold.Text);
  MainForm.Options.Values['NR_FACT'] := i2s(ENrFact.Text);
  MainForm.Options.Values['THEME_NAME'] := cbSkins.Text;
  MainForm.FontColor := MainForm.SM.gd[MainForm.SM.GetSkinIndex('EDIT')].FontColor[1];
  MainForm.BkColor := MainForm.SM.gd[MainForm.SM.GetSkinIndex('EDIT')].Color;
  MainForm.MedianColor := GetMedianColor(MainForm.FontColor, MainForm.BkColor, 30);
  ModalResult := mrOk;
end;

procedure TOptiuni.Btn_RefreshClick(Sender: TObject);
begin
  MainForm.Btn_RefreshClick(Sender);
  ModalResult := mrCancel;
end;

procedure TOptiuni.Btn_RenuntaClick(Sender: TObject);
var
  Temp: string;
begin
  Temp := Optiuni.Hint;
  ModalResult := mrCancel;
  MainForm.SM.SkinName := Optiuni.Hint;
end;

procedure TOptiuni.FormKeyPress(Sender: TObject; var Key: Char);
var
  Temp: string;
begin
  if Key = #27 then begin
    Temp := Optiuni.Hint;
    Close;
    MainForm.SM.SkinName := Temp;
  end;
end;

procedure TOptiuni.FormShow(Sender: TObject);
var
  I: integer;
begin
  Color := MainForm.Color;
  if GestVisible then COptiuni.Checked[0] := True;
  if ManagerVisible then COptiuni.Checked[1] := True;
  CExpire.ItemIndex := DoExpire;
  CRefresh.ItemIndex := DoRefresh;
  CVerCli.ItemIndex := DoVerify;
  ETreshold.Text := FloatToStr(Treshold);
  ENrFact.Text := MainForm.Options.Values['NR_FACT'];
  cbSkins.Items.Clear;
  for I := 0 to MainForm.SM.InternalSkins.Count - 1 do
    cbSkins.Items.Add(MainForm.SM.InternalSkins.Items[I].Name);
  cbSkins.ItemIndex := cbSkins.IndexOf(MainForm.SM.SkinName);  
end;

procedure TOptiuni.Btn_VerifClientiClick(Sender: TObject);
begin
  MainForm.ScheduleVerify;
  ModalResult := mrCancel;
end;

procedure TOptiuni.btUpdateClick(Sender: TObject);
begin
  MainForm.DoSchedule('UM');
end;

procedure TOptiuni.cbSkinsChange(Sender: TObject);
begin
  MainForm.SM.SkinName := cbSkins.Text;
end;

function TOptiuni.Start(): integer;
begin
  Optiuni := TOptiuni.Create(Application);
  Optiuni.Hint := MainForm.SM.SkinName;
  Result := Optiuni.ShowModal;
  Optiuni.Free;
end;

end.
