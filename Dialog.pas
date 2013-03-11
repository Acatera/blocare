unit Dialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Constants, AlexUtils, jpeg, pngimage, ImgList,
  smslabel;

type
  TFDialog = class(TForm)
    LMessage: TLabel;
    Btn_Yes: TButton;
    Btn_No: TButton;
    Btn_Cancel: TButton;
    Image: TImage;
    LMessage_S: TLabel;
    procedure Btn_CancelClick(Sender: TObject);
    procedure Btn_YesClick(Sender: TObject);
    procedure Btn_NoClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    function Start(Title, Msg: String; Params: Integer): integer; overload;
    function Start(Title, Msg: String; Params: Integer; MsgType: integer): integer; overload;
    function Start(Title, Msg: String; Params: Integer; MsgType: integer; Split: boolean): integer; overload;
    { Public declarations }
  end;

const
  BUTTON_SPACING: integer  = 16;
  fdNone: integer          = 0;
  fdBtn_Yes: integer       = 1 shl 1;
  fdBtn_No: integer        = 1 shl 2;
  fdBtn_Cancel: integer    = 1 shl 3;
  fdAll: integer           = 1 shl 4;
  fdOk: integer            = 1 shl 5;

  mtError: integer         = 1;
  mtInformation: integer   = 2;
  mtConfirmation: integer  = 3;
  mtWarning: integer       = 4;
  mtAbout: integer         = 5;

var
  FDialog: TFDialog;
  ButtonPressed: integer;

implementation

uses FMain;

{$R *.dfm}

procedure TFDialog.Btn_CancelClick(Sender: TObject);
begin
  ButtonPressed := fdBtn_Cancel;
  Close; 
end;

procedure TFDialog.Btn_NoClick(Sender: TObject);
begin
  ButtonPressed := fdBtn_No;
  Close
end;

procedure TFDialog.Btn_YesClick(Sender: TObject);
begin
  ButtonPressed := fdBtn_Yes;
  Close;
end;

procedure TFDialog.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then Btn_CancelClick(Sender);
end;

function TFDialog.Start(Title, Msg: String; Params: Integer): integer;
begin
  Start(Title, Msg, Params, 0, True);
  MainForm.ActionExecuted := False;
  Result := ButtonPressed;
end;

function TFDialog.Start(Title, Msg: String; Params: Integer; MsgType: integer): integer;
begin
  Start(Title, Msg, Params, MsgType, True);
  Result := ButtonPressed;
end;

function TFDialog.Start(Title, Msg: String; Params: Integer;  MsgType: integer; Split: boolean): integer;
var
  Temp: string;
  iLeft: integer;
  iTop: integer;
  Aux: integer;
//  Aux2: integer;
begin
  iLeft := 0;
  iTop := 0;
  FDialog := TFDialog.Create(Application);
  with FDialog do begin
    Caption := Title;
    Color := MainForm.Color;
    case MsgType of
      1: Image.Picture.LoadFromFile(GetCurrentDir + '\Images\mtError.png');
      2: Image.Picture.LoadFromFile(GetCurrentDir + '\Images\mtInformation.png');
      3: Image.Picture.LoadFromFile(GetCurrentDir + '\Images\mtConfirmation.png');
      4: Image.Picture.LoadFromFile(GetCurrentDir + '\Images\mtWarning.png');
      5: Image.Picture.LoadFromFile(GetCurrentDir + '\Images\mtAbout.png');
    end;
    if Split then begin
      Temp := Copy(Msg, 1, GetLastSpace(Msg, 100));
      Msg := Copy(Msg, GetLastSpace(Msg, 100) + 1, Length(Msg));
      while Msg <> '' do begin
        Temp := Temp + #13 + Copy(Msg, 1, GetLastSpace(Msg, 100));
        Msg := Copy(Msg, GetLastSpace(Msg, 100) + 1, Length(Msg));
      end;
      LMessage.Caption := Temp;
      LMessage_S.Caption := Temp;
    end else begin
      LMessage.Caption := Msg;
      LMessage_S.Caption := Msg;
    end;
    if not (Image.Picture.Graphic = nil) then begin
      iLeft := 136;
      if LMessage.Height + 32 > 144 then iTop := 32 + LMessage.Height - 144
      else iTop := 144 - 32 - LMessage.Height;
      if iTop < 0 then iTop := 0;
    end;
    Width := LMessage.Width + 32 + iLeft;
    if Width < 200 then Width := 200;
    Height := 32 + LMessage.Height + 32 + 25 + 8 + iTop;
    //Showmessage('H:' + IntToStr(Height) + 'L.H:' + IntToStr(LMessage.Height) + 'I:' + IntToStr(iTop));
    LMessage.Left := iLeft + (Width - LMessage.Width - iLeft) div 2;
    LMessage_S.Left := LMessage.Left + 1;
    LMessage_S.Top := LMessage.Top + 1;
//buttons
    if Params and fdBtn_Yes = fdBtn_Yes then Btn_Yes.Visible := True;
    if Params and fdBtn_No = fdBtn_No then Btn_No.Visible := True;
    if Params and fdBtn_Cancel = fdBtn_Cancel then Btn_Cancel.Visible := True;
    if Params and fdAll = fdAll then begin
      Btn_Yes.Visible := True;
      Btn_No.Visible := True;
      Btn_Cancel.Visible := True;
    end;
    if Params and fdOk = fdOk then begin
      Btn_Cancel.Visible := True;
      Btn_Cancel.Caption := 'Ok';
    end;
    Aux := 0;
    if Btn_Yes.Visible then Aux := Aux + 1;
    if Btn_No.Visible then Aux := Aux + 1;
    if Btn_Cancel.Visible then Aux := Aux + 1;
    if Aux = 1 then Btn_Cancel.Left := (Width - 75) div 2;
    if Aux = 2 then begin
      if Btn_Yes.Visible then Btn_Yes.Left := (Width div 2) - 75 - (BUTTON_SPACING div 2);
      if Btn_No.Visible then Btn_No.Left := (Width div 2) + (BUTTON_SPACING div 2);
      if Btn_Cancel.Visible then Btn_No.Left := (Width div 2) + (BUTTON_SPACING div 2);
    end;
    if Aux = 3 then begin
      Btn_Yes.Left := (Width div 2) - BUTTON_SPACING - 112;
      Btn_No.Left := (Width - 75) div 2;
      Btn_Cancel.Left := (Width div 2) + BUTTON_SPACING + 37;
    end;
    ShowModal;
  end;
  Result := ButtonPressed;
end;

end.
