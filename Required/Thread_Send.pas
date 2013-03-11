unit Thread_Send;

interface

uses
  Classes, Graphics, ExtCtrls, RbProgressBar, SysUtils, Sent_Mail, IdMessage, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase, IdMessageClient,
  IdSMTPBase, IdSMTP, IdReplySMTP, FMain, IdSSLOpenSSL, IdAttachmentFile, IdUserPassProvider,
  IdSASLPlain, Windows;

type
  TMailThread = class(TThread)
  private
    POwner: TObject;
    PWorkCount: int64;
    PWork: int64;
    PAdresses: wideString;
    PSubject: string;
    PAtachments: widestring;
    PAtachmentsSize: Longint;
    PBody: widestring;
    PID: integer;
    SMTP: TIdSMTP;
    Msg: TIdMessage;
    procedure DoVisualUpdate;
    procedure DoSend;
    procedure SetName;
  protected
    procedure Execute; override;
    procedure VisualUpdate;
    procedure Send;
    procedure SMTPWork(ASender: TObject; AWorkMode: TWorkMode;
                AWorkCount: Integer);
    procedure SMTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
                AWorkCountMax: Integer);
    procedure SMTPWorkEnd(ASender: TObject; AWorkMode: TWorkMode);                        
  public
    constructor Create(AOwner: TObject; Adresses: widestring; Subject: string; Atachments, Body: widestring; ID: integer);
  end;

{$IFDEF MSWINDOWS}
type
  TThreadNameInfo = record
    FType: LongWord;     // must be 0x1000
    FName: PChar;        // pointer to name (in user address space)
    FThreadID: LongWord; // thread ID (-1 indicates caller thread)
    FFlags: LongWord;    // reserved for future use, must be zero
  end;
{$ENDIF}

implementation

constructor TMailThread.Create(AOwner: TObject; Adresses: widestring; Subject: string; Atachments, Body: widestring; ID: integer);
begin
  POwner := AOwner;
  PAdresses := Adresses;
  PSubject := Subject;
  PAtachments := Atachments;
  PBody := Body;
  PWork := 0;
  FreeOnTerminate := True;
  inherited Create(False);
  SetName;
  PID := ID;
  OnTerminate := MainForm.DoThreadTerminate;
end;

procedure TMailThread.SetName;
{$IFDEF MSWINDOWS}
var
  ThreadNameInfo: TThreadNameInfo;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  ThreadNameInfo.FType := $1000;
  ThreadNameInfo.FName := 'MailerDeamon';
  ThreadNameInfo.FThreadID := $FFFFFFFF;
  ThreadNameInfo.FFlags := 0;

  try
    RaiseException( $406D1388, 0, sizeof(ThreadNameInfo) div sizeof(LongWord), @ThreadNameInfo );
  except
  end;
{$ENDIF}
end;

procedure TMailThread.Execute;
begin
  PWork := 0;
  Send;
end;

procedure TMailThread.VisualUpdate;
begin
  Synchronize(DoVisualUpdate);
end;

procedure TMailThread.DoVisualUpdate;
begin
  Exit;
  if Assigned(SentMail) then
    if SentMail.Visible then begin
      if SentMail.PBar.Max <> PWorkCount then SentMail.PBar.Max := PWorkCount;
      SentMail.PBar.Position := PWork;
    end;
end;

procedure TMailThread.SMTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCountMax: Integer);
begin

end;

procedure TMailThread.SMTPWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
begin
  MainForm.LastMailID := PID;
end;

procedure TMailThread.SMTPWork(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Integer);
begin
  if not MainForm.ThreadCancel then begin
    PWork := Round(AWorkCount/1024);
    VisualUpdate;
  end else begin
    //raise Exception.Create('Canceled');
    SMTP.Disconnect;
  end;
    //TMailThread.Terminated := True;
end;

procedure TMailThread.DoSend;
var
  I: Integer;
  tsAdress: TStringList;
  tsAtachments: TStringList;
  tsBody: TStringList;
  Temp: TStringList;
  Aux: string;
  //iTemp: integer;
  TempStream: TMemoryStream;
  //SearchRec: TSearchRec;
begin
  tsAdress := TStringList.Create;
  tsAtachments := TStringList.Create;
  tsBody := TStringList.Create;

  tsAdress.CommaText := PAdresses;
  tsAtachments.CommaText := PAtachments;
  tsBody.CommaText := PBody;

  Temp := TStringList.Create;
  Temp.Duplicates := dupIgnore;
  Temp.Sorted := True;
  for I := 0 to tsAdress.Count - 1 do begin
    Aux := Copy(Copy(tsAdress[I], Pos('<', tsAdress[I]) +1), 1, Pos('>', Copy(tsAdress[I], Pos('<', tsAdress[I]) +1)) - 1);
    if Aux = '' then begin
      if (Pos('@', tsAdress[I]) <> 0) and (Pos('.', tsAdress[I]) <> 0) then
        Temp.Add(tsAdress[I])
    end else
      Temp.Add(Aux);
  end;
  //ShowMessage(Temp.CommaText);

  SMTP := TIdSMTP.Create;
  SMTP.OnWork := SMTPWork;
  SMTP.OnWorkBegin := SMTPWorkBegin;
  SMTP.OnWorkEnd := SMTPWorkEnd;
  Msg := TIdMessage.Create;
  
  SMTP.Username := MainForm.TUMail;
  SMTP.Password := MainForm.TPMail;
  SMTP.Host := 'dsoft.ro';
  SMTP.Port := 587;

  Msg.MessageParts.Clear;
  Msg.From.Address := MainForm.TUMail;
  //Msg.Recipients.EMailAddresses := UMail;
  Temp.Delimiter := ';';
  Msg.BccList.EMailAddresses := Temp.DelimitedText;

  //file size;
  for I := 0 to tsAtachments.Count - 1 do begin
    Aux := Copy(tsAtachments[I], Pos('|', tsAtachments[I]) + 1);
    if FileExists(Aux) then
      TIdAttachmentFile.Create(Msg.MessageParts, Aux)
    else
      if FileExists(tsAtachments[I]) then
        TIdAttachmentFile.Create(Msg.MessageParts, Aux);

  end;
  if Assigned(SentMail) then SentMail.PBar.Max := PAtachmentsSize;
  Msg.Subject := PSubject;
  Msg.Body := tsBody;
  TempStream := TMemoryStream.Create;
  Msg.SaveToStream(TempStream);
  PWorkCount := Round(TempStream.Size/1024);
  TempStream.Free;
  try
    try
      SMTP.Connect;
      SMTP.Send(Msg);
    except on E: EIdSMTPReplyError do
     //FDialog.Start('Eroare la trimitere', E.Message, fdOk, mtError);
    end;
  finally
    if SMTP.Connected then SMTP.Disconnect;
  end;
  Temp.Free;
  tsAdress.Free;
  {for I := 0 to tsAtachments.Count - 1 do begin
    if FileExists(Copy(tsAtachments[I], Pos('|', tsAtachments[I]) + 1)) then begin
      if Pos('FactTemp', Copy(tsAtachments[I], Pos('|', tsAtachments[I]) + 1)) <> 0 then
        DeleteFile(Copy(tsAtachments[I], Pos('|', tsAtachments[I]) + 1));
    end;
  end;    }
  tsAtachments.Free;
  tsBody.Free;
  SMTP.Free;
  Msg.Free;
end;

procedure TMailThread.Send();
begin
  DoSend;
  {for I := 1 to 100 do begin
    Inc(Position);
    VisualUpdate;
  end; }
end;

end.