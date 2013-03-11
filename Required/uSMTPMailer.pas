unit uSMTPMailer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, IdMessage, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdMessageClient, IdSMTP, StdCtrls;

type
  TSendMail = class(TThread)
  private
    FPortNumber: Integer;
    FSubject: String;
    FPassword: String;
    FServerName: String;
    FFromAddress: String;
    FBodyMessage: TStrings;
    FRecipientsList: TStrings;
    procedure SetBodyMessage(const Value: TStrings);
    procedure SetFromAddress(const Value: String);
    procedure SetPasword(const Value: String);
    procedure SetPortNumber(const Value: Integer);
    procedure SetRecipientsList(const Value: TStrings);
    procedure SetServerName(const Value: String);
    procedure SetSubject(const Value: String);
  public
    constructor Create(ASuspended: Boolean);
    property PortNumber: Integer read FPortNumber write SetPortNumber;
    property ServerName: String read FServerName write SetServerName;
    property Password: String read FPassword write SetPasword;
    property FromAddress: String read FFromAddress write SetFromAddress;
    property Recipients: TStrings  read FRecipientsList write SetRecipientsList;
    property Subject: String read FSubject write SetSubject;
    property Body: TStrings read FBodyMessage write SetBodyMessage;
    procedure SendEMail;
  protected
    procedure Execute;  override;
  end;

  function SendSMTPMail(APort: Integer;
                        ASMTPServer, APassword, AFromAddress: String;
                        AToAddresses, ABodyText: TStrings): Boolean;

implementation

{ TSendMail }
constructor TSendMail.Create(ASuspended: Boolean);
begin
  inherited Create(ASuspended);
  FreeOnTerminate := True;
  FBodyMessage := TStringList.Create;
  FRecipientsList := TStringList.Create;
end;

procedure TSendMail.Execute;
var
  FIdSMTP: TIdSMTP;
  FIdMessage: TIdMessage;
begin
  FIdSMTP := TIdSMTP.Create(nil);
  FIdMessage := TIdMessage.Create(nil);
  try
    FIdSMTP.Host := FServerName;
    FIdSMTP.Port := FPortNumber;
    FIdSMTP.Password:= FPassword;
    FIdMessage.From.Address := FFromAddress;
    FIdmessage.Recipients.Assign(FRecipientsList);
    FIdMessage.Subject := FSubject;
    FIdMessage.Body.Assign(FBodyMessage);
    try
      FIdSMTP.Connect;
      FIdSMTP.Send(FIdMessage);
    except end;
  finally
    if FIdSMTP.Connected then FIdSMTP.Disconnect;
    FreeAndNil(FIdMessage);
    FreeAndNil(FIdSMTP);
  end;
end;

procedure TSendMail.SendEMail;
begin
  Resume;
end;

procedure TSendMail.SetBodyMessage(const Value: TStrings);
begin
  FBodyMessage.Assign(Value);
end;

procedure TSendMail.SetFromAddress(const Value: String);
begin
  FFromAddress := Value;
end;

procedure TSendMail.SetPasword(const Value: String);
begin
  FPassword := Value;
end;

procedure TSendMail.SetPortNumber(const Value: Integer);
begin
  FPortNumber := Value;
end;

procedure TSendMail.SetRecipientsList(const Value: TStrings);
begin
  FRecipientsList.Assign(Value);
end;

procedure TSendMail.SetServerName(const Value: String);
begin
  FServerName := Value;
end;

procedure TSendMail.SetSubject(const Value: String);
begin
  FSubject := Value;
end;

function SendSMTPMail(APort: Integer; ASMTPServer, APassword,
  AFromAddress: String; AToAddresses, ABodyText: TStrings): Boolean;
begin
  try
    with TSendMail.Create(True) do
    begin
      PortNumber := APort;
      ServerName := ASMTPServer;
      Password   := APassword;
      FromAddress := AFromAddress;
      Recipients.Assign(AToAddresses);
      Body.Assign(ABodyText);
      SendEMail;
      {no need to free, its a self destructive thread}
    end;
    Result := True;
  except
    Result := False;
  end;
end;

end.