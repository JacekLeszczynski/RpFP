unit bot;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, XMLPropStorage, Polfan;

type

  { FBot }

  { TBot }

  TBot = class
  private
    web: TPolfan;
    PropStorage: TXMLPropStorage;
    _laczenie,_exit: boolean;
    _licznik,_polaczono: integer;
    _error: integer;
    procedure Init;
    procedure DeInit;
    procedure PropStorageRestoreProperties(Sender: TObject);
    procedure PropStorageSaveProperties(Sender: TObject);
    procedure webReadDocument(Sender: TObject; AName: string;
      AMode: TPolfanRoomMode; AMessage: string; ADocument: TStrings;
      ARefresh: boolean);
    procedure webOpen(Sender: TObject);
    procedure webClose(Sender: TObject; aErr: integer; aErrorString: string);
  protected
  public
    constructor Create;
    destructor Destroy; override;
    procedure Execute;
  end;

implementation

uses
  config, ecode;

{ FBot }

procedure TBot.Init;
begin
  SetConfDir('radio_player_40_plus');
  _exit:=false;
  _licznik:=0;
  _polaczono:=0;
  _laczenie:=false;
  PropStorage.FileName:=MyConfDir('config.xml');
  PropStorage.Active:=true;
  PropStorage.Restore;
end;

procedure TBot.DeInit;
begin
  PropStorage.Active:=false;
end;

procedure TBot.PropStorageRestoreProperties(Sender: TObject);
begin
  _BOT_ROOM:=PropStorage.ReadString('BotRoom','');
  _BOT_USER:=PropStorage.ReadString('BotUser','Bot');
  _BOT_PASSW:=DecryptString(PropStorage.ReadString('BotPassw',''),POLFAN_TOKEN,true);
end;

procedure TBot.PropStorageSaveProperties(Sender: TObject);
begin

end;

procedure TBot.webReadDocument(Sender: TObject; AName: string;
  AMode: TPolfanRoomMode; AMessage: string; ADocument: TStrings;
  ARefresh: boolean);
begin
  writeln(AMessage);
end;

procedure TBot.webOpen(Sender: TObject);
begin
  inc(_polaczono);
  _laczenie:=false;
  _error:=0;
end;

procedure TBot.webClose(Sender: TObject; aErr: integer; aErrorString: string);
begin
  _laczenie:=false;
  if aErr=0 then writeln('*** Rozłączony ***') else
  begin
    dec(_polaczono);
    writeln('*** Error: ',aErrorString,' ***');
    _error:=aErr;
    if aErr=100 then _exit:=true;
  end;
end;

constructor TBot.Create;
begin
  PropStorage:=TXMLPropStorage.Create(nil);
  PropStorage.OnRestoreProperties:=@PropStorageRestoreProperties;
  PropStorage.OnSaveProperties:=@PropStorageSaveProperties;
  PropStorage.RootNodePath:='root';
  web:=TPolfan.Create(nil);
  web.OnReadDocument:=@webReadDocument;
  web.OnOpen:=@webOpen;
  web.OnClose:=@webClose;
  Init;
end;

destructor TBot.Destroy;
begin
  DeInit;
  web.Free;
  PropStorage.Free;
  inherited Destroy;
end;

procedure TBot.Execute;
var
  b: boolean;
begin
  if _BOT_ROOM='' then
  begin
    writeln('Niewypełniona nazwa pokoju, wychodzę.');
    exit;
  end;
  try
    writeln('BOT Hello :)');
    web.ProgName:='Bot';
    web.ProgVersion:='1.0';
    web.ImagesOFF:=true;
    web.Room:=_BOT_ROOM;
    web.User:=_BOT_USER;
    web.Password:=_BOT_PASSW;
    web.UserStatus:='';
    web.ImgAltVisible:=false;
    web.MaxLines:=50;
    web.FingerPrint:='';
    web.BaseDirectory:=MyDir;
    while true do
    begin
      if not web.Active then
      begin
        if _exit then break;
        inc(_licznik);
        _laczenie:=true;
        if _licznik-_polaczono>3 then
        begin
          writeln('Zbyt duża liczba niepoprawnych połączeń - wychodzę!');
          break;
        end;
        if _licznik>1 then
        begin
          writeln('ponawiam połączenie za 10 sekund...');
          sleep(10000);
        end;
        writeln('Łączę się z czatem (',_licznik,')...');
        web.Connect;
        while _laczenie do begin application.ProcessMessages; sleep(50); end;
      end;
      application.ProcessMessages;
      sleep(50);
    end;
  finally
    if web.Active then web.Disconnect;
  end;
end;

end.

