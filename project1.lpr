program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, CustApp, ExtParams, cverinfo,
  Forms, Interfaces,
  DefaultTranslator, LCLTranslator, LazUTF8,
  {$IFDEF CLIENT}
  config, client;
  {$ELSE}
    {$IFDEF BOT}
    config, bot, bot_edytor_kodu;
    {$ELSE}
    main, config, datamodule, consola, bot_code_help;
    {$ENDIF}
  {$ENDIF}

{$R *.res}

type

  { TRadioPlayer }

  TRadioPlayer = class(TCustomApplication)
  protected
    procedure DoRun; override;
  private
    par: TExtParams;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
  end;

function GetLang: string;
var
  T: string; // unused FallBackLang
  i: integer;
begin
  Result := '';
  { We use the same method that is used in LCLTranslator unit }
  for i := 1 to Paramcount - 1 do
    if (ParamStrUTF8(i) = '--LANG') or (ParamStrUTF8(i) = '-l') or
      (ParamStrUTF8(i) = '--lang') then
      Result := ParamStrUTF8(i + 1);
  //Win32 user may decide to override locale with LANG variable.
  if Result = '' then
    Result := GetEnvironmentVariableUTF8('LANG');
  if Result = '' then
    LazGetLanguageIDs(Result, {%H-}T);
  if length(Result)>2 then Result:=copy(Result,1,2);
end;

var
  lang: string;

  //gnome-session-quit --power-off

procedure TRadioPlayer.DoRun;
var
  v1,v2,v3,v4: integer;
  go_exit: boolean;
  {$IFDEF BOT}
  FBOT: TBot;
  {$ENDIF}
begin
  inherited DoRun;
  go_exit:=false;
  lang:=getlang;
  if not POFileIsExists(lang) then lang:='en';
  SetDefaultLang(lang);

  {$IFDEF APP}
  par:=TExtParams.Create(nil);
  try
    _DEV:=false;
    _DEBUG:=false;
    _CUSTOM_POLFAN:='';
    par.Execute;
    par.ParamsForValues.Add('polfan');
    par.ParamsForValues.Add('chat-identify');
    if par.IsParam('ver') then
    begin
      //writeln('zażądano VER');
      GetProgramVersion(v1,v2,v3,v4);
      if v4>0 then writeln(v1,'.',v2,'.',v3,'-',v4) else
      if v3>0 then writeln(v1,'.',v2,'.',v3) else
      if v2>0 then writeln(v1,'.',v2) else writeln(v1,'.',v2);
      go_exit:=true;
    end;
    if par.IsParam('dev') then _DEV:=true;
    if par.IsParam('debug') then _DEBUG:=true;
    if par.IsParam('polfan') then _CUSTOM_POLFAN:=par.GetValue('polfan');
    if par.IsParam('chat-identify') then _DEV_CHAT_IDENTIFY:=par.GetValue('chat-identify');
  finally
    par.Free;
  end;
  if go_exit then
  begin
    terminate;
    exit;
  end;
  randomize;
  {$ENDIF}

  {$IFDEF BOT}
  FBOT:=TBot.Create;
  try
    FBOT.Execute;
  finally
    FBOT.Free;
  end;
  {$ELSE}
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
    {$IFDEF CLIENT}
    Application.CreateForm(TFClient, FClient);
    {$ELSE}
    Application.CreateForm(TFMain, FMain);
    Application.CreateForm(Tdm, dm);
    Application.CreateForm(TFConsola, FConsola);
    {$ENDIF}
  Application.Run;
  {$ENDIF}
  Terminate;
end;

constructor TRadioPlayer.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  StopOnException:=True;
end;

destructor TRadioPlayer.Destroy;
begin
  inherited Destroy;
end;

var
  L: TRadioPlayer;

begin
  Application.Title:='Radio Player 40 Plus';
  Application.Scaled:=True;
  L:=TRadioPlayer.Create(nil);
  L.Title:='RpFP';
  L.Run;
  L.Free;
end.

