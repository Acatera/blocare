unit Color;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, ExtCtrls, FMain, AlexUtils;

type
  TCulori = class(TForm)
    SG: TStringGrid;
    CD: TColorDialog;
    eFormColor: TLabeledEdit;
    eGridTitle: TLabeledEdit;
    eOdd: TLabeledEdit;
    eEven: TLabeledEdit;
    eContract: TLabeledEdit;
    eOverdue: TLabeledEdit;
    eBlocked: TLabeledEdit;
    eCursor: TLabeledEdit;
    eSelection: TLabeledEdit;
    Button1: TButton;
    Button2: TButton;
    eHeader: TLabeledEdit;
    eFooter: TLabeledEdit;
    Header: TPaintBox;
    Footer: TPaintBox;
    gbPage: TGroupBox;
    gbPartner: TGroupBox;
    gbGridColors: TGroupBox;
    procedure SGDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
    procedure eFormColorClick(Sender: TObject);
    procedure eGridTitleClick(Sender: TObject);
    procedure eOddClick(Sender: TObject);
    procedure eEvenClick(Sender: TObject);
    procedure eCursorClick(Sender: TObject);
    procedure eSelectionClick(Sender: TObject);
    procedure eContractClick(Sender: TObject);
    procedure eBlockedClick(Sender: TObject);
    procedure eOverdueClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure eHeaderClick(Sender: TObject);
    procedure eFooterClick(Sender: TObject);
    procedure HeaderPaint(Sender: TObject);
    procedure FooterPaint(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function Start(): integer;
  end;

var
  Culori: TCulori;
  TempColors: TColors;

implementation

//uses FMain;

{$R *.dfm}

procedure TCulori.Button1Click(Sender: TObject);
begin
  with Colors do begin
    HeaderColor := TempColors.HeaderColor;
    FormColor := TempColors.FormColor;
    FooterColor := TempColors.FooterColor;
    //GridColors
    GridTitle := TempColors.GridTitle;
    Selection := TempColors.Selection;
    Cursor := TempColors.Cursor;
    Odd := TempColors.Odd;
    Even := TempColors.Even;
    //Partner colors
    Contract := TempColors.Contract;
    Overdue := TempColors.Overdue;
    Blocked := TempColors.Blocked;
    DoRepaint := True;
  end;
//  Colors := TempColors;
  ModalResult := mrOk;
end;

procedure TCulori.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TCulori.eBlockedClick(Sender: TObject);
begin
  CD.Color := TempColors.Blocked;
  if CD.Execute then begin
    eBlocked.Color := CD.Color;
    TempColors.Blocked := CD.Color;
    SG.Repaint;
  end;
end;

procedure TCulori.eContractClick(Sender: TObject);
begin
  CD.Color := TempColors.Contract;
  if CD.Execute then begin
    eContract.Color := CD.Color;
    TempColors.Contract := CD.Color;
    SG.Repaint;
  end;
end;

procedure TCulori.eFooterClick(Sender: TObject);
begin
  CD.Color := TempColors.FooterColor;
  if CD.Execute then begin
    Footer.Color := CD.Color;
    eFooter.Color := CD.Color;
    TempColors.FooterColor := eFooter.Color;
  end;
end;

procedure TCulori.eFormColorClick(Sender: TObject);
begin
  CD.Color := TempColors.FormColor;
  if CD.Execute then begin
    Culori.Color := CD.Color;
    eFormColor.Color := CD.Color;
    TempColors.FormColor := eFormColor.Color;
    Color := CD.Color;
  end;
end;

procedure TCulori.eOverdueClick(Sender: TObject);
begin
  CD.Color := TempColors.Overdue;
  if CD.Execute then begin
    eOverdue.Color := CD.Color;
    TempColors.Overdue := CD.Color;
    SG.Repaint;
  end;
end;

procedure TCulori.eCursorClick(Sender: TObject);
begin
  CD.Color := TempColors.Cursor;
  if CD.Execute then begin
    eCursor.Color := CD.Color;
    TempColors.Cursor := CD.Color;
    SG.Repaint;
  end;
end;

procedure TCulori.eOddClick(Sender: TObject);
begin
  CD.Color := TempColors.Odd;
  if CD.Execute then begin
    eOdd.Color := CD.Color;
    TempColors.Odd := CD.Color;
    SG.Repaint;
  end;
end;

procedure TCulori.eEvenClick(Sender: TObject);
begin
  CD.Color := TempColors.Even;
  if CD.Execute then begin
    eEven.Color := CD.Color;
    TempColors.Even := CD.Color;
    SG.Repaint;
  end;
end;

procedure TCulori.eSelectionClick(Sender: TObject);
begin
  CD.Color := TempColors.Selection;
  if CD.Execute then begin
    eSelection.Color := CD.Color;
    TempColors.Selection := CD.Color;
    SG.Repaint;
  end;
end;

procedure TCulori.eGridTitleClick(Sender: TObject);
begin
  CD.Color := TempColors.GridTitle;
  if CD.Execute then begin
    SG.FixedColor := CD.Color;
    eGridTitle.Color := CD.Color;
    TempColors.GridTitle := eGridTitle.Color;
    SG.Repaint;
  end;
end;

procedure TCulori.eHeaderClick(Sender: TObject);
begin
  CD.Color := TempColors.HeaderColor;
  if CD.Execute then begin
    Header.Color := CD.Color;
    eHeader.Color := CD.Color;
    TempColors.HeaderColor := eHeader.Color;
  end;
end;

procedure TCulori.FooterPaint(Sender: TObject);
begin
  GradientHorizontalFooter(TPaintBox(Sender));
end;

procedure TCulori.FormShow(Sender: TObject);
begin
  //TempColors := MainForm.Colors;
  with Colors do begin
    //Form colors
    TempColors.HeaderColor := HeaderColor;
    TempColors.FooterColor := FooterColor;
    TempColors.FormColor := FormColor;
    //GridColors
    TempColors.GridTitle := GridTitle;
    TempColors.Selection := Selection;
    TempColors.Cursor := Cursor;
    TempColors.Odd := Odd;
    TempColors.Even := Even;
    //Partner colors
    TempColors.Contract := Contract;
    TempColors.Overdue := Overdue;
    TempColors.Blocked := Blocked;
    DoRepaint := False;
  end;

  Header.Color := TempColors.HeaderColor;
  Color := TempColors.FormColor;
  Footer.Color := TempColors.FooterColor;
  //Form colors
  eHeader.Color := TempColors.HeaderColor;
  eFormColor.Color := TempColors.FormColor;
  eFooter.Color := TempColors.FooterColor;
  //Grid Colors
  eGridTitle.Color := TempColors.GridTitle;
  eSelection.Color := TempColors.Selection;
  eCursor.Color := TempColors.Cursor;
  eOdd.Color := TempColors.Odd;
  eEven.Color := TempColors.Even;
  //Partner colors
  eContract.Color := TempColors.Contract;
  eOverdue.Color := TempColors.Overdue;
  eBlocked.Color := TempColors.Blocked;
end;

procedure TCulori.HeaderPaint(Sender: TObject);
begin
  GradientHorizontalMirror(TPaintBox(Sender).Canvas, TPaintBox(Sender).ClientRect, TPaintBox(Sender).Color);
end;

procedure TCulori.SGDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
  State: TGridDrawState);
begin
  if ARow = 0 then begin
    SG.Canvas.Brush.Color := TempColors.GridTitle;
    (Sender as TStringGrid).Canvas.FillRect(Rect);
    Exit;
  end;
  if ((ARow mod 2) = 1) and (ARow <> 0) then SG.Canvas.Brush.Color := TempColors.Odd
  else SG.Canvas.Brush.Color := TempColors.Even;
  if gdSelected in State then SG.Canvas.Brush.Color := TempColors.Cursor;
  if ARow = 3 then SG.Canvas.Brush.Color := TempColors.Selection;
  if (ACol = 2) and (ARow = 2) then SG.Canvas.Brush.Color := TempColors.Contract;
  if (ACol = 3) and (ARow = 2) then SG.Canvas.Brush.Color := TempColors.Blocked;
  if (ACol = 4) and (ARow = 2) then SG.Canvas.Brush.Color := TempColors.Overdue;
  if (ACol = 4) and (ARow = 3) then SG.Canvas.Brush.Color := TempColors.Overdue;
  (Sender as TStringGrid).Canvas.FillRect(Rect);

end;

function TCulori.Start(): integer;
begin
  Culori := TCulori.Create(Application);
  Culori.ShowModal;
  Culori.Free;
end;

end.
