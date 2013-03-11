unit Fur_Panel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, smslabel, ToolWin, ComCtrls, acCoolBar, ExtCtrls,
  sPanel, sScrollBox, DB, DBTables, AlexUtils, Menus, Buttons, PngSpeedButton;

type
  TFurPanel = class(TForm)
    q: TQuery;
    sScrollBox1: TsScrollBox;
    sPanel1: TsPanel;
    sCoolBar1: TsCoolBar;
    LDenFur: mslabelFX;
    g: TStringGrid;
    pmEmail: TPopupMenu;
    PngSpeedButton1: TPngSpeedButton;
    PngSpeedButton2: TPngSpeedButton;
    PngSpeedButton3: TPngSpeedButton;
    PngSpeedButton4: TPngSpeedButton;
    PngSpeedButton5: TPngSpeedButton;
    PngSpeedButton6: TPngSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure gDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
    procedure gMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    function Start(AOwner: TComponent; Params: integer): word;
  end;

var
  FurPanel: TFurPanel;

implementation

{$R *.dfm}

uses
  FMain, Fur_Detail, Dialog;

procedure TFurPanel.FormShow(Sender: TObject);
var
  s: string;
  i: Integer;
begin
  g.Color := MainForm.BkColor;
  g.Canvas.Brush.Color := MainForm.BkColor;
  g.Canvas.FillRect(g.Canvas.ClipRect);
  s := '';
  for i := 0 to MainForm.CGest.Items.Count - 1 do
    s := s +
         'SELECT DENFUR, "Sediu" AGENT, EMAIL, CODFUR, TELEFON ' +
         'FROM ' + MainForm.CGest.Items[I] + '.FUR WHERE (EMAIL NOT IN ("","W")) AND ' +
           '(CODFUR = "' + FurDetail.CodFur + '")  UNION ALL ' +
         'SELECT DENFUR, NUME, EMAIL, C.CODFUR, TELEFON ' +
         'FROM (' +
           'SELECT NUME, EMAIL, CODFUR, TELEFON ' +
           'FROM ' + MainForm.CGest.Items[I] + '.CONTACTE ' +
           'WHERE EMAIL NOT IN ("","W")) C LEFT JOIN (' +
           'SELECT DENFUR, CODFUR FROM ' + MainForm.CGest.Items[I] + '.FUR) F USING(CODFUR) '+
         'WHERE F.CODFUR = "' + FurDetail.CodFur + '"  UNION ALL ';
  s := Copy(s, 1, Length(s) - 11);
  DoSQL(q, s);
  i := 0;
  while not q.Eof do begin
    try
      if i > g.RowCount then 
        g.RowCount := g.RowCount + 1;
      g.Cells[0, i] := q.FieldByName('AGENT').AsString + '<br>' +
                       q.FieldByName('EMAIL').AsString + '<br>' +
                       q.FieldByName('TELEFON').AsString;  
    except
      on E: EDatabaseError do begin
        FDialog.Start('Eroare', 'Am intampinat o eroare.'#13'Detalii:'#13 + E.Message, fdOk, mtError);
        Exit;
      end;
    end;          
    q.next;
    Inc(i);
  end;
end;

procedure TFurPanel.gDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
  State: TGridDrawState);
var
  s: string;
  s1: string;
  r,r1: TRect;
begin
  s := TStringGrid(Sender).Cells[ACol, ARow];
  r := Rect;
  r1 := r;
  r1.Bottom := r1.Bottom + 1;
  r1.Right := r1.Right + 1; 
  if s = '' then Exit;
  s1 := cut(s, 1, Pos('<br>', s), 1, 3);
  TStringGrid(Sender).Canvas.Font.Name := 'Segoe UI';
  TStringGrid(Sender).Canvas.Font.Color := MainForm.FontColor;
  TStringGrid(Sender).Canvas.Brush.Color := MainForm.BkColor;
  TStringGrid(Sender).Canvas.FillRect(r1);

  if s1 <> '' then begin
    r.Left := r.Left + 2;
    TStringGrid(Sender).Canvas.Font.Size := 14;
    TStringGrid(Sender).Canvas.Font.Style := [fsBold];
    DrawText(TStringGrid(Sender).Canvas.Handle, PChar(s1), Length(s1), r, 0);
    TStringGrid(Sender).Canvas.Font.Style := [];
  end;
  s1 := cut(s, 1, Pos('<br>', s), 1, 3);
  if s1 <> '' then begin
    r.Left := r.Left + 2;
    r.Top := r.Top + 22;
    TStringGrid(Sender).Canvas.Font.Size := 12;
    DrawText(TStringGrid(Sender).Canvas.Handle, PChar(s1), Length(s1), r, 0);
    r := Rect;
  end;
  if s <> '' then begin
    r.Left := r.Left + 2;
    r.Top := r.Top + 42;
    TStringGrid(Sender).Canvas.Font.Size := 11;
    DrawText(TStringGrid(Sender).Canvas.Handle, PChar(s), Length(s), r, 0);
  end;
end;

procedure TFurPanel.gMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  xx: integer;
  yy: integer;
begin
  g.MouseToCell(X,Y,xx,yy);


end;

function TFurPanel.Start(AOwner: TComponent; Params: integer): word;
begin
  FurPanel := TFurPanel.Create(AOwner);
  FurPanel.Height := TForm(AOwner).Height;
  FurPanel.Top := TForm(AOwner).Top;
  FurPanel.Left := TForm(AOwner).Left + TForm(AOwner).Width;
  FurPanel.Show;
end;

end.
