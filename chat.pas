unit chat;

{$mode objfpc}{$H+}

interface

{
    img/drwal.gif  <== ten plik wywala mi aplikację!
}

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, XMLPropStorage,
  Buttons, StdCtrls, ExtCtrls, ComCtrls, Menus, IpHtml,
  ueled, uETilePanel, HtmlView, Polfan, ExtMessage, NetSynHTTP,
  cyPanel, config, Types, db, HtmlGlobals, HTMLUn2, switches, ZDataset;

type

  { TFChat }

  TFChat = class(TForm)
    ButtonChat: TOnOffSwitch;
    code_edit: TSpeedButton;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    get_login: TNetSynHTTP;
    ListBox1: TListBox;
    m_emotki: TZQuery;
    MenuItem9: TMenuItem;
    button_si: TOnOffSwitch;
    www: TNetSynHTTP;
    p_emotki: TZQuery;
    podpowiedz: TPanel;
    SrcDump: TSpeedButton;
    html: THtmlViewer;
    Label1: TLabel;
    Label10: TLabel;
    Label3: TLabel;
    LabelProcesyDownload: TLabel;
    led: TuELED;
    led_download: TuELED;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    N1: TMenuItem;
    get_image: TNetSynHTTP;
    ShowImgTitle: TOnOffSwitch;
    Panel1: TPanel;
    CheckBox2: TCheckBox;
    g_kategorie: TComboBox;
    g_filtr: TEdit;
    html2: THtmlViewer;
    Label6: TLabel;
    Label7: TLabel;
    Panel21: TPanel;
    ColorButton1: TColorButton;
    galeria: TCyPanel;
    Edit1: TEdit;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    mess: TExtMessage;
    ImageList1: TImageList;
    Panel20: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    pomoc: TSpeedButton;
    PopupTabs: TPopupMenu;
    PopupUzytkownicy: TPopupMenu;
    procesy_download: TLabel;
    my_status: TOnOffSwitch;
    SpeedButton1: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    emotki: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    Splitter1: TSplitter;
    TabControl: TTabControl;
    timer_opoznienie: TTimer;
    timer_focus: TTimer;
    uETilePanel1: TuETilePanel;
    uETilePanel2: TuETilePanel;
    uzytkownicy: TListBox;
    web: TPolfan;
    PropStorage: TXMLPropStorage;
    wyslij: TSpeedButton;
    wyslij_source: TSpeedButton;
    procedure BitBtn2Click(Sender: TObject);
    procedure ButtonChatChange(Sender: TObject);
    procedure button_siChange(Sender: TObject);
    procedure CheckBox2Change(Sender: TObject);
    procedure code_editClick(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit1KeyPress(Sender: TObject; var Key: char);
    procedure Edit1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure htmlHotSpotClick(Sender: TObject; const SRC: ThtString;
      var Handled: Boolean);
    procedure htmlImageClick(Sender, Obj: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure htmlImageRequest(Sender: TObject; const SRC: ThtString;
      var Stream: TStream);
    procedure htmlKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure htmlMouseDouble(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure htmlMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure my_statusChange(Sender: TObject);
    procedure m_emotkiBeforeOpen(DataSet: TDataSet);
    procedure ShowImgTitleChange(Sender: TObject);
    procedure pomocClick(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
    procedure emotkiClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure SrcDumpClick(Sender: TObject);
    procedure TabControlChange(Sender: TObject);
    procedure timer_focusTimer(Sender: TObject);
    procedure timer_opoznienieTimer(Sender: TObject);
    procedure TRZY_PRZYCISKI(Sender: TObject);
    procedure uzytkownicyDblClick(Sender: TObject);
    procedure uzytkownicyDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure uzytkownicyMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure webAutoResponseRequest(Sender: TObject; AUser, AMessage: string);
    procedure webBeforeConnect(Sender: TObject; aUser, aFingerPrint,
      aOS: string; var aAccepted: boolean);
    procedure webBeforeReadDocument(Sender: TObject; AName, aNadawca,
      aAdresat: string; AMode: TPolfanRoomMode; AMessage: string; var aDropNow,
      aDeleteFromLogSrc: boolean);
    procedure webClose(Sender: TObject; aErr: integer; aErrorString: string);
    procedure webDownloadNow(Sender: TObject; APrive: string);
    procedure webDownloadRequest(Sender: TObject; AFilename, APrive: string);
    procedure webImageFilename(Sender: TObject; aFilename: string;
      var aNewFilename: string);
    procedure webListUserAdd(Sender: TObject; ARoom, AUsername,
      ADescription: string; aAttr: integer);
    procedure webListUserDeInit(Sender: TObject);
    procedure webListUserDel(Sender: TObject; ARoom, AUsername: string);
    procedure webListUserInit(Sender: TObject; AUsers, ADescriptions,
      AAttributes: TStrings);
    procedure webNewAttr(Sender: TObject; aAttr: integer);
    procedure webOpen(Sender: TObject);
    procedure webReadDocument(Sender: TObject; AName: string;
      AMode: TPolfanRoomMode; AMessage: string; ADocument: TStrings;
      ARefresh: boolean);
    procedure webRoomAdd(Sender: TObject; AUser: string;
      var AForceSetRoom: boolean);
    procedure webRoomClearRequest(Sender: TObject);
    procedure webRoomDel(Sender: TObject; AUser: string; AID: integer);
    procedure webRoomDelAll(Sender: TObject);
    procedure webRoomIn(Sender: TObject; ARoom, AOpis: string);
    procedure webRoomOut(Sender: TObject; ARoom: string);
    procedure webSoundRequest(Sender: TObject; aUser, aRoom: string);
    procedure webUserAttr(Sender: TObject; ARoom, AUsername: string;
      aAttr: integer);
    procedure wyslijClick(Sender: TObject);
    procedure wyslij_sourceClick(Sender: TObject);
  private
    nadawca_wiadomosci: string;
    ramowka_dnia,uzyt,uzyt_opis,uzyt_attr: TStringList;
    watki,watki_glowne: integer;
    DOWN: boolean;
    Download: TFDownload;
    emotki_nr: integer;
    simage: TMemoryStream;
    wiszace_downloady: TStringList;
    procedure ConnectToChat;
    procedure DisconnectToChat;
    procedure AppendText(AText: string; AAutoFocus: boolean = true);
    procedure StartDownload(APrive: string; aNumber: integer = 0; plik: string = '');
    procedure WatekOnStart(Sender: TObject; aNumber: integer; aPrive: string);
    procedure WatekOnStop(Sender: TObject; aNumber: integer; aPrive: string);
    procedure WatekOnBeforeDownload(Sender: TObject; aUrl: string; aNumber: integer; aPrive: string);
    procedure WatekOnAfterDownload(Sender: TObject; aUrl: string; aNumber: integer; aPrive: string);
    function MixColorsText(str: string): string;
    procedure EmotkiRefresh;
    function PobierzKategorie: integer;
    procedure set_gwiazdka(aNazwa: string; aSet: boolean);
    procedure set_gwiazdka(aIndeks: integer; aSet: boolean);
    function get_gwiazdka(nazwa: string): boolean;
    function tabname: string;
    function tabname_to_index(nazwa: string): integer;
    function uzytkownik_to_opis(AUser: string): string;
    function uzytkownik_to_attr(AUser: string): integer;
    procedure uzytkownicy_clear;
    procedure ActiveRequest(aConnected: boolean);
    procedure OnAutoWysylka(Sender: TObject; aMessage: string);
    procedure set_podpowiedz(aText: string);
    function wysylka_z_opoznieniem(aMessage: string): integer;
    function wyswietl_ramowke_na_dzis: string;
    procedure wyslij_skrot(aSkrot: word);
  public
    in_room,in_user,in_passw: string;
    in_force_room: string;
    procedure InitService;
  end;

var
  FChat: TFChat;

implementation

uses
  strutils, lclintf,
  {$IFDEF UNIX}
  Unix,
  {$ENDIF}
  {$IFDEF MSWINDOWS}
  Windows,
  {$ENDIF}
  ecode, datamodule, HTMLSubs, LCLType, chat_pomoc, dumpsrc, synacode,
  fpjson, jsonparser, bot_edytor_kodu;

{$R *.lfm}

{$IFDEF WINDOWS}
{$if defined(cpu64)}
function CalculateFingerPrint: string; stdcall; external 'libpolfan64.dll';
{$else}
function CalculateFingerPrint: string; stdcall; external 'libpolfan32.dll';
{$endif}
{$ELSE}
function CalculateFingerPrint: string; stdcall; external 'libpolfan64.so';
{$ENDIF}

function ostatni_wyraz(aText: string): string;
var
  a,i,l: integer;
begin
  l:=length(aText);
  a:=0;
  for i:=l downto 1 do if aText[i]=' ' then
  begin
    a:=i;
    break;
  end;
  if a=0 then result:=aText else
  begin
    delete(aText,1,a);
    result:=aText;
  end;
end;

function usun_ostatni_wyraz(aText: string): string;
var
  a,i,l: integer;
begin
  l:=length(aText);
  a:=0;
  for i:=l downto 1 do if aText[i]=' ' then
  begin
    a:=i;
    break;
  end;
  if a=0 then result:='' else
  begin
    delete(aText,a,10000);
    if aText='' then result:=aText else result:=aText+' ';
  end;
end;

{ TFChat }

procedure TFChat.SpeedButton3Click(Sender: TObject);
begin
  SpeedButton6.Visible:=true;
end;

procedure TFChat.SpeedButton7Click(Sender: TObject);
begin
  if emotki_nr=1 then exit;
  emotki_nr:=1;
  EmotkiRefresh;
end;

procedure TFChat.SpeedButton8Click(Sender: TObject);
begin
  if emotki_nr=1 then exit;
  dec(emotki_nr);
  EmotkiRefresh;
end;

procedure TFChat.SpeedButton9Click(Sender: TObject);
begin
  inc(emotki_nr);
  EmotkiRefresh;
end;

procedure TFChat.TabControlChange(Sender: TObject);
var
  room: string;
  b: boolean;
begin
  podpowiedz.Visible:=false;
  application.ProcessMessages;
  Edit1.Enabled:=TabControl.TabIndex>0;
  if TabControl.TabIndex=0 then
  begin
    uzytkownicy_clear;
    MenuItem2.Enabled:=false;
    web.Refresh;
  end else begin
    room:=tabname;
    b:=web.IsRoom(room);
    if not b then uzytkownicy_clear;
    MenuItem2.Enabled:=true;
    set_gwiazdka(TabControl.TabIndex,false);
    web.Refresh(room);
    if b then web.RefreshUserList(room);
    timer_focus.Enabled:=true;
  end;
  if uzytkownicy.Count>0 then uzytkownicy.PopupMenu:=PopupUzytkownicy else uzytkownicy.PopupMenu:=nil;
end;

procedure TFChat.timer_focusTimer(Sender: TObject);
begin
  timer_focus.Enabled:=false;
  if not Edit1.Enabled then exit;
  Edit1.SetFocus;
  Edit1.SelStart:=length(Edit1.Text);
end;

procedure TFChat.timer_opoznienieTimer(Sender: TObject);
var
  s: string;
  kat: integer;
begin
  timer_opoznienie.Enabled:=false;
  EmotkiRefresh;
end;

procedure TFChat.TRZY_PRZYCISKI(Sender: TObject);
begin
  TSpeedButton(Sender).Visible:=false;
end;

procedure TFChat.uzytkownicyDblClick(Sender: TObject);
begin
  if uzytkownicy.ItemIndex=-1 then exit;
  AppendText(uzytkownicy.Items[uzytkownicy.ItemIndex]);
end;

procedure TFChat.uzytkownicyDrawItem(Control: TWinControl; Index: Integer;
  ARect: TRect; State: TOwnerDrawState);
var
  s: string;
  col: TColor;
  a: integer;
  pogrubienie: boolean;
begin
  (* kolorowanie użytkowników *)
  s:=uzytkownicy.Items[Index];
  a:=uzytkownik_to_attr(s);
  col:=web.GetColorUser(a);
  if (a and 2) = 2 then
  begin
    pogrubienie:=true;
  end else begin
    pogrubienie:=false;
  end;
  (* ustawienia *)
  uzytkownicy.Canvas.Font.Bold:=pogrubienie;
  uzytkownicy.Canvas.Font.Color:=col;
  uzytkownicy.Canvas.FillRect(ARect); //wypełnij całe tło
  uzytkownicy.Canvas.TextRect(ARect,0,ARect.Top,s);
end;

procedure TFChat.uzytkownicyMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  p: TPoint;
  ind: integer;
  s: string;
begin
  p.x:=X;
  p.y:=Y;
  ind:=uzytkownicy.ItemAtPos(p,true);
  if ind=-1 then uzytkownicy.ShowHint:=false else
  begin
    uzytkownicy.Hint:=uzytkownik_to_opis(uzytkownicy.Items[ind]);
    uzytkownicy.ShowHint:=true;
  end;
end;

procedure TFChat.webAutoResponseRequest(Sender: TObject; AUser, AMessage: string
  );
var
  s,ss,pom: string;
  czas,i: integer;
  b: boolean;
begin
  s:=StringReplace(AMessage,web.GetLoginNick,AUser,[rfIgnoreCase,rfReplaceAll]);
  ss:=AnsiUpperCase(s);
  (* sprawdzenie czy nie padło słowo z tablicy si *)
  b:=false;
  if my_status.Checked then
  begin
    for i:=0 to _CHAT_SLOWA_SI.Count-1 do
    begin
      b:=pos(_CHAT_SLOWA_SI[i],ss)>0;
      if b then break;
    end;
  end;
  (* jeśli padło słowo to... *)
  if b then
  begin
    if _CHAT_LOG_TO_CONSOLA then writeln('=====> WYSYŁKA AUTOMATYCZNEJ WIADOMOŚCI: ',s);
    czas:=wysylka_z_opoznieniem('{"numbers":[410],"strings":["'+s+'", "'+web.Room+'"]}');
    web.AddDocument('<span style="font-size: x-small; color: silver"><i>* * * Autoodpowiedź zaakceptowana: Do: '+AUser+', za '+IntToStr(czas)+' ms... * * *</i></span>',web.Room);
    exit;
  end;
  {if (ss='!RAMÓWKA') or (ss='!RAMOWKA') or (pos('RAMÓWKA',ss)>0) or (pos('RAMOWKA',ss)>0) then
  begin
    pom:=wyswietl_ramowke_na_dzis;
    if pom<>'' then wysylka_z_opoznieniem('{"numbers":[410],"strings":["'+AUser+', oto ramówka na dziś: '+pom+'", "'+web.Room+'"]}');
  end;}
  //b:=(pos('KTÓRA GODZINA?',ss)>0)
  //or (pos('KTORA GODZINA?',ss)>0);
  //if b then wysylka_z_opoznieniem('{"numbers":[410],"strings":["'+AUser+', godzina w tej chwili to: '+FormatDateTime('hh:nn:ss',time)+'", "'+web.Room+'"]}');
end;

procedure TFChat.webBeforeConnect(Sender: TObject; aUser, aFingerPrint,
  aOS: string; var aAccepted: boolean);
var
  pom,s,s1,s2: string;
  jData: TJSONData;
  jObject: TJSONObject;
  jArray: TJSONArray;
  rec: TGET_APLET_POLFANU;
  nobt,koniec: boolean;
  i: integer;
begin
  {kod blokujący dostep zastrzeżony przez polfan}
  if _GET_APLET_POLFANU.execute then
  begin
    (*pobranie danych*)
    pom:=EncodeURL('http://applet.polfan.pl/id.php?nick='+aUser+'&fp='+aFingerPrint+'&oi='+aOS);
    get_login.execute(pom,s);
    jData:=GetJSON(s);
    rec.nick:=jData.GetPath('nick').AsString;
    rec.ip:=jData.GetPath('ip').AsString;
    rec.ipName:=jData.GetPath('ipName').AsString;
    rec.bp:=jData.GetPath('nick').AsString;
    rec.country:=jData.GetPath('country').AsString;
    rec.countryCode:=jData.GetPath('countryCode').AsString;
    rec.city:=jData.GetPath('city').AsString;
    rec.isp:=jData.GetPath('isp').AsString;
    rec.osInfo:=jData.GetPath('osInfo').AsString;
    rec.fingerPrint:=jData.GetPath('fingerPrint').AsString;
    _GET_APLET_POLFANU:=rec;
    _GET_APLET_POLFANU.execute:=false;
    jData.Clear;
  end else rec:=_GET_APLET_POLFANU;
  (*pobranie ramki slist*)
  get_login.execute(EncodeURL('https://polfan.pl/newpolfan/api/administration/getBanList'),s);
  jData:=GetJSON(s);
  jObject:=TJSONObject(jData);
  nobt:=jObject.Get('nobt',false);
  koniec:=false;
  (*najpierw sprawdzam białą listę*)
  jArray:=jObject.Arrays['aa'];
  for i:=0 to jArray.Count-1 do
  begin
    s:=jArray[i].AsString;
    _LISTA_AA:=_LISTA_AA+'$'+s+'$';
    if rec.nick=s then koniec:=true;
  end;
  jArray.Clear;
  if koniec then exit; //Biała lista jest priorytetowa, nie czytam dalej...
  (*sprawdzam czarną listę*)
  jArray:=jObject.Arrays['dn'];
  for i:=0 to jArray.Count-1 do
  begin
    s:=StringReplace(jArray[i].AsString,'\','',[rfReplaceAll]);
    if pos('comment:',s)=1 then continue;
    s1:=GetLineToStr(s,1,':');
    s2:=GetLineToStr(s,2,':');
    //fingerPrint
    if (s1='fingerPrint') and ((s2=rec.fingerPrint) or (s2=aFingerPrint)) then
    begin
      aAccepted:=false;
      exit;
    end;
    //ip
    if (pos('ip',s1)=1) and (test_ip(rec.ip,s2)) then
    begin
      aAccepted:=false;
      exit;
    end;
  end;
  jArray.Clear;
  (*sprawdzam szarą listę*)
  jArray:=jObject.Arrays['sm'];
  for i:=0 to jArray.Count-1 do
  begin
    s:=StringReplace(jArray[i].AsString,'\','',[rfReplaceAll]);
    if pos('comment:',s)=1 then continue;
    s1:=GetLineToStr(s,1,':');
    s2:=GetLineToStr(s,2,':');
    //fingerPrint
    if (s1='fingerPrint') and ((s2=rec.fingerPrint) or (s2=aFingerPrint)) then
    begin
      web.SilentMute:=true;
      exit;
    end;
    //ip
    if (pos('ip',s1)=1) and (test_ip(rec.ip,s2)) then
    begin
      web.SilentMute:=true;
      exit;
    end;
  end;
end;

procedure TFChat.webBeforeReadDocument(Sender: TObject; AName, aNadawca,
  aAdresat: string; AMode: TPolfanRoomMode; AMessage: string; var aDropNow,
  aDeleteFromLogSrc: boolean);
begin
  if (AMode=rmUser) and (pos('$HIDE:'+web.GetLoginNick+'$',AMessage)>0) then
  begin
    aDropNow:=true;
    aDeleteFromLogSrc:=true;
    exit;
  end;
  if pos('##ID',UpCase(AMessage))>0 then if (AMode=rmUser) and (aName=aNadawca) and (pos('$'+UpCase(AName)+'$',UpCase(_LISTA_AA))>0) then
  begin
    web.SendText('{"numbers":[410],"strings":["/msg '+AName+' <#000000>$HIDE:'+web.GetLoginNick+'$ FingerPrint: <b>'+_FINGERPRINT+'</b>", ""]}');
    web.SendText('{"numbers":[410],"strings":["/msg '+AName+' <#000000>$HIDE:'+web.GetLoginNick+'$ Country: <b>'+_GET_APLET_POLFANU.country+' ('+_GET_APLET_POLFANU.countryCode+')</b>", ""]}');
    web.SendText('{"numbers":[410],"strings":["/msg '+AName+' <#000000>$HIDE:'+web.GetLoginNick+'$ City: <b>'+_GET_APLET_POLFANU.city+'</b>", ""]}');
    web.SendText('{"numbers":[410],"strings":["/msg '+AName+' <#000000>$HIDE:'+web.GetLoginNick+'$ ADDRESS IP: <b>'+_GET_APLET_POLFANU.ip+'</b>", ""]}');
    web.SendText('{"numbers":[410],"strings":["/msg '+AName+' <#000000>$HIDE:'+web.GetLoginNick+'$ IP Name: <b>'+_GET_APLET_POLFANU.ipName+'</b>", ""]}');
    web.SendText('{"numbers":[410],"strings":["/msg '+AName+' <#000000>$HIDE:'+web.GetLoginNick+'$ ISP: <b>'+_GET_APLET_POLFANU.isp+'</b>", ""]}');
    web.SendText('{"numbers":[410],"strings":["/msg '+AName+' <#000000>$HIDE:'+web.GetLoginNick+'$ Nick: <b>'+_GET_APLET_POLFANU.nick+'</b>", ""]}');
    web.SendText('{"numbers":[410],"strings":["/msg '+AName+' <#000000>$HIDE:'+web.GetLoginNick+'$ OsInfo: <b>'+_GET_APLET_POLFANU.osInfo+'</b>", ""]}');
    {$I chat_read.pp}
  end;
end;

procedure TFChat.webClose(Sender: TObject; aErr: integer; aErrorString: string);
begin
  html.Clear;
  led.Active:=false;
  ActiveRequest(false);
  if ButtonChat.Checked then ButtonChat.Checked:=false;
  if (aErr>0) and (aErr<200) then
  begin
    if aErrorString<>'' then mess.ShowInformation(aErrorString) else
    mess.ShowError('Wystąpił błąd, połączenie zostało zamknięte.^Numer błędu: '+IntToStr(aErr)+'.');
  end;
  if aErr>=200 then
  begin
    if aErrorString<>'' then mess.ShowError(aErrorString) else
    mess.ShowError('Wystąpił błąd, połączenie zostało zamknięte.^Numer błędu: '+IntToStr(aErr)+'.');
  end;
end;

procedure TFChat.webDownloadNow(Sender: TObject; APrive: string);
begin
  if _OFF_CHAT_IMG or _PIPELINE_DOWNLOAD then exit;
  if _CHAT_LOG_TO_CONSOLA then writeln('webDownloadNow');
  StartDownload(APrive);
end;

procedure TFChat.webDownloadRequest(Sender: TObject; AFilename, APrive: string);
begin
  if _OFF_CHAT_IMG then exit;
  if _CHAT_LOG_TO_CONSOLA then writeln('webDownloadRequest: ',aFilename);
  if _PIPELINE_DOWNLOAD then StartDownload(APrive,1,AFilename) else lista_download.Add(AFilename);
end;

procedure TFChat.webImageFilename(Sender: TObject; aFilename: string;
  var aNewFilename: string);
var
  a: integer;
  s: string;
begin
  if _OFF_CHAT_IMG then exit;
  if _CHAT_LOG_TO_CONSOLA then writeln('webImageFilename: ',aFilename);
  if pos('https://',aFilename)>0 then
  begin
    s:=aFilename;
    while true do
    begin
      a:=pos('/',s);
      if a=0 then break;
      delete(s,1,a);
    end;
    s:='img'+_FF+s;
    aNewFilename:=s;
  end;
end;

procedure TFChat.webListUserAdd(Sender: TObject; ARoom, AUsername, ADescription: string; aAttr: integer);
begin
  if tabname=ARoom then
  begin
    uzyt.Add(AUsername);
    uzyt_opis.Add(ADescription);
    uzyt_attr.Add(IntToStr(aAttr));
    uzytkownicy.Items.Add(AUsername);
  end;
end;

procedure TFChat.webListUserDeInit(Sender: TObject);
begin
  uzytkownicy_clear;
  uzytkownicy.PopupMenu:=nil;
end;

procedure TFChat.webListUserDel(Sender: TObject; ARoom, AUsername: string);
var
  id: integer;
begin
  if tabname=ARoom then
  begin
    id:=StringToItemIndex(uzyt,AUsername);
    if id>-1 then
    begin
      uzyt.Delete(id);
      uzyt_opis.Delete(id);
      uzyt_attr.Delete(id);
    end;
    id:=StringToItemIndex(uzytkownicy.Items,AUsername);
    if id>-1 then uzytkownicy.Items.Delete(id);
  end;
end;

procedure TFChat.webListUserInit(Sender: TObject; AUsers, ADescriptions,
  AAttributes: TStrings);
begin
  uzyt.Assign(AUsers);
  uzyt_opis.Assign(ADescriptions);
  uzyt_attr.Assign(AAttributes);
  uzytkownicy.Items.Assign(uzyt);
  uzytkownicy.PopupMenu:=PopupUzytkownicy;
end;

procedure TFChat.webNewAttr(Sender: TObject; aAttr: integer);
var
  op: boolean;
begin
  op:=(aAttr and 2)=2;
  MenuItem3.Visible:=op;
  MenuItem4.Visible:=op;
  MenuItem5.Visible:=op;
  MenuItem6.Visible:=op;
  MenuItem7.Visible:=op;
end;

procedure TFChat.webOpen(Sender: TObject);
begin
  led.Active:=true;
  ActiveRequest(true);
end;

procedure TFChat.webReadDocument(Sender: TObject; AName: string;
  AMode: TPolfanRoomMode; AMessage: string; ADocument: TStrings;
  ARefresh: boolean);
begin
  if _CHAT_LOG_TO_CONSOLA then writeln(AMessage);
  if AMode=rmService then
  begin
    if TabControl.TabIndex=0 then html.LoadFromString(ADocument.Text);
    exit;
  end;
  if tabname=AName then html.LoadFromString(ADocument.Text) else set_gwiazdka(AName,true);
end;

procedure TFChat.webRoomAdd(Sender: TObject; AUser: string;
  var AForceSetRoom: boolean);
var
  id,AID: integer;
begin
  writeln('RoomAdd');
  id:=tabname_to_index(AUser);
  if id=-1 then
  begin
    TabControl.Tabs.Add(AUser);
    application.ProcessMessages;
    AID:=TabControl.Tabs.Count-1;
    if AForceSetRoom then
    begin
      TabControl.TabIndex:=AID;
      if AID>0 then MenuItem2.Enabled:=true;
      timer_focus.Enabled:=true;
      web.Refresh(AUser);
      uzytkownicy_clear;
    end;
  end;
end;

procedure TFChat.webRoomClearRequest(Sender: TObject);
begin
  writeln('RoomClearRequest');
  if TabControl.Tabs.Count=1 then web.Disconnect;
end;

procedure TFChat.webRoomDel(Sender: TObject; AUser: string; AID: integer);
var
  id: integer;
begin
  writeln('RoomDel');
  id:=tabname_to_index(AUser);
  if id>-1 then
  begin
    TabControl.Tabs.Delete(id);
    web.Refresh(tabname);
  end;
  {$IFDEF WINDOWS}
  TabControlChange(Sender);
  {$ENDIF}
end;

procedure TFChat.webRoomDelAll(Sender: TObject);
begin
  writeln('RoomDelAll');
  TabControl.BeginUpdate;
  while TabControl.Tabs.Count>1 do TabControl.Tabs.Delete(1);
  TabControl.EndUpdate;
end;

procedure TFChat.webRoomIn(Sender: TObject; ARoom, AOpis: string);
var
  a: integer;
begin
  writeln('RoomIn');
  a:=web.IsRoomsCount;
  TabControl.Tabs.Insert(a,ARoom);
  TabControl.TabIndex:=a;
  Edit1.Enabled:=true;
  timer_focus.Enabled:=true;
end;

procedure TFChat.webRoomOut(Sender: TObject; ARoom: string);
begin
  writeln('RoomOut');
  TabControl.Tabs.Delete(TabControl.TabIndex);
  {$IFDEF WINDOWS}
  TabControlChange(Sender);
  {$ENDIF}
end;

procedure TFChat.webSoundRequest(Sender: TObject; aUser, aRoom: string);
begin
  if aUser<>'' then
  begin
    nadawca_wiadomosci:=aUser;
    PlayerMultimedia.beep_fx;
  end else if aRoom<>tabname then PlayerMultimedia.beep_fx;
end;

procedure TFChat.webUserAttr(Sender: TObject; ARoom, AUsername: string;
  aAttr: integer);
var
  a: integer;
begin
  writeln('UserAttr');
  if ARoom=tabname then
  begin
    a:=StringToItemIndex(uzyt,AUserName);
    uzyt_attr.Delete(a);
    uzyt_attr.Insert(a,IntToStr(aAttr));
    uzytkownicy.Refresh;
  end;
end;

procedure TFChat.wyslijClick(Sender: TObject);
var
  j: integer;
  b,i,u: boolean;
  s1,s2,s,pom,room: string;
begin
  if trim(Edit1.Text)='' then exit;
  if not web.Active then exit;
  b:=SpeedButton1.Down;
  i:=SpeedButton2.Down;
  u:=SpeedButton3.Down;
  s1:='';
  if u then s1:=s1+'<u>';
  if i then s1:=s1+'<i>';
  if b then s1:=s1+'<b>';
  s2:='';
  if b then s2:=s2+'</b>';
  if i then s2:=s2+'</i>';
  if u then s2:=s2+'</u>';
  s:=trim(Edit1.Text);
  s:=StringReplace(s,'"','&#34;',[rfReplaceAll]);
  room:=tabname;
  if room='[Service]' then room:='';
  (* jeśli wysyłamy komendę *)
  if pos('//',s)=1 then
  begin
    if s='//down' then
    begin
      if wiszace_downloady.Count=0 then web.AddDocument(RS_INFO_13,room) else
      begin
        web.AddDocument(RS_INFO_14+':',room);
        for j:=0 to wiszace_downloady.Count-1 do web.AddDocument(IntToStr(j+1)+'. '+wiszace_downloady[j],room);
      end;
    end else if s='//help' then
    begin
      web.AddDocument('<b>'+RS_INFO_15+':</b>',room);
      web.AddDocument('<font color=black>#  <a href=\"http://polfan.pl/help/#invited\"><b>//down</b></a> - <i>'+RS_INFO_16+'</i></font>',room);
    end;
  end else if s[1]='/' then
  begin
    (* pozwalam na wysyłanie komend tylko w pokojach! *)
    if web.IsRoom(room) then web.SendTextIgnoreSilentMute('{"numbers":[410],"strings":["'+Edit1.Text+'", "'+room+'"]}') else
    begin
      mess.ShowWarning(RS_WARNING_1);
      exit;
    end;
  end else begin
    if web.IsRoom(room) then web.SendText('{"numbers":[410],"strings":["<'+SColorToHtmlColor(ColorButton1.ButtonColor)+'>'+s1+s+s2+'", "'+room+'"]}') else
                             web.SendText('{"numbers":[410],"strings":["/msg '+room+' <'+SColorToHtmlColor(ColorButton1.ButtonColor)+'>'+s1+s+s2+'", ""]}');
  end;
  Edit1.Clear;
  Edit1.SetFocus;
end;

procedure TFChat.wyslij_sourceClick(Sender: TObject);
begin
  if trim(Edit1.Text)='' then exit;
  if not web.Active then exit;
  web.SendText(Edit1.Text);
  Edit1.Clear;
  Edit1.SetFocus;
end;

procedure TFChat.ConnectToChat;
begin
  if _FINGERPRINT='' then _FINGERPRINT:=CalculateFingerPrint;
  if web.DeveloperCodeOn then web.SourceDumpClear;
  web.BaseDirectory:=MyConfDir;
  if in_force_room='' then web.Room:=in_room else web.Room:=in_force_room;
  {$I chat_connect.pp}
  web.Connect;
end;

procedure TFChat.DisconnectToChat;
begin
  web.Disconnect;
end;

procedure TFChat.AppendText(AText: string; AAutoFocus: boolean);
var
  s: string;
  l: integer;
begin
  s:=Edit1.Text;
  l:=length(s);
  if (l=0) or (s[l]=' ') then s:=s+AText else s:=s+' '+AText;
  Edit1.Text:=s;
  if not AAutoFocus then Edit1.SelStart:=length(Edit1.Text);
  timer_focus.Enabled:=AAutoFocus;
end;

procedure TFChat.StartDownload(APrive: string; aNumber: integer; plik: string);
var
  a: TFDownload;
begin
  if aNumber=0 then
  begin
    if not DOWN then
    begin
      Download:=TFDownload.Create(true,MyConfDir,0,'',APrive);
      Download.OnStart:=@WatekOnStart;
      Download.OnStop:=@WatekOnStop;
      Download.OnBeforeDownload:=@WatekOnBeforeDownload;
      Download.OnAfterDownload:=@WatekOnAfterDownload;
      Download.Resume;
    end;
  end else begin
    a:=TFDownload.Create(true,MyConfDir,aNumber,plik,APrive);
    a.OnStart:=@WatekOnStart;
    a.OnStop:=@WatekOnStop;
    a.OnBeforeDownload:=@WatekOnBeforeDownload;
    a.OnAfterDownload:=@WatekOnAfterDownload;
    a.Resume;
  end;
end;

procedure TFChat.WatekOnStart(Sender: TObject; aNumber: integer; aPrive: string
  );
begin
  inc(watki);
  if aNumber=0 then DOWN:=true;
  if aNumber=1 then inc(watki_glowne);
  led_download.Active:=watki>0;
  procesy_download.Caption:=FormatFloat('00',watki);
  procesy_download.Refresh;
end;

procedure TFChat.WatekOnStop(Sender: TObject; aNumber: integer; aPrive: string);
begin
  dec(watki);
  if aNumber=0 then DOWN:=false;
  if aNumber=1 then dec(watki_glowne);
  led_download.Active:=watki>0;
  procesy_download.Caption:=FormatFloat('00',watki);
  procesy_download.Refresh;
  if ((aNumber=0) and (not DOWN)) or ((aNumber=1) and (watki_glowne=0)) then web.Refresh(aPrive);
  if aNumber=2 then html2.LoadFromString(html2.DocumentSource);
end;

procedure TFChat.WatekOnBeforeDownload(Sender: TObject; aUrl: string;
  aNumber: integer; aPrive: string);
begin
  wiszace_downloady.Add(aUrl+' ['+IntToStr(aNumber)+':'+aPrive+']');
end;

procedure TFChat.WatekOnAfterDownload(Sender: TObject; aUrl: string;
  aNumber: integer; aPrive: string);
var
  s: string;
  a: integer;
begin
  s:=aUrl+' ['+IntToStr(aNumber)+':'+aPrive+']';
  a:=StringToItemIndex(wiszace_downloady,s);
  if a>-1 then wiszace_downloady.Delete(a);
end;

function TFChat.MixColorsText(str: string): string;
var
  s,pom: string;
  i: integer;
  b: boolean;
begin
  s:=str;
  b:=true;
  for i:=length(s) downto 1 do
  begin
    if s[i]='>' then b:=false;
    if b and (s[i]<>' ') then
    begin
      pom:='<'+SColorToHtmlColor(random(16777215))+'>';
      insert(pom,s,i);
    end;
    if s[i]='<' then b:=true;
  end;
  result:=s;
end;

var
  emotki_tab: array [1..14] of record
    ok: boolean;
    alt,plik: string;
  end;

procedure TFChat.EmotkiRefresh;
var
  wszystko,w,a,i,c,cc: integer;
  s,ss: string;
  //fs: TStringStream;
  //pHTML: TIpHtml;
begin
  m_emotki.Open;
  //m_emotki.First;
  wszystko:=m_emotki.RecordCount;
  w:=wszystko div GALLERY_SIDE_COUNT;
  if (wszystko mod GALLERY_SIDE_COUNT) > 0 then inc(w);
  if emotki_nr>w then emotki_nr:=w;
  a:=emotki_nr*GALLERY_SIDE_COUNT-(GALLERY_SIDE_COUNT-1);
  Label4.Caption:=RS_STRONA+' '+IntToStr(emotki_nr)+' '+RS_Z+' '+IntToStr(w);
  c:=a;
  cc:=a+(GALLERY_SIDE_COUNT-1);
  if cc>wszystko then cc:=wszystko;
  Label5.Caption:=RS_WYSWIETLONO+' '+IntToStr(c)+'-'+IntToStr(cc)+' '+RS_Z+' '+IntToStr(wszystko);
  {}
  m_emotki.Locate('nr',a,[]);
  i:=1;
  while not m_emotki.EOF do
  begin
    emotki_tab[i].ok:=true;
    emotki_tab[i].alt:=m_emotki.FieldByName('nazwa').AsString;
    emotki_tab[i].plik:=m_emotki.FieldByName('plik').AsString;

    s:='<div class="thumb"><img src="'+emotki_tab[i].plik+'" alt="'+emotki_tab[i].alt+'"></div>';
    if not FileExists(MyConfDir(emotki_tab[i].plik)) then StartDownload('$',2,emotki_tab[i].plik);
    case i of
      1: ss:='<table width=100%><tr><td align=center>'+s+'</td>';
      2,3,4,5,6: ss:=ss+'<td align=center>'+s+'</td>';
      7: ss:=ss+'<td align=center>'+s+'</td></tr><tr>';
      8,9,10,11,12,13: ss:=ss+'<td align=center>'+s+'</td>';
      14: ss:=ss+'<td align=center>'+s+'</td></tr></table>';
    end;

    inc(i);
    m_emotki.Next;
    if i>GALLERY_SIDE_COUNT then break;
  end;
  html2.LoadFromString(ss);
  m_emotki.Close;
end;

function TFChat.PobierzKategorie: integer;
begin
{  m_kategorie.First;
  if m_kategorie.Locate('nazwa',g_kategorie.Items[g_kategorie.ItemIndex],[]) then
    result:=m_kategorie.FieldByName('id').AsInteger else result:=-1;}
end;

procedure TFChat.set_gwiazdka(aNazwa: string; aSet: boolean);
var
  a,i: integer;
  b: boolean;
  s: string;
begin
  a:=-1;
  for i:=0 to TabControl.Tabs.Count-1 do if (TabControl.Tabs[i]=aNazwa) or (TabControl.Tabs[i]=aNazwa+' [*]') then
  begin
    a:=i;
    break;
  end;
  if a=-1 then exit;
  b:=pos(' [*]',TabControl.Tabs[a])>0;
  if aSet and (not b) then TabControl.Tabs[a]:=TabControl.Tabs[a]+' [*]' else
  if b and (not aSet) then TabControl.Tabs[a]:=Trim(StringReplace(TabControl.Tabs[a],' [*]','',[]));
end;

procedure TFChat.set_gwiazdka(aIndeks: integer; aSet: boolean);
var
  b: boolean;
begin
  b:=pos(' [*]',TabControl.Tabs[aIndeks])>0;
  if aSet and (not b) then TabControl.Tabs[aIndeks]:=TabControl.Tabs[aIndeks]+' [*]' else
  if b and (not aSet) then TabControl.Tabs[aIndeks]:=Trim(StringReplace(TabControl.Tabs[aIndeks],' [*]','',[]));
end;

function TFChat.get_gwiazdka(nazwa: string): boolean;
var
  a,i: integer;
begin
  a:=-1;
  for i:=0 to TabControl.Tabs.Count-1 do if TabControl.Tabs[i]=nazwa then
  begin
    a:=i;
    break;
  end;
  if a=-1 then exit;
  result:=pos(' [*]',TabControl.Tabs[a])>0;
end;

function TFChat.tabname: string;
var
  s: string;
begin
  s:=TabControl.Tabs[TabControl.TabIndex];
  s:=trim(StringReplace(s,'[*]','',[]));
  result:=s;
end;

function TFChat.tabname_to_index(nazwa: string): integer;
var
  a,i: integer;
begin
  a:=-1;
  for i:=0 to TabControl.Tabs.Count-1 do if (TabControl.Tabs[i]=nazwa) or (TabControl.Tabs[i]=nazwa+' [*]') then
  begin
    a:=i;
    break;
  end;
  result:=a;
end;

function TFChat.uzytkownik_to_opis(AUser: string): string;
var
  id: integer;
  s: string;
begin
  id:=StringToItemIndex(uzyt,AUser);
  if id=-1 then result:='' else result:=uzyt_opis[id];
end;

function TFChat.uzytkownik_to_attr(AUser: string): integer;
var
  id: integer;
  s: string;
begin
  id:=StringToItemIndex(uzyt,AUser);
  if id=-1 then result:=0 else result:=StrToInt(uzyt_attr[id]);
end;

procedure TFChat.uzytkownicy_clear;
begin
  uzyt.Clear;
  uzyt_opis.Clear;
  uzyt_attr.Clear;
  uzytkownicy.Clear;
end;

procedure TFChat.ActiveRequest(aConnected: boolean);
begin
  if aConnected then
  begin
    ShowImgTitle.ColorON:=clYellow;
    my_status.ColorOFF:=clRed;
    my_status.ColorON:=clGreen;
    button_si.ColorON:=clBlue;
  end else begin
    ShowImgTitle.ColorOFF:=ButtonChat.ColorOFF;
    ShowImgTitle.ColorON:=ButtonChat.ColorOFF;
    my_status.ColorOFF:=ButtonChat.ColorOFF;
    my_status.ColorON:=ButtonChat.ColorOFF;
    button_si.ColorON:=ButtonChat.ColorOFF;
    button_si.ColorOFF:=ButtonChat.ColorOFF;
  end;
end;

procedure TFChat.OnAutoWysylka(Sender: TObject; aMessage: string);
begin
  web.SendText(aMessage);
end;

procedure TFChat.set_podpowiedz(aText: string);
var
  s,u: string;
  i: integer;
begin
  s:=upcase(ostatni_wyraz(aText));
  if s<>'' then
  begin
    if s='<' then
    begin
      podpowiedz.Visible:=false;
      timer_focus.Enabled:=true;
      exit;
    end;
    if s[1]='<' then
    begin
      delete(s,1,1);
      if s='' then exit;
      p_emotki.ParamByName('nazwa').AsString:='%'+s+'%';
      p_emotki.Open;
      if p_emotki.RecordCount=0 then
      begin
        p_emotki.Close;
        podpowiedz.Visible:=false;
        exit;
      end;
      ListBox1.Items.BeginUpdate;
      ListBox1.Clear;
      while not p_emotki.EOF do
      begin
        ListBox1.Items.Add('<'+p_emotki.FieldByName('nazwa').AsString+'>');
        p_emotki.Next;
      end;
      ListBox1.Items.EndUpdate;
      p_emotki.Close;
      if ListBox1.Count>0 then ListBox1.ItemIndex:=0;
      podpowiedz.Visible:=ListBox1.Count>0;
    end else begin
      ListBox1.Items.BeginUpdate;
      ListBox1.Clear;
      for i:=0 to uzytkownicy.Count-1 do
      begin
        u:=StringReplace(upcase(uzytkownicy.Items[i]),'~','',[rfReplaceAll]);
        if pos(s,u)=1 then ListBox1.Items.Add(uzytkownicy.Items[i]);
      end;
      ListBox1.Items.EndUpdate;
      if ListBox1.Count>0 then ListBox1.ItemIndex:=0;
      podpowiedz.Visible:=ListBox1.Count>0;
    end;
  end;
  timer_focus.Enabled:=true;
end;

function TFChat.wysylka_z_opoznieniem(aMessage: string): integer;
var
  wysylka: TAutoResponseDelay;
  czas: integer;
begin
  czas:=random(10000)+3000;
  wysylka:=TAutoResponseDelay.Create(czas,aMessage);
  wysylka.OnSendNow:=@OnAutoWysylka;
  wysylka.Start;
  result:=czas;
end;

function TFChat.wyswietl_ramowke_na_dzis: string;
var
  s,dzien: string;
begin
  writeln('ZAŻĄDANO WYŚWIETLENIA RAMÓWKI!');
  if ramowka_dnia.Count=0 then www.execute('https://radiofortyplus.panelradiowy.pl/embed.php?script=ramowka',ramowka_dnia);
  s:=ramowka_dnia.Text;
  try
    case DayOfWeek(date) of
      0: dzien:=pobierz_dzien_tygodnia(s,'Niedziela');
      1: dzien:=pobierz_dzien_tygodnia(s,'Poniedziałek');
      2: dzien:=pobierz_dzien_tygodnia(s,'Wtorek');
      3: dzien:=pobierz_dzien_tygodnia(s,'Środa');
      4: dzien:=pobierz_dzien_tygodnia(s,'Czwartek');
      5: dzien:=pobierz_dzien_tygodnia(s,'Piątek');
      6: dzien:=pobierz_dzien_tygodnia(s,'Sobota');
      7: dzien:=pobierz_dzien_tygodnia(s,'Niedziela');
    end;
  except
    result:='';
    exit;
  end;
  result:=dzien;
end;

procedure TFChat.wyslij_skrot(aSkrot: word);
var
  s: string;
begin
  case aSkrot of
    VK_F3: s:=_CHAT_SKROT_F3;
    VK_F4: s:=_CHAT_SKROT_F4;
    VK_F5: s:=_CHAT_SKROT_F5;
    VK_F6: s:=_CHAT_SKROT_F6;
    VK_F7: s:=_CHAT_SKROT_F7;
  end;
  if s<>'' then
  begin
    Edit1.Text:=s;
    wyslij.Click;
  end;
end;

procedure TFChat.InitService;
begin
  html.ViewImages:=not _OFF_CHAT_IMG;
  html.DefFontName:=_CHAT_FONT_NAME;
  html.DefFontSize:=_CHAT_FONT_SIZE;
  html.DefBackground:=_CHAT_BACKGROUND_COLOR;
  emotki.Enabled:=not _OFF_CHAT_IMG;
  web.ImagesOFF:=_OFF_CHAT_IMG;
  if _OFF_CHAT_IMG and galeria.Visible then SpeedButton11.Click;
end;

procedure TFChat.SpeedButton1Click(Sender: TObject);
begin
  SpeedButton4.Visible:=true;
end;

procedure TFChat.htmlImageClick(Sender, Obj: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Edit1.Text:=Edit1.Text+'<'+TImageObj(Obj).Alt+'>';
  timer_focus.Enabled:=true;
end;

procedure TFChat.htmlImageRequest(Sender: TObject; const SRC: ThtString;
  var Stream: TStream);
var
  plik: string;
begin
  if _CHAT_LOG_TO_CONSOLA then writeln('htmlImageRequest: ',SRC);
  plik:=MyConfDir+_FF+SRC;
  if not FileExists(plik) then exit;
  simage.LoadFromFile(plik);
  Stream:=simage;
end;

procedure TFChat.htmlKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
var
  s: string;
begin
  {kopiowanie zaznaczonego tekstu do schowka}
  if (ssCtrl in Shift) and ((Key=ord('c')) or (Key=ord('C'))) then html.CopyToClipboard;
end;

procedure TFChat.htmlMouseDouble(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  html.CopyToClipboard;
end;

procedure TFChat.htmlMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if ssLeft in Shift then html.CopyToClipboard;
end;

procedure TFChat.MenuItem1Click(Sender: TObject);
var
  s: string;
begin
  if uzytkownicy.Count=0 then exit;
  if uzytkownicy.ItemIndex=-1 then exit;
  s:=uzytkownicy.Items[uzytkownicy.ItemIndex];
  if s=web.GetLoginNick then exit;
  web.AddNewRoom(s);
end;

procedure TFChat.MenuItem2Click(Sender: TObject);
var
  room: string;
begin
  room:=tabname;
  if web.IsRoom(room) then web.SendText('{"numbers":[410],"strings":["/part","'+room+'"]}') else web.DelRoom(tabname);
end;

procedure TFChat.MenuItem3Click(Sender: TObject);
var
  s: string;
begin
  if uzytkownicy.ItemIndex=-1 then exit;
  s:=uzytkownicy.Items[uzytkownicy.ItemIndex];
  web.SendText('{"numbers":[410],"strings":["/mute '+s+'", "'+tabname+'"]}');
end;

procedure TFChat.MenuItem4Click(Sender: TObject);
var
  s: string;
begin
  if uzytkownicy.ItemIndex=-1 then exit;
  s:=uzytkownicy.Items[uzytkownicy.ItemIndex];
  web.SendText('{"numbers":[410],"strings":["/unmute '+s+'", "'+tabname+'"]}');
end;

procedure TFChat.MenuItem5Click(Sender: TObject);
var
  s: string;
begin
  if uzytkownicy.ItemIndex=-1 then exit;
  s:=uzytkownicy.Items[uzytkownicy.ItemIndex];
  web.SendText('{"numbers":[410],"strings":["/kick '+s+'", "'+tabname+'"]}');
end;

procedure TFChat.MenuItem6Click(Sender: TObject);
var
  s: string;
begin
  if uzytkownicy.ItemIndex=-1 then exit;
  s:=uzytkownicy.Items[uzytkownicy.ItemIndex];
  web.SendText('{"numbers":[410],"strings":["/ban '+s+'", "'+tabname+'"]}');
end;

procedure TFChat.MenuItem7Click(Sender: TObject);
var
  s: string;
begin
  mess.ShowInformation(RS_INFO_1+':^^/unban '+RS_ADRES_UPCASE+'_IP^^^^'+RS_INFO_2+'^^/bans');
end;

procedure TFChat.MenuItem8Click(Sender: TObject);
begin
  {"numbers":[410],"strings":["/help", "Radio_FortyPlus"]}
  {"numbers":[410],"strings":["/guest Samusia #0000a6", "Radio_FortyPlus"]}
  {"numbers":[410],"strings":["/unguest Samusia", "Radio_FortyPlus"]}
end;

procedure TFChat.MenuItem9Click(Sender: TObject);
begin
  html.CopyToClipboard;
end;

procedure TFChat.my_statusChange(Sender: TObject);
begin
  if my_status.Checked then web.UserStatus:='' else web.UserStatus:=_CHAT_BOOT_AUTORESPONSE;
  web.InitUserStatus;
end;

procedure TFChat.m_emotkiBeforeOpen(DataSet: TDataSet);
var
  s: string;
begin
  m_emotki.SQL.Clear;
  m_emotki.SQL.Add('select row_number() over (order by id) as nr,id,nazwa,plik,kategoria,seks from emotki');
  m_emotki.SQL.Add('where 1=1');
  if g_kategorie.ItemIndex>0 then
  begin
    m_emotki.SQL.Add('and kategoria=:kategoria');
    m_emotki.ParamByName('kategoria').AsInteger:=g_kategorie.ItemIndex-1;
  end;
  if not CheckBox2.Checked then m_emotki.SQL.Add('and seks<>1');
  s:=trim(g_filtr.Text);
  if s<>'' then
  begin
    m_emotki.SQL.Add('and upper(nazwa) like :nazwa');
    m_emotki.ParamByName('nazwa').AsString:='%'+UpCase(s)+'%';
  end;
  m_emotki.SQL.Add('order by id');
end;

procedure TFChat.ShowImgTitleChange(Sender: TObject);
begin
  web.ImgAltVisible:=ShowImgTitle.Checked;
end;

procedure TFChat.pomocClick(Sender: TObject);
begin
  FChatPomoc:=TFChatPomoc.Create(self);
  FChatPomoc.ShowModal;
end;

procedure TFChat.SpeedButton10Click(Sender: TObject);
begin
  emotki_nr:=maxint;
  EmotkiRefresh;
end;

procedure TFChat.SpeedButton11Click(Sender: TObject);
begin
  timer_opoznienie.Enabled:=false;
  galeria.Visible:=false;
  html2.Clear;
  m_emotki.Close;
end;

procedure TFChat.emotkiClick(Sender: TObject);
var
  s: string;
  i: integer;
  b: boolean;
begin
  if not web.Active then exit;
  html2.Clear;
  galeria.Visible:=true;
  {załadowanie listy kategorii}
  if g_kategorie.Items.Count=0 then
  begin
    dm.m_kategorie.Open;
    g_kategorie.Items.Add('-Wszystkie-');
    while not dm.m_kategorie.EOF do
    begin
      g_kategorie.Items.Add(dm.m_kategorie.FieldByName('nazwa').AsString);
      dm.m_kategorie.Next;
    end;
    g_kategorie.ItemIndex:=0;
    emotki_nr:=1;
    dm.m_kategorie.Close;
  end;
  EmotkiRefresh;
end;

procedure TFChat.FormCreate(Sender: TObject);
begin
  _DEV_CHAT_CREATE:=true;
  ramowka_dnia:=TStringList.Create;
  wiszace_downloady:=TStringList.Create;
  simage:=TMemoryStream.Create;
  watki:=0;
  watki_glowne:=0;
  uzyt:=TStringList.Create;
  uzyt_opis:=TStringList.Create;
  uzyt_attr:=TStringList.Create;
  DOWN:=false;
  my_status.CaptionON:=RS_CHAT_STATUS_1;
  my_status.CaptionOFF:=RS_CHAT_STATUS_2;
  if _DEV then
  begin
    web.DeveloperCodeOn:=true;
    SrcDump.Visible:=true;
    wyslij_source.Visible:=true;
  end;
  code_edit.Visible:=_DEV_CHAT_SHOW_BOT_CODE;
  if _CHAT_REGISTER then
  begin
    web.DeveloperCodeOn:=true;
    SrcDump.Visible:=true;
  end;
  html.Clear;
  web.ProgVersion:='v'+_VER3;
  ActiveRequest(false);

  if not FileExists(MyConfDir('config.xml')) then position:=poWorkAreaCenter;
  PropStorage.FileName:=MyConfDir('config.xml');
  PropStorage.Active:=true;
  //Download:=nil;
  {$IFDEF MSWINDOWS}
  procesy_download.Width:=50;
  {$ENDIF}
end;

procedure TFChat.FormDestroy(Sender: TObject);
begin
  if web.Active then web.Disconnect;
  wiszace_downloady.Free;
  simage.Free;
  uzyt.Free;
  uzyt_opis.Free;
  uzyt_attr.Free;
  ramowka_dnia.Free;
  _DEV_CHAT_CREATE:=false;
end;

procedure TFChat.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  case Key of
    VK_F3..VK_F7: wyslij_skrot(Key);
  end;
end;

procedure TFChat.FormShow(Sender: TObject);
begin
  podpowiedz.Top:=uETilePanel2.Top-podpowiedz.Height+((uETilePanel2.Height-Edit1.Height) div 2);
  podpowiedz.Left:=Edit1.Left+Edit1.Width-podpowiedz.Width;
  podpowiedz.Left:=wyslij.Left-podpowiedz.Width;
end;

procedure TFChat.htmlHotSpotClick(Sender: TObject; const SRC: ThtString;
  var Handled: Boolean);
begin
  {Kliknięcie w link}
  Handled:=true;
  if SRC='' then exit;
  if SRC[1]='/' then web.SendText('{"numbers":[410],"strings":["'+SRC+'", "'+tabname+'"]}') else OpenURL(SRC);
end;

procedure TFChat.BitBtn2Click(Sender: TObject);
begin
  web.Disconnect;
end;

procedure TFChat.ButtonChatChange(Sender: TObject);
begin
  podpowiedz.Visible:=false;
  if ButtonChat.Checked then ConnectToChat else DisconnectToChat;
end;

procedure TFChat.button_siChange(Sender: TObject);
begin
  web.AutoResponse:=button_si.Checked;
end;

procedure TFChat.CheckBox2Change(Sender: TObject);
begin
  emotki_nr:=1;
  timer_opoznienie.Enabled:=false;
  timer_opoznienie.Enabled:=true;
end;

procedure TFChat.code_editClick(Sender: TObject);
begin
  FBotEdytorKodu:=TFBotEdytorKodu.Create(self);
  FBotEdytorKodu.Show;
end;

procedure TFChat.Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
var
  s,u: string;
  a,i: integer;
begin
  if Key=VK_TAB then set_podpowiedz(Edit1.Text);
  if podpowiedz.Visible then
  begin
    case Key of
      VK_ESCAPE: podpowiedz.Visible:=false;
      VK_UP:
      begin
        a:=ListBox1.ItemIndex;
        dec(a);
        if a<0 then a:=0;
        ListBox1.ItemIndex:=a;
      end;
      VK_DOWN:
      begin
        a:=ListBox1.ItemIndex;
        inc(a);
        if a>ListBox1.Count-1 then a:=ListBox1.Count-1;
        ListBox1.ItemIndex:=a;
      end;
      VK_PRIOR: begin
                  a:=ListBox1.ItemIndex;
                  dec(a,ListBox1.Height div ListBox1.ItemHeight - 1);
                  if a<0 then a:=0;
                  ListBox1.ItemIndex:=a;
                end;
      VK_NEXT: begin
                 a:=ListBox1.ItemIndex;
                 inc(a,ListBox1.Height div ListBox1.ItemHeight - 1);
                 if a>ListBox1.Count-1 then a:=ListBox1.Count-1;
                 ListBox1.ItemIndex:=a;
               end;
    end;
  end;
end;

procedure TFChat.Edit1KeyPress(Sender: TObject; var Key: char);
var
  s: string;
begin
  if podpowiedz.Visible then
  begin
    s:=Edit1.Text;
    if (Key=#8) or (Key=#13) or (Key=#10) then exit else s:=s+Key;
    set_podpowiedz(s);
  end;
end;

procedure TFChat.Edit1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  s: string;
  a: integer;
begin
  if podpowiedz.Visible then
  begin
    s:=ostatni_wyraz(Edit1.Text);
    if s='' then podpowiedz.Visible:=false;
  end;
  case Key of
    VK_TAB: timer_focus.Enabled:=true;
    VK_RETURN: if podpowiedz.Visible then
               begin
                 Edit1.Text:=usun_ostatni_wyraz(Edit1.Text)+ListBox1.Items[ListBox1.ItemIndex]+' ';
                 ListBox1.Clear;
                 podpowiedz.Visible:=false;
                 Edit1.SelStart:=length(Edit1.Text);
               end else wyslij.Click;
    VK_ESCAPE: if podpowiedz.Visible then podpowiedz.Visible:=false;
    VK_F1: if nadawca_wiadomosci<>'' then
    begin
      AppendText(nadawca_wiadomosci,false);
      Edit1.SelStart:=length(Edit1.Text);
    end;
    VK_F2: if uzytkownicy.ItemIndex>-1 then
    begin
      AppendText(uzytkownicy.Items[uzytkownicy.ItemIndex],false);
      Edit1.SelStart:=length(Edit1.Text);
    end;
    VK_BACK: if podpowiedz.Visible then set_podpowiedz(Edit1.Text);
  end;
end;

procedure TFChat.Edit1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button=mbMiddle then Edit1.PasteFromClipboard;
end;

procedure TFChat.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if web.Active then CloseAction:=caHide else CloseAction:=caFree;
end;

procedure TFChat.SrcDumpClick(Sender: TObject);
begin
  FDumpSrc:=TFDumpSrc.Create(self);
  FDumpSrc.Memo1.Lines.Assign(web.GetSourceDump);
  FDumpSrc.ShowModal;
end;

procedure TFChat.SpeedButton2Click(Sender: TObject);
begin
  SpeedButton5.Visible:=true;
end;

end.

