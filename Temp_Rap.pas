unit Temp_Rap;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RpCon, RpConDS, RpConBDE, RpRender, RpRenderPDF, RpRave,
  RpDefine, RpBase, RpSystem, RvLDCompiler, DB, DBTables;

type
  TTempRap = class(TForm)
    RS: TRvSystem;
    RP: TRvProject;
    RR_PDF: TRvRenderPDF;
    R1: TRvQueryConnection;
    R2: TRvQueryConnection;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TempRap: TTempRap;

implementation

{$R *.dfm}

end.
