unit config;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ExtCtrls, NetSynHTTP, UOSEngine, UOSPlayer;

resourcestring
  RS_BRAK = 'BRAK';
  RS_STRONA = 'Strona';
  RS_Z = 'z';
  RS_WYSWIETLONO = 'Wyświetlono';
  RS_ADRES_UPCASE = 'ADRES';
  RS_LINK_HTTP_OPIS = 'Link do strony programu';
  RS_CHAT_STATUS_1 = 'Dostępny';
  RS_CHAT_STATUS_2 = 'Automat';
  RS_CLEAR_CONF_WARNING_1 = 'UWAGA';
  RS_CLEAR_CONF_WARNING_2 = 'Włączyłeś opcję wyczyszczenia konfiguracji! Spowoduje to usunięcie całej konfiguracji programu.';
  RS_CLEAR_CONF_WARNING_3 = 'Aby konfiguracja została usunięta - musisz zamknąć aplikację.';
  RS_CLEAR_CONF_WARNING_4 = 'Zgadzasz się na zaznaczenie tej opcji?';
  RS_DELETE_CONFIRMATION_1 = 'Czy na pewno usunąć zaznaczony wpis?';
  RS_DELETE_CONFIRMATION_2 = 'Plik zostanie usunięty, tej operacji nie będzie można cofnąć!';
  RS_DELETE_CONFIRMATION_3 = 'Czy usunąć ten plik?';
  RS_POZDROWIENIA_OFF = 'Wysyłanie pozdrowień wyłączone!';
  RS_ZAMAWIANIE_UTWOROW_OFF = 'Zamawianie utworów wyłączone!';
  RS_WARNING_1 = 'Komendy możesz wysyłać tylko w pokoju głównym.';
  RS_INFO_1 = 'W celu odbanowania użytkownika użyj komendy';
  RS_INFO_2 = 'W celu podejrzenia zbanowanych uzytkowników, użyj:';
  RS_INFO_3 = 'Błąd odczytu ramówki, być może na serwerze zdalnym coś zostało zmienione.';
  RS_INFO_4 = 'Jeśli problem powtarza się, poinformuj autora.';
  RS_INFO_5 = 'Nazwa użytkownika nie została ustawiona!';
  RS_INFO_6 = 'Aby korzystać z chatu należy ustawić nazwę użytkownika i opcjonalnie hasło. Aby to zrobić, wejdź do ustawień programu.';
  RS_INFO_7 = 'Próbujesz usunąć nagranie, które jest używane w Deck-2.';
  RS_INFO_8 = 'Wyjmij taśmę i wtedy będziesz mógł usunąć nagranie.';
  RS_INFO_9 = 'Twoja wiadomość nie została wysłana!';
  RS_INFO_10 = 'Niestety pozdrowienia zostały wyłączone zanim ta wiadomość miała zostać wysłana.';
  RS_INFO_11 = 'Twoje zamówienie nie zostało wysłane!';
  RS_INFO_12 = 'Niestety zamówienia utworów zostały wyłączone zanim to zamówienie mmiało zostać wysłane.';
  RS_INFO_13 = 'W tej chwili nic się nie ściąga.';
  RS_INFO_14 = 'Aktualnie ściągają się poniższe pliki (lub wiszą)';
  RS_INFO_15 = 'Lista dostępnych poleceń programu';
  RS_INFO_16 = 'Lista wszystkich aktualnie się ściągających plików';

resourcestring {dot. ramówki}
  RS_DZIEN = 'Dzień';
  RS_AUDYCJA = 'Audycja';
  RS_PREZENTER = 'Prezenter';
  RS_GODZINA = 'Godzina';
  RS_PONIEDZIALEK = 'Poniedziałek';
  RS_WTOREK = 'Wtorek';
  RS_SRODA = 'Środa';
  RS_CZWARTEK = 'Czwartek';
  RS_PIATEK = 'Piątek';
  RS_SOBOTA = 'Sobota';
  RS_NIEDZIELA = 'Niedziela';

resourcestring {tymczasowe}
  RS_TMP_1 = 'Tu będzie możliwość pocięcia nagrań i kompresji do mp3 w niedalekiej przyszłości.';

type
  { TFDownLoad - DOWNLOAD W WĄTKU }
  TNotifyEventDownloadOnStartStop = procedure(ASender: TObject; aNumber: integer; aPrive: string) of object;
  TNotifyEventDownloadOnBeforeAfter = procedure(ASender: TObject; aUrl: string; aNumber: integer; aPrive: string) of object;
  TFDownload = class(TThread)
  private
    FOnAfterDownload: TNotifyEventDownloadOnBeforeAfter;
    FOnBeforeDownload: TNotifyEventDownloadOnBeforeAfter;
    prive: string;
    watki: integer;
    force_file: string;
    number: integer;
    directory: string;
    FOnStart: TNotifyEventDownloadOnStartStop;
    FOnStop: TNotifyEventDownloadOnStartStop;
    http: TNetSynHTTP;
    url,pobierane_url: string;
    procedure ile_watkow; //sync
    procedure zwieksz_watki; //sync
    procedure pobierz_pozycje; //sync
    procedure przed_pobraniem; //sync
    procedure download;
    procedure po_pobraniu; //sync
  protected
    procedure Starting; //sync
    procedure Execute; override;
    procedure Stopping; //sync
  public
    constructor Create(CreateSuspended: boolean; sDirectory: string; aNumber: integer; aFile, aPrive: string);
    destructor Destroy; override;
    property OnStart: TNotifyEventDownloadOnStartStop read FOnStart write FOnStart;
    property OnStop: TNotifyEventDownloadOnStartStop read FOnStop write FOnStop;
    property OnBeforeDownload: TNotifyEventDownloadOnBeforeAfter read FOnBeforeDownload write FOnBeforeDownload;
    property OnAfterDownload: TNotifyEventDownloadOnBeforeAfter read FOnAfterDownload write FOnAfterDownload;
  end;

  { TAutoResponseDelay }

  TNotifyEventAutoResponseNow = procedure(ASender: TObject; aMessage: string) of object;
  TAutoResponseDelay = class(TThread)
  private
    FOnSendNow: TNotifyEventAutoResponseNow;
    opoznienie: integer;
    message: string;
    procedure wyslij; //sync
  protected
    procedure Execute; override;
  public
    constructor Create(aSleep: integer; aMessage: string);
  published
    property OnSendNow: TNotifyEventAutoResponseNow read FOnSendNow write FOnSendNow;
  end;


  { TFPlayerMultimedia }

  TPlayerMultimediaOnPause = procedure(Sender: TObject; aPaused: boolean) of object;
  TPlayerMultimediaOnStatusGetRequest = procedure(Sender: TObject; var aPosL,aPosR: single) of object;
  TPlayerMultimediaOnStatusSet = procedure(Sender: TObject; aPosL,aPosR: single) of object;
  TPlayerMultimediaOnSetLeds = procedure(Sender: TObject; aIndex: integer; aActive: boolean) of object;
  TPlayerMultimediaOnStatPositionSet = procedure(Sender: TObject; sPos,sMax: string; aPos,aMax: longword) of object;
  TPlayerMultimediaOnTrybOdtwarzaniaRequest = procedure(Sender: TObject; var vTryb: integer) of object;
  TPlayerMultimediaOnVideoStartRequest = procedure(Sender: TObject; aFilename: string) of object;
  TFPlayerMultimedia = class
  private
    FOnLedsSet: TPlayerMultimediaOnSetLeds;
    FOnListUpdateRequest: TNotifyEvent;
    FOnPause: TPlayerMultimediaOnPause;
    FOnPlay: TNotifyEvent;
    FOnShutdownRequest: TNotifyEvent;
    FOnStatSet: TPlayerMultimediaOnStatPositionSet;
    FOnStatusRequest: TPlayerMultimediaOnStatusGetRequest;
    FOnStatusSet: TPlayerMultimediaOnStatusSet;
    FOnStop: TNotifyEvent;
    FOnTrybOdtwarzaniaRequest: TPlayerMultimediaOnTrybOdtwarzaniaRequest;
    FOnVideoStartRequest: TPlayerMultimediaOnVideoStartRequest;
    FOnVideoStopPauseRequest: TNotifyEvent;
    FOnVideoStopReplayRequest: TNotifyEvent;
    FOnVideoStopRequest: TNotifyEvent;
    silnik: TUOSEngine;
    player: TUOSPlayer;
    player0,player1,player2,player3: TUOSPlayer;
    play_index,player_index,pause_index,II: integer;
    force_player: integer;
    mem: TMemoryStream;
    pliki: TStringList;
    play_start,status,status_pos,status_stop: TTimer;
    wycisz1,wycisz2,wycisz3: TTimer;
    zglosnij1,zglosnij2,zglosnij3: TTimer;
    volumes: array[1..4] of double;
    BFilm,film_busy: boolean;
    film_file: string;
    film_stopped: boolean;
    procedure wycisz_timers(Sender: TObject);
    procedure zglosnij_timers(Sender: TObject);
    procedure play_start_timer(Sender: TObject);
    procedure status_timer(Sender: TObject);
    procedure status_timer_onstart(Sender: TObject);
    procedure status_timer_onstop(Sender: TObject);
    procedure status_pos_timer(Sender: TObject);
    procedure status_stop_timer(Sender: TObject);
    function set_force_player: boolean;
    procedure cleaning_for_stop_all;
    function GetLevelPlayer(var l,r: single): boolean;
    procedure PlayersOnAfterStart(Sender: TObject);
    procedure PlayersOnAfterStop(Sender: TObject);
    procedure _LOOP(Sender: TObject);
    procedure _PLAY_STOPPED(Sender: TObject);
    procedure _PLAY_STOPPED_FILM;
    function TestCommandPlayerList(aIndex: integer): boolean;
  protected
  public
    katalog: string;
    LibLoaded: boolean;
    MEMII: integer;
    constructor Create;
    destructor Destroy; override;
    function beep_fx(aSound: integer = -1): boolean;
    function IsPlaying: boolean;
    function IsStopping: boolean;
    procedure video_start;
    procedure video_stop(aForce: boolean = false);
    procedure video_starting;
    procedure video_stoping;
    procedure play(indeks: integer);
    procedure replay(aPlayerIndex: integer);
    procedure stop;
    procedure stop_now;
    procedure pause;
    procedure powtorz_utwor;
    procedure nastepny_utwor(aZPowtorzeniemListy: boolean = false);
    procedure poprzedni_utwor;
    procedure SetVolume(aVolume: double);
    function GetPosition: TTime;
    function GetPosition(var aMax,aPosition: TTime): boolean;
    procedure SeekPlayer(sample: single);
    procedure PlikiClear;
    procedure PlikiAdd(aValue: string);
    procedure PlikiInsert(aIndex: integer; aValue: string);
    procedure PlikiMove(aStartPosition,aDropPosition: integer);
    procedure PlikiDelete(aIndex: integer);
    function PlikiItems: TStrings;
    function GetII: integer;
    procedure SetII(AValue: integer);
    procedure DecII;
    procedure IncII;
    function GetPauseIndex: integer;
    procedure SetPauseIndex(AValue: integer);
    procedure SetPlayIndex(AValue: integer);
    function GetPlayerIndex: integer;
    function GetPlayerLength(aIndex: integer): single;
    procedure SetPlayerIndex(AValue: integer);
    function GetPlayingPlayer: integer;
    function GetPlayingIndex: integer;
    procedure TagInfoStart;
    function TagGet(aFilename: string; var aTag: TIDTag): boolean;
    procedure TagInfoStop;
    function ExtToDialog: string;
  published
    property OnPlay: TNotifyEvent read FOnPlay write FOnPlay;
    property OnPause: TPlayerMultimediaOnPause read FOnPause write FOnPause;
    property OnStop: TNotifyEvent read FOnStop write FOnStop;
    property OnListUpdateRequest: TNotifyEvent read FOnListUpdateRequest write FOnListUpdateRequest;
    property OnStatusRequest: TPlayerMultimediaOnStatusGetRequest read FOnStatusRequest write FOnStatusRequest;
    property OnStatusSet: TPlayerMultimediaOnStatusSet read FOnStatusSet write FOnStatusSet;
    property OnLedsSet: TPlayerMultimediaOnSetLeds read FOnLedsSet write FOnLedsSet;
    property OnStatSet: TPlayerMultimediaOnStatPositionSet read FOnStatSet write FOnStatSet;
    property OnTrybOdtwarzaniaRequest: TPlayerMultimediaOnTrybOdtwarzaniaRequest read FOnTrybOdtwarzaniaRequest write FOnTrybOdtwarzaniaRequest;
    property OnShutdownRequest: TNotifyEvent read FOnShutdownRequest write FOnShutdownRequest;
    property OnVideoStartRequest: TPlayerMultimediaOnVideoStartRequest read FOnVideoStartRequest write FOnVideoStartRequest;
    property OnVideoStopRequest: TNotifyEvent read FOnVideoStopRequest write FOnVideoStopRequest;
    property OnVideoStopPauseRequest: TNotifyEvent read FOnVideoStopPauseRequest write FOnVideoStopPauseRequest;
    property OnVideoStopReplayRequest: TNotifyEvent read FOnVideoStopReplayRequest write FOnVideoStopReplayRequest;
  end;

  TGET_APLET_POLFANU = record
    execute: boolean;
    nick,ip,ipName,bp,country,countryCode,city,isp,osInfo,fingerPrint,proxy: string;
    browserInfo: string;
  end;

const
  GALLERY_SIDE_COUNT = 14;
  ExtMusicCount=5;
  ExtFilmsCount=8;

var
  ExtMusic: array [0..ExtMusicCount-1] of string = ('.wav','.flac','.ogg','.mp2','.mp3');
  ExtFilms: array [0..ExtFilmsCount-1] of string = ('.avi','.mp4','.mkv','.mov','.ogm','.rmvb','.m2ts','webm');
  PlayerMultimedia: TFPlayerMultimedia;
  lista_download: TStringList;
  kolejka_watkow_N1: integer = 0;
  kolejka_watkow: integer = 0;
  serwer_on_error_count: integer = 0;
  client_on_error_count: integer = 0;
  serwer_on: boolean = false;
  client_on: boolean = false;
  serwer_client_count: integer = 0;
  net_open_dialog_active: boolean = false;

var
  _GPG: boolean = false;
  _DEV_CLEAR_CONFIG: boolean = false;
  _DEV: boolean;
  _DEV_CHAT_CREATE: boolean = false;
  _DEV_CHAT_IDENTIFY: string = '';
  _DEV_GNUPG: boolean = false;
  _DEBUG: boolean;
  _DIR_TAP: string;
  _SHUTDOWN_EXEC: boolean = false;
  _RADIO_PLAYING: boolean = false;
  _RADIO_LIST_UPDATE: boolean = false;
  _RADIO_CACHE: integer = 0;
  _RADIO_CACHE_MIN: integer = 0;
  _FILM_CACHE: integer = 0;
  _FILM_CACHE_MIN: integer = 0;
  _VER,_VER2, _VER3: string;
  _CUSTOM_POLFAN: string = '';
  _HIST_MEM_LINES_CODE: integer = 200;
  _CHAT_REGISTER: boolean = false;
  _CHAT_SOUND: integer = 0;
  _CHAT_BOOT_AUTORESPONSE: string;
  _CHAT_FONT_NAME: string;
  _CHAT_FONT_SIZE: integer;
  _CHAT_BACKGROUND_COLOR: integer;
  _PIPELINE_DOWNLOAD: boolean = false; //false = kolejka, true = jednocześnie
  _SHOW_KINO: boolean = false;
  _SHOW_RADIO: boolean = true;
  _SHOW_RECORDER: boolean = false;
  _SHOW_PLAYER: boolean = false;
  _SHOW_CONSOLE: boolean = false;
  _POLFAN_USER: string;
  _POLFAN_PASSW: string;
  _POLFAN_FORCE_ROOM: string;
  _AUTOSTART_PLAYER: boolean = false;
  _SHUTDOWN_MODE: integer;
  _SHUTDOWN_CMD: string = '';
  _VIDEO_FONT_NAME: string;
  _VIDEO_FONT_FACTOR: integer = 1;
  _VIDEO_ALANG_DEFAULT: string = '';
  _VIDEO_SLANG_DEFAULT: string = '';
  _VIDEO_ISO_DEFAULT: integer = 0;
  _VIDEO_FS_DEFAULT: boolean = false;
  _VIDEO_SUBPOS_DEFAULT: integer = 95;
  _VIDEO_SUBSCALE_DEFAULT: integer = 25;
  _VIDEO_MPV: boolean = false;
  _VIDEO_MPV_FORCE: boolean = false;
  _VIDEO_MPV_OSC: boolean = false;
  _FILM_PLAYING: boolean = false;
  _SERVER_ON: boolean = false;

var {flagi wyłączające}
  _OFF_CHAT_SOUND_INFO: boolean = false;
  _OFF_CHAT_IMG: boolean = false;

var {zmienne ograniczające}
  _LISTA_AA: string = '';
  _FINGERPRINT: string = '';
  _GET_APLET_POLFANU: TGET_APLET_POLFANU;

function POFileIsExists(kod: string): boolean;
procedure cAdd(AText: string);

implementation

uses
  ecode, consola, math, LCLType;

function POFileIsExists(kod: string): boolean;
begin
  if kod='pl' then result:=true else result:=FileExists(MyDir('locale/radio-player.'+kod+'.po'));
end;

procedure cAdd(AText: string);
begin
  if FConsola.Showing then FConsola.Add(AText);
end;

{ TAutoResponseDelay }

procedure TAutoResponseDelay.wyslij;
begin
  if Assigned(FOnSendNow) then FOnSendNow(self,message);
end;

procedure TAutoResponseDelay.Execute;
begin
  sleep(opoznienie);
  wyslij;
end;

constructor TAutoResponseDelay.Create(aSleep: integer; aMessage: string);
begin
  inherited Create(true);
  FreeOnTerminate:=True;
  opoznienie:=aSleep;
  message:=aMessage;
end;

{ TFPlayerMultimedia }

procedure TFPlayerMultimedia.wycisz_timers(Sender: TObject);
var
  t: TTimer;
  p: TUOSPlayer;
begin
  t:=TTimer(Sender);
  if t.Tag=1 then p:=player1 else if t.Tag=2 then p:=player2 else p:=player3;
  if p.Volume>0.1 then p.Volume:=p.Volume-0.01 else
  if p.Volume>0.01 then p.Volume:=p.Volume-0.01 else
  if p.Volume>0.001 then p.Volume:=p.Volume-0.001 else
  if p.Volume>0.0001 then p.Volume:=p.Volume-0.0001 else
  if p.Volume>0.00001 then p.Volume:=p.Volume-0.00001 else
  if p.Volume>0.000001 then p.Volume:=p.Volume-0.00001 else
                             p.Volume:=p.Volume-0.000001;
  set_force_player;
  if p.Volume<=0.00000000001 then
  begin
    t.Enabled:=false;
    p.Stop;
    volumes[t.Tag]:=-1;
    if IsStopping then cleaning_for_stop_all;
  end;
end;

procedure TFPlayerMultimedia.zglosnij_timers(Sender: TObject);
var
  t: TTimer;
  p: TUOSPlayer;
begin
  t:=TTimer(Sender);
  if t.Tag=1 then p:=player1 else if t.Tag=2 then p:=player2 else p:=player3;
  p.Volume:=p.Volume+0.01;
  if p.Volume>=1 then zglosnij1.Enabled:=false;
end;

procedure TFPlayerMultimedia.play_start_timer(Sender: TObject);
begin
  play_start.Enabled:=not set_force_player;
end;

procedure TFPlayerMultimedia.status_timer(Sender: TObject);
var
  aPosL,aPosR: single;
  l,r: single;
  ll,rr: single;
begin
  if Assigned(FOnStatusRequest) then FOnStatusRequest(self,aPosL,aPosR);
  if aPosL>0 then aPosL:=aPosL-5;
  if aPosR>0 then aPosR:=aPosR-5;
  if Assigned(FOnStatusSet) then FOnStatusSet(self,aPosL,aPosR);
  if player_index=-1 then exit;
  if player1.Paused or player2.Paused or player3.Paused then exit;
  GetLevelPlayer(ll,rr);
  l:=ll*101;
  r:=rr*101;
  if aPosL<l then aPosL:=aPosL+(l-aPosL)*0.5;
  if aPosR<r then aPosR:=aPosR+(r-aPosR)*0.5;
  if Assigned(FOnStatusSet) then FOnStatusSet(self,aPosL,aPosR);
end;

procedure TFPlayerMultimedia.status_timer_onstart(Sender: TObject);
begin
  if Assigned(FOnLedsSet) then FOnLedsSet(self,4,true);
  status_pos.Enabled:=true;
end;

procedure TFPlayerMultimedia.status_timer_onstop(Sender: TObject);
begin
  if Assigned(FOnLedsSet) then FOnLedsSet(self,4,false);
  status_pos.Enabled:=false;
end;

procedure TFPlayerMultimedia.status_pos_timer(Sender: TObject);
begin
  _LOOP(Sender);
end;

procedure TFPlayerMultimedia.status_stop_timer(Sender: TObject);
begin
  zglosnij1.Enabled:=false;
  zglosnij2.Enabled:=false;
  zglosnij3.Enabled:=false;
  status_stop.Enabled:=false;
  status.Enabled:=false;
end;

function TFPlayerMultimedia.set_force_player: boolean;
var
  g,p1,p2,p3: double;
begin
  result:=false;
  if force_player=0 then exit;
  if MEMII<>-1 then player1.Volume:=0;
  g:=0;
  if player1.Busy then p1:=player1.Volume else p1:=0;
  if player2.Busy then p2:=player2.Volume else p2:=0;
  if player3.Busy then p3:=player3.Volume else p3:=0;
  g:=p1;
  if g<p2 then g:=p2;
  if g<p3 then g:=p3;
  if g<0.4 then
  begin
    case force_player of
      1: player1.Start;
      2: player2.Start;
      3: player3.Start;
      5: video_start;
    end;
    player_index:=force_player;
    force_player:=0;
    if Assigned(FOnPause) then FOnPause(self,true);
    if MEMII>-1 then
    begin
      SeekPlayer(MEMII);
      MEMII:=-1;
      zglosnij1.Enabled:=true;
    end;
    result:=true;
  end;
end;

procedure TFPlayerMultimedia.cleaning_for_stop_all;
begin
  player_index:=-1;
  if Assigned(FOnStop) then FOnStop(self);
  status_stop.Enabled:=true;
end;

function TFPlayerMultimedia.GetLevelPlayer(var l, r: single): boolean;
begin
  result:=true;
  if (player_index=1) and player1.Busy then
  begin
    player1.GetMeter(l,r);
  end else
  if (player_index=2) and player2.Busy then
  begin
    player2.GetMeter(l,r);
  end else
  if (player_index=3) and player3.Busy then
  begin
    player3.GetMeter(l,r);
  end else result:=false;
end;

function TFPlayerMultimedia.GetPosition: TTime;
var
  a: single;
begin
  if (player_index=1) and player1.Busy then a:=player1.PositionTime else
  if (player_index=2) and player2.Busy then a:=player2.PositionTime else
  if (player_index=3) and player3.Busy then a:=player3.PositionTime else a:=-1;
  result:=a;
end;

function TFPlayerMultimedia.GetPosition(var aMax, aPosition: TTime): boolean;
begin
  result:=true;
  if (player_index=1) and player1.Busy then
  begin
    aMax:=player1.GetLengthTime;
    aPosition:=player1.PositionTime;
  end else
  if (player_index=2) and player2.Busy then
  begin
    aMax:=player2.GetLengthTime;
    aPosition:=player2.PositionTime;
  end else
  if (player_index=3) and player3.Busy then
  begin
    aMax:=player3.GetLengthTime;
    aPosition:=player3.PositionTime;
  end else result:=false;
end;

procedure TFPlayerMultimedia.PlayersOnAfterStart(Sender: TObject);
var
  p: TUOSPlayer;
begin
  if film_busy then
  begin
    if Assigned(FOnLedsSet) then FOnLedsSet(self,5,true);
    status_stop.Enabled:=true;
    //status.Enabled:=false;
    exit;
  end;
  status_stop.Enabled:=false;
  status.Enabled:=true;
  if Assigned(FOnLedsSet) then
  begin
    p:=TUOSPlayer(Sender);
    case p.Tag of
      1: FOnLedsSet(self,1,true);
      2: FOnLedsSet(self,2,true);
      3: FOnLedsSet(self,3,true);
    end;
  end;
end;

procedure TFPlayerMultimedia.PlayersOnAfterStop(Sender: TObject);
var
  p: TUOSPlayer;
begin
  if not film_busy then
  begin
    if Assigned(FOnLedsSet) then FOnLedsSet(self,5,false);
    if IsStopping then cleaning_for_stop_all;
  end;
  if Sender=nil then exit;
  if Assigned(FOnLedsSet) then
  begin
    p:=TUOSPlayer(Sender);
    case p.Tag of
      1: FOnLedsSet(self,1,false);
      2: FOnLedsSet(self,2,false);
      3: FOnLedsSet(self,3,false);
    end;
  end;
  if IsStopping then cleaning_for_stop_all;
end;

procedure TFPlayerMultimedia._LOOP(Sender: TObject);
var
  m,p: TTime;
  sPos,sMax: string;
  aPos,aMax: longword;
  bPos,bMax: boolean;
begin
  if IsStopping or bfilm then exit;
  if player1.Paused or player2.Paused or player3.Paused then exit;
  GetPosition(m,p);
  aPos:=TimeToInteger(p);
  aMax:=TimeToInteger(m);
  bPos:=aPos<3600000;
  bMax:=aMax<3600000;
  if bPos then sPos:=FormatDateTime('nn:ss',p) else sPos:=FormatDateTime('h:nn:ss',p);
  if bMax then sMax:=FormatDateTime('nn:ss',m) else sMax:=FormatDateTime('h:nn:ss',m);
  if Assigned(FOnStatSet) then FOnStatSet(self,sPos,sMax,aPos,aMax);
end;

procedure TFPlayerMultimedia._PLAY_STOPPED(Sender: TObject);
var
  i,tryb: integer;
  comp: TUOSPlayer;
begin
  comp:=TUOSPlayer(Sender);
  if Assigned(FOnLedsSet) then case comp.Tag of
    1: FOnLedsSet(self,1,false);
    2: FOnLedsSet(self,2,false);
    3: FOnLedsSet(self,3,false);
  end;
  if comp.Volume=1 then
  begin
    if Assigned(FOnTrybOdtwarzaniaRequest) then FOnTrybOdtwarzaniaRequest(self,tryb) else tryb:=0;
    case tryb of
      0: nastepny_utwor;
      1: powtorz_utwor;
      2: nastepny_utwor(true);
    end;
  end;
  if IsStopping then
  begin
    cleaning_for_stop_all;
    if Assigned(FOnPause) then FOnPause(self,false);
  end else if Assigned(FOnPause) then FOnPause(self,true);
end;

procedure TFPlayerMultimedia._PLAY_STOPPED_FILM;
var
  tryb: integer;
begin
  if (not film_stopped) then
  begin
    if Assigned(FOnTrybOdtwarzaniaRequest) then FOnTrybOdtwarzaniaRequest(self,tryb) else tryb:=0;
    case tryb of
      0: nastepny_utwor;
      1: powtorz_utwor;
      2: nastepny_utwor(true);
    end;
  end;
  if IsStopping then
  begin
    cleaning_for_stop_all;
    if Assigned(FOnPause) then FOnPause(self,false);
  end else if Assigned(FOnPause) then FOnPause(self,true);
end;

function TFPlayerMultimedia.TestCommandPlayerList(aIndex: integer): boolean;
begin
  result:=false;
  if (aIndex<0) or (aIndex>pliki.Count-1) then exit;
  if pliki[aIndex]='[stop]' then
  begin
    result:=true;
    stop;
  end;
  if pliki[aIndex]='[shutdown]' then
  begin
    result:=true;
    stop;
    if Assigned(FOnShutdownRequest) then FOnShutdownRequest(self);
  end;
end;

function TFPlayerMultimedia.GetII: integer;
begin
  result:=II;
end;

procedure TFPlayerMultimedia.SetII(AValue: integer);
begin
  II:=AValue;
end;

procedure TFPlayerMultimedia.DecII;
begin
  dec(II);
  dec(play_index);
end;

procedure TFPlayerMultimedia.IncII;
begin
  inc(II);
  inc(play_index);
end;

function TFPlayerMultimedia.GetPauseIndex: integer;
begin
  result:=pause_index;
end;

procedure TFPlayerMultimedia.SetPauseIndex(AValue: integer);
begin
  pause_index:=AValue;
end;

procedure TFPlayerMultimedia.SetPlayIndex(AValue: integer);
begin
  play_index:=AValue;
end;

function TFPlayerMultimedia.GetPlayerIndex: integer;
begin
  result:=player_index;
end;

function TFPlayerMultimedia.GetPlayerLength(aIndex: integer): single;
begin
  case aIndex of
    1: result:=player1.GetLengthSeconds;
    2: result:=player2.GetLengthSeconds;
    3: result:=player3.GetLengthSeconds;
  end;
end;

procedure TFPlayerMultimedia.SetPlayerIndex(AValue: integer);
begin
  player_index:=AValue;
end;

function TFPlayerMultimedia.GetPlayingPlayer: integer;
begin
  if (player1.Busy and (player1.Volume=1))
  or (player2.Busy and (player2.Volume=1))
  or (player3.Busy and (player3.Volume=1))
  then result:=play_index
  else result:=-1;
end;

function TFPlayerMultimedia.GetPlayingIndex: integer;
var
  a: integer;
begin
  a:=GetPlayingPlayer;
  if a=-1 then result:=-1 else result:=II;
end;

procedure TFPlayerMultimedia.TagInfoStart;
begin
  player0.Start;
end;

function TFPlayerMultimedia.TagGet(aFilename: string; var aTag: TIDTag
  ): boolean;
begin
  result:=player0.GetTag(aFilename,aTag);
end;

procedure TFPlayerMultimedia.TagInfoStop;
begin
  player0.Stop;
end;

function TFPlayerMultimedia.ExtToDialog: string;
var
  i: integer;
  s: string;
begin
  s:='Pliki muzyczne|';
  for i:=0 to ExtMusicCount-1 do if i=0 then s:=s+'*'+ExtMusic[i] else s:=s+';*'+ExtMusic[i];
  s:=s+'|Pliki filmowe|';
  for i:=0 to ExtFilmsCount-1 do if i=0 then s:=s+'*'+ExtFilms[i] else s:=s+';*'+ExtFilms[i];
  s:=s+'|Wszystkie pliki|*.*';
  result:=s;
end;

constructor TFPlayerMultimedia.Create;
begin
  BFilm:=false;
  film_busy:=false;
  mem:=TMemoryStream.Create;
  pliki:=TStringList.Create;
  play_start:=TTimer.Create(nil);
  play_start.Enabled:=true;
  play_start.Interval:=100;
  play_start.OnTimer:=@play_start_timer;
  status:=TTimer.Create(nil);
  status.Enabled:=false;
  status.Interval:=100;
  status.OnTimer:=@status_timer;
  status.OnStartTimer:=@status_timer_onstart;
  status.OnStopTimer:=@status_timer_onstop;
  status_pos:=TTimer.Create(nil);
  status_pos.Enabled:=false;
  status_pos.Interval:=250;
  status_pos.OnTimer:=@status_pos_timer;
  status_stop:=TTimer.Create(nil);
  status_stop.Enabled:=false;
  status_stop.Interval:=3000;
  status_stop.OnTimer:=@status_stop_timer;

  wycisz1:=TTimer.Create(nil);
  wycisz2:=TTimer.Create(nil);
  wycisz3:=TTimer.Create(nil);
  wycisz1.Enabled:=false;
  wycisz2.Enabled:=false;
  wycisz3.Enabled:=false;
  wycisz1.Interval:=30;
  wycisz2.Interval:=30;
  wycisz3.Interval:=30;
  wycisz1.Tag:=1;
  wycisz2.Tag:=2;
  wycisz3.Tag:=3;
  wycisz1.OnTimer:=@wycisz_timers;
  wycisz2.OnTimer:=@wycisz_timers;
  wycisz3.OnTimer:=@wycisz_timers;
  zglosnij1:=TTimer.Create(nil);
  zglosnij2:=TTimer.Create(nil);
  zglosnij3:=TTimer.Create(nil);
  zglosnij1.Enabled:=false;
  zglosnij2.Enabled:=false;
  zglosnij3.Enabled:=false;
  zglosnij1.Interval:=10;
  zglosnij2.Interval:=10;
  zglosnij3.Interval:=10;
  zglosnij1.Tag:=1;
  zglosnij2.Tag:=2;
  zglosnij3.Tag:=3;
  zglosnij1.OnTimer:=@zglosnij_timers;
  zglosnij2.OnTimer:=@zglosnij_timers;
  zglosnij3.OnTimer:=@zglosnij_timers;

  silnik:=TUOSEngine.Create(nil);
  silnik.DriversLoad:=[dlPortAudio,dlSndAudio,dlMpg123,dlMp4ff,dlFaad,dlOpus];
  silnik.LibDirectory:=MyDir+_FF+'uos';
  LibLoaded:=silnik.LoadLibrary;
  player:=TUOSPlayer.Create(nil);
  player.DeviceEngine:=silnik;
  player.DeviceIndex:=0;
  player.Mode:=moPlay;
  player.Volume:=1;

  player0:=TUOSPlayer.Create(nil);
  player0.DeviceEngine:=silnik;
  player0.DeviceIndex:=5;
  player0.Mode:=moInfo;
  player0.Volume:=0;

  player1:=TUOSPlayer.Create(nil);
  player1.DeviceEngine:=silnik;
  player1.DeviceIndex:=1;
  player1.Mode:=moPlay;
  player1.Volume:=0;
  player1.CalcLoop:=false;
  player1.CalcMeter:=true;
  player1.CalcPosition:=true;
  player1.Tag:=1;
  player2:=TUOSPlayer.Create(nil);
  player2.DeviceEngine:=silnik;
  player2.DeviceIndex:=2;
  player2.Mode:=moPlay;
  player2.Volume:=0;
  player2.CalcLoop:=false;
  player2.CalcMeter:=true;
  player2.CalcPosition:=true;
  player2.Tag:=2;
  player3:=TUOSPlayer.Create(nil);
  player3.DeviceEngine:=silnik;
  player3.DeviceIndex:=3;
  player3.Mode:=moPlay;
  player3.Volume:=0;
  player3.CalcLoop:=false;
  player3.CalcMeter:=true;
  player3.CalcPosition:=true;
  player3.Tag:=3;

  player1.AfterStart:=@PlayersOnAfterStart;
  player2.AfterStart:=@PlayersOnAfterStart;
  player3.AfterStart:=@PlayersOnAfterStart;
  player1.AfterStop:=@PlayersOnAfterStop;
  player2.AfterStop:=@PlayersOnAfterStop;
  player3.AfterStop:=@PlayersOnAfterStop;
  player1.OnLoop:=@_LOOP;
  player2.OnLoop:=@_LOOP;
  player3.OnLoop:=@_LOOP;
  player1.OnStop:=@_PLAY_STOPPED;
  player2.OnStop:=@_PLAY_STOPPED;
  player3.OnStop:=@_PLAY_STOPPED;

  II:=-1;
  MEMII:=-1;
  play_index:=-1;
  player_index:=-1;
  force_player:=0;
  volumes[1]:=-1;
  volumes[2]:=-1;
  volumes[3]:=-1;
  volumes[4]:=-1;
  pause_index:=-1;

end;

destructor TFPlayerMultimedia.Destroy;
begin
  wycisz1.Enabled:=false;
  wycisz2.Enabled:=false;
  wycisz3.Enabled:=false;
  zglosnij1.Enabled:=false;
  zglosnij2.Enabled:=false;
  zglosnij3.Enabled:=false;
  player1.Stop;
  player2.Stop;
  player3.Stop;
  if film_busy then video_stop;

  silnik.UnLoadLibrary;
  player.Free;
  player0.Free;
  player1.Free;
  player2.Free;
  player3.Free;
  silnik.Free;
  //mem.Free; //mem jest usuwane przez UOS gdy sam się kończy...
  pliki.Free;
  play_start.Free;
  status.Free;
  status_pos.Free;
  status_stop.Free;
  wycisz1.Free;
  wycisz2.Free;
  wycisz3.Free;
  zglosnij1.Free;
  zglosnij2.Free;
  zglosnij3.Free;
  inherited Destroy;
end;

function TFPlayerMultimedia.beep_fx(aSound: integer): boolean;
var
  res: TResourceStream;
  s: string;
begin
  result:=false;
  if _OFF_CHAT_SOUND_INFO then exit;
  if not LibLoaded then exit;
  if player.Busy then player.Stop;
  if aSound=-1 then s:='SOUND'+IntToStr(_CHAT_SOUND) else s:='SOUND'+IntToStr(aSound);
  mem:=TMemoryStream.Create;
  try
    res:=TResourceStream.Create(hInstance,s,RT_RCDATA);
    mem.LoadFromStream(res);
  finally
    res.Free;
  end;
  player.Start(mem); //TU SIĘ POTRAFI WYWALIĆ JAK SYSTEM MA KŁOPOT Z OBSŁUGĄ DANEGO FORMATU :))
  result:=true;
end;

function TFPlayerMultimedia.IsPlaying: boolean;
begin
  result:=player1.Busy or player2.Busy or player3.Busy or film_busy;
end;

function TFPlayerMultimedia.IsStopping: boolean;
begin
  result:=not IsPlaying;
end;

procedure TFPlayerMultimedia.video_start;
begin
  film_stopped:=false;
  if Assigned(FOnVideoStartRequest) then FOnVideoStartRequest(self,film_file);
end;

procedure TFPlayerMultimedia.video_stop(aForce: boolean);
begin
  if aForce then film_stopped:=aForce;
  if Assigned(FOnVideoStopRequest) then FOnVideoStopRequest(self);
end;

procedure TFPlayerMultimedia.video_starting;
begin
  film_busy:=true;
  PlayersOnAfterStart(nil);
end;

procedure TFPlayerMultimedia.video_stoping;
begin
  film_busy:=false;
  PlayersOnAfterStop(nil);
  II:=-1;
  if Assigned(FOnListUpdateRequest) then FOnListUpdateRequest(self);
  _PLAY_STOPPED_FILM;
end;

procedure TFPlayerMultimedia.play(indeks: integer);
var
  plik,ext: string;
  yt: boolean;
begin
  if BFilm then video_stop;
  BFilm:=false;
  plik:=pliki[indeks];
  yt:=pos('https://',plik)>0;
  if not yt then ext:=upcase(ExtractFileExt(plik));
  if yt or (ext='.AVI') or (ext='.MP4') or (ext='.MKV') or (ext='.MOV') or (ext='.OGM') or (ext='.RMVB') or (ext='.M2TS') or (ext='.WEBM') then
  begin
    _VIDEO_MPV_FORCE:=yt;
    {żądanie uruchomienia filmu}
    film_file:=plik;
    BFilm:=true;
    force_player:=5;
    II:=indeks;
  end else
  if not player1.Busy then
  begin
    player1.FileName:=plik;
    player1.Volume:=1;
    force_player:=1;
  end else if not player2.Busy then
  begin
    player2.FileName:=plik;
    player2.Volume:=1;
    force_player:=2;
  end else if not player3.Busy then
  begin
    player3.FileName:=plik;
    player3.Volume:=1;
    force_player:=3;
  end;
  if player1.Busy then wycisz1.Enabled:=true;
  if player2.Busy then wycisz2.Enabled:=true;
  if player3.Busy then wycisz3.Enabled:=true;
  if film_busy then video_stop;
  if (not wycisz1.Enabled) and (not wycisz2.Enabled) and (not wycisz3.Enabled) then play_start.Enabled:=true;
  II:=indeks;
  if Assigned(FOnListUpdateRequest) then FOnListUpdateRequest(self);
end;

procedure TFPlayerMultimedia.replay(aPlayerIndex: integer);
begin
  case aPlayerIndex of
    1: player1.Replay;
    2: player2.Replay;
    3: player3.Replay;
    5: if Assigned(FOnVideoStopReplayRequest) then FOnVideoStopReplayRequest(self);
  end;
end;

procedure TFPlayerMultimedia.stop;
begin
  if bfilm then
  begin
    bfilm:=false;
    video_stop(true);
  end;
  if player1.Busy then wycisz1.Enabled:=true;
  if player2.Busy then wycisz2.Enabled:=true;
  if player3.Busy then wycisz3.Enabled:=true;
  II:=-1;
  if Assigned(FOnListUpdateRequest) then FOnListUpdateRequest(self);
end;

procedure TFPlayerMultimedia.stop_now;
var
  p: TUOSPlayer;
  i: integer;
begin
  II:=-1;
  if bfilm then
  begin
    video_stop(true);
    exit;
  end;
  i:=player_index;
  if i=-1 then i:=pause_index;
  if i=-1 then exit;
  if Assigned(FOnListUpdateRequest) then FOnListUpdateRequest(self);
  case i of
    1: begin player1.Volume:=0; player1.Stop; volumes[1]:=-1; end;
    2: begin player2.Volume:=0; player2.Stop; volumes[2]:=-1; end;
    3: begin player3.Volume:=0; player3.Stop; volumes[3]:=-1; end;
  end;
  if IsStopping then cleaning_for_stop_all;
end;

procedure TFPlayerMultimedia.pause;
begin
  case player_index of
    1: player1.Pause;
    2: player2.Pause;
    3: player3.Pause;
    5: if Assigned(FOnVideoStopPauseRequest) then FOnVideoStopPauseRequest(self);
  end;
  pause_index:=player_index;
  player_index:=-1;
  if Assigned(FOnPause) then FOnPause(self,false);
end;

procedure TFPlayerMultimedia.powtorz_utwor;
var
  i: integer;
begin
  i:=play_index;
  if (i>-1) and (i<pliki.Count) then play(i) else stop;
end;

procedure TFPlayerMultimedia.nastepny_utwor(aZPowtorzeniemListy: boolean);
var
  i: integer;
begin
  i:=play_index;
  inc(i);
  if TestCommandPlayerList(i) then exit;
  if (i>-1) and (i<pliki.Count) then play(i) else if aZPowtorzeniemListy then play(0) else stop;
end;

procedure TFPlayerMultimedia.poprzedni_utwor;
var
  i: integer;
begin
  i:=play_index;
  if i=0 then exit;
  dec(i);
  if TestCommandPlayerList(i) then exit;
  if i>-1 then play(i) else stop;
end;

procedure TFPlayerMultimedia.SetVolume(aVolume: double);
begin
  player1.VolumeGlobal:=aVolume;
  player2.VolumeGlobal:=aVolume;
  player3.VolumeGlobal:=aVolume;
end;

procedure TFPlayerMultimedia.SeekPlayer(sample: single);
begin
  case player_index of
    1: player1.SeekSeconds(sample);
    2: player2.SeekSeconds(sample);
    3: player3.SeekSeconds(sample);
  end;
end;

procedure TFPlayerMultimedia.PlikiClear;
begin
  pliki.Clear;
end;

procedure TFPlayerMultimedia.PlikiAdd(aValue: string);
begin
  pliki.Add(aValue);
end;

procedure TFPlayerMultimedia.PlikiInsert(aIndex: integer; aValue: string);
begin
  pliki.Insert(aIndex,aValue);
end;

procedure TFPlayerMultimedia.PlikiMove(aStartPosition, aDropPosition: integer);
begin
  pliki.Move(aStartPosition,aDropPosition);
end;

procedure TFPlayerMultimedia.PlikiDelete(aIndex: integer);
begin
  pliki.Delete(aIndex);
end;

function TFPlayerMultimedia.PlikiItems: TStrings;
begin
  result:=pliki;
end;

{ TFDownload }

procedure TFDownload.ile_watkow;
begin
  if number=1 then watki:=kolejka_watkow_N1 else watki:=kolejka_watkow;
end;

procedure TFDownload.zwieksz_watki;
begin
  if number=1 then inc(kolejka_watkow_N1) else inc(kolejka_watkow);
end;

procedure TFDownload.pobierz_pozycje;
begin
  if terminated then exit;
  if lista_download.Count>0 then
  begin
    url:=lista_download[0];
    lista_download.Delete(0);
  end else url:='';
end;

procedure TFDownload.przed_pobraniem;
begin
  if Assigned(FOnBeforeDownload) then
  begin
    FOnBeforeDownload(self,url,number,prive);
    sleep(20);
  end;
end;

procedure TFDownload.download;
var
  stream: TMemoryStream;
  s: string;
  a: integer;
  b: boolean;
begin
  if terminated then exit;
  b:=false;
  if pos('http:',url)>0 then
  begin
    s:=url;
    while true do
    begin
      a:=pos('/',url);
      if a=0 then break;
      delete(url,1,a);
    end;
    url:='img'+_FF+url;
    b:=true;
  end;
  if FileExists(directory+_FF+url) then exit;
  stream:=TMemoryStream.Create;
  try
    if b then pobierane_url:=s else pobierane_url:='http://polfan.pl/'+url;
    synchronize(@przed_pobraniem);
    http.GetBinary(pobierane_url,stream);
    synchronize(@po_pobraniu);
    stream.SaveToFile(directory+_FF+url);
  finally
    stream.Free;
  end;
end;

procedure TFDownload.po_pobraniu;
begin
  if Assigned(FOnAfterDownload) then
  begin
    sleep(20);
    FOnAfterDownload(self,url,number,prive);
  end;
end;

procedure TFDownload.Starting;
begin
  watki:=-1;
  if Assigned(FOnStart) then FOnStart(self,number,prive);
end;

procedure TFDownload.Execute;
begin
  sleep(200);
  synchronize(@Starting);
  if number>0 then while true do
  begin
    synchronize(@ile_watkow);
    if (_PIPELINE_DOWNLOAD and (watki<40)) or ((not _PIPELINE_DOWNLOAD) and (watki<5)) then break;
    sleep(200);
  end;
  if number>0 then synchronize(@zwieksz_watki);
  while not terminated do
  begin
    sleep(200);
    if number=0 then synchronize(@pobierz_pozycje) else url:=force_file;
    sleep(200);
    if url='' then break else download;
    if number>0 then break;
  end;
  sleep(200);
  synchronize(@Stopping);
end;

procedure TFDownload.Stopping;
begin
  if number=1 then dec(kolejka_watkow_N1) else if number>1 then dec(kolejka_watkow);
  if Assigned(FOnStop) then FOnStop(self,number,prive);
end;

constructor TFDownload.Create(CreateSuspended: boolean; sDirectory: string;
  aNumber: integer; aFile, aPrive: string);
begin
  inherited Create(CreateSuspended);
  FreeOnTerminate:=True;
  http:=TNetSynHTTP.Create(nil);
  number:=aNumber;
  directory:=sDirectory;
  if aNumber>0 then force_file:=aFile;
  url:='';
  prive:=aPrive;
end;

destructor TFDownload.Destroy;
begin
  http.Free;
  inherited Destroy;
end;

initialization
  _GET_APLET_POLFANU.execute:=true;
  lista_download:=TStringList.Create;
  {$IFDEF UNIX}
  _DEV_GNUPG:=true;
  {$ENDIF}
finalization
  lista_download.Free;
end.

