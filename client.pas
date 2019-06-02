unit client;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  ExtCtrls, XMLPropStorage, Menus, ExtMessage, ExtShutdown, NetSocket,
  lNetComponents, lNet, TplProgressBarUnit, ueled, Types;

type

  { TFClient }

  TFClient = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    led_conn: TuELED;
    led_crypt: TuELED;
    tcp: TNetSocket;
    shutdown: TExtShutdown;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    N1: TMenuItem;
    mess: TExtMessage;
    IpAddr: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    list1: TListBox;
    Panel1: TPanel;
    Panel2: TPanel;
    MenuPlayLista: TPopupMenu;
    PropStorage: TXMLPropStorage;
    SpeedButton1: TSpeedButton;
    stat_position: TplProgressBar;
    stat_volume: TplProgressBar;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure list1Click(Sender: TObject);
    procedure list1DblClick(Sender: TObject);
    procedure list1DrawItem(Control: TWinControl; Index: Integer; ARect: TRect;
      State: TOwnerDrawState);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure tcpConnect(aSocket: TLSocket);
    procedure tcpCryptString(var aText: string);
    procedure tcpDecryptString(var aText: string);
    procedure tcpError(const aMsg: string; aSocket: TLSocket);
    procedure tcpReceiveString(aMsg: string; aSocket: TLSocket);
    procedure PropStorageRestoreProperties(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure stat_positionMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure stat_volumeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tcpStatus(aActive, aCrypt: boolean);
  private
    cmd_shutdown: boolean;
    II: integer;
    procedure reconnect;
  public
    uid: string;
    function TcpSend(aRodzaj,aKod: integer; const aWartosc: string = ''): boolean;
    function TcpSend(aRodzaj,aKod: integer; const aWartosc: integer): boolean;
  end;

var
  FClient: TFClient;

implementation

uses
  ecode,config, NetOpenDialog;

{$R *.lfm}

{ TFClient }

procedure TFClient.FormCreate(Sender: TObject);
var
  s: TGUID;
begin
  cmd_shutdown:=false;
  SetConfDir('radio_player_40_plus');
  if not FileExists(MyConfDir('config.xml')) then position:=poScreenCenter;
  PropStorage.FileName:=MyConfDir('config.xml');
  PropStorage.Active:=true;
  II:=-1;
  CreateGUID(s);
  uid:=s.ToString(true);
end;

procedure TFClient.FormShow(Sender: TObject);
begin
  if IpAddr.Text='' then exit;
  if not tcp.Active then SpeedButton1.Click;
end;

procedure TFClient.list1Click(Sender: TObject);
begin
  TcpSend(1,101,list1.ItemIndex);
end;

procedure TFClient.list1DblClick(Sender: TObject);
begin
  TcpSend(1,116);
end;

procedure TFClient.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if tcp.Active then tcp.Disconnect;
//  if tcp.Connected then
//  begin
//    tcp.Disconnect;
//    sleep(250);
//  end;
  if cmd_shutdown then
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
    shutdown.execute;
  end;
end;

procedure TFClient.BitBtn3Click(Sender: TObject);
begin
  TcpSend(1,114);
end;

procedure TFClient.BitBtn1Click(Sender: TObject);
begin
  TcpSend(1,111);
end;

procedure TFClient.BitBtn2Click(Sender: TObject);
begin
  TcpSend(1,112);
end;

procedure TFClient.BitBtn4Click(Sender: TObject);
begin
  TcpSend(1,113);
end;

procedure TFClient.BitBtn5Click(Sender: TObject);
begin
  if mess.ShowConfirmationYesNo('Czy na pewno wysłać polecenie wyłączenia zdalnego komputera?') then TcpSend(1,999);
end;

procedure TFClient.BitBtn6Click(Sender: TObject);
begin
  TcpSend(1,117);
end;

procedure TFClient.BitBtn7Click(Sender: TObject);
begin
  TcpSend(1,121);
end;

procedure TFClient.BitBtn8Click(Sender: TObject);
begin
  TcpSend(1,120);
end;

procedure TFClient.BitBtn9Click(Sender: TObject);
begin
  TcpSend(1,118);
end;

procedure TFClient.list1DrawItem(Control: TWinControl; Index: Integer;
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
  list1.Canvas.Font.Bold:=Index=II;
  list1.Canvas.FillRect(ARect);
  list1.Canvas.TextRect(ARect,0,ARect.Top,list1.Items[Index]);
  //if Index=PlayerMultimedia.GetII then PlayerMultimedia.SetPlayIndex(Index);
end;

procedure TFClient.MenuItem1Click(Sender: TObject);
begin
  {Polecenie dodania nowych plików do listy}
  FNetOpenDialog:=TFNetOpenDialog.Create(self);
  try
    FNetOpenDialog.ShowModal;
    if FNetOpenDialog.out_ok then TcpSend(1,202,FNetOpenDialog.out_ramka);
  finally
    FNetOpenDialog.Free;
  end;
end;

procedure TFClient.MenuItem2Click(Sender: TObject);
begin
  if list1.ItemIndex=-1 then exit;
  TcpSend(1,204,list1.ItemIndex);
end;

procedure TFClient.MenuItem3Click(Sender: TObject);
begin
  if list1.Count=0 then exit;
  TcpSend(1,205);
end;

procedure TFClient.MenuItem4Click(Sender: TObject);
begin
  if list1.ItemIndex=-1 then exit;
  TcpSend(1,210);
end;

procedure TFClient.MenuItem5Click(Sender: TObject);
begin
  if list1.ItemIndex=-1 then exit;
  TcpSend(1,211);
end;

procedure TFClient.tcpConnect(aSocket: TLSocket);
begin
  TcpSend(2,101);
end;

procedure TFClient.tcpCryptString(var aText: string);
begin
  aText:=EncryptString(aText,'123');
end;

procedure TFClient.tcpDecryptString(var aText: string);
begin
  aText:=DecryptString(aText,'123');
end;

procedure TFClient.tcpError(const aMsg: string; aSocket: TLSocket);
begin
  inc(client_on_error_count);
end;

procedure TFClient.tcpReceiveString(aMsg: string; aSocket: TLSocket);
var
  pom: string;
  s,cto,adres,wartosc: string;
  rodzaj,kod,td,i,a: integer;
  b: boolean;
begin
  s:=aMsg;
  cto:=GetLineToStr(s,1,'$');
  if cto='CTO' then
  begin
    adres:=GetLineToStr(s,2,'$');
    if (adres='[ALL]') or (adres=uid) then
    begin
      rodzaj:=StrToInt(GetLineToStr(s,3,'$','0')); //1=SET, 2=GET
      if rodzaj=0 then exit;
      kod:=StrToInt(GetLineToStr(s,4,'$'));
      wartosc:=GetLineToStr(s,5,'$');
      //td:=StrToInt(LineToStr(s,6,'$','0'));
      {lecimy}
      if rodzaj=1 then
      begin
        {SET - dostaję informacje od serwera}
        if kod=101 then
        begin
          {dostałem listę plików}
          list1.Items.BeginUpdate;
          list1.Clear;
          (* czytam wiersze listy *)
          i:=1;
          while true do
          begin
            s:=GetLineToStr(wartosc,i,#9);
            if (s='[OK]') or (s='') then break;
            list1.Items.Add(s);
            inc(i);
          end;
          (* czytam indeksy listy *)
          inc(i);
          list1.ItemIndex:=StrToInt(GetLineToStr(wartosc,i,#9,'-1'));
          inc(i);
          II:=StrToInt(GetLineToStr(wartosc,i,#9,'-1'));
          list1.Items.EndUpdate;
        end else
        if kod=102 then
        begin
          II:=StrToInt(wartosc);
          list1.Refresh;
        end else
        if kod=103 then
        begin
          stat_position.Max:=StrToInt(GetLineToStr(wartosc,2,#9,'100'));
          stat_position.Position:=StrToInt(GetLineToStr(wartosc,1,#9,'0'));
          Label2.Caption:=GetLineToStr(wartosc,3,#9,'-:--');
          Label3.Caption:=GetLineToStr(wartosc,4,#9,'-:--');
        end else
        if kod=104 then
        begin
          stat_position.Max:=100;
          stat_position.Position:=0;
          Label2.Caption:='-:--';
          Label3.Caption:='-:--';
        end else
        if kod=105 then
        begin
          if wartosc='1' then b:=true else b:=false;
          BitBtn6.Enabled:=b;
          BitBtn1.Enabled:=not b;
        end else
        if kod=106 then stat_volume.Position:=StrToInt(wartosc) else
        if (kod=200) and net_open_dialog_active then FNetOpenDialog.Init(GetLineToStr(wartosc,1,#9),GetLineToStr(wartosc,2,#9),GetLineToStr(wartosc,3,#9)) else
        if (kod=201) and net_open_dialog_active then FNetOpenDialog.wczytaj(wartosc) else
        if kod=202 then
        begin
          {dodano nowe pliki do playlisty}
          list1.Items.BeginUpdate;
          i:=1;
          while true do
          begin
            s:=GetLineToStr(wartosc,i,#9);
            if s='' then break;
            list1.Items.Add(s);
            inc(i);
          end;
          list1.Items.EndUpdate;
        end else
        if kod=203 then
        begin
          {wstaw nową pozycję we właściwe miejsce}
          a:=StrToInt(GetLineToStr(wartosc,1,#9,'-1'));
          if a>-1 then
          begin
            s:=GetLineToStr(wartosc,2,#9,'-1');
            list1.Items.Insert(a,s);
          end;
        end else
        if kod=204 then list1.Items.Delete(StrToInt(wartosc)) else {usunięto plik z playlisty}
        if kod=205 then list1.Clear else {usunięto całą playlistę!}
        if kod=999 then cmd_shutdown:=true else
        if kod=1000 then
        begin
          tcp.Disconnect;
          //tcp.Disconnect(true);
          close;
        end;
      end;
    end;
  end;
end;

procedure TFClient.PropStorageRestoreProperties(Sender: TObject);
begin
  {$IFDEF UNIX}
  _SHUTDOWN_MODE:=PropStorage.ReadInteger('ShutdownMode',1);
  {$ENDIF}
  {$IFDEF WINDOWS}
  _SHUTDOWN_MODE:=PropStorage.ReadInteger('ShutdownMode',4);
  {$ENDIF}
  _SHUTDOWN_CMD:=PropStorage.ReadString('ShutdownCMD','');
end;

procedure TFClient.SpeedButton1Click(Sender: TObject);
begin
  reconnect;
end;

procedure TFClient.stat_positionMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  TcpSend(1,150,IntToStr(X)+#9+IntToStr(stat_position.Width));
end;

procedure TFClient.stat_volumeMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  at: integer;
begin
  at:=round(270*Y/stat_volume.Height)*-1+270;
  TcpSend(1,106,at);
end;

procedure TFClient.tcpStatus(aActive, aCrypt: boolean);
begin
  led_conn.Active:=aActive;
  led_crypt.Active:=aCrypt;
  client_on:=aActive;
end;

procedure TFClient.reconnect;
begin
  if tcp.Active then tcp.Disconnect(true);
  tcp.Host:=IpAddr.Text;
  tcp.Connect;
end;

function TFClient.TcpSend(aRodzaj, aKod: integer; const aWartosc: string
  ): boolean;
var
  n: integer;
  s: string;
begin
  result:=false;
  if tcp.Active then
  begin
    s:='CTO$'+uid+'$'+IntToStr(aRodzaj)+'$'+IntToStr(aKod)+'$'+aWartosc;
    tcp.SendString(s);
    result:=true;
  end;
end;

function TFClient.TcpSend(aRodzaj, aKod: integer; const aWartosc: integer
  ): boolean;
begin
  result:=TcpSend(aRodzaj,aKod,IntToStr(aWartosc));
end;

end.

