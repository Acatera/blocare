unit FStatii;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin;

type
  TStatii = class(TForm)
    GPost: TGroupBox;
    EConta: TSpinEdit;
    EGest: TSpinEdit;
    EGWin: TSpinEdit;
    EFarm: TSpinEdit;
    ESal: TSpinEdit;
    EMiFix: TSpinEdit;
    ERCasa: TSpinEdit;
    EEx: TSpinEdit;
    EGRest: TSpinEdit;
    LConta: TLabel;
    LGest: TLabel;
    LSal: TLabel;
    LMiFix: TLabel;
    LFarm: TLabel;
    LGWin: TLabel;
    LRCasa: TLabel;
    LEx: TLabel;
    LGRest: TLabel;
    Btn_Save: TButton;
    Btn_Renunta: TButton;
    procedure Btn_RenuntaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  Statii: TStatii;

implementation

{$R *.dfm}

procedure TStatii.Btn_RenuntaClick(Sender: TObject);
begin
  Close;
end;

end.
