program Blocare;

uses
  Forms,
  ShellAPI,
  Classes,
  Add_Modify in 'Add_Modify.pas' {AddModify},
  AlexUtils in 'AlexUtils.pas',
  Color in 'Color.pas' {Culori},
  DContact in 'DContact.pas' {Contact},
  Dialog in 'Dialog.pas' {FDialog},
  E_Mail in 'E_Mail.pas' {EMail},
  Extras_Cont in 'Extras_Cont.pas' {ExtrasCont},
  Fisa_Client in 'Fisa_Client.pas' {FisaClient},
  FOptiuni in 'FOptiuni.pas' {Optiuni},
  FRezolvare in 'FRezolvare.pas' {Rezolvare},
  FSesizari in 'FSesizari.pas' {Sesizari},
  FStatii in 'FStatii.pas' {Statii},
  Fur_Detail in 'Fur_Detail.pas' {FurDetail},
  FWait in 'FWait.pas' {Wait},
  Sel_Mail in 'Sel_Mail.pas' {SelMail},
  Send_Mail in 'Send_Mail.pas' {SendMail},
  Sesiz_Detail in 'Sesiz_Detail.pas' {SesizDetail},
  Temp_Rap in 'Temp_Rap.pas' {TempRap},
  Jur_Clienti in 'Jur_Clienti.pas' {JurClienti},
  Jur_C_Clienti in 'Jur_C_Clienti.pas' {JurCClienti},
  ListareFacturi in 'ListareFacturi.pas',
  Bank in 'Bank.pas' {FBank},
  Editare in 'Editare.pas' {FEditare},
  Sent_Mail in 'Sent_Mail.pas' {SentMail},
  Thread_Send in 'Required\Thread_Send.pas',
  Updater in 'Updater.pas',
  FMain in 'FMain.pas' {MainForm},
  Fur_Panel in 'Fur_Panel.pas' {FurPanel};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;

  if MainForm.DoRestart then begin
    ShellExecute(MainForm.Handle, 'open', PChar(Application.ExeName), PChar('/restarting'), nil, 5);
    //Application.Terminate;
  end;

end.
