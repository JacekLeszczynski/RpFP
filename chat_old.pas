unit chat_old;

{$mode objfpc}{$H+}

interface

uses
  config, Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons,
  StdCtrls, XMLPropStorage, ExtCtrls, ComCtrls, Menus, FileCtrl, ueled,
  HtmlView, NetSynWebSocket, ExtMessage, NetSynHTTP, ArchitectureOSInfo, Polfan,
  WebSocket2, HTMLUn2, HtmlGlobals, GifAnim, Types, HtmlBuffer, HTMLSubs;

type
  TPokoj = record
    tab: TTabSheet;
    nazwa: string;
    text: TStringList;
    web: THtmlViewer;
  end;

  { TFChat }

  TFChat = class(TForm)
    arch: TArchitectureOSInfo;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    emotki: TBitBtn;
    CheckBox1: TCheckBox;
    ColorButton1: TColorButton;
    Edit1: TEdit;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    PageControl1: TPageControl;
    Polfan1: TPolfan;
    PopupTabs: TPopupMenu;
    PopupUzytkownicy: TPopupMenu;
    SoundInfoOn: TCheckBox;
    my_status: TComboBox;
    HtmlViewer1: THtmlViewer;
    ImageList1: TImageList;
    Label1: TLabel;
    Label3: TLabel;
    led: TuELED;
    mess: TExtMessage;
    led_download: TuELED;
    Memo1: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    HtmlPanel: TPanel;
    PropStorage: TXMLPropStorage;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    pomoc: TSpeedButton;
    TabSheet1: TTabSheet;
    wyslij_source: TSpeedButton;
    wyslij: TSpeedButton;
    Splitter1: TSplitter;
    timer_quit: TTimer;
    uzytkownicy: TListBox;
    web: TNetSynWebSocket;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure emotkiClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure pomocClick(Sender: TObject);
    procedure _IMAGE_CLICK(Sender, Obj: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure my_statusChange(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure wyslijClick(Sender: TObject);
    procedure uzytkownicyDblClick(Sender: TObject);
    procedure wyslij_sourceClick(Sender: TObject);
    procedure _SB_FALSE(Sender: TObject);
    procedure timer_quitTimer(Sender: TObject);
    procedure webClose(aSender: TWebSocketCustomConnection;
      aCloseCode: integer; aCloseReason: string; aClosedByPeer: boolean);
    procedure webOpen(aSender: TWebSocketCustomConnection);
    procedure webRead(aSender: TWebSocketCustomConnection; aFinal, aRes1,
      aRes2, aRes3: boolean; aCode: integer; aData: TMemoryStream);
  private
    pokoje_count: integer;
    pokoje: array of TPokoj;
    Download: TFDownload;
    html: TStringList;
    //lista_download: TStringList;
    out_user: string;
    vElement,vLink: string;
    procedure GoRefresh(wiadomosc: string = ''; nadawca: string = '');
    procedure OdczytRamki(str: string);
    function ImagePlusOpis(str: string): string;
    function IsExistEmotka(str: string): boolean;
    procedure LoadFromResource(sName:string; sGif: TMemoryStream);
    procedure WatekOnStart(Sender: TObject);
    procedure WatekOnStop(Sender: TObject);
    (* kod dot. wiadomości prywatnych *)
    procedure PokojToIndex(nazwa: string; var TabId,PokojId: integer);
    function dodaj_nowy_pokoj(nazwa: string): integer;
    procedure usun_pokoj(nazwa: string);
    procedure usun_wszystkie_pokoje;
  public
    in_user,in_passw: string;
    procedure StartDownload;
  end;

var
  FChat: TFChat;

implementation

uses
  ecode, datamodule, synautil, math, synachar, LResources, LMessages, LCLType,
  LCLVersion, fpjson, jsonparser, TypInfo, emotki, chat_pomoc;

type
  TIm = record
    alt: string;
    index: integer;
  end;

var
  petla: boolean;
  czas_statusu: integer;
  zalogowany_uzytkownik: string;

{$R *.lfm}

function IsCharWord(ch: char): boolean;
begin
  Result:= ch in ['a'..'z', 'A'..'Z', '_', '0'..'9'];
end;

function IsCharHex(ch: char): boolean;
begin
  Result:= ch in ['0'..'9', 'a'..'f', 'A'..'F'];
end;

function SColorToHtmlColor(Color: TColor): string;
var
  N: Longint;
begin
  if Color=clNone then
    begin Result:= ''; exit end;
  N:= ColorToRGB(Color);
  Result:= '#'+
    IntToHex(Red(N), 2)+
    IntToHex(Green(N), 2)+
    IntToHex(Blue(N), 2);
end;

function SHtmlColorToColor(s: string; out Len: integer; Default: TColor): TColor;
var
  N1, N2, N3: integer;
  i: integer;
begin
  Result:= Default;
  Len:= 0;
  if (s<>'') and (s[1]='#') then Delete(s, 1, 1);
  if (s='') then exit;

  //delete after first nonword char
  i:= 1;
  while (i<=Length(s)) and IsCharWord(s[i]) do Inc(i);
  Delete(s, i, Maxint);

  //allow only #rgb, #rrggbb
  Len:= Length(s);
  if (Len<>3) and (Len<>6) then exit;

  for i:= 1 to Len do
    if not IsCharHex(s[i]) then exit;

  if Len=6 then
  begin
    N1:= StrToInt('$'+Copy(s, 1, 2));
    N2:= StrToInt('$'+Copy(s, 3, 2));
    N3:= StrToInt('$'+Copy(s, 5, 2));
  end
  else
  begin
    N1:= StrToInt('$'+s[1]+s[1]);
    N2:= StrToInt('$'+s[2]+s[2]);
    N3:= StrToInt('$'+s[3]+s[3]);
  end;

  Result:= RGBToColor(N1, N2, N3);
end;

{ TFChat }

procedure TFChat.BitBtn1Click(Sender: TObject);
begin
  if not web.Active then web.Open;
end;

procedure TFChat.BitBtn2Click(Sender: TObject);
begin
  if web.Active then
  begin
    usun_wszystkie_pokoje;
    web.SendText('{"numbers":[410],"strings":["/quit", ""]}');
    timer_quit.Enabled:=true;
    if not CheckBox1.Checked then
    begin
      html.Clear;
      Memo1.Clear;
      uzytkownicy.Clear;
      HTMLViewer1.Clear;
    end;
  end;
end;

procedure TFChat.CheckBox1Change(Sender: TObject);
begin
  if CheckBox1.Checked then HtmlPanel.Visible:=false else HtmlPanel.Visible:=true;
  if (not web.Active) and (not CheckBox1.Checked) then
  begin
    html.Clear;
    Memo1.Clear;
    uzytkownicy.Clear;
    HTMLViewer1.Clear;
  end;
end;

var
  o_s: string;
  o_ll,o_l: integer;

function SToFr(var str: string; do_tekstu: string; usun_takze_tekst: boolean = false):string;
var
  s,s2: string;
  a: integer;
begin
  s:=str;
  a:=pos(do_tekstu,s);
  s2:=copy(s,1,a-1);
  delete(s,1,a-1);
  if usun_takze_tekst then delete(s,1,length(do_tekstu));
  str:=s;
  result:=s2;
end;

procedure TFChat.Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  case Key of
    VK_RETURN: wyslij.Click;
    VK_F2: if uzytkownicy.ItemIndex>-1 then
    begin
      Edit1.Text:=Edit1.Text+uzytkownicy.Items[uzytkownicy.ItemIndex];
      Edit1.SelStart:=length(Edit1.Text);
    end;
  end;
end;

procedure TFChat.emotkiClick(Sender: TObject);
begin
  FEmotki:=TFEmotki.Create(self);
  FEmotki.Show;
end;

procedure TFChat.FormCreate(Sender: TObject);
begin
  if _DEV then
  begin
    CheckBox1.Visible:=true;
    wyslij_source.Visible:=true;
  end;
  pokoje_count:=0;
  html:=TStringList.Create;
  if not FileExists(MyConfDir('config.xml')) then position:=poWorkAreaCenter;
  PropStorage.FileName:=MyConfDir('config.xml');
  PropStorage.Active:=true;
  SoundInfoOn.Visible:=dm._ENGINE_UOS_LOADING;
  Download:=nil;
end;

procedure TFChat.FormDestroy(Sender: TObject);
begin
  if web.Active then
  begin
    usun_wszystkie_pokoje;
    web.SendText('{"numbers":[410],"strings":["/quit", ""]}');
    sleep(200);
    if web.Active then web.Close;
    html.Free;
    if led_download.Active then
    begin
      Download.Terminate;
      repeat sleep(50) until not led_download.Active;
    end;
  end;
end;

procedure TFChat.PageControl1Change(Sender: TObject);
begin
  if pos(' *',PageControl1.ActivePage.Caption)>0 then PageControl1.ActivePage.Caption:=StringReplace(PageControl1.ActivePage.Caption,' *','',[]);
end;

procedure TFChat.pomocClick(Sender: TObject);
begin
  FChatPomoc:=TFChatPomoc.Create(self);
  FChatPomoc.ShowModal;
end;

procedure TFChat._IMAGE_CLICK(Sender, Obj: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Edit1.Text:=Edit1.Text+'<'+TImageObj(Obj).Alt+'>';
end;

procedure TFChat.MenuItem1Click(Sender: TObject);
var
  s: string;
begin
  if uzytkownicy.Count=0 then exit;
  if uzytkownicy.ItemIndex=-1 then exit;
  s:=uzytkownicy.Items[uzytkownicy.ItemIndex];
  if s=zalogowany_uzytkownik then exit;
  dodaj_nowy_pokoj(s);
end;

procedure TFChat.MenuItem2Click(Sender: TObject);
begin
  usun_pokoj(PageControl1.ActivePage.Caption);
end;

procedure TFChat.my_statusChange(Sender: TObject);
begin
  czas_statusu:=0;
end;

procedure TFChat.SpeedButton1Click(Sender: TObject);
begin
  SpeedButton4.Visible:=true;
end;

procedure TFChat.SpeedButton2Click(Sender: TObject);
begin
  SpeedButton5.Visible:=true;
end;

procedure TFChat.SpeedButton3Click(Sender: TObject);
begin
  SpeedButton6.Visible:=true;
end;

procedure TFChat.wyslijClick(Sender: TObject);
var
  j: integer;
  b,i,u: boolean;
  s1,s2,s,pom: string;
begin
  if trim(Edit1.Text)='' then exit;
  if not web.Active then exit;
  my_status.ItemIndex:=0;
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
  s:=Edit1.Text;
  if PageControl1.ActivePageIndex=0 then web.SendText('{"numbers":[410],"strings":["<'+SColorToHtmlColor(ColorButton1.ButtonColor)+'>'+s1+s+s2+'", "Radio_FortyPlus"]}') else
  begin
    pom:=PageControl1.ActivePage.Caption;
    web.SendText('{"numbers":[410],"strings":["/msg '+pom+' <#000000>'+s+'", ""]}');
  end;
  Edit1.Clear;
  Edit1.SetFocus;
end;

procedure TFChat.uzytkownicyDblClick(Sender: TObject);
begin
  if uzytkownicy.ItemIndex=-1 then exit;
  Edit1.Text:=Edit1.Text+uzytkownicy.Items[uzytkownicy.ItemIndex];
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

procedure TFChat._SB_FALSE(Sender: TObject);
begin
  TSpeedButton(Sender).Visible:=false;
end;

procedure TFChat.timer_quitTimer(Sender: TObject);
begin
  timer_quit.Enabled:=false;
  if web.Active then web.Close;
end;

procedure TFChat.webClose(aSender: TWebSocketCustomConnection;
  aCloseCode: integer; aCloseReason: string; aClosedByPeer: boolean);
begin
  usun_wszystkie_pokoje;
  led.Active:=false;
  HtmlPanel.Visible:=false;
end;

procedure TFChat.webOpen(aSender: TWebSocketCustomConnection);
var
  s,ver: string;
begin
  led.Active:=true;
  ver:=' '+_VER;
  sleep(500);
  case arch.OsInfo of
    ArchitectureOSInfo.osLinux86:   s:='Radio-Player-F+'+ver+' (Linux i386)';
    ArchitectureOSInfo.osLinux64:   s:='Radio-Player-F+'+ver+' (Linux x86_64)';
    ArchitectureOSInfo.osWindows86: s:='Radio-Player-F+'+ver+' (Windows 86bit)';
    ArchitectureOSInfo.osWindows64: s:='Radio-Player-F+'+ver+' (Windows 64bit)';
    ArchitectureOSInfo.osNone:      s:='Radio-Player-F+'+ver;
    else                            s:='Radio-Player-F+'+ver;
  end;
  if _CUSTOM_POLFAN='' then
    web.SendText('{"numbers": [1400], "strings":["'+in_user+'","'+in_passw+'","","Radio_FortyPlus","http://polfan.pl?cg=p","nlst=1&nnum=1&jlmsg=true&ignprv=false","","'+s+'"]}')
  else
    web.SendText('{"numbers": [1400], "strings":["'+in_user+'","'+in_passw+'","","'+_CUSTOM_POLFAN+'","http://polfan.pl?cg=p","nlst=1&nnum=1&jlmsg=true&ignprv=false","","'+s+'"]}');
end;

procedure TFChat.webRead(aSender: TWebSocketCustomConnection; aFinal, aRes1,
  aRes2, aRes3: boolean; aCode: integer; aData: TMemoryStream);
var
  s: string;
  c: TTestWebSocketClientConnection;
begin
  c:=TTestWebSocketClientConnection(aSender);
  //InfoMemo.Lines.Insert(0, Format('OnRead %d, final: %d, ext1: %d, ext2: %d, ext3: %d, type: %d, length: %d', [aSender.Index, ord(aFinal), ord(aRes1), ord(aRes2), ord(aRes3), aCode, aData.Size]));
  s:=ReadStrFromStream(c.ReadStream,min(c.ReadStream.size,10*1024));
  OdczytRamki(s);
end;

procedure TFChat.GoRefresh(wiadomosc: string; nadawca: string);
var
  nazwa: string;
  a,id: integer;
begin
  if wiadomosc='' then
  begin
    if PageControl1.ActivePageIndex=0 then HtmlViewer1.LoadFromString(html.Text) else
    begin
      PokojToIndex(PageControl1.ActivePage.Caption,a,id);
      if id=-1 then exit;
      pokoje[id].web.LoadFromString(pokoje[id].text.Text);
    end;
    exit;
  end;
  if nadawca='' then
  begin
    if PageControl1.ActivePageIndex>0 then PageControl1.Pages[0].Caption:='Pokój główny *';
    html.Add(wiadomosc);
    if html.Count>200 then html.Delete(0);
    HtmlViewer1.LoadFromString(html.Text);
    if not CheckBox1.Checked then HtmlPanel.Visible:=true;
  end else begin
    PokojToIndex(nadawca,a,id);
    if id=-1 then id:=dodaj_nowy_pokoj(nadawca);
    pokoje[id].text.Add(wiadomosc);
    if pokoje[id].text.Count>200 then pokoje[id].text.Delete(0);
    pokoje[id].web.LoadFromString(pokoje[id].text.Text);
    if (PageControl1.ActivePageIndex<>id+1) and (pos(' *',pokoje[id].tab.Caption)=0) then pokoje[id].tab.Caption:=pokoje[id].tab.Caption+' *';
  end;
end;

procedure TFChat.OdczytRamki(str: string);
var
  jData : TJSONData;
  jObject : TJSONObject;
  jArray : TJSONArray;
  s,nadawca,adresat,pom,uzytkownik: string;
  a,i,ii,ile: integer;
  kod,kod2: integer;
  obrazek,wiadomosc: string;
  sekret: boolean;
  USER,SS: string;
begin
  uzytkownik:='';
  sekret:=false;
  jData:=GetJSON(str);
  jObject:=TJSONObject(jData);
  jArray:=jObject.Arrays['numbers'];
  kod:=jArray[0].AsInteger;
  if jArray.Count=2 then kod2:=jArray[1].AsInteger else kod2:=-1;
  s:='';

  if kod=610 then {Normalne pakiety rozmów}
  begin //<img src=\"img/tany16.gif\" alt=\"tany16\" /><img src=\"img/tany16.gif\" alt=\"tany16\" />
    jArray:=jObject.Arrays['strings'];
    s:=jArray[0].AsString;
    (* tu kod sprawdzający czy obrazek istnieje, a jak nie, to ściąga obrazek automatycznie *)
    if IsExistEmotka(s) then StartDownload;
    //if ImageHints.Checked then s:=ImagePlusOpis(s);
    (* powiadomienie dźwiękowe przy wiadomości nadchodzącej do ciebie *)
    USER:=upcase(zalogowany_uzytkownik);
    SS:=upcase(s);
    //<FONT COLOR=#000000><B>~SAMULAPTOP</B></FONT>: <FONT COLOR=#000000>TU TEZ DZIALAJA EMOTKI SAMU <IMG SRC="IMG/A2.GIF" ALT="A2" /><FONT COLOR=#808080 SIZE=1>[A2]</FONT></FONT>
    if SoundInfoOn.Checked and (pos('><B>'+USER+'</B></FONT>:',SS)=0) and (pos('<FONT COLOR=RED>** PRZYCHODZI <B>'+USER+'</B>...</FONT>',SS)=0)
    and ((pos(' '+USER+' ',SS)>0) or (pos(' '+USER+'<',SS)>0) or (pos('>'+USER+' ',SS)>0) or (pos('>'+USER+'<',SS)>0)) then dm.beep_fx;
    (* jeśli nie mogę odpowiedzieć - odpowiedź automatyczna *)
    if my_status.ItemIndex>0 then
    begin
      if (pos('><B>'+USER+'</B></FONT>:',SS)=0) and (pos('<FONT COLOR=RED>** PRZYCHODZI <B>'+USER+'</B>...</FONT>',SS)=0)
        and ((pos(' '+USER+' ',SS)>0) or (pos(' '+USER+'<',SS)>0) or (pos('>'+USER+' ',SS)>0) or (pos('>'+USER+'<',SS)>0))
          and (czas_statusu+60000<TimeToInteger)
            then
      begin
        czas_statusu:=TimeToInteger;
        case my_status.ItemIndex of
          1: wiadomosc:='<u>Informacja automatyczna:</u> <i>Jestem delikatnie zajęty...';
          2: wiadomosc:='<u>Informacja automatyczna:</u> <i>Odszedłem od komputera na chwilę...';
        end;
        web.SendText('{"numbers":[410],"strings":["<'+SColorToHtmlColor(clGray)+'>'+wiadomosc+'", "Radio_FortyPlus"]}');
      end;
    end;
  end else

  if kod=611 then {Wiadomość prywatna}
  begin
    sekret:=true;
    jArray:=jObject.Arrays['strings'];
    ile:=jArray.Count;
    s:=jArray[0].AsString; {wiadomość}
    nadawca:=jArray[1].AsString; {nadawca}
    if 2<=ile-1 then adresat:=jArray[2].AsString; {adresat}
    if (adresat='') or (adresat=zalogowany_uzytkownik) then uzytkownik:=nadawca else
    if (nadawca='') or (nadawca=zalogowany_uzytkownik) then uzytkownik:=adresat else
    uzytkownik:='';
    if IsExistEmotka(s) then StartDownload;
    dm.beep_fx;
  end else

  if kod=615 then {ZJAWIA SIĘ NOWY UŻYTKOWNIK}
  begin
    jArray:=jObject.Arrays['strings'];
    uzytkownicy.Items.Add(jArray[0].AsString);
    (* przykład witania wszystkich nowych użytkowników z automatu *)
    //if jArray[0].AsString<>zalogowany_uzytkownik then
    //  web.SendText('{"numbers":[410],"strings":["<'+SColorToHtmlColor(clGray)+'>'+jArray[0].AsString+'<hej>", "Radio_FortyPlus"]}');
  end else

  if kod=616 then {ZNIKA SIĘ NOWY UŻYTKOWNIK}
  begin
    jArray:=jObject.Arrays['strings'];
    a:=StringToItemIndex(uzytkownicy.Items,jArray[0].AsString);
    if a>-1 then uzytkownicy.Items.Delete(a);
  end else

  if (kod=618) and (kod2=4) then {Jako kto się loguję}
  begin
    jArray:=jObject.Arrays['strings'];
    zalogowany_uzytkownik:=jArray[0].AsString;
  end else

  if kod=619 then {ZALOGOWANI LUDZIE}
  begin
    uzytkownicy.Clear;
    jArray:=jObject.Arrays['strings'];
    i:=1;
    ii:=jArray.Count;
    uzytkownicy.BeginUpdateBounds;
    while i<ii do
    begin
      uzytkownicy.Items.Add(jArray[i].AsString);
      //writeln(jArray[i].AsString,' - ',jArray[i+1].AsString);
      inc(i,2);
    end;
    uzytkownicy.EndUpdateBounds;
  end else

  if kod=625 then {NAGŁÓWKI POKOJU}
  begin
    jArray:=jObject.Arrays['strings'];
    s:=jArray[0].AsString;
  end else

  if kod=630 then {INFORMACJE SERWERA DO UŻYTKOWNIKA - WAŻNE}
  begin
    jArray:=jObject.Arrays['strings'];
    s:=jArray[0].AsString;
  end else

  if kod=65535 then
  begin
    {"numbers":[65535],"strings":[""]}
    timer_quit.Enabled:=false;
    if web.Active then web.Close;
  end;

  Memo1.Lines.Add(str);
  GoRefresh(s+'<br>',uzytkownik);
  jData.Free;
end;

function TFChat.ImagePlusOpis(str: string): string;
var
  s: string;
  aa,a,licznik,i: integer;
  tab: array of TIm;
begin
  licznik:=0;
  aa:=0;
  s:=StringReplace(str,'"',#9,[rfReplaceAll]);
  while true do
  begin
    a:=pos('<img src=',s);
    if a=0 then break;
    delete(s,1,a);
    inc(aa,a);
    a:=pos('alt=',s);
    delete(s,1,a);
    inc(aa,a);
    a:=pos(#9,s);
    delete(s,1,a);
    inc(aa,a);
    inc(licznik);
    SetLength(tab,licznik);
    tab[licznik-1].alt:=GetLineToStr(s,1,#9);
    a:=pos('>',s);
    tab[licznik-1].index:=aa+a+1;
  end;
  s:=str;
  for i:=licznik-1 downto 0 do insert('<font color=#808080 size=1>['+tab[i].alt+']</font>',s,tab[i].index);
  SetLength(tab,0);
  result:=s;
end;

function TFChat.IsExistEmotka(str: string): boolean;
var
  s,s1: string;
  a: integer;
  stream: TMemoryStream;
begin
  s:=str;
  s:=StringReplace(s,'\"','"',[rfReplaceAll]);
  while true do
  begin
    a:=pos('<img ',s);
    if a=0 then break;
    delete(s,1,a+4);
    a:=pos('src="',s);
    delete(s,1,a+4);
    a:=pos('"',s);
    s1:=copy(s,1,a-1);
    if not FileExists(MyDir(s1)) then lista_download.Add(s1);
  end;
  result:=lista_download.Count>0;
end;

procedure TFChat.StartDownload;
begin
  if not led_download.Active then
  begin
    Download:=TFDownload.Create(true,MyDir);
    Download.OnStart:=@WatekOnStart;
    Download.OnStop:=@WatekOnStop;
    Download.Resume;
  end;
end;

procedure TFChat.LoadFromResource(sName: string; sGif: TMemoryStream);
var
  res: TResourceStream;
begin
  try
    res:=TResourceStream.Create(hInstance,sName,RT_RCDATA);
    sGif.LoadFromStream(res);
  finally
    res.Free;
  end;
end;

procedure TFChat.WatekOnStart(Sender: TObject);
begin
  led_download.Active:=true;
end;

procedure TFChat.WatekOnStop(Sender: TObject);
begin
  led_download.Active:=false;
  GoRefresh;
end;

procedure TFChat.PokojToIndex(nazwa: string; var TabId, PokojId: integer);
var
  s: string;
  i,a: integer;
begin
  a:=0;
  PokojId:=-1;
  for i:=1 to PageControl1.PageCount-1 do
  begin
    s:=PageControl1.Pages[i].Caption;
    if pos(' *',s)>0 then s:=StringReplace(s,' *','',[]);
    if s=nazwa then
    begin
      a:=i;
      break;
    end;
  end;
  TabId:=a;
  a:=-1;
  if TabId>0 then for i:=0 to pokoje_count-1 do if pokoje[i].nazwa=nazwa then
  begin
    a:=i;
    break;
  end;
  PokojId:=a;
end;

function TFChat.dodaj_nowy_pokoj(nazwa: string): integer;
var
  a,id: integer;
begin
  PokojToIndex(nazwa,a,id);
  if a=0 then
  begin
    inc(pokoje_count);
    SetLength(pokoje,pokoje_count);
    id:=pokoje_count-1;
    pokoje[id].tab:=PageControl1.AddTabSheet;
    pokoje[id].nazwa:=nazwa;
    pokoje[id].tab.Caption:=nazwa;
    pokoje[id].tab.PopupMenu:=PopupTabs;
    pokoje[id].web:=ThtmlViewer.Create(pokoje[id].tab);
    pokoje[id].web.Parent:=pokoje[id].tab;
    pokoje[id].web.Align:=alClient;
    pokoje[id].web.AutoScrollToDown:=true;
    pokoje[id].web.DefFontName:='Sans';
    pokoje[id].web.DefFontSize:=11;
    pokoje[id].web.NoMouseBusy:=true;
    pokoje[id].web.OnImageClick:=@_IMAGE_CLICK;
    pokoje[id].text:=TStringList.Create;
    pokoje[id].web.LoadFromString('');
    PageControl1.ActivePage:=pokoje[id].tab;
  end else PageControl1.ActivePageIndex:=a;
  result:=id;
end;

procedure TFChat.usun_pokoj(nazwa: string);
var
  i,a,id: integer;
begin
  PokojToIndex(nazwa,a,id);
  if id=-1 then exit;
  pokoje[id].text.Free;
  pokoje[id].web.Free;
  pokoje[id].tab.Free;
  for i:=id+1 to pokoje_count-1 do pokoje[i-1]:=pokoje[i];
  dec(pokoje_count);
  SetLength(pokoje,pokoje_count);
end;

procedure TFChat.usun_wszystkie_pokoje;
var
  i: integer;
begin
  if pokoje_count=0 then exit;
  for i:=0 to pokoje_count-1 do
  begin
    pokoje[i].text.Free;
    pokoje[i].web.Free;
    pokoje[i].tab.Free;
  end;
  pokoje_count:=0;
  SetLength(pokoje,pokoje_count);
end;

initialization
  {$I gif2.lrs}

end.

