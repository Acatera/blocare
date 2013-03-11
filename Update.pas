unit Update;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TFUpdate = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
    function Start(Param: string): byte;
  end;

var
  FUpdate: TFUpdate;
  Params: string;

implementation

{$R *.dfm}

function TFUpdate.Start(Param: string): byte;
begin
  //
  FUpdate := TFUpdate.Create(Application);
  Params := Param;
  FUpdate.ShowModal;
end;

end.
