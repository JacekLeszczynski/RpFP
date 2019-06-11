unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, ComCtrls, Menus, XMLPropStorage, ueled, uETilePanel, GifAnim,
  BGRAKnob, TplProgressBarUnit, rxctrls, A3nalogGauge, MPlayerCtrl, ExtMessage,
  NetSynHTTP, ExtShutdown, DirectoryPack, LResources, Types, lNet,
  UOSPlayer, NetSocket;

type

  { TFMain }

  TFMain = class(TForm)
    A3nalogGauge1: TA3nalogGauge;
    A3nalogGauge2: TA3nalogGauge;
    audycja: TLabel;
    dir: TDirectoryPack;
    Label1: TLabel;
    Label2: TLabel;
    led_server: TuELED;
    ledF: TuELED;
    list1: TListBox;
    MenuItem9: TMenuItem;
    tcp: TNetSocket;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    film: TMPlayerControl;
    N1: TMenuItem;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel8: TPanel;
    pstop: TSpeedButton;
    pprior: TSpeedButton;
    ppause: TSpeedButton;
    pplay: TSpeedButton;
    PlayerOptTryb: TSpeedButton;
    pnext: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton13: TSpeedButton;
    stat_position: TplProgressBar;
    PopupListPlayerMenu: TPopupMenu;
    SpeedButton11: TSpeedButton;
    shutdown: TExtShutdown;
    led_radio: TuELED;
    ButtonFS: TSpeedButton;
    SpeedButton15: TSpeedButton;
    SpeedButton16: TSpeedButton;
    timer_film_off: TTimer;
    timer_shutdown: TTimer;
    timer_upd_volume_film: TTimer;
    uETilePanel3: TuETilePanel;
    uETilePanel00: TuETilePanel;
    ustawienia: TSpeedButton;
    VolumeRadio: TBGRAKnob;
    LogoTitle: TRxLabel;
    ComboBox1: TComboBox;
    czas: TLabel;
    deck1: TLabel;
    deck2: TLabel;
    html_post: TNetSynHTTP;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    kaseta1: TGifAnim;
    kaseta2: TGifAnim;
    Label9: TLabel;
    led1: TuELED;
    led2: TuELED;
    led3: TuELED;
    led4: TuELED;
    led_play: TuELED;
    led_play2: TuELED;
    led_rec: TuELED;
    ListBox1: TListBox;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    mess: TExtMessage;
    ImageList1: TImageList;
    MenuStacje: TPopupMenu;
    html: TNetSynHTTP;
    OpenDialogMuzyka: TOpenDialog;
    Panel2: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    play: TSpeedButton;
    play_play: TSpeedButton;
    play_stop: TSpeedButton;
    prezenter: TLabel;
    rec: TSpeedButton;
    rec_eject: TSpeedButton;
    rec_play: TSpeedButton;
    rec_stop: TSpeedButton;
    Shape1: TShape;
    Shape2: TShape;
    MenuItem1: TMenuItem;
    player: TMPlayerControl;
    player2: TMPlayerControl;
    MenuTrayIcon: TPopupMenu;
    radio: TMPlayerControl;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    status: TLabel;
    stop: TSpeedButton;
    timer_restore_icy: TTimer;
    timer_czas: TTimer;
    TrayIcon1: TTrayIcon;
    uETilePanel1: TuETilePanel;
    Panel1: TPanel;
    autorun: TTimer;
    PropStorage: TXMLPropStorage;
    uETilePanel2: TuETilePanel;
    uETilePanel0: TuETilePanel;
    uETilePanelTitle: TuETilePanel;
    url: TLabel;
    utwor: TLabel;
    VolumePlayer: TBGRAKnob;
    procedure autorunTimer(Sender: TObject);
    procedure dirPackRecord(Sender: TObject; APackRecord, ASignature: string);
    procedure filmBeforePlay(ASender: TObject; AFilename: string);
    procedure filmPlay(Sender: TObject);
    procedure filmPlaying(ASender: TObject; APosition: single);
    procedure filmStop(Sender: TObject);
    procedure filmTimerDump(ASender: TObject; AText: String);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure list1DrawItem(Control: TWinControl; Index: Integer; ARect: TRect;
      State: TOwnerDrawState);
    procedure list1SelectionChange(Sender: TObject; User: boolean);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure ButtonFSClick(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure player2TimerDump(ASender: TObject; AText: String);
    procedure playerTimerDump(ASender: TObject; AText: String);
    procedure radioTimerDump(ASender: TObject; AText: String);
    procedure shutdownBeforeShutdown(Sender: TObject);
    procedure SpeedButton13Click(Sender: TObject);
    procedure tcpCryptString(var aText: string);
    procedure tcpDecryptString(var aText: string);
    procedure tcpError(const aMsg: string; aSocket: TLSocket);
    procedure tcpReceiveString(aMsg: string; aSocket: TLSocket);
    procedure tcpStatus(aActive, aCrypt: boolean);
    procedure timer_film_offTimer(Sender: TObject);
    procedure timer_shutdownTimer(Sender: TObject);
    procedure timer_upd_volume_filmTimer(Sender: TObject);
    procedure VolumeRadioValueChanged(Sender: TObject; Value: single);
    procedure stat_positionMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure VolumePlayerValueChanged(Sender: TObject; Value: single);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure list1DblClick(Sender: TObject);
    procedure list1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure list1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure list1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure list1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListBox1DblClick(Sender: TObject);
    procedure ListBox1SelectionChange(Sender: TObject; User: boolean);
    procedure MenuItem1Click(Sender: TObject);
    procedure playClick(Sender: TObject);
    procedure player2Play(Sender: TObject);
    procedure player2Stop(Sender: TObject);
    procedure playerPlay(Sender: TObject);
    procedure pnextClick(Sender: TObject);
    procedure ppauseClick(Sender: TObject);
    procedure pplayClick(Sender: TObject);
    procedure ppriorClick(Sender: TObject);
    procedure pstopClick(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
    procedure SpeedButton12Click(Sender: TObject);
    procedure PlayerOptTrybClick(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure ustawieniaClick(Sender: TObject);
    procedure timer_restore_icyTimer(Sender: TObject);
    procedure _PLAY_TIMER(ASender: TObject; APosition: single);
    procedure playerStop(Sender: TObject);
    procedure play_playClick(Sender: TObject);
    procedure play_stopClick(Sender: TObject);
    procedure PropStorageRestoreProperties(Sender: TObject);
    procedure PropStorageSaveProperties(Sender: TObject);
    procedure rec_ejectClick(Sender: TObject);
    procedure rec_stopClick(Sender: TObject);
    procedure radioCapture(ASender: TObject; ACapture: boolean);
    procedure radioICYRadio(ASender: TObject; AName, AGenre, AWebsite: string;
      APublic: boolean; ABitrate, AStreamTitle, AStreamURL: string);
    procedure radioPlay(Sender: TObject);
    procedure radioStop(Sender: TObject);
    procedure recClick(Sender: TObject);
    procedure rec_playClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure stopClick(Sender: TObject);
    procedure timer_czasTimer(Sender: TObject);
  private
    stacje_adresy,stacje_pokoje: TStringList;
    __FULL_SCREEN: boolean;
    __x,__y,__w,__h: integer;
    procedure init_stacje;
    procedure init_preferences;
    procedure init_nagrania;
    function SendToAll(aAdres: string; aRodzaj,aKod: integer; const aWartosc: string = ''): boolean;
    function SendToAll(aAdres: string; aRodzaj,aKod: integer; const aWartosc: integer): boolean;
    function CzyToJestFilm(aIndex: integer): boolean;
    function CzyToJestFilm(aFilename: string): boolean;
    function DodajPlikDoPlaylisty(aFilename: string; t: UOSPlayer.TIDTag): string;
    procedure RamkaToPlaylista(aRamka: string);
    function RemoveFile(aFile: TFilename): boolean;
    procedure przyciski;
    procedure przyciski_radia_update;
    procedure wczytaj_dumpu_play;
    function DumpForListToFilename(aIndex: integer): string;
    procedure add_track_to_cue;
    function wersja(zapytanie: integer = 3): string;
    procedure load_cue(filename: string);
    procedure unload_cue;
    function GetVolumeRadio(aValue: single = -1): integer;
    procedure ShutdownNow(Sender: TObject);
    procedure VideoPlayRequest(Sender: TObject; aFilename: string);
    procedure VideoStopRequest(Sender: TObject);
    procedure VideoPauseRequest(Sender: TObject);
    procedure VideoReplayRequest(Sender: TObject);
    procedure Kino(aON: boolean = false);
    procedure FilmFullScreen(aOn: boolean);
    procedure SetPositionFromX(AMouseX,AMouseMax: integer);
    { Eventy }
    procedure OnTrybOdtwarzaniaRequest(Sender: TObject; var aTryb: integer);
    procedure OnPlayerPlay(Sender: TObject);
    procedure OnPlayerStop(Sender: TObject);
    procedure OnPlayerPause(Sender: TObject; aPaused: boolean);
    procedure OnPlayerListUpdateRequest(Sender: TObject);
    procedure OnPlayerStatusRequest(Sender: TObject; var aPosL,aPosR: single);
    procedure OnPlayerStatusSet(Sender: TObject; aPosL,aPosR: single);
    procedure OnPlayerLedsSet(Sender: TObject; aIndex: integer; aActive: boolean);
    procedure OnPlayerStatPositionSet(Sender: TObject; sPos,sMax: string; aPos,aMax: longword);
  public

  end;

var
  FMain: TFMain;

implementation

uses
  {$IFDEF WINDOWS}windows,{$ENDIF}
  config, ecode, lconvencoding, datamodule, cverinfo, ustawienia, consola,
  pozdrowienia, ramowka, zamowutwor, chat, ValEdit,
  unit_exit, fileconf, LCLType;

type
  TKaseta = record
    czas_nagrania: TDateTime;
    radio: string;
    index: integer;
  end;
  TCueDat = record
    tracks: integer;
    czas: integer;
  end;
  TCue = record
    performer,title,filename,typ: string;
    count: integer;
  end;
  TCueTrack = record
    track: integer;
    title, performer: string;
    start: integer;
  end;

const
  FLAGA_DECK = '[REC]';
  LINK_MPLAYERS_ENGINE = 'https://sourceforge.net/projects/paczki-do-moich-program-w/files/mplayer.zip/download';

var
  AUTOSTART: boolean = true;
  RADIO_FORCE_PLAY: boolean = false;
  {$IFDEF MSWINDOWS}
  BASE_DIRECTORY: string;
  {$ENDIF}

var
  IsDumpFile: boolean = false;
  wektor_czasu,wektor_czasu_start,start_odtwarzania: integer;
  czas_aktualny,czas_nastepny: integer;
  duration: integer;
  swiatlo: TColor = 0;
  kaseta: TKaseta;
  ff: textfile;
  ff_track: integer;
  ff_czas: integer;
  ff2: file of TCueDat;
  cue: TCue;
  tracks: array of TCueTrack;

var
  icy_mem: record
    prezenter,audycja,utwor,url: string;
  end;

{$R *.lfm}

{$IFDEF WINDOWS}
function ListaNapedow: string;
var
  i,r: integer;
  s: string;
begin
  s:='';
  for i:=ord('A') to ord('Z') do
  begin
    r:=GetDriveType(pchar(chr(i)+':\'));
    if (r<>0) and (r<>1) and (r<>DRIVE_REMOTE) then if s='' then s:=chr(i) else s:=s+','+chr(i);
  end;
  result:=s;
end;
{$ENDIF}

{ TFMain }

procedure TFMain.FormCreate(Sender: TObject);
begin
  stacje_adresy:=TStringList.Create;
  stacje_pokoje:=TStringList.Create;
  kaseta1.LoadFromLazarusResource('kaseta');
  kaseta2.LoadFromLazarusResource('kaseta');
  SetConfDir('radio_player_40_plus');
  if not FileExists(MyConfDir('config.xml')) then position:=poScreenCenter;
  if not DirectoryExists(MyConfDir('img')) then mkdir(MyConfDir('img'));
  if not DirectoryExists(MyConfDir('tap')) then mkdir(MyConfDir('tap'));
  _DIR_TAP:=MyConfDir('tap');
  PropStorage.FileName:=MyConfDir('config.xml');
  PropStorage.Active:=true;
  _VER:=wersja;
  _VER2:=wersja(2);
  _VER3:=wersja(3);
  FMain.Caption:='RpFP (ver. '+_VER+')';
  FMain.Height:=Panel1.Height;
  status.Caption:='';
  deck1.Caption:='';
  deck2.Caption:='';
  prezenter.Caption:='';
  audycja.Caption:='';
  utwor.Caption:='';
  url.Caption:='';
  __FULL_SCREEN:=false;

  { Dot. dźwięku UOS i playerów }
  PlayerMultimedia:=TFPlayerMultimedia.Create;
  PlayerMultimedia.OnTrybOdtwarzaniaRequest:=@OnTrybOdtwarzaniaRequest;
  PlayerMultimedia.OnPlay:=@OnPlayerPlay;
  PlayerMultimedia.OnStop:=@OnPlayerStop;
  PlayerMultimedia.OnPause:=@OnPlayerPause;
  PlayerMultimedia.OnListUpdateRequest:=@OnPlayerListUpdateRequest;
  PlayerMultimedia.OnStatusRequest:=@OnPlayerStatusRequest;
  PlayerMultimedia.OnStatusSet:=@OnPlayerStatusSet;
  PlayerMultimedia.OnLedsSet:=@OnPlayerLedsSet;
  PlayerMultimedia.OnStatSet:=@OnPlayerStatPositionSet;
  PlayerMultimedia.OnShutdownRequest:=@ShutdownNow;
  PlayerMultimedia.OnVideoStartRequest:=@VideoPlayRequest;
  PlayerMultimedia.OnVideoStopRequest:=@VideoStopRequest;
  PlayerMultimedia.OnVideoStopPauseRequest:=@VideoPauseRequest;
  PlayerMultimedia.OnVideoStopReplayRequest:=@VideoReplayRequest;
  OpenDialogMuzyka.Filter:=PlayerMultimedia.ExtToDialog;

  autorun.Enabled:=true;
end;

procedure TFMain.FormDestroy(Sender: TObject);
begin
  if _DEV_CHAT_CREATE then FChat.Free;
  radio.Stop;
  player.Stop;
  player2.Stop;
  PlayerMultimedia.stop;
  stacje_adresy.Free;
  stacje_pokoje.Free;
  PlayerMultimedia.Free;
  if _DEV_CLEAR_CONFIG then if FileExists(MyConfDir('config.xml')) then
  RemoveFile(MyConfDir('config.xml'));
  if _SHUTDOWN_EXEC then shutdown.execute;
end;

procedure TFMain.FormShow(Sender: TObject);
begin
  if AUTOSTART then
  begin
    AUTOSTART:=false;
    PlayerMultimedia.SetVolume(VolumePlayer.Value/360);
    init_stacje;
    init_preferences;
    init_nagrania;
    ComboBox1Change(Sender);
  end;
end;

procedure TFMain.list1DblClick(Sender: TObject);
begin
  if list1.Count=0 then exit;
  if pos('[',list1.Items[list1.ItemIndex])=1 then exit;
  if PlayerMultimedia.GetII=list1.ItemIndex then exit;
  if PlayerMultimedia.GetPauseIndex>-1 then PlayerMultimedia.stop_now;
  PlayerMultimedia.play(list1.ItemIndex);
end;

procedure TFMain.list1DragDrop(Sender, Source: TObject; X, Y: Integer);
var
  DropPosition,StartPosition: Integer;
  DropPoint: TPoint;
  i: integer;
begin
  DropPoint.X:=X;
  DropPoint.Y:=Y;
  with Source as TListBox do
  begin
    StartPosition:=ItemAtPos(StartingPoint,True) ;
    DropPosition:=ItemAtPos(DropPoint,True) ;
    i:=PlayerMultimedia.GetII;
    if StartPosition=i then PlayerMultimedia.SetII(DropPosition);
    Items.Move(StartPosition,DropPosition) ;
    PlayerMultimedia.PlikiMove(StartPosition,DropPosition);
  end;
end;

procedure TFMain.list1DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  Accept:=Source=list1;
end;

procedure TFMain.list1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  case Key of
    VK_RETURN: list1DblClick(Sender);
    VK_DELETE: SpeedButton11.Click;
  end;
end;

procedure TFMain.list1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  StartingPoint.x:=X;
  StartingPoint.y:=Y;
end;

procedure TFMain.ListBox1DblClick(Sender: TObject);
var
  nazwa,ss,s,pom: string;
  a: integer;
  fs : TFormatSettings;
begin
  if ListBox1.Count=0 then exit;
  if IsDumpFile then exit;
  kaseta.index:=ListBox1.ItemIndex;
  ss:=ListBox1.Items[kaseta.index];
  s:=ss;
  ss:=ss+' '+FLAGA_DECK;
  a:=pos(':',s);
  kaseta.radio:=trim(copy(s,1,a-1));
  delete(s,1,a+1);
  fs.DateSeparator:='-';
  fs.ShortDateFormat:='y/m/d';
  fs.TimeSeparator:=':';
  fs.ShortTimeFormat:='h:n:s';
  kaseta.czas_nagrania:=StrToDateTime(s,fs);

  ListBox1.Items.Delete(kaseta.index);
  ListBox1.Items.Insert(kaseta.index,ss);
  ListBox1.ItemIndex:=kaseta.index;

  nazwa:='stream.'+StringReplace(kaseta.radio,' ','_',[rfReplaceAll])+'.'+FormatDateTime('yyyymmddhhnnss',kaseta.czas_nagrania)+'.dump';
  if RenameFile(_DIR_TAP+_FF+nazwa,_DIR_TAP+_FF+'stream.dump') then
  begin
    RenameFile(_DIR_TAP+_FF+nazwa+'.cue',_DIR_TAP+_FF+'stream.dump.cue');
    RenameFile(_DIR_TAP+_FF+nazwa+'.dat',_DIR_TAP+_FF+'stream.dump.dat');
    IsDumpFile:=true;
    ListBox1.Items.SaveToFile(_DIR_TAP+_FF+'nagrania.dat');
    kaseta1.Visible:=true;
  end else begin
    ListBox1.Items.LoadFromFile(_DIR_TAP+_FF+'nagrania.dat');
    kaseta.index:=-1;
    IsDumpFile:=false;
  end;
  przyciski;
end;

procedure TFMain.ListBox1SelectionChange(Sender: TObject; User: boolean);
begin
  przyciski;
end;

procedure TFMain.MenuItem1Click(Sender: TObject);
begin
  close;
end;

procedure TFMain.autorunTimer(Sender: TObject);
begin
  inc(swiatlo,1);
  if swiatlo<=240 then Panel6.Color:=RGBToColor(swiatlo,swiatlo,swiatlo div 2);
  if swiatlo=50 then
  begin
    status.Caption:='STREAMING';
    deck1.Caption:='DECK1';
    deck2.Caption:='DECK2';
    status.Font.Color:=clSilver;
    deck1.Font.Color:=status.Font.Color;
    deck2.Font.Color:=status.Font.Color;
  end;
  if (swiatlo=100) and _RADIO_PLAYING then play.Click;
  if swiatlo=300 then autorun.Enabled:=false;
end;

procedure TFMain.dirPackRecord(Sender: TObject; APackRecord, ASignature: string
  );
begin
  SendToAll(ASignature,1,201,APackRecord);
end;

function odczytaj_iso(a: integer): string;
begin
  case a of
    0: result:='-utf8';
    1: result:='-unicode';
    2: result:='-subcp ISO-8859-2';
    3: result:='-subcp cp852';
    4: result:='-subcp cp1250';
  end;
end;

function odczytaj_iso_mpv(a: integer): string;
begin
  case a of
    0: result:='-utf8';
    1: result:='-unicode';
    2: result:='--sub-codepage=ISO-8859-2';
    3: result:='--sub-codepage=cp852';
    4: result:='--sub-codepage=cp1250';
  end;
end;

function odczytaj_ffaktor(a: integer): string;
begin
  case a of
    0: result:='-ffactor 0';
    1: result:='-ffactor 0.75';
    2: result:='-ffactor 1';
    3: result:='-ffactor 10';
  end;
end;

function odczytaj_ffaktor_mpv(a: integer): string;
begin
  case a of
    0: result:='-ffactor 0';
    1: result:='-ffactor 0.75';
    2: result:='-ffactor 1';
    3: result:='-ffactor 10';
  end;
end;

procedure TFMain.filmBeforePlay(ASender: TObject; AFilename: string);
var
  vs_changes: boolean;
  vs_audio: string;
  vs_subtitle: string;
  vs_iso,vs_ffactor,vs_subpos,vs_subscale: integer;
  vs_nosubtitle: boolean;
  zmienna,s,bb: string;
begin
  if _VIDEO_MPV_FORCE or _VIDEO_MPV then film.Engine:=meMPV else film.Engine:=meMplayer;
  _VIDEO_MPV_FORCE:=false;
  film.MpvNoOSC:=not _VIDEO_MPV_OSC;
  film.Volume:=round((VolumePlayer.Value/270)*100);
  film.Cache:=_FILM_CACHE;
  film.CacheMin:=_FILM_CACHE_MIN;
  zmienna:='FILE_ATTR:'+ExtractFileName(AFilename);
  {ustawienia domyślne}
  vs_changes:=false;
  vs_audio:='';
  vs_subtitle:='';
  vs_iso:=-1;
  vs_ffactor:=-1;
  vs_nosubtitle:=false;
  vs_subpos:=0;
  vs_subscale:=0;
  {odczyt danych jeśli są}
  s:=dm.GetZmienna(zmienna);
  if s<>'' then
  begin
    vs_changes:=true;
    vs_audio:=GetLineToStr(s,1,#9);
    vs_subtitle:=GetLineToStr(s,2,#9);
    vs_iso:=StrToInt(GetLineToStr(s,3,#9,'0'))-1;
    vs_nosubtitle:=(GetLineToStr(s,4,#9)='1');
    vs_ffactor:=StrToInt(GetLineToStr(s,5,#9,'0'))-1;
    vs_subpos:=StrToInt(GetLineToStr(s,6,#9,'0'));
    vs_subscale:=StrToInt(GetLineToStr(s,7,#9,'0'));
  end;
  if film.Engine=meMplayer then
  begin
    {MPLAYER}
    s:='-softvol';
    if vs_nosubtitle then
    begin
      s:=s+' -noautosub -nosub';
      if vs_audio='' then
      begin
        if _VIDEO_ALANG_DEFAULT<>'' then s:=s+' -alang '+_VIDEO_ALANG_DEFAULT;
      end else s:=s+' -alang '+vs_audio;
    end else begin
      if vs_audio='' then
      begin
        if _VIDEO_ALANG_DEFAULT<>'' then s:=s+' -alang '+_VIDEO_ALANG_DEFAULT;
      end else s:=s+' -alang '+vs_audio;
      if vs_subtitle='' then
      begin
        if _VIDEO_SLANG_DEFAULT<>'' then s:=s+' -slang '+_VIDEO_SLANG_DEFAULT;
      end else s:=s+' -slang '+vs_subtitle;
      s:=s+' -font "'+_VIDEO_FONT_NAME+'"';
      if vs_iso<0 then s:=s+' '+odczytaj_iso(_VIDEO_ISO_DEFAULT) else s:=s+' '+odczytaj_iso(vs_iso);
      if vs_subpos=0 then s:=s+' -subpos '+IntToStr(_VIDEO_SUBPOS_DEFAULT) else s:=s+' -subpos '+IntToStr(vs_subpos-1);
      if vs_subscale=0 then s:=s+' -subfont-text-scale '+FormatFloat('0.0',_VIDEO_SUBSCALE_DEFAULT/10) else s:=s+' -subfont-text-scale '+FormatFloat('0.0',(vs_subscale+9)/10);
      if vs_ffactor<0 then s:=s+' '+odczytaj_ffaktor(_VIDEO_FONT_FACTOR) else s:=s+' '+odczytaj_ffaktor(vs_ffactor);
    end;
  end else begin
    {MPV}
    //s:='--softvol=yes'; {MPV nie wykorzystuje tej opcji, a opcja ta włączona jest domyślnie i nie ma potrzeby jej włączać}
    if vs_nosubtitle then
    begin
      s:=s+' --no-sub';
      if vs_audio='' then
      begin
        if _VIDEO_ALANG_DEFAULT<>'' then s:=s+' --alang='+_VIDEO_ALANG_DEFAULT;
      end else s:=s+' --alang='+vs_audio;
    end else begin
      if vs_audio='' then
      begin
        if _VIDEO_ALANG_DEFAULT<>'' then s:=s+' --alang='+_VIDEO_ALANG_DEFAULT;
      end else s:=s+' --alang='+vs_audio;
      if vs_subtitle='' then
      begin
        if _VIDEO_SLANG_DEFAULT<>'' then s:=s+' --slang='+_VIDEO_SLANG_DEFAULT;
      end else s:=s+' --slang='+vs_subtitle;
      s:=s+' --sub-font="'+_VIDEO_FONT_NAME+'"';
      if vs_iso<0 then s:=s+' '+odczytaj_iso_mpv(_VIDEO_ISO_DEFAULT) else s:=s+' '+odczytaj_iso_mpv(vs_iso);
      if vs_subpos=0 then s:=s+' --sub-pos='+IntToStr(_VIDEO_SUBPOS_DEFAULT) else s:=s+' --subpos='+IntToStr(vs_subpos-1);
      if vs_subscale=0 then s:=s+' --sub-scale='+FormatFloat('0.0',_VIDEO_SUBSCALE_DEFAULT/10) else s:=s+' --sub-scale='+FormatFloat('0.0',(vs_subscale+9)/10);
      //if vs_ffactor<0 then s:=s+' '+odczytaj_ffaktor_mpv(_VIDEO_FONT_FACTOR) else s:=s+' '+odczytaj_ffaktor_mpv(vs_ffactor);
    end;
  end;
  film.StartParam:=trim(s);
end;

procedure TFMain.filmPlay(Sender: TObject);
begin
  _FILM_PLAYING:=true;
  ButtonFS.Visible:=true;
  PlayerMultimedia.video_starting;
  if _VIDEO_FS_DEFAULT then FilmFullScreen(true);
end;

procedure TFMain.filmPlaying(ASender: TObject; APosition: single);
var
  a,b: integer;
  aa,bb: TTime;
  bPos,bMax: boolean;
begin
  if film.Duration=0 then exit;
  aa:=film.Duration/SecsPerDay;
  if aa<0.0000000001 then
  begin
    OnPlayerStop(nil); //wykorzystuję tylko do wyłączenia wyświetlaczy...
    exit;
  end;
  bb:=APosition/SecsPerDay;
  a:=TimeToInteger(aa);
  b:=TimeToInteger(bb);
  stat_position.Max:=a div 1000;
  stat_position.Position:=b div 1000;
  bMax:=a<3600000;
  bPos:=b<3600000;
  if bPos then Label1.Caption:=FormatDateTime('nn:ss',bb) else Label1.Caption:=FormatDateTime('h:nn:ss',bb);
  if bMax then Label2.Caption:=FormatDateTime('nn:ss',aa) else Label2.Caption:=FormatDateTime('h:nn:ss',aa);
  SendToAll('[ALL]',1,103,IntToStr(stat_position.Position)+#9+IntToStr(stat_position.Max)+#9+Label1.Caption+#9+Label2.Caption);
end;

procedure TFMain.filmStop(Sender: TObject);
begin
  _FILM_PLAYING:=false;
  ButtonFS.Visible:=false;
  PlayerMultimedia.video_stoping;
  FilmFullScreen(false);
  timer_film_off.Enabled:=true;
end;

procedure TFMain.filmTimerDump(ASender: TObject; AText: String);
begin
  cadd(FormatDateTime('hhnnss',time)+': [FILM]: '+AText);
end;

procedure TFMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  SendToAll('[ALL]',1,1000);
end;

procedure TFMain.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  if Film.Visible then
  begin
    case Key of
      VK_SPACE: if film.Paused then pplayClick(Sender) else PlayerMultimedia.pause;
      VK_RIGHT: film.SendMPlayerCommand('seek +60');
      VK_LEFT: film.SendMPlayerCommand('seek -60');
      VK_F12: if __FULL_SCREEN then FilmFullScreen(false) else FilmFullScreen(true);
      VK_ESCAPE: FilmFullScreen(false);
    end;
  end;
end;

procedure TFMain.list1DrawItem(Control: TWinControl; Index: Integer;
  ARect: TRect; State: TOwnerDrawState);
var
  s: string;
begin
  s:=list1.Items[Index];
  if pos('[',s)=1 then
  begin
    list1.Canvas.Font.Color:=clRed;
  end else begin
    list1.Canvas.Font.Color:=clBlack;
  end;
  list1.Canvas.Font.Bold:=Index=PlayerMultimedia.GetII;
  list1.Canvas.FillRect(ARect);
  list1.Canvas.TextRect(ARect,0,ARect.Top,list1.Items[Index]);
  if Index=PlayerMultimedia.GetII then PlayerMultimedia.SetPlayIndex(Index);
end;

procedure TFMain.list1SelectionChange(Sender: TObject; User: boolean);
begin
  SpeedButton13.Visible:=CzyToJestFilm(list1.ItemIndex);
end;

procedure TFMain.MenuItem7Click(Sender: TObject);
begin
  PlayerMultimedia.PlikiInsert(list1.ItemIndex+1,'[stop]');
  list1.Items.Insert(list1.ItemIndex+1,'[stop]');
  SendToAll('[ALL]',1,203,IntToStr(list1.ItemIndex+1)+#9+'[stop]');
end;

procedure TFMain.MenuItem8Click(Sender: TObject);
begin
  PlayerMultimedia.PlikiInsert(list1.ItemIndex+1,'[shutdown]');
  list1.Items.Insert(list1.ItemIndex+1,'[shutdown]');
  SendToAll('[ALL]',1,203,IntToStr(list1.ItemIndex+1)+#9+'[shutdown]');
end;

procedure TFMain.ButtonFSClick(Sender: TObject);
begin
  if Film.Visible then
  begin
    if __FULL_SCREEN then FilmFullScreen(false) else FilmFullScreen(true);
  end;
end;

procedure TFMain.MenuItem9Click(Sender: TObject);
var
  plik,ramka: string;
  t: UOSPlayer.TIDTag;
begin
  plik:=InputBox('Nagranie Youtube','Podaj link:','');
  if plik='' then exit;
  ramka:=ramka+DodajPlikDoPlaylisty(plik,t)+#9;
end;

procedure TFMain.player2TimerDump(ASender: TObject; AText: String);
begin
  cadd(FormatDateTime('hhnnss',time)+': PLAYER2: '+AText);
end;

procedure TFMain.playerTimerDump(ASender: TObject; AText: String);
begin
  cadd(FormatDateTime('hhnnss',time)+': PLAYER: '+AText);
end;

procedure TFMain.radioTimerDump(ASender: TObject; AText: String);
begin
  cadd(FormatDateTime('hhnnss',time)+': RADIO: '+AText);
end;

procedure TFMain.shutdownBeforeShutdown(Sender: TObject);
begin
  SendToAll('[ALL]',1,999);
end;

procedure TFMain.SpeedButton13Click(Sender: TObject);
var
  vs_changes: boolean;
  vs_audio: string;
  vs_subtitle: string;
  vs_iso,vs_ffactor,vs_subpos,vs_subscale: integer;
  vs_nosubtitle: boolean;
  zmienna,s,bb: string;
begin
  if list1.ItemIndex=-1 then exit;
  zmienna:='FILE_ATTR:'+ExtractFileName(PlayerMultimedia.PlikiItems[list1.ItemIndex]);
  {ustawienia domyślne}
  vs_audio:='';
  vs_subtitle:='';
  vs_iso:=0;
  vs_ffactor:=0;
  vs_nosubtitle:=false;
  vs_subpos:=0;
  vs_subscale:=0;
  {odczyt danych jeśli są}
  s:=dm.GetZmienna(zmienna);
  if s<>'' then
  begin
    vs_audio:=GetLineToStr(s,1,#9);
    vs_subtitle:=GetLineToStr(s,2,#9);
    vs_iso:=StrToInt(GetLineToStr(s,3,#9,'0'));
    vs_nosubtitle:=(GetLineToStr(s,4,#9)='1');
    vs_ffactor:=StrToInt(GetLineToStr(s,5,#9,'0'));
    vs_subpos:=StrToInt(GetLineToStr(s,6,#9,'0'));
    vs_subscale:=StrToInt(GetLineToStr(s,7,#9,'0'));
  end;
  {wybór użytkownika}
  FFileConf:=TFFileConf.Create(self);
  try
    FFileConf.Init(vs_audio,vs_subtitle,vs_iso,vs_ffactor,vs_nosubtitle,vs_subpos,vs_subscale);
    FFileConf.ShowModal;
    vs_changes:=FFileConf.GetData(vs_audio,vs_subtitle,vs_iso,vs_ffactor,vs_subpos,vs_subscale,vs_nosubtitle);
  finally
    FFileConf.Free;
  end;
  {zapis jeśli dokonano zmian}
  if vs_changes then
  begin
    if vs_nosubtitle then bb:='1' else bb:='0';
    s:=vs_audio+#9+vs_subtitle+#9+IntToStr(vs_iso)+#9+bb+#9+IntToStr(vs_ffactor)+#9+IntToStr(vs_subpos)+#9+IntToStr(vs_subscale);
    dm.SetZmienna(zmienna,s);
  end;
end;

procedure TFMain.tcpCryptString(var aText: string);
begin
  aText:=EncryptString(aText,'123');
end;

procedure TFMain.tcpDecryptString(var aText: string);
begin
  aText:=DecryptString(aText,'123');
end;

procedure TFMain.tcpError(const aMsg: string; aSocket: TLSocket);
begin
  inc(serwer_on_error_count);
  cadd(FormatDateTime('hhnnss:',now)+' SerwerLog_'+FormatFloat('000',serwer_on_error_count)+': '+aMsg);
end;

procedure TFMain.tcpReceiveString(aMsg: string; aSocket: TLSocket);
var
  s: string;
  pom: string;
  cto,adres,wartosc: string;
  rodzaj,kod,td,i,a,b: integer;
begin
  s:=aMsg;
  cto:=GetLineToStr(s,1,'$');
  if cto='CTO' then
  begin
    adres:=GetLineToStr(s,2,'$');
    rodzaj:=StrToInt(GetLineToStr(s,3,'$','0')); //1=SET, 2=GET
    if rodzaj=0 then exit;
    kod:=StrToInt(GetLineToStr(s,4,'$'));
    wartosc:=GetLineToStr(s,5,'$');
    td:=StrToInt(GetLineToStr(s,6,'$','0'));
    cadd('RamkaTCP: adres='+adres+', rodzaj='+IntToStr(rodzaj)+',kod='+IntToStr(kod)+', wartosc="'+wartosc+'"');
    {lecimy}
    if rodzaj=1 then
    begin
      {SET - komenda do wykonania}
      if kod=101 then list1.ItemIndex:=StrToInt(wartosc) else
      if kod=106 then
      begin
        a:=StrToInt(wartosc);
        VolumePlayer.Value:=a;
        PlayerMultimedia.SetVolume(a/270);
        if film.Visible then timer_upd_volume_film.Enabled:=true;
        SendToAll('[ALL]',1,106,Round(VolumePlayer.Value));
      end else
      if kod=111 then pplay.Click else
      if kod=112 then pstop.Click else
      if kod=113 then pnext.Click else
      if kod=114 then pprior.Click else
      if kod=115 then ButtonFS.Click else
      if kod=116 then list1DblClick(nil) else
      if kod=117 then ppause.Click else
      if kod=118 then ButtonFS.Click else
      if kod=120 then
      begin
        a:=round(VolumePlayer.Value);
        dec(a,10);
        if a<0 then a:=0;
        VolumePlayer.Value:=a;
        PlayerMultimedia.SetVolume(a/270);
        if film.Visible then timer_upd_volume_film.Enabled:=true;
        SendToAll('[ALL]',1,106,a);
      end else
      if kod=121 then
      begin
        a:=round(VolumePlayer.Value);
        inc(a,10);
        if a>270 then a:=270;
        VolumePlayer.Value:=a;
        PlayerMultimedia.SetVolume(a/270);
        if film.Visible then timer_upd_volume_film.Enabled:=true;
        SendToAll('[ALL]',1,106,a);
      end else
      if kod=150 then
      begin
        a:=StrToInt(GetLineToStr(wartosc,1,#9));
        b:=StrToInt(GetLineToStr(wartosc,2,#9));
        SetPositionFromX(a,b);
      end else
      if kod=202 then
      begin
        RamkaToPlaylista(wartosc);
      end else
      if kod=204 then SpeedButton11.Click else
      if kod=205 then SpeedButton12.Click else
      if kod=210 then MenuItem7.Click else
      if kod=211 then MenuItem8.Click else
      if kod=999 then
      begin
        case _SHUTDOWN_MODE of
          1: shutdown.Mode:=smShutdownP2;
          2: shutdown.Mode:=smShutdownP1;
          3: shutdown.Mode:=smQDbusKDE;
          4: shutdown.Mode:=smWindows;
          5: begin
               shutdown.Mode:=smCustom;
               shutdown.CustomCommand:=_SHUTDOWN_CMD;
             end;
        end;
        SendToAll('[ALL]',1,999);
        shutdown.execute;
        close;
      end;
    end else begin
      {GET - prośba o podanie informacji}
      if kod=101 then
      begin
        wartosc:='';
        for i:=0 to list1.Count-1 do wartosc:=wartosc+list1.Items[i]+#9;
        wartosc:=wartosc+'[OK]'+#9;
        wartosc:=wartosc+IntToStr(list1.ItemIndex)+#9;
        wartosc:=wartosc+IntToStr(PlayerMultimedia.GetII)+#9;
        SendToAll('[ALL]',1,101,wartosc); //lista
        if ppause.Visible then pom:='1' else pom:='0'; //czy player jest zatrzymany (pause)?
        SendToAll('[ALL]',1,105,pom);
        SendToAll('[ALL]',1,106,Round(VolumePlayer.Value)); //głośność
      end else
      if kod=200 then
      begin
        {polecenie pobrania domyślnego katalogu}
        {$IFDEF WINDOWS}
        SendToAll(adres,1,200,PlayerMultimedia.katalog+#9+_FF+#9+ListaNapedow);
        {$ELSE}
        SendToAll(adres,1,200,PlayerMultimedia.katalog+#9+_FF);
        {$ENDIF}
      end else
      if kod=201 then
      begin
        {polecenie wykonania dir}
        dir.Execute(GetLineToStr(wartosc,1,#9),GetLineToStr(wartosc,2,#9),adres);
      end;
    end;
  end;
end;

procedure TFMain.tcpStatus(aActive, aCrypt: boolean);
begin
  led_server.Active:=aActive;
  serwer_on:=aActive;
end;

procedure TFMain.timer_film_offTimer(Sender: TObject);
begin
  timer_film_off.Enabled:=false;
  kino;
end;

procedure TFMain.timer_shutdownTimer(Sender: TObject);
var
  b: boolean;
begin
  timer_shutdown.Enabled:=false;
  FHalt:=TFHalt.Create(self);
  try
    FHalt.ShowModal;
    b:=FHalt.wylaczenie;
  finally
    FHalt.Free;
  end;
  if b then
  begin
    case _SHUTDOWN_MODE of
      1: shutdown.Mode:=smShutdownP2;
      2: shutdown.Mode:=smShutdownP1;
      3: shutdown.Mode:=smQDbusKDE;
      4: shutdown.Mode:=smWindows;
      5: begin
           shutdown.Mode:=smCustom;
           shutdown.CustomCommand:=_SHUTDOWN_CMD;
         end;
    end;
    _SHUTDOWN_EXEC:=true;
    close;
  end;
end;

procedure TFMain.timer_upd_volume_filmTimer(Sender: TObject);
begin
  timer_upd_volume_film.Enabled:=false;
  film.Volume:=round((VolumePlayer.Value/270)*100);
end;

procedure TFMain.VolumeRadioValueChanged(Sender: TObject; Value: single);
var
  a: integer;
begin
  a:=GetVolumeRadio(Value);
  if (not led_play.Active) and (not led_play2.Active) then radio.Volume:=a;
  player.Volume:=a;
  player2.Volume:=a;
end;

procedure TFMain.stat_positionMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if PlayerMultimedia.IsStopping then exit;
  SetPositionFromX(X,stat_position.Width);
end;

procedure TFMain.VolumePlayerValueChanged(Sender: TObject; Value: single);
begin
  PlayerMultimedia.SetVolume(Value/270);
  if film.Visible then timer_upd_volume_film.Enabled:=true;
  SendToAll('[ALL]',1,106,Round(VolumePlayer.Value));
end;

procedure TFMain.ComboBox1Change(Sender: TObject);
begin
  przyciski_radia_update;
  if ComboBox1.ItemIndex=-1 then exit;
  if radio.Playing then
  begin
    stop.Click;
    play.Click;
  end else if radio.Paused then stop.Click;
end;

procedure TFMain.playClick(Sender: TObject);
begin
  if ComboBox1.ItemIndex=-1 then exit;
  if TSpeedButton(Sender).ImageIndex=0 then
  begin
    if (not radio.Playing) and radio.Paused then
    begin
      wektor_czasu:=wektor_czasu+(TimeToInteger-wektor_czasu_start);
      radio.Replay;
    end else begin
      wektor_czasu:=0;
      radio.Cache:=_RADIO_CACHE;
      radio.CacheMin:=_RADIO_CACHE_MIN;
      radio.Filename:=stacje_adresy[ComboBox1.ItemIndex];
      radio.Volume:=GetVolumeRadio;
      radio.Play(_DIR_TAP);
    end;
    timer_czas.Enabled:=true;
  end else begin
    radio.Pause;
    wektor_czasu_start:=TimeToInteger;
    timer_czas.Enabled:=false;
  end;
  przyciski;
end;

procedure TFMain.player2Play(Sender: TObject);
begin
  start_odtwarzania:=TimeToInteger;
  kaseta2.Visible:=true;
  led_play2.Active:=true;
  radio.Volume:=0;
  player2.Volume:=GetVolumeRadio;
  duration:=round(player2.Duration*1000);
  przyciski;
end;

procedure TFMain.player2Stop(Sender: TObject);
begin
  kaseta2.Visible:=false;
  led_play2.Active:=false;
  player2.Volume:=0;
  radio.Volume:=GetVolumeRadio;
  przyciski;
  unload_cue;
  timer_restore_icy.Enabled:=true;
end;

procedure TFMain.playerPlay(Sender: TObject);
begin
  start_odtwarzania:=TimeToInteger;
  led_play.Active:=true;
  radio.Volume:=0;
  player.Volume:=GetVolumeRadio;
  duration:=round(player.Duration*1000);
  przyciski;
end;

procedure TFMain.pnextClick(Sender: TObject);
begin
  if list1.Count=0 then exit;
  if PlayerMultimedia.GetII=list1.Count-1 then exit;
  PlayerMultimedia.nastepny_utwor;
end;

procedure TFMain.ppauseClick(Sender: TObject);
begin
  if PlayerMultimedia.GetPauseIndex=-1 then PlayerMultimedia.pause;
end;

procedure TFMain.pplayClick(Sender: TObject);
var
  a: integer;
begin
  if list1.Count=0 then exit;
  a:=list1.ItemIndex;
  if pos('[',list1.Items[a])=1 then exit;
  if a=-1 then a:=0;
  if PlayerMultimedia.IsStopping then PlayerMultimedia.play(a) else case PlayerMultimedia.GetPauseIndex of
    1: PlayerMultimedia.replay(1);
    2: PlayerMultimedia.replay(2);
    3: PlayerMultimedia.replay(3);
    5: PlayerMultimedia.replay(5);
  end;
  PlayerMultimedia.SetPlayerIndex(PlayerMultimedia.GetPauseIndex);
  PlayerMultimedia.SetPauseIndex(-1);
  ppause.Visible:=true;
  pplay.Visible:=false;
  SendToAll('[ALL]',1,105,'1');
end;

procedure TFMain.ppriorClick(Sender: TObject);
begin
  if list1.Count=0 then exit;
  if PlayerMultimedia.GetII=0 then exit;
  PlayerMultimedia.poprzedni_utwor;
end;

procedure TFMain.pstopClick(Sender: TObject);
begin
  //PlayerMultimedia.stop;
  PlayerMultimedia.stop_now;
end;

procedure TFMain.SpeedButton10Click(Sender: TObject);
var
  i: integer;
  plik,ramka: string;
  t: UOSPlayer.TIDTag;
begin
  OpenDialogMuzyka.InitialDir:=PlayerMultimedia.katalog;
  if OpenDialogMuzyka.Execute then
  begin
    PlayerMultimedia.katalog:=OpenDialogMuzyka.InitialDir;
    PlayerMultimedia.TagInfoStart;
    try
      ramka:='';
      for i:=0 to OpenDialogMuzyka.Files.Count-1 do
      begin
        plik:=OpenDialogMuzyka.Files.Strings[i];
        ramka:=ramka+DodajPlikDoPlaylisty(plik,t)+#9;
      end;
      SendToAll('[ALL]',1,202,ramka);
    finally
      PlayerMultimedia.TagInfoStop;
    end;
  end;
end;

procedure TFMain.SpeedButton11Click(Sender: TObject);
var
  a: integer;
begin
  a:=list1.ItemIndex;
  if a=-1 then exit;
  if a<PlayerMultimedia.GetII then PlayerMultimedia.DecII else if a=PlayerMultimedia.GetII then PlayerMultimedia.stop;
  PlayerMultimedia.PlikiDelete(a);
  list1.Items.Delete(a);
  if a<list1.Count then list1.ItemIndex:=a else list1.ItemIndex:=list1.Count-1;
  SendToAll('[ALL]',1,204,a);
end;

procedure TFMain.SpeedButton12Click(Sender: TObject);
begin
  PlayerMultimedia.stop;
  list1.Clear;
  PlayerMultimedia.PlikiClear;
  SendToAll('[ALL]',1,205);
end;

procedure TFMain.PlayerOptTrybClick(Sender: TObject);
var
  a: integer;
begin
  a:=PlayerOptTryb.ImageIndex;
  inc(a);
  if a>20 then a:=18;
  PlayerOptTryb.ImageIndex:=a;
end;

procedure ss_zapisz(s,plik: string);
var
  ss: TStringList;
begin
  ss:=TStringList.Create;
  try
    ss.Add(s);
    ss.SaveToFile(plik);
  finally
    ss.Free;
  end;
end;

function pobierz_dzien_tygodnia(tresc, nazwa_dnia: string): string;
var
  s: string;
  a: integer;
begin
  s:=tresc;
  a:=pos(nazwa_dnia,s);
  delete(s,1,a+length(nazwa_dnia));
  a:=pos('<table',s);
  delete(s,1,a-1);
  a:=pos('<tr',s);
  delete(s,1,a-1);
  a:=pos('</table>',s);
  delete(s,a,10000);
  result:=trim(s);
end;

procedure TFMain.SpeedButton6Click(Sender: TObject);
var
  ss: TStringList;
  s,poniedzialek,wtorek,sroda,czwartek,piatek,sobota,niedziela: string;
  error: boolean;
begin
  error:=false;
  ss:=TStringList.Create;
  try
    html.execute('https://radiofortyplus.panelradiowy.pl/embed.php?script=ramowka',ss);
    //ss.LoadFromFile('strona.txt');
    s:=ss.Text;
    //ss_zapisz(s,'strona.txt');
    try
      poniedzialek:=pobierz_dzien_tygodnia(s,'Poniedziałek');
      wtorek:=pobierz_dzien_tygodnia(s,'Wtorek');
      sroda:=pobierz_dzien_tygodnia(s,'Środa');
      czwartek:=pobierz_dzien_tygodnia(s,'Czwartek');
      piatek:=pobierz_dzien_tygodnia(s,'Piątek');
      sobota:=pobierz_dzien_tygodnia(s,'Sobota');
      niedziela:=pobierz_dzien_tygodnia(s,'Niedziela');
    except
      error:=true;
    end;
  finally
    ss.Free;
  end;
  if error then
  begin
    mess.ShowError(RS_INFO_3+'^'+RS_INFO_4);
    exit;
  end;
  FRamowka:=TFRamowka.Create(self);
  try
    FRamowka.poniedzialek:=poniedzialek;
    FRamowka.wtorek:=wtorek;
    FRamowka.sroda:=sroda;
    FRamowka.czwartek:=czwartek;
    FRamowka.piatek:=piatek;
    FRamowka.sobota:=sobota;
    FRamowka.niedziela:=niedziela;
    FRamowka.ShowModal;
  finally
    FRamowka.Free;
  end;
end;

procedure TFMain.SpeedButton7Click(Sender: TObject);
var
  ss: TStringList;
  s: string;
  a: integer;
begin
  ss:=TStringList.Create;
  try
    html.execute('https://radiofortyplus.panelradiowy.pl/embed.php?script=pozdrowienia',ss);
    s:=ss.Text;
    a:=pos('<b>Wysyłanie pozdrowień wyłączone!</b>',s);
    if a>0 then
    begin
      mess.ShowInformation(RS_POZDROWIENIA_OFF);
      exit;
    end;
    FPozdrowienia:=TFPozdrowienia.Create(self);
    try
      FPozdrowienia.ShowModal;
    finally
      FPozdrowienia.Free;
    end;
  finally
    ss.Free;
  end;
end;

procedure TFMain.SpeedButton8Click(Sender: TObject);
var
  ss: TStringList;
  s: string;
  a: integer;
begin
  ss:=TStringList.Create;
  try       {wykonawca=wykonawca&tytul=tytul&od=Samu&dla=Samu2&utwor=Zam%C3%B3w+utw%C3%B3r}
    //html.execute('https://radiofortyplus.panelradiowy.pl/embed.php?script=audio',ss);
    html.execute('https://radiofortyplus.panelradiowy.pl/embed.php?script=utwor',ss);
    s:=ss.Text;
    a:=pos('<b>Zamawianie utworów wyłączone!</b>',s);
    if a>0 then
    begin
      mess.ShowInformation(RS_ZAMAWIANIE_UTWOROW_OFF);
      exit;
    end;
    FZamowUtwor:=TFZamowUtwor.Create(self);
    try
      FZamowUtwor.ShowModal;
    finally
      FZamowUtwor.Free;
    end;
  finally
    ss.Free;
  end;
end;

procedure TFMain.SpeedButton9Click(Sender: TObject);
begin
  if not _DEV_CHAT_CREATE then
  begin
    FChat:=TFChat.Create(self);
    FChat.InitService;
  end;
  if trim(_POLFAN_USER)='' then
  begin
    mess.ShowWarning(RS_INFO_5+'^^'+RS_INFO_6);
    exit;
  end;
  FChat.in_user:=_POLFAN_USER;
  FChat.in_passw:=_POLFAN_PASSW;
  FChat.in_force_room:=_POLFAN_FORCE_ROOM;
  FChat.in_room:=stacje_pokoje[ComboBox1.ItemIndex];
  FChat.Show;
end;

procedure TFMain.ustawieniaClick(Sender: TObject);
begin
  FUstawienia:=TFUstawienia.Create(self);
  try
    FUstawienia.ShowModal;
  finally
    FreeAndNil(FUstawienia);
  end;
  PropStorage.Save;
  init_preferences;
end;

procedure TFMain.timer_restore_icyTimer(Sender: TObject);
begin
  timer_restore_icy.Enabled:=false;
  if (trim(audycja.Caption)='') and (radio.Playing or radio.Paused) then
  begin
    prezenter.Caption:=icy_mem.prezenter;
    audycja.Caption:=icy_mem.audycja;
    utwor.Caption:=icy_mem.utwor;
    url.Caption:=icy_mem.url;
  end;
end;

procedure TFMain._PLAY_TIMER(ASender: TObject; APosition: single);
var
  i: integer;
begin
  czas_aktualny:=round(APosition*1000);
  czas.Caption:=FormatDateTime('nnn:ss',IntegerToTime(czas_aktualny))+'/'+FormatDateTime('nnn:ss',IntegerToTime(duration));
  (* ICY *)
  if czas_aktualny>czas_nastepny then for i:=0 to cue.count-1 do
  begin
    czas_nastepny:=tracks[i].start;
    if czas_nastepny>czas_aktualny then
    begin
      prezenter.Caption:=cue.performer;
      audycja.Caption:=cue.title;
      utwor.Caption:=tracks[i-1].title;
      url.Caption:=tracks[i-1].performer;
      break;
    end;
  end;
end;

procedure TFMain.playerStop(Sender: TObject);
begin
  led_play.Active:=false;
  player.Volume:=0;
  radio.Volume:=GetVolumeRadio;
  przyciski;
  unload_cue;
  timer_restore_icy.Enabled:=true;
end;

procedure TFMain.play_playClick(Sender: TObject);
var
  s: string;
begin
  s:=DumpForListToFilename(ListBox1.ItemIndex);
  load_cue(_DIR_TAP+_FF+s+'.cue');
  start_odtwarzania:=TimeToInteger;
  player2.Filename:=_DIR_TAP+_FF+s;
  player2.Play;
end;

procedure TFMain.play_stopClick(Sender: TObject);
begin
  player2.Stop;
end;

procedure TFMain.PropStorageRestoreProperties(Sender: TObject);
var
  a: integer;
begin
  _RADIO_CACHE:=PropStorage.ReadInteger('RadioCache',0);
  _RADIO_CACHE_MIN:=PropStorage.ReadInteger('RadioCacheMin',0);
  _FILM_CACHE:=PropStorage.ReadInteger('FilmCache',0);
  _FILM_CACHE_MIN:=PropStorage.ReadInteger('FilmCacheMin',0);
  _SHOW_KINO:=PropStorage.ReadBoolean('ShowKino',false);
  _SHOW_RADIO:=PropStorage.ReadBoolean('ShowRadio',true);
  _SHOW_RECORDER:=PropStorage.ReadBoolean('ShowRecorders',false);
  _SHOW_PLAYER:=PropStorage.ReadBoolean('ShowPlayer',false);
  _SHOW_CONSOLE:=PropStorage.ReadBoolean('ShowConsole',false);
  _SERVER_ON:=PropStorage.ReadBoolean('ServerOn',false);
  _POLFAN_USER:=PropStorage.ReadString('PolfanUser','');
  _POLFAN_PASSW:=DecryptString(PropStorage.ReadString('PolfanPassw',''),POLFAN_TOKEN,true);
  _POLFAN_FORCE_ROOM:=PropStorage.ReadString('PolfanForceRoom','');
  _RADIO_PLAYING:=PropStorage.ReadBoolean('RadioPlaying',false);
  _HIST_MEM_LINES_CODE:=PropStorage.ReadInteger('HistMemLinesCode',200);
  _CHAT_REGISTER:=PropStorage.ReadBoolean('ChatRegisterCode',false);
  _CHAT_FONT_NAME:=PropStorage.ReadString('ChatFontName','Sans');
  _CHAT_FONT_SIZE:=PropStorage.ReadInteger('ChatFontSize',11);
  _OFF_CHAT_SOUND_INFO:=PropStorage.ReadBoolean('OffChatSoundInfo',false);
  _OFF_CHAT_IMG:=PropStorage.ReadBoolean('OffChatEngineImg',false);
  _CHAT_BACKGROUND_COLOR:=PropStorage.ReadInteger('ChatBackgroundColor',clWhite);
  _CHAT_SOUND:=PropStorage.ReadInteger('ChatSoundInfo',0);
  _CHAT_BOOT_AUTORESPONSE:=PropStorage.ReadString('ChatBootAutoResponse','* * * <i><b><#008000>$<#></b> chwilowo nie ma mnie... <#004F64>Ale będę <oczko0></i> <#>* * *');
  _DEV_CHAT_SHOW_BOT_CODE:=PropStorage.ReadBoolean('ChatShowBotCode',false);
  {$IFDEF UNIX}
  _SHUTDOWN_MODE:=PropStorage.ReadInteger('ShutdownMode',1);
  {$ENDIF}
  {$IFDEF WINDOWS}
  _SHUTDOWN_MODE:=PropStorage.ReadInteger('ShutdownMode',4);
  {$ENDIF}
  _SHUTDOWN_CMD:=PropStorage.ReadString('ShutdownCMD','');
  _VIDEO_MPV:=PropStorage.ReadBoolean('VideoMPV',false);
  _VIDEO_MPV_OSC:=PropStorage.ReadBoolean('VideoMPVOSC',false);
  _VIDEO_ALANG_DEFAULT:=PropStorage.ReadString('VideoALangDefault','');
  _VIDEO_SLANG_DEFAULT:=PropStorage.ReadString('VideoSLangDefault','');
  _VIDEO_ISO_DEFAULT:=PropStorage.ReadInteger('VideoISODefault',0);
  _VIDEO_FS_DEFAULT:=PropStorage.ReadBoolean('VideoFSDefault',false);
  _VIDEO_FONT_NAME:=PropStorage.ReadString('VideoFontName','Sans');
  _VIDEO_FONT_FACTOR:=PropStorage.ReadInteger('VideoFontFactor',1);
  _VIDEO_SUBPOS_DEFAULT:=PropStorage.ReadInteger('VideoSubposDefault',95);
  _VIDEO_SUBSCALE_DEFAULT:=PropStorage.ReadInteger('VideoSubscaleDefault',25);
  { przywrócenie listy playera i start jeśli trzeba }
  PlayerMultimedia.katalog:=PropStorage.ReadString('PlayerDirectory','');
  PropStorage.ReadStrings('PlayerListNames',list1.Items);
  PropStorage.ReadStrings('PlayerListFiles',PlayerMultimedia.PlikiItems);
  list1.ItemIndex:=PropStorage.ReadInteger('PlayerListIndex',-1);
  _AUTOSTART_PLAYER:=PropStorage.ReadBoolean('PlayerAutoStart',false);
  if _SHOW_PLAYER and _AUTOSTART_PLAYER then
  begin
    a:=PropStorage.ReadInteger('PlayerPlayIndex',-1);
    if a>-1 then
    begin
      PlayerMultimedia.play(a);
      PlayerMultimedia.MEMII:=PropStorage.ReadInteger('PlayerAutoSeek',-1);
    end;
  end;
end;

procedure TFMain.PropStorageSaveProperties(Sender: TObject);
begin
  PropStorage.WriteInteger('RadioIndex',ComboBox1.ItemIndex);
  PropStorage.WriteInteger('RadioCache',_RADIO_CACHE);
  PropStorage.WriteInteger('RadioCacheMin',_RADIO_CACHE_MIN);
  PropStorage.WriteInteger('FilmCache',_FILM_CACHE);
  PropStorage.WriteInteger('FilmCacheMin',_FILM_CACHE_MIN);
  PropStorage.WriteBoolean('ShowKino',_SHOW_KINO);
  PropStorage.WriteBoolean('ShowRadio',_SHOW_RADIO);
  PropStorage.WriteBoolean('ShowRecorders',_SHOW_RECORDER);
  PropStorage.WriteBoolean('ShowPlayer',_SHOW_PLAYER);
  PropStorage.WriteBoolean('ShowConsole',_SHOW_CONSOLE);
  PropStorage.WriteBoolean('ServerOn',_SERVER_ON);
  PropStorage.WriteString('PolfanUser',_POLFAN_USER);
  PropStorage.WriteString('PolfanPassw',EncryptString(_POLFAN_PASSW,POLFAN_TOKEN,100));
  PropStorage.WriteString('PolfanForceRoom',_POLFAN_FORCE_ROOM);
  PropStorage.WriteBoolean('RadioPlaying',_RADIO_PLAYING);
  PropStorage.WriteInteger('HistMemLinesCode',_HIST_MEM_LINES_CODE);
  PropStorage.WriteBoolean('ChatRegisterCode',_CHAT_REGISTER);
  PropStorage.WriteString('ChatFontName',_CHAT_FONT_NAME);
  PropStorage.WriteInteger('ChatFontSize',_CHAT_FONT_SIZE);
  PropStorage.WriteInteger('ChatBackgroundColor',_CHAT_BACKGROUND_COLOR);
  PropStorage.WriteBoolean('OffChatSoundInfo',_OFF_CHAT_SOUND_INFO);
  PropStorage.WriteBoolean('OffChatEngineImg',_OFF_CHAT_IMG);
  PropStorage.WriteInteger('ChatSoundInfo',_CHAT_SOUND);
  PropStorage.WriteString('ChatBootAutoResponse',_CHAT_BOOT_AUTORESPONSE);
  PropStorage.WriteBoolean('ChatShowBotCode',_DEV_CHAT_SHOW_BOT_CODE);
  PropStorage.WriteInteger('ShutdownMode',_SHUTDOWN_MODE);
  PropStorage.WriteString('ShutdownCMD',_SHUTDOWN_CMD);
  PropStorage.WriteBoolean('VideoMPV',_VIDEO_MPV);
  PropStorage.WriteBoolean('VideoMPVOSC',_VIDEO_MPV_OSC);
  PropStorage.WriteString('VideoALangDefault',_VIDEO_ALANG_DEFAULT);
  PropStorage.WriteString('VideoSLangDefault',_VIDEO_SLANG_DEFAULT);
  PropStorage.WriteInteger('VideoISODefault',_VIDEO_ISO_DEFAULT);
  PropStorage.WriteBoolean('VideoFSDefault',_VIDEO_FS_DEFAULT);
  PropStorage.WriteString('VideoFontName',_VIDEO_FONT_NAME);
  PropStorage.WriteInteger('VideoFontFactor',_VIDEO_FONT_FACTOR);
  PropStorage.WriteInteger('VideoSubposDefault',_VIDEO_SUBPOS_DEFAULT);
  PropStorage.WriteInteger('VideoSubscaleDefault',_VIDEO_SUBSCALE_DEFAULT);
  { zapis danych playera }
  PropStorage.WriteString('PlayerDirectory',PlayerMultimedia.katalog);
  PropStorage.WriteStrings('PlayerListNames',list1.Items);
  PropStorage.WriteStrings('PlayerListFiles',PlayerMultimedia.PlikiItems);
  PropStorage.WriteInteger('PlayerListIndex',list1.ItemIndex);
  PropStorage.WriteBoolean('PlayerAutoStart',_AUTOSTART_PLAYER);
  PropStorage.WriteInteger('PlayerPlayIndex',PlayerMultimedia.GetPlayingIndex);
  PropStorage.WriteInteger('PlayerAutoSeek',round(PlayerMultimedia.GetPosition));
end;

procedure TFMain.rec_ejectClick(Sender: TObject);
var
  nazwa,s: string;
  a: integer;
begin
  nazwa:='stream.'+StringReplace(kaseta.radio,' ','_',[rfReplaceAll])+'.'+FormatDateTime('yyyymmddhhnnss',kaseta.czas_nagrania)+'.dump';
  if RenameFile(_DIR_TAP+_FF+'stream.dump',_DIR_TAP+_FF+nazwa) then
  begin
    RenameFile(_DIR_TAP+_FF+'stream.dump.cue',_DIR_TAP+_FF+nazwa+'.cue');
    RenameFile(_DIR_TAP+_FF+'stream.dump.dat',_DIR_TAP+_FF+nazwa+'.dat');
    s:=ListBox1.Items[kaseta.index];
    a:=pos('[',s);
    delete(s,a,1000);
    ListBox1.Items.Delete(kaseta.index);
    ListBox1.Items.Insert(kaseta.index,trim(s));
    ListBox1.ItemIndex:=kaseta.index;
    ListBox1.Items.SaveToFile(_DIR_TAP+_FF+'nagrania.dat');
    kaseta.index:=-1;
    IsDumpFile:=false;
    kaseta1.Visible:=false;
    przyciski;
  end;
end;

procedure TFMain.rec_stopClick(Sender: TObject);
begin
  if led_rec.Active then radio.Capturing else player.Stop;
end;

procedure TFMain.radioCapture(ASender: TObject; ACapture: boolean);
var
  r: TCueDat;
begin
  if ACapture then kaseta1.Visible:=true;
  led_rec.Active:=ACapture;
  IsDumpFile:=true;
  przyciski;
  if led_rec.Active then
  begin
    if FileExists(_DIR_TAP+_FF+'stream.dump.dat') then
    begin
      assignfile(ff2,_DIR_TAP+_FF+'stream.dump.dat');
      reset(ff2,1);
      read(ff2,r);
      closefile(ff2);
      ff_track:=r.tracks;
      ff_czas:=TimeToInteger-r.czas;
      assignfile(ff,_DIR_TAP+_FF+'stream.dump.cue');
      append(ff);
    end else begin
      ff_track:=1;
      ff_czas:=-1;
      assignfile(ff,_DIR_TAP+_FF+'stream.dump.cue');
      rewrite(ff);
    end;
  end else begin
    closefile(ff);
    r.tracks:=ff_track;
    r.czas:=TimeToInteger-ff_czas;
    assignfile(ff2,_DIR_TAP+_FF+'stream.dump.dat');
    rewrite(ff2);
    write(ff2,r);
    closefile(ff2);
  end;
end;

function OnlyAsciiText(s: string): string;
var
  i: integer;
begin
  result:=s;
  exit;
  for i:=1 to length(s) do
    if (ord(s[i])<32) or (ord(s[i])>127) then
    begin
      delete(s,i,1);
      insert(' ',s,i);
    end;
  result:=s;
end;

procedure TFMain.radioICYRadio(ASender: TObject; AName, AGenre,
  AWebsite: string; APublic: boolean; ABitrate, AStreamTitle, AStreamURL: string
  );
begin
  if led_play.Active or led_play2.Active then exit;
  radio.Volume:=GetVolumeRadio;
  icy_mem.prezenter:=OnlyAsciiText(AGenre);
  icy_mem.audycja:=OnlyAsciiText(AName);
  icy_mem.utwor:=OnlyAsciiText(AStreamTitle);
  icy_mem.url:=OnlyAsciiText(AStreamURL);
  prezenter.Caption:=icy_mem.prezenter;
  audycja.Caption:=icy_mem.audycja;
  utwor.Caption:=icy_mem.utwor;
  url.Caption:=icy_mem.url;
  if led_rec.Active then add_track_to_cue;
end;

procedure TFMain.radioPlay(Sender: TObject);
begin
  led_radio.Active:=true;
  _RADIO_PLAYING:=true;
  timer_czas.Enabled:=true;
  rec.Enabled:=radio.Playing and (not led_rec.Active) and (not led_play.Active) and (not led_play2.Active);
  przyciski;
end;

procedure TFMain.radioStop(Sender: TObject);
begin
  led_radio.Active:=false;
  _RADIO_PLAYING:=false;
  timer_czas.Enabled:=false;
  czas.Caption:='-:--:--';
  prezenter.Caption:='';
  audycja.Caption:='';
  utwor.Caption:='';
  url.Caption:='';
  rec.Enabled:=radio.Playing and (not led_rec.Active) and (not led_play.Active) and (not led_play2.Active);
  przyciski;
end;

procedure TFMain.recClick(Sender: TObject);
var
  s: string;
begin
  if not IsDumpFile then
  begin
    kaseta.czas_nagrania:=now;
    kaseta.radio:=ComboBox1.Items[ComboBox1.ItemIndex];
    s:=kaseta.radio+': '+FormatDateTime('yyyy-mm-dd hh:nn:ss',kaseta.czas_nagrania)+' '+FLAGA_DECK;
    ListBox1.Items.Add(s);
    kaseta.index:=StringToItemIndex(ListBox1.Items,s);
    ListBox1.Items.SaveToFile(_DIR_TAP+_FF+'nagrania.dat');
  end;
  radio.Capturing;
end;

procedure TFMain.rec_playClick(Sender: TObject);
begin
  load_cue(_DIR_TAP+_FF+'stream.dump.cue');
  start_odtwarzania:=TimeToInteger;
  player.Filename:=_DIR_TAP+_FF+'stream.dump';
  player.Play;
end;

procedure TFMain.SpeedButton2Click(Sender: TObject);
var
  i: integer;
begin
  mess.ShowInformation(RS_TMP_1);
  i:=ListBox1.ItemIndex;
  if i=-1 then exit;
end;

procedure TFMain.SpeedButton5Click(Sender: TObject);
var
  s: string;
  i: integer;
begin
  i:=ListBox1.ItemIndex;
  if i=-1 then exit;
  if pos(FLAGA_DECK,ListBox1.Items[i])>0 then
  begin
    mess.ShowInformation(RS_INFO_7+'^'+RS_INFO_8);
    exit;
  end;
  if mess.ShowConfirmationYesNo(RS_DELETE_CONFIRMATION_2+'^'+RS_DELETE_CONFIRMATION_3) then
  begin
    s:=_DIR_TAP+_FF+DumpForListToFilename(i);
    if FileExists(s) then RemoveFile(s);
    if FileExists(s+'.cue') then RemoveFile(s+'.cue');
    if FileExists(s+'.dat') then RemoveFile(s+'.dat');
    ListBox1.Items.Delete(i);
    if FileExists(_DIR_TAP+_FF+'nagrania.dat') then
      if ListBox1.Count=0 then RemoveFile(_DIR_TAP+_FF+'nagrania.dat') else ListBox1.Items.SaveToFile(_DIR_TAP+_FF+'nagrania.dat');
    przyciski;
  end;
end;

procedure TFMain.stopClick(Sender: TObject);
begin
  radio.Stop;
end;

procedure TFMain.timer_czasTimer(Sender: TObject);
begin
  if (not led_play.Active) and (not led_play2.Active) then
    czas.Caption:=FormatDateTime('h:nn:ss',IntegerToTime(TimeToInteger-wektor_czasu));
end;

function TFMain.SendToAll(aAdres: string; aRodzaj, aKod: integer;
  const aWartosc: string): boolean;
var
  n: integer;
  s: string;
begin
  result:=false;
  if tcp.Active then
  begin
    s:='CTO$'+aAdres+'$'+IntToStr(aRodzaj)+'$'+IntToStr(aKod)+'$'+aWartosc;
    cadd('Ramka-tcp: '+s);
    tcp.SendString(s);
    result:=true;
  end;
end;

function TFMain.SendToAll(aAdres: string; aRodzaj, aKod: integer;
  const aWartosc: integer): boolean;
begin
  result:=SendToAll(aAdres,aRodzaj,aKod,IntToStr(aWartosc));
end;

procedure TFMain.init_stacje;
var
  e: TValueListEditor;
  i: integer;
  key: string;
  def: integer;
begin
  _RADIO_LIST_UPDATE:=false;
  def:=PropStorage.ReadInteger('RadioIndex',-1);

  ComboBox1.Clear;
  stacje_adresy.Clear;
  stacje_pokoje.Clear;
  dm.db_stacje.Open;
  while not dm.db_stacje.EOF do
  begin
    ComboBox1.Items.Add(dm.db_stacje.FieldByName('nazwa').AsString);
    stacje_adresy.Add(dm.db_stacje.FieldByName('url').AsString);
    stacje_pokoje.Add(dm.db_stacje.FieldByName('chat').AsString);
    dm.db_stacje.Next;
  end;
  dm.db_stacje.Close;

  //i:=StringToItemIndex(ComboBox1.Items,def);
  i:=def;
  if i=-1 then i:=StringToItemIndex(ComboBox1.Items,'Forte Plus');
  if i=-1 then if ComboBox1.Items.Count>0 then i:=0;
  if i>-1 then ComboBox1.ItemIndex:=i;
end;

procedure TFMain.init_preferences;
var
  adres: string;
begin
  uETilePanel0.Visible:=_SHOW_KINO;
  uETilePanel1.Visible:=_SHOW_RADIO;
  uETilePanel2.Visible:=_SHOW_RECORDER;
  uETilePanel3.Visible:=_SHOW_PLAYER;
  Panel1.Height:=10;
  FMain.Height:=Panel1.Height;
  FMain.Update;
  if _RADIO_LIST_UPDATE then
  begin
    adres:=stacje_adresy[ComboBox1.ItemIndex];
    init_stacje;
    if stacje_adresy[ComboBox1.ItemIndex]<>adres then ComboBox1Change(nil);
  end;
  przyciski_radia_update;
  if _DEV_CHAT_CREATE then FChat.InitService;
  if _SHOW_CONSOLE then
  begin
    if not FConsola.Showing then
    begin
      FConsola.Show;
      FConsola.Info;
    end;
    film.TimerDump:=true;
    radio.TimerDump:=true;
    player.TimerDump:=true;
    player2.TimerDump:=true;
  end else begin
    film.TimerDump:=false;
    radio.TimerDump:=false;
    player.TimerDump:=false;
    player2.TimerDump:=false;
    if FConsola.Showing then
    begin
      FConsola.NoClose:=false;
      FConsola.Close;
    end;
  end;
  if _SERVER_ON then tcp.Connect else tcp.Disconnect;
end;

procedure TFMain.init_nagrania;
begin
  if FileExists(_DIR_TAP+_FF+'nagrania.dat') then wczytaj_dumpu_play else ListBox1.Clear;
  IsDumpFile:=FileExists(_DIR_TAP+_FF+'stream.dump');
  kaseta1.Visible:=IsDumpFile;
  przyciski;
end;

function TFMain.CzyToJestFilm(aIndex: integer): boolean;
var
  s,ext: string;
  i: integer;
begin
  result:=false;
  if aIndex=-1 then exit;
  s:=PlayerMultimedia.PlikiItems[aIndex];
  if pos('[',s)=1 then exit;
  ext:=ExtractFileExt(s);
  for i:=0 to ExtFilmsCount-1 do if upcase(ext)=upcase(ExtFilms[i]) then
  begin
    result:=true;
    break;
  end;
end;

function TFMain.CzyToJestFilm(aFilename: string): boolean;
var
  ext: string;
  i: integer;
begin
  result:=false;
  ext:=ExtractFileExt(aFilename);
  for i:=0 to ExtFilmsCount-1 do if upcase(ext)=upcase(ExtFilms[i]) then
  begin
    result:=true;
    break;
  end;
end;

function TFMain.DodajPlikDoPlaylisty(aFilename: string; t: UOSPlayer.TIDTag
  ): string;
var
  nazwa,nazwa2: string;
  bfilm: boolean;
begin
  nazwa:=ExtractFilename(aFilename);
  nazwa2:=nazwa;
  bfilm:=CzyToJestFilm(nazwa);
  PlayerMultimedia.PlikiAdd(aFilename);
  try
    if bfilm then list1.Items.Add(nazwa) else
    if PlayerMultimedia.TagGet(aFilename,t) then
    begin
      nazwa2:=t.Artist+' - '+t.Title+' - ('+t.Album+')';
      list1.Items.Add(nazwa2);
    end else
    list1.Items.Add(nazwa);
  except
    list1.Items.Add(nazwa);
  end;
  result:=nazwa2;
end;

procedure TFMain.RamkaToPlaylista(aRamka: string);
var
  i: integer;
  plik,ramka: string;
  t: UOSPlayer.TIDTag;
begin
  PlayerMultimedia.TagInfoStart;
  try
    ramka:='';
    i:=1;
    while true do
    begin
      plik:=GetLineToStr(aRamka,i,#9);
      if plik='' then break;
      ramka:=ramka+DodajPlikDoPlaylisty(plik,t)+#9;
      inc(i);
    end;
    SendToAll('[ALL]',1,202,ramka);
  finally
    PlayerMultimedia.TagInfoStop;
  end;
end;

function TFMain.RemoveFile(aFile: TFilename): boolean;
begin
  {$IFDEF WINDOWS}
  result:=DeleteFile(pchar(aFile));
  {$ELSE}
  result:=DeleteFile(aFile);
  {$ENDIF}
end;

procedure TFMain.przyciski;
begin
  if radio.Playing and (not radio.Paused) then play.ImageIndex:=1 else play.ImageIndex:=0;
  if (radio.Playing or radio.Paused) and (not led_play.Active) and (not led_play2.Active) then status.Font.Color:=clBlack else status.Font.Color:=clSilver;
  if led_play.Active then deck1.Font.Color:=clBlack else deck1.Font.Color:=clSilver;
  if led_play2.Active then deck2.Font.Color:=clBlack else deck2.Font.Color:=clSilver;
  ComboBox1.Enabled:=not led_rec.Active;
  play.Enabled:=((not radio.Playing) or (radio.Playing or radio.Paused)) and (not led_rec.Active);
  stop.Enabled:=(radio.Playing or radio.Paused) and (not led_rec.Active);
  rec.Enabled:=radio.Playing and (not led_rec.Active) and (not led_play.Active) and (not led_play2.Active) and led_radio.Active;
  rec_play.Enabled:=IsDumpFile and (not led_rec.Active) and (not led_play.Active) and (not led_play2.Active);
  rec_stop.Enabled:=led_rec.Active or led_play.Active;
  rec_eject.Enabled:=IsDumpFile and (not led_rec.Active) and (not led_play.Active) and (not led_play2.Active);
  play_play.Enabled:=(ListBox1.ItemIndex>-1) and (not led_play.Active) and (not led_play2.Active) and (not led_rec.Active);
  play_stop.Enabled:=led_play2.Active;
  kaseta1.Animate:=led_rec.Active or led_play.Active;
  kaseta2.Visible:=led_play2.Active;
  //VolumeRadio.Enabled:=not led_rec.Active;
end;

procedure TFMain.przyciski_radia_update;
begin
  SpeedButton6.Enabled:=stacje_pokoje[ComboBox1.ItemIndex]<>'';
  SpeedButton7.Enabled:=SpeedButton6.Enabled;
  SpeedButton8.Enabled:=SpeedButton6.Enabled;
  SpeedButton9.Enabled:=SpeedButton6.Enabled;
end;

procedure TFMain.wczytaj_dumpu_play;
var
  i,a: integer;
  s: string;
  fs : TFormatSettings;
begin
  ListBox1.Items.LoadFromFile(_DIR_TAP+_FF+'nagrania.dat');
  for i:=0 to ListBox1.Count-1 do
  begin
    s:=ListBox1.Items[i];
    if pos(FLAGA_DECK,s)>0 then
    begin
      kaseta.index:=i;
      a:=pos(FLAGA_DECK,s);
      delete(s,a,1000);
      s:=trim(s);
      a:=pos(':',s);
      kaseta.radio:=trim(copy(s,1,a-1));
      delete(s,1,a+1);
      fs.DateSeparator:='-';
      fs.ShortDateFormat:='y/m/d';
      fs.TimeSeparator:=':';
      fs.ShortTimeFormat:='h:n:s';
      kaseta.czas_nagrania:=StrToDateTime(s,fs);
      IsDumpFile:=true;
    end;
  end;
end;

function TFMain.DumpForListToFilename(aIndex: integer): string;
var
  i,a: integer;
  ss,nazwa: string;
  b: boolean;
  czas_nagrania: TDateTime;
  fs : TFormatSettings;
begin
  b:=false;
  ss:=ListBox1.Items[aIndex];
  if pos(FLAGA_DECK,ss)>0 then
  begin
    b:=true;
    a:=pos(FLAGA_DECK,ss);
    delete(ss,a,1000);
    ss:=trim(ss);
  end;
  a:=pos(':',ss);
  nazwa:=trim(copy(ss,1,a-1));
  delete(ss,1,a+1);
  fs.DateSeparator:='-';
  fs.ShortDateFormat:='y/m/d';
  fs.TimeSeparator:=':';
  fs.ShortTimeFormat:='h:n:s';
  czas_nagrania:=StrToDateTime(ss,fs);
  if b then result:='stream.dump' else result:='stream.'+StringReplace(nazwa,' ','_',[rfReplaceAll])+'.'+FormatDateTime('yyyymmddhhnnss',czas_nagrania)+'.dump';
end;

procedure TFMain.add_track_to_cue;
var
  t: integer;
begin
  if ff_czas=-1 then
  begin
    ff_czas:=TimeToInteger;
    t:=0;
  end else t:=TimeToInteger-ff_czas;
  inc(ff_track);
end;

function TFMain.wersja(zapytanie: integer): string;
var
  v1,v2,v3,v4: integer;
begin
  GetProgramVersion(v1,v2,v3,v4);
  case zapytanie of
    1: result:=IntToStr(v1);
    2: result:=IntToStr(v1)+'.'+IntToStr(v2);
    3: result:=IntToStr(v1)+'.'+IntToStr(v2)+'.'+IntToStr(v3);
    4: result:=IntToStr(v1)+'.'+IntToStr(v2)+'.'+IntToStr(v3)+'-'+IntToStr(v4);
  end;
end;

function sTimeToInteger(s: string): integer;
var
  s1,s2,s3,s4: string;
begin
  s1:=GetLineToStr(s,1,':');
  s2:=GetLineToStr(s,2,':');
  s3:=GetLineToStr(s,3,':');
  s4:=GetLineToStr(s,4,':');
  if s4='' then
  begin
    (* NN:SS:ZZZ *)
    result:=(StrToInt(s1)*60*1000)+(StrToInt(s2)*1000)+StrToInt(s3);
  end else begin
    (* HH:NN:SS:ZZZ *)
    result:=(StrToInt(s1)*60*60*1000)+(StrToInt(s2)*60*1000)+(StrToInt(s3)*1000)+StrToInt(s4);
  end;
end;

procedure TFMain.load_cue(filename: string);
var
  tab: TStringList;
  s,pom: string;
  i,licznik,a,b,c,d: integer;
begin
  licznik:=0;
  tab:=TStringList.Create;
  try
    tab.LoadFromFile(filename);
    for i:=0 to tab.Count-1 do
    begin
      s:=tab[i];
      if i=0 then cue.performer:=GetLineToStr(s,2,' ') else
      if i=1 then cue.title:=GetLineToStr(s,2,' ') else
      if i>=3 then
      begin
        a:=pos('  TRACK',s);
        b:=pos(#9,s);
        if (a>0) and (b=0) then inc(licznik);
      end;
    end;
    cue.count:=licznik;
    SetLength(tracks,licznik+1);
    licznik:=0;
    for i:=3 to tab.Count-1 do
    begin
      s:=tab[i];
      a:=pos('  TRACK',s);
      b:=pos(#9+'TITLE',s);
      c:=pos(#9+'PERFORMER',s);
      d:=pos(#9+'INDEX',s);
      if a>0 then tracks[licznik].track:=StrToInt(GetLineToStr(trim(s),2,' ')) else
      if b>0 then tracks[licznik].title:=GetLineToStr(trim(s),2,' ') else
      if c>0 then tracks[licznik].performer:=GetLineToStr(trim(s),2,' ') else
      if d>0 then
      begin
        pom:=GetLineToStr(trim(s),3,' ');
        tracks[licznik].start:=sTimeToInteger('0:'+pom);
        inc(licznik);
      end;
    end;
    tracks[licznik].performer:='null';
    tracks[licznik].title:='null';
    tracks[licznik].track:=-1;
    tracks[licznik].start:=10*60*60*1000;
  finally
    tab.Free;
  end;
  czas_aktualny:=0;
  czas_nastepny:=-1;
end;

procedure TFMain.unload_cue;
begin
  SetLength(tracks,0);
end;

function TFMain.GetVolumeRadio(aValue: single): integer;
begin
  if aValue<0 then result:=round(VolumeRadio.Value/2.7)
              else result:=round(aValue/2.7);
end;

procedure TFMain.ShutdownNow(Sender: TObject);
begin
  timer_shutdown.Enabled:=true;
end;

procedure TFMain.VideoPlayRequest(Sender: TObject; aFilename: string);
begin
  kino(true);
  film.Visible:=true;
  film.Filename:=aFilename;
  film.Volume:=round((VolumePlayer.Value/270)*100);
  film.Play;
end;

procedure TFMain.VideoStopRequest(Sender: TObject);
begin
  film.Stop;
  film.Visible:=false;
end;

procedure TFMain.VideoPauseRequest(Sender: TObject);
begin
  film.Pause;
end;

procedure TFMain.VideoReplayRequest(Sender: TObject);
begin
  film.Replay;
end;

procedure TFMain.Kino(aON: boolean);
var
  a: integer;
begin
  if timer_film_off.Enabled then
  begin
    timer_film_off.Enabled:=false;
    exit;
  end;
  if _SHOW_KINO then
  begin
    film.Top:=uETilePanelTitle.Height+2+uETilePanel00.Top+1;
    film.Left:=uETilePanel00.Left+1;
    film.Height:=uETilePanel00.Height-1;
    film.Width:=uETilePanel00.Width-1;
    exit;
  end else begin
    if aON then
    begin
      a:=0;
      if uETilePanel1.Visible and uETilePanel2.Visible then inc(a,uETilePanel1.Height+uETilePanel2.Height+2) else
      if uETilePanel1.Visible then inc(a,uETilePanel1.Height) else
      if uETilePanel2.Visible then inc(a,uETilePanel2.Height) else a:=283;
      UETilePanel0.Height:=a;
      film.Top:=uETilePanelTitle.Height+2+uETilePanel00.Top+1;
      film.Left:=uETilePanel00.Left+1;
      film.Height:=a-16-1;
      film.Width:=uETilePanel00.Width-1;
    end;
  end;
  if aON then
  begin
    uETilePanel0.Visible:=true;
    uETilePanel1.Visible:=false;
    uETilePanel2.Visible:=false;
  end else begin
    uETilePanel0.Visible:=_SHOW_KINO;
    uETilePanel1.Visible:=_SHOW_RADIO;
    uETilePanel2.Visible:=_SHOW_RECORDER;
    UETilePanel0.Height:=283;
  end;
end;

var
  OriginalWindowState: TWindowState;
  OriginalBounds: TRect;
  OriginalFilm: TRect;

procedure TFMain.FilmFullScreen(aOn: boolean);
begin
  {$IFDEF UNIX}
  if aOn then
  begin
    if __FULL_SCREEN then exit;
    OriginalFilm:=film.BoundsRect;
    film.Anchors:=[akTop,akLeft,akBottom,akRight];
    film.Top:=0;
    film.Left:=0;
    film.Height:=FMain.Height;
    film.Width:=FMain.Width;
    OriginalWindowState:=WindowState;
    OriginalBounds:=BoundsRect;
    WindowState:=wsFullScreen;
    film.Cursor:=crNone;
    __FULL_SCREEN:=true;
  end else begin
    if not __FULL_SCREEN then exit;
    film.Anchors:=[akTop,akLeft];
    WindowState:=OriginalWindowState;
    WindowState:=wsFullScreen;
    WindowState:=OriginalWindowState;
    BoundsRect:=OriginalBounds;
    film.Cursor:=crDefault;
    film.BoundsRect:=OriginalFilm;
    __FULL_SCREEN:=false;
  end;
  {$ELSE}
  if aOn then begin
    if __FULL_SCREEN then exit;
    OriginalBounds:=BoundsRect;
    OriginalFilm:=film.BoundsRect;
    film.Anchors:=[akTop,akLeft,akBottom,akRight];
    film.Top:=0;
    film.Left:=0;
    film.Height:=FMain.Height;
    film.Width:=FMain.Width;
    film.Cursor:=crNone;
    WindowState:=wsMaximized;
    SetWindowLong(Handle,GWL_STYLE,GetWindowLong(Handle,GWL_STYLE) and not WS_CAPTION);
    ClientHeight:=Height;
    __FULL_SCREEN:=true;
  end else begin
    if not __FULL_SCREEN then exit;
    WindowState:=wsNormal;
    SetWindowLong(Handle,gwl_Style,GetWindowLong(Handle,gwl_Style) or ws_Caption or ws_border);
    ClientHeight := Height + GetSystemMetrics(SM_CYCAPTION);
    refresh;
    BoundsRect:=OriginalBounds;
    film.Cursor:=crDefault;
    film.BoundsRect:=OriginalFilm;
    __FULL_SCREEN:=false;
  end;
  {$ENDIF}
end;

procedure TFMain.SetPositionFromX(AMouseX, AMouseMax: integer);
var
  max,a: longword;
  maxt,at: single;
begin
  if PlayerMultimedia.IsStopping then exit;
  if film.Visible then
  begin
    if film.Duration<0.0000000001 then exit;
    max:=TimeToInteger(film.Duration/SecsPerDay);
    if max=0 then exit;
    a:=round(max*AMouseX/AMouseMax);
    film.SendMPlayerCommand('seek '+IntToStr(round(a/1000))+' 2');
    exit;
  end;
  case PlayerMultimedia.GetPlayerIndex of
    1: maxt:=PlayerMultimedia.GetPlayerLength(1);
    2: maxt:=PlayerMultimedia.GetPlayerLength(2);
    3: maxt:=PlayerMultimedia.GetPlayerLength(3);
    4: maxt:=PlayerMultimedia.GetPlayerLength(4);
  end;
  if maxt=0 then exit;
  at:=maxt*AMouseX/AMouseMax;
  PlayerMultimedia.SeekPlayer(at);
end;

procedure TFMain.OnTrybOdtwarzaniaRequest(Sender: TObject; var aTryb: integer);
begin
  aTryb:=PlayerOptTryb.ImageIndex-18;
end;

procedure TFMain.OnPlayerPlay(Sender: TObject);
begin

end;

procedure TFMain.OnPlayerStop(Sender: TObject);
begin
  { z procedury cleaning }
  stat_position.Position:=0;
  Label1.Caption:='-:--';
  Label2.Caption:='-:--';
  SendToAll('[ALL]',1,104);
end;

procedure TFMain.OnPlayerPause(Sender: TObject; aPaused: boolean);
var
  s: string;
begin
  ppause.Visible:=aPaused;
  pplay.Visible:=not aPaused;
  if aPaused then s:='1' else s:='0';
  SendToAll('[ALL]',1,105,s);
end;

procedure TFMain.OnPlayerListUpdateRequest(Sender: TObject);
begin
  list1.Refresh;
  SendToAll('[ALL]',1,102,PlayerMultimedia.GetII);
end;

procedure TFMain.OnPlayerStatusRequest(Sender: TObject; var aPosL, aPosR: single
  );
begin
  aPosL:=A3nalogGauge1.Position;
  aPosR:=A3nalogGauge2.Position;
end;

procedure TFMain.OnPlayerStatusSet(Sender: TObject; aPosL, aPosR: single);
begin
  if aPosL<0 then aPosL:=0;
  if aPosR<0 then aPosR:=0;
  A3nalogGauge1.Position:=aPosL;
  A3nalogGauge2.Position:=aPosR;
end;

procedure TFMain.OnPlayerLedsSet(Sender: TObject; aIndex: integer;
  aActive: boolean);
begin
  case aIndex of
    1: led1.Active:=aActive;
    2: led2.Active:=aActive;
    3: led3.Active:=aActive;
    4: led4.Active:=aActive;
    5: ledF.Active:=aActive;
  end;
end;

procedure TFMain.OnPlayerStatPositionSet(Sender: TObject; sPos, sMax: string;
  aPos, aMax: longword);
begin
  if aMax=0 then
  begin
    OnPlayerStop(nil);
    exit;
  end;
  stat_position.Max:=aMax div 1000;
  stat_position.Position:=aPos div 1000;
  {$IFDEF MSWINDOWS}
  stat_position.Refresh;
  {$ENDIF}
  Label1.Caption:=sPos;
  Label2.Caption:=sMax;
  SendToAll('[ALL]',1,103,IntToStr(stat_position.Position)+#9+IntToStr(stat_position.Max)+#9+sPos+#9+sMax);
end;

initialization
  {$I gif.lrs}

end.

