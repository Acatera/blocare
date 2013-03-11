unit FWait;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ClipBrd;

type
  TWait = class(TForm)
    Label1: TLabel;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Wait: TWait;

implementation

{$R *.dfm}

procedure TWait.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #27) and (Length(Label1.Caption) = 8) then Close;
end;

procedure TWait.FormShow(Sender: TObject);
begin
  Clipboard.AsText := Label1.Caption;
end;

end.
