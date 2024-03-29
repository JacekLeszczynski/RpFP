unit bot;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,
  {$IFDEF WINDOWS}
  windows,
  {$ENDIF}
  XMLPropStorage, Polfan, NetSynHTTP, uPSComponent,
  PointerTab, ExtSharedMemory, IniFiles;

type

  { TBot }

  TBot = class
  private
    FTest: boolean;
    FDebug: boolean;
    ini: TIniFile;
    me: TPointerTab;
    web: TPolfan;
    MemSH: TExtSharedMemory;
    script: TPSScript;
    get_login: TNetSynHTTP;
    _laczenie,_exit,_reload: boolean;
    _licznik,_polaczono: integer;
    _error: integer;
    _users: TStringList;
    nadawca,adresat: string;
    script_loaded: boolean;
    procedure Init;
    procedure DeInit;
    procedure conf_load;
    procedure conf_save;
    procedure MemSHSendMessage(Sender: TObject; var AMessage: string);
    procedure MemSHReceiveMessage(Sender: TObject; AMessage: string);
    procedure MemSHServer(Sender: TObject);
    procedure MemSHClient(Sender: TObject);
    procedure ScriptCompile(Sender: TPSScript);
    procedure ListaCreateElement(Sender: TObject; var AWskaznik: Pointer);
    procedure ListaDestroyElement(Sender: TObject; var AWskaznik: Pointer);
    procedure ListaReadElement(Sender: TObject; var AWskaznik: Pointer);
    procedure ListaWriteElement(Sender: TObject; var AWskaznik: Pointer);
    procedure webOpen(Sender: TObject);
    procedure webListUserInit(Sender: TObject; AUsers, ADescriptions, AAttributes: TStrings);
    procedure webListUserAdd(Sender: TObject; ARoom, AUsername, ADescription: string; aAttr: integer);
    procedure webListUserDel(Sender: TObject; ARoom, AUsername: string);
    procedure webListUserDeInit(Sender: TObject);
    procedure webBeforeConnect(Sender: TObject; aUser, aFingerPrint, aOS: string; var aAccepted: boolean);
    procedure webBeforeReadDocument(Sender: TObject; AName, aNadawca, aAdresat: string;
      AMode: TPolfanRoomMode; AMessage: string; var aDropNow, aDeleteFromLogSrc: boolean);
    procedure webReadDocument(Sender: TObject; AName: string; AMode: TPolfanRoomMode;
      AMessage: string; ADocument: TStrings; ARefresh: boolean);
    procedure webClose(Sender: TObject; aErr: integer; aErrorString: string);
    procedure ConnectToChat;
    procedure DisconnectToChat;
    procedure SendNow(Sender: TObject; aMessage: string);
    procedure Send(const aText: string; const aSleep: integer);
    procedure SendToUser(const aText: string; const aSleep: integer; const aUser: string);
    function load_script(aScript: string): boolean;
    function load_script(aScript: TStringList): boolean;
    procedure zeruj_tablice;
    procedure wczytaj_tablice;
    function odczytaj_element_tablicy(aName: string; aIndex: integer): string;
  protected
    function GetScriptData(var aNumber: integer; var aWebRoom,aWebUser,aRoom,aUser,aMessage: string): boolean;
    function _random(const min,max:integer): integer;
    function _pos(const aFragment,aText: string): integer;
    procedure _delete(var aText: string; const aStart, aCount: integer);
    function _StringReplace(const aText,aS1,aS2: string; const aTryb: integer): string;
    function _DeleteHtml(const aText: string): string;
    function _UpCase(const aText: string): string;
    function _DeleteCiapki(const aText: string): string;
    function _GetLineToStr(const aText: string; const aIndex: integer; const aSeparator: char): string;
    function _DateTime(const aMask: string): string;
    function _odczytaj_element_tablicy(const aName: string; const aIndex: integer): string;
    function _UsersCount: integer;
    function _UsersGet(const aIndex: integer): string;
  public
    constructor Create(aTestMode: boolean = false);
    destructor Destroy; override;
    procedure Execute;
    function TestCompilation(aScript: string): boolean;
  published
    property Debug: boolean read FDebug write FDebug;
  end;

var
  _komenda: string;

implementation

uses
  config, ecode, fpjson, jsonparser, synacode, Graphics;

type
  TElement = record
    Number: integer; //1 - nowy user, 2 - zdarzenie
    WebRoom: string;
    WebUser: string;
    Room: string;
    User: string;
    Message: string;
  end;

var
  czekaj: boolean = true;
  element: TElement;
  pp: ^TElement;

var
  tabs_count: integer = 0;
  tabs_elements: integer = 0;
  tabs_name: array of record
    nazwa: string;
    start,count: integer;
  end;
  tabs_var: array of string;

{$IFDEF WINDOWS}
{$if defined(cpu64)}
function CalculateFingerPrint: string; stdcall; external 'libpolfan64.dll';
{$else}
function CalculateFingerPrint: string; stdcall; external 'libpolfan32.dll';
{$endif}
{$ELSE}
function CalculateFingerPrint: string; stdcall; external 'libpolfan64.so';
{$ENDIF}

procedure ProcessMessages;
{$IFDEF WINDOWS}
var
  Msg: TMsg;
{$ENDIF}
begin
  checkSynchronize;
  {$IFDEF WINDOWS}
  while PeekMessage(Msg,0,0,0,PM_REMOVE) do
  begin
    if Msg.Message=WM_QUIT then exit else
    begin
      //GetMessage(Msg,0,0,0);
      TranslateMessage(Msg);
      DispatchMessage(Msg);
    end;
  end;
  {$ENDIF}
end;

{ FBot }

procedure TBot.Init;
begin
  FDebug:=false;
  _licznik:=0;
  _polaczono:=0;
  _laczenie:=false;
  conf_load;
end;

procedure TBot.DeInit;
begin
end;

procedure TBot.conf_load;
var
  s: TStringList;
begin
  _BOT_ROOM:=ini.ReadString('root','BotRoom','');
  _BOT_USER:=ini.ReadString('root','BotUser','Bot');
  _BOT_PASSW:=DecryptString(ini.ReadString('root','BotPassw',''),POLFAN_TOKEN,true);
  s:=TStringList.Create;
  try
    if FileExists(MyConfDir('config_bot.script')) then s.LoadFromFile(MyConfDir('config_bot.script'));
    if load_script(s) then script_loaded:=true else _exit:=true;
  finally
    s.Free;
  end;
end;

procedure TBot.conf_save;
begin

end;

procedure TBot.MemSHSendMessage(Sender: TObject; var AMessage: string);
begin
  AMessage:=_komenda;
end;

procedure TBot.MemSHReceiveMessage(Sender: TObject; AMessage: string);
begin
  {$IFDEF WINDOWS}
  if AMessage='stop' then halt else
  if AMessage='reload' then _reload:=true;
  {$ELSE}
  if AMessage='stop' then _exit:=true else
  if AMessage='reload' then _reload:=true;
  {$ENDIF}
end;

procedure TBot.MemSHServer(Sender: TObject);
begin
  if _komenda='stop' then _exit:=true;
  czekaj:=false;
end;

procedure TBot.MemSHClient(Sender: TObject);
begin
  _exit:=true;
  czekaj:=false;
end;

procedure TBot.ScriptCompile(Sender: TPSScript);
begin
  {funkcje wejścia-wyjścia}
  Sender.AddMethod(self,@TBot.GetScriptData,'function GetData(var aNumber: integer; var aWebRoom,aWebUser,aRoom,aUser,aMessage: string): boolean;');
  Sender.AddMethod(self,@TBot.Send,'procedure Send(const aText: string; const aSleep: integer);');
  Sender.AddMethod(self,@TBot.SendToUser,'procedure SendToUser(const aText: string; const aSleep: integer; const aUser: string);');
  Sender.AddMethod(self,@TBot._odczytaj_element_tablicy,'function ReadTab(const aName: string; const aIndex: integer): string;');
  Sender.AddMethod(self,@TBot._UsersCount,'function UsersCount: integer;');
  Sender.AddMethod(self,@TBot._UsersGet,'function UsersGet(const aIndex: integer): string;');
  {funkcje operujące na stringach}
  Sender.AddMethod(self,@TBot._random,'function random(const min, max: integer): integer;');
  Sender.AddMethod(self,@TBot._pos,'function pos(const aFragment, aText: string): integer;');
  Sender.AddMethod(self,@TBot._delete,'procedure delete(var aText: string; const aStart, aCount: integer);');
  Sender.AddMethod(self,@TBot._StringReplace,'function StringReplace(const aText, aS1, aS2: string; const aTryb: integer): string;');
  Sender.AddMethod(self,@TBot._DeleteHtml,'function DeleteHtml(const aText: string): string;');
  Sender.AddMethod(self,@TBot._UpCase,'function UpCase(const aText: string): string;');
  Sender.AddMethod(self,@TBot._GetLineToStr,'function LineToStr(const aText: string; const aIndex: integer; const aSeparator: char): string;');
  Sender.AddMethod(self,@TBot._DateTime,'function DateTime(const aMask: string): string;');
  Sender.AddMethod(self,@TBot._DeleteCiapki,'function rmCiapki(const aText: string): string;');
end;

procedure TBot.ListaCreateElement(Sender: TObject; var AWskaznik: Pointer);
begin
  new(pp);
  AWskaznik:=pp;
end;

procedure TBot.ListaDestroyElement(Sender: TObject; var AWskaznik: Pointer);
begin
  pp:=AWskaznik;
  dispose(pp);
  pp:=nil;
end;

procedure TBot.ListaReadElement(Sender: TObject; var AWskaznik: Pointer);
begin
  pp:=AWskaznik;
  element:=pp^;
end;

procedure TBot.ListaWriteElement(Sender: TObject; var AWskaznik: Pointer);
begin
  pp^:=element;
  AWskaznik:=pp;
end;

procedure TBot.webBeforeConnect(Sender: TObject; aUser, aFingerPrint,
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

procedure TBot.webBeforeReadDocument(Sender: TObject; AName, aNadawca,
  aAdresat: string; AMode: TPolfanRoomMode; AMessage: string; var aDropNow,
  aDeleteFromLogSrc: boolean);
begin
  nadawca:=aNadawca;
  adresat:=aAdresat;
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

procedure TBot.webReadDocument(Sender: TObject; AName: string;
  AMode: TPolfanRoomMode; AMessage: string; ADocument: TStrings;
  ARefresh: boolean);
var
  u_s,wiadomosc: string;
  a,b,i: integer;
begin
  if AMode=rmService then exit;

  u_s:=upcase(AMessage);
  a:=pos('><B>',u_s)+4;
  b:=pos('</B></FONT>:',u_s);
  nadawca:=copy(AMessage,a,b-a);
  adresat:=AName;

  wiadomosc:=AMessage;
  a:=pos('><b>'+nadawca+'</b></font>:',wiadomosc);
  delete(wiadomosc,1,a+15+length(nadawca));
  wiadomosc:=StringReplace(wiadomosc,'</font>','',[rfReplaceAll,rfIgnoreCase]);
  wiadomosc:=StringReplace(wiadomosc,'<font color=#','<#',[rfReplaceAll,rfIgnoreCase]);
  //<img src="img/piwosz.gif" alt="piwosz" />
  while true do begin
    a:=pos('<img src="',wiadomosc);
    if a=0 then break;
    b:=pos('alt="',wiadomosc);
    delete(wiadomosc,a,b-a);
    wiadomosc:=StringReplace(wiadomosc,'alt="','<',[rfIgnoreCase]);
    wiadomosc:=StringReplace(wiadomosc,'" />','>',[rfIgnoreCase]);
  end;
  while true do begin
    a:=pos('&lt;',wiadomosc);
    if a=0 then break;
    if a>0 then delete(wiadomosc,a,4);
    insert('<',wiadomosc,a);
  end;
  while true do begin
    a:=pos('&gt;',wiadomosc);
    if a=0 then break;
    if a>0 then delete(wiadomosc,a,4);
    insert('>',wiadomosc,a);
  end;
  wiadomosc:=trim(wiadomosc);
  while true do
  begin
    a:=pos('<#',wiadomosc);
    if a=0 then break;
    b:=length(wiadomosc);
    for i:=a+2 to b do if wiadomosc[i]='>' then
    begin
      b:=i;
      break;
    end;
    delete(wiadomosc,a,b-a+1);
  end;
  wiadomosc:=StringReplace(wiadomosc,'<br>','',[rfReplaceAll]);
  wiadomosc:=StringReplace(wiadomosc,'<i>','',[rfReplaceAll]);
  wiadomosc:=StringReplace(wiadomosc,'</i>','',[rfReplaceAll]);
  wiadomosc:=StringReplace(wiadomosc,'<b>','',[rfReplaceAll]);
  wiadomosc:=StringReplace(wiadomosc,'</b>','',[rfReplaceAll]);
  wiadomosc:=StringReplace(wiadomosc,'<u>','',[rfReplaceAll]);
  wiadomosc:=StringReplace(wiadomosc,'</u>','',[rfReplaceAll]);
  wiadomosc:=StringReplace(wiadomosc,'&#34;','"',[rfReplaceAll]);

  if nadawca<>'' then
  begin
    element.Number:=2;
    element.WebUser:=web.User;
    element.WebRoom:=web.Room;
    element.Room:=AName;
    element.User:=nadawca;
    element.Message:=wiadomosc;
    me.Add;
  end;
end;

procedure TBot.webListUserAdd(Sender: TObject; ARoom, AUsername,
  ADescription: string; aAttr: integer);
begin
  _users.Add(AUsername);
  if AUsername=web.User then exit;
  element.Number:=1;
  element.WebUser:=web.User;
  element.Room:=ARoom;
  element.User:=AUsername;
  me.Add;
end;

procedure TBot.webListUserDel(Sender: TObject; ARoom, AUsername: string);
var
  a: integer;
begin
  a:=ecode.StringToItemIndex(_users,AUsername);
  if a>-1 then _users.Delete(a);
end;

procedure TBot.webListUserDeInit(Sender: TObject);
begin
  _users.Clear;
end;

procedure TBot.webOpen(Sender: TObject);
begin
  inc(_polaczono);
  _laczenie:=false;
  _error:=0;
end;

procedure TBot.webListUserInit(Sender: TObject; AUsers, ADescriptions,
  AAttributes: TStrings);
begin
  _users.Assign(AUsers);
  element.Number:=0;
  element.WebRoom:=web.Room;
  element.WebUser:=web.User;
  element.Room:=web.Room;
  element.User:=web.User;
  me.Add;
end;

procedure TBot.webClose(Sender: TObject; aErr: integer; aErrorString: string);
begin
  _laczenie:=false;
  if aErr<>0 then
  begin
    dec(_polaczono);
    _error:=aErr;
    if aErr=100 then _exit:=true;
  end;
end;

procedure TBot.ConnectToChat;
begin
  if _FINGERPRINT='' then _FINGERPRINT:=CalculateFingerPrint;
  //if web.DeveloperCodeOn then web.SourceDumpClear;
  web.BaseDirectory:=MyConfDir;
  web.Room:=_BOT_ROOM;
  web.ProgName:='Bot';
  web.ProgVersion:='1.0';
  web.ImagesOFF:=true;
  web.User:=_BOT_USER;
  web.Password:=_BOT_PASSW;
  web.UserStatus:='';
  web.ImgAltVisible:=false;
  web.MaxLines:=50;
  web.FingerPrint:=_FINGERPRINT;
  web.Connect;
end;

procedure TBot.DisconnectToChat;
begin
  web.Disconnect;
end;

procedure TBot.SendNow(Sender: TObject; aMessage: string);
begin
  web.SendText(aMessage);
end;

procedure TBot.Send(const aText: string; const aSleep: integer);
var
  wysylka: TAutoResponseDelay;
  s: string;
begin
  s:=StringReplace(aText,'"','&#34;',[rfReplaceAll]);
  s:='{"numbers":[410],"strings":["<'+SColorToHtmlColor(clBlack)+'>'+s+'", "'+web.Room+'"]}';
  if aSleep=0 then web.SendText(s) else
  begin
    wysylka:=TAutoResponseDelay.Create(aSleep,s);
    wysylka.OnSendNow:=@SendNow;
    wysylka.Resume;
  end;
end;

procedure TBot.SendToUser(const aText: string; const aSleep: integer;
  const aUser: string);
var
  wysylka: TAutoResponseDelay;
  s: string;
begin
  s:=StringReplace(aText,'"','&#34;',[rfReplaceAll]);
  s:='{"numbers":[410],"strings":["/msg '+aUser+' <'+SColorToHtmlColor(clBlack)+'>'+s+'", ""]}';
  if aSleep=0 then web.SendText(s) else
  begin
    wysylka:=TAutoResponseDelay.Create(aSleep,s);
    wysylka.OnSendNow:=@SendNow;
    wysylka.Resume;
  end;
end;

{aNumer: 1 - dot. nowych użytkowników}
{aNumer: 2 - dot. zdarzeń na dyskusję w pokoju}
function TBot.load_script(aScript: string): boolean;
var
  old: TStringList;
begin
  result:=false;
  if aScript='' then exit;
  old:=TStringList.Create;
  try
    old.Assign(script.Script);
    script.Script.Clear;
    script.Script.AddText(aScript);
    if script.Compile then result:=true else
    begin
      script.Script.Assign(old);
      if script.Script.Count>0 then script.Compile;
    end;
    wczytaj_tablice;
  finally
    old.Free;
  end;
end;

function TBot.load_script(aScript: TStringList): boolean;
var
  old: TStringList;
begin
  result:=false;
  if aScript.Count=0 then exit;
  old:=TStringList.Create;
  try
    old.Assign(script.Script);
    script.Script.Assign(aScript);
    if script.Compile then result:=true else
    begin
      script.Script.Assign(old);
      if script.Script.Count>0 then script.Compile;
    end;
    wczytaj_tablice;
  finally
    old.Free;
  end;
end;

procedure TBot.zeruj_tablice;
begin
  tabs_count:=0;
  tabs_elements:=0;
  SetLength(tabs_name,0);
  SetLength(tabs_var,0);
end;

procedure TBot.wczytaj_tablice;
var
  i,j,a,el: integer;
  s,s1,s2: string;
begin
  zeruj_tablice;
  for i:=0 to script.Script.Count-1 do
  begin
    s:=script.Script[i];
    a:=pos('{#',s);
    if a>0 then
    begin
      s:=trim(StringReplace(s,' ','',[rfReplaceAll]));
      delete(s,1,2);
      delete(s,length(s),1);
      s1:=GetLineToStr(s,1,'='); //nazwa tablicy
      s2:=GetLineToStr(s,2,'='); //elementy tablicy
      {wczytujemy elementy do nowej tablicy}
      inc(tabs_count); SetLength(tabs_name,tabs_count);
      tabs_name[tabs_count-1].nazwa:=s1;
      tabs_name[tabs_count-1].start:=tabs_elements;
      tabs_name[tabs_count-1].count:=0;
      j:=1;
      el:=0;
      while true do
      begin
        s:=GetLineToStr(s2,j,',');
        if s='' then break;
        inc(el);
        inc(tabs_elements);
        SetLength(tabs_var,tabs_elements);
        tabs_var[tabs_elements-1]:=s;
        tabs_name[tabs_count-1].count:=tabs_name[tabs_count-1].count+1;
        inc(j);
      end;
    end;
  end;
end;

function TBot.odczytaj_element_tablicy(aName: string; aIndex: integer): string;
var
  a,b,c: integer;
  i: integer;
begin
  a:=-1;
  {znajduję początek tej tablicy}
  for i:=0 to tabs_count-1 do if tabs_name[i].nazwa=aName then
  begin
    a:=i;
    break;
  end;
  if a=-1 then
  begin
    result:='';
    exit;
  end;
  {ustawiam się na indeks pierwszego elementu}
  b:=tabs_name[a].start;
  c:=tabs_name[a].count;
  if (aIndex<0) or (aIndex>c-1) then
  begin
    result:='';
    exit;
  end;
  {zwracam właściwy element tablicy}
  result:=tabs_var[b+aIndex];
end;

function TBot.GetScriptData(var aNumber: integer; var aWebRoom, aWebUser,
  aRoom, aUser, aMessage: string): boolean;
var
  b: boolean;
begin
  b:=me.Read;
  aNumber:=element.Number;
  aWebRoom:=element.WebRoom;
  aWebUser:=element.WebUser;
  aRoom:=element.Room;
  aUser:=element.User;
  aMessage:=element.Message;
  result:=b;
end;

function TBot._random(const min, max: integer): integer;
begin
  result:=random(max-min)+min;
end;

function TBot._pos(const aFragment, aText: string): integer;
begin
  result:=pos(aFragment,aText);
end;

procedure TBot._delete(var aText: string; const aStart, aCount: integer);
begin
  delete(aText,aStart,aCount);
end;

function TBot._StringReplace(const aText, aS1, aS2: string; const aTryb: integer): string;
begin
  case aTryb of
    0: result:=StringReplace(aText,aS1,aS2,[]);
    1: result:=StringReplace(aText,aS1,aS2,[rfIgnoreCase]);
    2: result:=StringReplace(aText,aS1,aS2,[rfReplaceAll]);
    3: result:=StringReplace(aText,aS1,aS2,[rfReplaceAll,rfIgnoreCase]);
    else result:=StringReplace(aText,aS1,aS2,[]);
  end;
end;

function TBot._DeleteHtml(const aText: string): string;
var
  s: string;
  i,a,b: integer;
begin
  s:=aText;
  while true do
  begin
    a:=pos('<',s);
    if a=0 then break;
    b:=length(s);
    for i:=a+1 to b do if s[i]='>' then
    begin
      delete(s,a,i-a+1);
      break;
    end;
  end;
  result:=s;
end;

function TBot._UpCase(const aText: string): string;
begin
  result:=AnsiUpperCase(aText);
end;

function TBot._DeleteCiapki(const aText: string): string;
const
  t_ciapki: array [1..18] of string = ('Ę','Ó','Ą','Ś','Ł','Ż','Ź','Ć','Ń','ę','ó','ą','ś','ł','ż','ź','ć','ń');
  t_b_apki: array [1..18] of string = ('E','O','A','S','L','Z','Z','C','N','e','o','a','s','l','z','z','c','n');
var
  s: string;
  i: integer;
begin
  s:=aText;
  for i:=1 to 18 do s:=StringReplace(s,t_ciapki[i],t_b_apki[i],[rfReplaceAll]);
  result:=s;
end;

function TBot._GetLineToStr(const aText: string; const aIndex: integer; const aSeparator: char): string;
begin
  result:=GetLineToStr(aText,aIndex,aSeparator);
end;

function TBot._DateTime(const aMask: string): string;
begin
  result:=FormatDateTime(aMask,time);
end;

function TBot._odczytaj_element_tablicy(const aName: string; const aIndex: integer): string;
begin
  result:=odczytaj_element_tablicy(aName,aIndex);
end;

function TBot._UsersCount: integer;
begin
  result:=_users.Count;
end;

function TBot._UsersGet(const aIndex: integer): string;
begin
  result:=_users[aIndex];
end;

constructor TBot.Create(aTestMode: boolean);
begin
  FTest:=aTestMode;
  if not FTest then
  begin
    SetConfDir('pbot');
    randomize;
    script_loaded:=false;
    _reload:=false;
    _exit:=false;
    MemSH:=TExtSharedMemory.Create(nil);
    MemSH.ApplicationKey:='343678273647236457438246374572';
    MemSH.OnSendMessage:=@MemSHSendMessage;
    MemSH.OnMessage:=@MemSHReceiveMessage;
    MemSH.OnServer:=@MemSHServer;
    MemSH.OnClient:=@MemSHClient;
    MemSH.Execute;
    ini:=TIniFile.Create(MyConfDir('config_bot.ini'));
    me:=TPointerTab.Create(nil);
    me.Rodzaj:=roKolejka;
    me.OnCreateElement:=@ListaCreateElement;
    me.OnDestroyElement:=@ListaDestroyElement;
    me.OnReadElement:=@ListaReadElement;
    me.OnWriteElement:=@ListaWriteElement;
    _users:=TStringList.Create;
  end;
  script:=TPSScript.Create(nil);
  script.OnCompile:=@ScriptCompile;
  script.UseDebugInfo:=false;
  if not FTest then
  begin
    get_login:=TNetSynHTTP.Create(nil);
    web:=TPolfan.Create(nil);
    web.OnBeforeConnect:=@webBeforeConnect;
    web.OnBeforeReadDocument:=@webBeforeReadDocument;
    web.OnReadDocument:=@webReadDocument;
    web.OnOpen:=@webOpen;
    web.OnClose:=@webClose;
    web.OnListUserInit:=@webListUserInit;
    web.OnListUserAdd:=@webListUserAdd;
    web.OnListUserDel:=@webListUserDel;
    web.OnListUserDeInit:=@webListUserDeInit;
    Init;
  end;
end;

destructor TBot.Destroy;
begin
  zeruj_tablice;
  if not FTest then
  begin
    DeInit;
    web.Free;
  end;
  script.Free;
  if not FTest then
  begin
    get_login.Free;
    _users.Free;
    me.Free;
    ini.Free;
    MemSH.Free;
  end;
  inherited Destroy;
end;

procedure TBot.Execute;
begin
  if _BOT_ROOM='' then exit;

  while czekaj do
  begin
    ProcessMessages;
    sleep(10);
  end;
  if _exit then exit;

  try
    while true do
    begin
      if script_loaded and (not web.Active) then
      begin
        if _exit then break;
        inc(_licznik);
        _laczenie:=true;
        if _licznik-_polaczono>3 then break;
        if _licznik>1 then sleep(10000);
        ConnectToChat;
        while _laczenie do begin ProcessMessages; sleep(10); end;
      end;
      ProcessMessages;
      sleep(10);
      if _exit then break;
      if _reload then
      begin
        _reload:=false;
        conf_load;
      end;
    end;
  finally
    if web.Active then DisconnectToChat;
  end;

end;

function TBot.TestCompilation(aScript: string): boolean;
begin
  result:=false;
  if aScript='' then exit;
  script.Script.Clear;
  script.Script.AddText(aScript);
  result:=script.Compile;
end;

end.

