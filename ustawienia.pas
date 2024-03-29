unit ustawienia;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, Spin, ColorBox, ComCtrls, DBGrids, AsyncProcess,
  ZDataset, RxXMLPropStorage, ExtMessage, db, process, IniFiles;

type

  { TFUstawienia }

  TFUstawienia = class(TForm)
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    ListBox1: TListBox;
    proc1: TAsyncProcess;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    cache: TSpinEdit;
    cache1: TSpinEdit;
    ChatBackgroundColor: TColorBox;
    ChatRegister: TCheckBox;
    CheckBox1: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    CLEAR_CONFIG: TCheckBox;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    DBGrid1: TDBGrid;
    db_stacje: TZQuery;
    db_stacjechat: TMemoField;
    db_stacjeid: TLargeintField;
    db_stacjenazwa: TMemoField;
    db_stacjeurl: TMemoField;
    ds_stacje: TDataSource;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    FontsSize: TSpinEdit;
    force_room: TEdit;
    bot_room: TEdit;
    GroupBox3: TGroupBox;
    haslo: TEdit;
    bot_haslo: TEdit;
    HistMemLinesCode: TSpinEdit;
    Image1: TImage;
    ImageList1: TImageList;
    KlickOff: TCheckBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label3: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label4: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label5: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label57: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    ListFonts: TComboBox;
    film_font: TComboBox;
    mess: TExtMessage;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    proc2: TAsyncProcess;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    PropStorage: TRxXMLPropStorage;
    SerwerOn: TCheckBox;
    ShowConsole: TCheckBox;
    LogToConsole: TCheckBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    TabSheet7: TTabSheet;
    TestBeep: TSpeedButton;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    st_cancel: TSpeedButton;
    st_dodaj: TSpeedButton;
    st_edytuj: TSpeedButton;
    st_ok: TSpeedButton;
    st_usun: TSpeedButton;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    uzytkownik: TEdit;
    bot_user: TEdit;
    wypelnienie: TSpinEdit;
    wypelnienie1: TSpinEdit;
    zaraz_wracam: TEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure bot_hasloChange(Sender: TObject);
    procedure bot_roomChange(Sender: TObject);
    procedure bot_userChange(Sender: TObject);
    procedure cache1Change(Sender: TObject);
    procedure cacheChange(Sender: TObject);
    procedure ChatBackgroundColorChange(Sender: TObject);
    procedure ChatRegisterChange(Sender: TObject);
    procedure CheckBox10Change(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure CheckBox2Change(Sender: TObject);
    procedure CheckBox3Change(Sender: TObject);
    procedure CheckBox4Change(Sender: TObject);
    procedure CheckBox5Change(Sender: TObject);
    procedure CheckBox6Change(Sender: TObject);
    procedure CheckBox7Change(Sender: TObject);
    procedure CheckBox8Change(Sender: TObject);
    procedure CheckBox9Change(Sender: TObject);
    procedure CLEAR_CONFIGChange(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure ds_stacjeDataChange(Sender: TObject; Field: TField);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure Edit5Change(Sender: TObject);
    procedure Edit6Change(Sender: TObject);
    procedure Edit7Change(Sender: TObject);
    procedure Edit8Change(Sender: TObject);
    procedure film_fontChange(Sender: TObject);
    procedure FontsSizeChange(Sender: TObject);
    procedure force_roomChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure hasloChange(Sender: TObject);
    procedure HistMemLinesCodeChange(Sender: TObject);
    procedure KlickOffChange(Sender: TObject);
    procedure ListFontsChange(Sender: TObject);
    procedure LogToConsoleChange(Sender: TObject);
    procedure SerwerOnChange(Sender: TObject);
    procedure ShowConsoleChange(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure TestBeepClick(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure st_cancelClick(Sender: TObject);
    procedure st_dodajClick(Sender: TObject);
    procedure st_edytujClick(Sender: TObject);
    procedure st_okClick(Sender: TObject);
    procedure st_usunClick(Sender: TObject);
    procedure uzytkownikChange(Sender: TObject);
    procedure wypelnienie1Change(Sender: TObject);
    procedure wypelnienieChange(Sender: TObject);
    procedure zaraz_wracamChange(Sender: TObject);
    procedure _OPEN_URL(Sender: TObject);
    procedure _RADIO_BUTTONS(Sender: TObject);
    procedure _TAB_CLICK(Sender: TObject);
    procedure _ZMIANA(DataSet: TDataSet);
  private
    bot_conf: TIniFile;
    vMajorVersion,vMinorVersion,vRelease,vBuild: integer;
    procedure init;
    function czy_jest_nowsza_wersja(v1,v2,v3,v4: integer): boolean;
    procedure conf_load;
    procedure conf_save;
  public
    OUT_OK: boolean;
  end;

var
  FUstawienia: TFUstawienia;

implementation

uses
  config, cverinfo, ecode, lclintf, bot_edytor_kodu;

{$R *.lfm}

{ TFUstawienia }

procedure TFUstawienia._OPEN_URL(Sender: TObject);
begin
  OpenUrl(TLabel(Sender).Caption);
end;

procedure TFUstawienia._RADIO_BUTTONS(Sender: TObject);
begin
  _SHUTDOWN_MODE:=TRadioButton(Sender).Tag;
  Edit1.Enabled:=RadioButton5.Checked;
end;

procedure TFUstawienia._TAB_CLICK(Sender: TObject);
begin
  PageControl1.ActivePageIndex:=TSpeedButton(Sender).Tag;
end;

procedure TFUstawienia._ZMIANA(DataSet: TDataSet);
begin
  _RADIO_LIST_UPDATE:=true;
end;

procedure TFUstawienia.init;
begin
  KlickOff.Checked:=_OFF_CHAT_SOUND_INFO;
  SerwerOn.Checked:=_SERVER_ON;
  CheckBox8.Checked:=_VIDEO_MPV;
  CheckBox9.Checked:=_VIDEO_MPV_OSC;
  CheckBox7.Checked:=_SHOW_KINO;
  CheckBox1.Checked:=_SHOW_RADIO;
  CheckBox2.Checked:=_SHOW_RECORDER;
  CheckBox3.Checked:=_SHOW_PLAYER;
  CheckBox4.Checked:=_AUTOSTART_PLAYER;
  CheckBox6.Checked:=_OFF_CHAT_IMG;
  ComboBox1.ItemIndex:=_CHAT_SOUND;
  zaraz_wracam.Text:=_CHAT_BOOT_AUTORESPONSE;
  ListFonts.Text:=_CHAT_FONT_NAME;
  FontsSize.Value:=_CHAT_FONT_SIZE;
  ChatBackGroundColor.Selected:=_CHAT_BACKGROUND_COLOR;
  Edit1.Text:=_SHUTDOWN_CMD;
  CheckBox5.Checked:=_VIDEO_FS_DEFAULT;
  ShowConsole.Checked:=_SHOW_CONSOLE;
  film_font.Text:=_VIDEO_FONT_NAME;
  ComboBox3.ItemIndex:=_VIDEO_FONT_FACTOR;
  Edit2.Text:=_VIDEO_ALANG_DEFAULT;
  Edit3.Text:=_VIDEO_SLANG_DEFAULT;
  ComboBox2.ItemIndex:=_VIDEO_ISO_DEFAULT;
  SpinEdit1.Value:=_VIDEO_SUBPOS_DEFAULT;
  SpinEdit2.Value:=_VIDEO_SUBSCALE_DEFAULT;
  {bot}
  bot_room.Text:=_BOT_ROOM;
  bot_user.Text:=_BOT_USER;
  bot_haslo.Text:=_BOT_PASSW;
  CheckBox10.Checked:=_DEV_CHAT_SHOW_BOT_CODE;
end;

function TFUstawienia.czy_jest_nowsza_wersja(v1, v2, v3, v4: integer): boolean;
begin
  if (v1>vMajorVersion) or
  ((v1=vMajorVersion) and (v2>vMinorVersion)) or
  ((v1=vMajorVersion) and (v2=vMinorVersion) and (v3>vRelease)) or
  ((v1=vMajorVersion) and (v2=vMinorVersion) and (v3=vRelease) and (v4>vBuild))
  then result:=true else result:=false;
end;

procedure TFUstawienia.conf_load;
begin
  _BOT_ROOM:=bot_conf.ReadString('root','BotRoom','');
  _BOT_USER:=bot_conf.ReadString('root','BotUser','Bot');
  _BOT_PASSW:=DecryptString(bot_conf.ReadString('root','BotPassw',''),POLFAN_TOKEN,true);
end;

procedure TFUstawienia.conf_save;
begin
  bot_conf.WriteString('root','BotRoom',_BOT_ROOM);
  bot_conf.WriteString('root','BotUser',_BOT_USER);
  bot_conf.WriteString('root','BotPassw',EncryptString(_BOT_PASSW,POLFAN_TOKEN,100));
end;

procedure TFUstawienia.CheckBox2Change(Sender: TObject);
begin
  _SHOW_RECORDER:=CheckBox2.Checked;
end;

procedure TFUstawienia.ChatBackgroundColorChange(Sender: TObject);
begin
  _CHAT_BACKGROUND_COLOR:=ChatBackGroundColor.Selected;
end;

procedure TFUstawienia.cacheChange(Sender: TObject);
begin
  _RADIO_CACHE:=cache.Value;
end;

procedure TFUstawienia.BitBtn1Click(Sender: TObject);
begin
  OUT_OK:=true;
  close;
end;

procedure TFUstawienia.BitBtn2Click(Sender: TObject);
begin
  if proc1.Running then proc1.Terminate(0);
  {$IFDEF WINDOWS}
  proc1.Executable:=MyDir('pbot.exe');
  {$ELSE}
  proc1.Executable:=MyDir('pbot');
  {$ENDIF}
  proc1.Parameters.Clear;
  proc1.Parameters.Add('start');
  proc1.Execute;
end;

procedure TFUstawienia.BitBtn3Click(Sender: TObject);
begin
  FBotEdytorKodu:=TFBotEdytorKodu.Create(self);
  FBotEdytorKodu.ShowModal;
end;

procedure TFUstawienia.BitBtn4Click(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  proc2.Executable:=MyDir('pbot.exe');
  {$ELSE}
  proc2.Executable:=MyDir('pbot');
  {$ENDIF}
  proc2.Parameters.Clear;
  proc2.Parameters.Add('stop');
  proc2.Execute;
  sleep(1000);
  proc1.Terminate(0);
  proc2.Terminate(0);
end;

procedure TFUstawienia.BitBtn5Click(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  proc2.Executable:=MyDir('pbot.exe');
  {$ELSE}
  proc2.Executable:=MyDir('pbot');
  {$ENDIF}
  proc2.Parameters.Clear;
  proc2.Parameters.Add('reload');
  proc2.Execute;
  sleep(1000);
  proc2.Terminate(0);
end;

procedure TFUstawienia.bot_hasloChange(Sender: TObject);
begin
  _BOT_PASSW:=bot_haslo.Text;
end;

procedure TFUstawienia.bot_roomChange(Sender: TObject);
begin
  _BOT_ROOM:=bot_room.Text;
end;

procedure TFUstawienia.bot_userChange(Sender: TObject);
begin
  _BOT_USER:=bot_user.Text;
end;

procedure TFUstawienia.cache1Change(Sender: TObject);
begin
  _FILM_CACHE:=cache1.Value;
end;

procedure TFUstawienia.ChatRegisterChange(Sender: TObject);
begin
  _CHAT_REGISTER:=ChatRegister.Checked;
end;

procedure TFUstawienia.CheckBox10Change(Sender: TObject);
begin
  _DEV_CHAT_SHOW_BOT_CODE:=CheckBox10.Checked;
end;

procedure TFUstawienia.CheckBox1Change(Sender: TObject);
begin
  _SHOW_RADIO:=CheckBox1.Checked;
end;

procedure TFUstawienia.CheckBox3Change(Sender: TObject);
begin
  _SHOW_PLAYER:=CheckBox3.Checked;
end;

procedure TFUstawienia.CheckBox4Change(Sender: TObject);
begin
  _AUTOSTART_PLAYER:=CheckBox4.Checked;
end;

procedure TFUstawienia.CheckBox5Change(Sender: TObject);
begin
  _VIDEO_FS_DEFAULT:=CheckBox5.Checked;
end;

procedure TFUstawienia.CheckBox6Change(Sender: TObject);
begin
  _OFF_CHAT_IMG:=CheckBox6.Checked;
end;

procedure TFUstawienia.CheckBox7Change(Sender: TObject);
begin
  _SHOW_KINO:=CheckBox7.Checked;
end;

procedure TFUstawienia.CheckBox8Change(Sender: TObject);
begin
  _VIDEO_MPV:=CheckBox8.Checked;
end;

procedure TFUstawienia.CheckBox9Change(Sender: TObject);
begin
  _VIDEO_MPV_OSC:=CheckBox9.Checked;
end;

procedure TFUstawienia.CLEAR_CONFIGChange(Sender: TObject);
var
  b: boolean;
begin
  b:=CLEAR_CONFIG.Checked;
  if b then
  begin
    if not mess.ShowWarningYesNo(RS_CLEAR_CONF_WARNING_1+':^^'+RS_CLEAR_CONF_WARNING_2+'^^'+RS_CLEAR_CONF_WARNING_3+'^^'+RS_CLEAR_CONF_WARNING_4) then
    begin
      CLEAR_CONFIG.Checked:=false;
      b:=false;
    end;
  end;
  _DEV_CLEAR_CONFIG:=b;
end;

procedure TFUstawienia.ComboBox1Change(Sender: TObject);
begin
  _CHAT_SOUND:=ComboBox1.ItemIndex;
end;

procedure TFUstawienia.ComboBox2Change(Sender: TObject);
begin
  _VIDEO_ISO_DEFAULT:=ComboBox2.ItemIndex;
end;

procedure TFUstawienia.ComboBox3Change(Sender: TObject);
begin
  _VIDEO_FONT_FACTOR:=ComboBox3.ItemIndex;
end;

procedure TFUstawienia.ds_stacjeDataChange(Sender: TObject; Field: TField);
var
  aktywne,edycja,pusta: boolean;
begin
  aktywne:=db_stacje.Active;
  if aktywne then
  begin
    edycja:=db_stacje.State in [dsEdit,dsInsert];
    pusta:=db_stacje.IsEmpty;
  end;
  st_dodaj.Enabled:=aktywne and (not edycja);
  st_edytuj.Enabled:=aktywne and (not edycja) and (not pusta);
  st_usun.Enabled:=st_edytuj.Enabled and (db_stacjeid.AsInteger<>1);
  st_ok.Enabled:=aktywne and edycja;
  st_cancel.Enabled:=st_ok.Enabled;
end;

procedure TFUstawienia.Edit1Change(Sender: TObject);
begin
  _SHUTDOWN_CMD:=Edit1.Text;
end;

procedure TFUstawienia.Edit2Change(Sender: TObject);
begin
  _VIDEO_ALANG_DEFAULT:=Edit2.Text;
end;

procedure TFUstawienia.Edit3Change(Sender: TObject);
begin
  _VIDEO_SLANG_DEFAULT:=Edit3.Text;
end;

procedure TFUstawienia.Edit4Change(Sender: TObject);
begin
  _CHAT_SKROT_F3:=Edit4.Text;
end;

procedure TFUstawienia.Edit5Change(Sender: TObject);
begin
  _CHAT_SKROT_F4:=Edit5.Text;
end;

procedure TFUstawienia.Edit6Change(Sender: TObject);
begin
  _CHAT_SKROT_F5:=Edit6.Text;
end;

procedure TFUstawienia.Edit7Change(Sender: TObject);
begin
  _CHAT_SKROT_F6:=Edit7.Text;
end;

procedure TFUstawienia.Edit8Change(Sender: TObject);
begin
  _CHAT_SKROT_F7:=Edit8.Text;
end;

procedure TFUstawienia.film_fontChange(Sender: TObject);
begin
  _VIDEO_FONT_NAME:=film_font.Text;
end;

procedure TFUstawienia.FontsSizeChange(Sender: TObject);
begin
  _CHAT_FONT_SIZE:=FontsSize.Value;
end;

procedure TFUstawienia.force_roomChange(Sender: TObject);
begin
  _POLFAN_FORCE_ROOM:=force_room.Text;
end;

procedure TFUstawienia.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  conf_save;
  db_stacje.Close;
  CloseAction:=caFree;
end;

procedure TFUstawienia.FormCreate(Sender: TObject);
var
  s1,s2,s3: string;
begin
  PropStorage.FileName:=MyConfDir('config.xml');
  PropStorage.Active:=true;
  bot_conf:=TIniFile.Create(_BOT_DIR+_FF+'config_bot.ini');
  conf_load;
  PageControl1.ShowTabs:=false;
  GetProgramVersion(vMajorVersion,vMinorVersion,vRelease,vBuild);
  GetProgramVersion(s1,s2,s3);
  Label2.Caption:='v.'+s3;
  cache.Value:=_RADIO_CACHE;
  wypelnienie.Value:=_RADIO_CACHE_MIN;
  cache1.Value:=_FILM_CACHE;
  wypelnienie1.Value:=_FILM_CACHE_MIN;
  uzytkownik.Text:=_POLFAN_USER;
  haslo.Text:=_POLFAN_PASSW;
  force_room.Text:=_POLFAN_FORCE_ROOM;
  HistMemLinesCode.Value:=_HIST_MEM_LINES_CODE;
  ChatRegister.Checked:=_CHAT_REGISTER;
  LogToConsole.Checked:=_CHAT_LOG_TO_CONSOLA;
  ListFonts.Items:=Screen.Fonts;
  film_font.Items.Assign(ListFonts.Items);
  ListBox1.Items.Assign(_CHAT_SLOWA_SI);
  Edit4.Text:=_CHAT_SKROT_F3;
  Edit5.Text:=_CHAT_SKROT_F4;
  Edit6.Text:=_CHAT_SKROT_F5;
  Edit7.Text:=_CHAT_SKROT_F6;
  Edit8.Text:=_CHAT_SKROT_F7;
  {$IFDEF UNIX}
  RadioButton1.Enabled:=true;
  RadioButton2.Enabled:=true;
  RadioButton3.Enabled:=true;
  RadioButton4.Enabled:=false;
  {$ENDIF}
  {$IFDEF WINDOWS}
  RadioButton1.Enabled:=false;
  RadioButton2.Enabled:=false;
  RadioButton3.Enabled:=false;
  RadioButton4.Enabled:=true;
  {$ENDIF}
  case _SHUTDOWN_MODE of
    1: RadioButton1.Checked:=true;
    2: RadioButton2.Checked:=true;
    3: RadioButton3.Checked:=true;
    4: RadioButton4.Checked:=true;
    5: RadioButton5.Checked:=true;
  end;
  Edit1.Enabled:=RadioButton5.Checked;
end;

procedure TFUstawienia.FormDestroy(Sender: TObject);
begin
  bot_conf.Free;
  Propstorage.Active:=false;
end;

procedure TFUstawienia.FormShow(Sender: TObject);
var
  i: integer;
begin
  case PageControl1.ActivePageIndex of
    0: SpeedButton1.Down:=true;
    1: SpeedButton2.Down:=true;
    2: SpeedButton3.Down:=true;
    3: SpeedButton4.Down:=true;
    4: SpeedButton5.Down:=true;
    5: SpeedButton6.Down:=true;
    6: SpeedButton7.Down:=true;
  end;
  init;
  db_stacje.Open;
end;

procedure TFUstawienia.hasloChange(Sender: TObject);
begin
  _POLFAN_PASSW:=haslo.Text;
end;

procedure TFUstawienia.HistMemLinesCodeChange(Sender: TObject);
begin
  _HIST_MEM_LINES_CODE:=HistMemLinesCode.Value;
end;

procedure TFUstawienia.KlickOffChange(Sender: TObject);
begin
  _OFF_CHAT_SOUND_INFO:=KlickOff.Checked;
end;

procedure TFUstawienia.ListFontsChange(Sender: TObject);
begin
  _CHAT_FONT_NAME:=ListFonts.Text;
end;

procedure TFUstawienia.LogToConsoleChange(Sender: TObject);
begin
  _CHAT_LOG_TO_CONSOLA:=LogToConsole.Checked;
end;

procedure TFUstawienia.SerwerOnChange(Sender: TObject);
begin
  _SERVER_ON:=SerwerOn.Checked;
end;

procedure TFUstawienia.ShowConsoleChange(Sender: TObject);
begin
  _SHOW_CONSOLE:=ShowConsole.Checked;
end;

procedure TFUstawienia.SpeedButton8Click(Sender: TObject);
var
  s: string;
begin
  s:=AnsiUpperCase(InputBox('Słowa SI','Nowe słowo:',''));
  if s<>'' then
  begin
    ListBox1.Items.Add(s);
    _CHAT_SLOWA_SI.Assign(ListBox1.Items);
  end;
end;

procedure TFUstawienia.SpeedButton9Click(Sender: TObject);
begin
  if ListBox1.ItemIndex=-1 then exit;
  ListBox1.DeleteSelected;
  _CHAT_SLOWA_SI.Assign(ListBox1.Items);
end;

procedure TFUstawienia.TestBeepClick(Sender: TObject);
begin
  if ComboBox1.ItemIndex=-1 then exit;
  PlayerMultimedia.beep_fx(ComboBox1.ItemIndex);
end;

procedure TFUstawienia.SpinEdit1Change(Sender: TObject);
begin
  _VIDEO_SUBPOS_DEFAULT:=SpinEdit1.Value;
end;

procedure TFUstawienia.SpinEdit2Change(Sender: TObject);
begin
  _VIDEO_SUBSCALE_DEFAULT:=SpinEdit2.Value;
end;

procedure TFUstawienia.st_cancelClick(Sender: TObject);
begin
  db_stacje.Cancel;
end;

procedure TFUstawienia.st_dodajClick(Sender: TObject);
begin
  db_stacje.Append;
end;

procedure TFUstawienia.st_edytujClick(Sender: TObject);
begin
  db_stacje.Edit;
end;

procedure TFUstawienia.st_okClick(Sender: TObject);
begin
  db_stacje.Post;
end;

procedure TFUstawienia.st_usunClick(Sender: TObject);
begin
  if mess.ShowConfirmationYesNo(RS_DELETE_CONFIRMATION_1) then db_stacje.Delete;
end;

procedure TFUstawienia.uzytkownikChange(Sender: TObject);
begin
  _POLFAN_USER:=uzytkownik.Text;
end;

procedure TFUstawienia.wypelnienie1Change(Sender: TObject);
begin
  _FILM_CACHE_MIN:=wypelnienie1.Value;
end;

procedure TFUstawienia.wypelnienieChange(Sender: TObject);
begin
  _RADIO_CACHE_MIN:=wypelnienie.Value;
end;

procedure TFUstawienia.zaraz_wracamChange(Sender: TObject);
begin
  _CHAT_BOOT_AUTORESPONSE:=zaraz_wracam.Text;
end;

end.

