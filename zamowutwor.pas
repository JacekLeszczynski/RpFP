unit zamowutwor;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  XMLPropStorage, NetSynHTTP, ExtMessage;

type

  { TFZamowUtwor }

  TFZamowUtwor = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    html: TNetSynHTTP;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    mess: TExtMessage;
    od_kogo: TEdit;
    dla_kogo: TEdit;
    PropStorage: TXMLPropStorage;
    wykonawca: TEdit;
    tytul: TEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure wykonawcaChange(Sender: TObject);
  private

  public

  end;

var
  FZamowUtwor: TFZamowUtwor;

implementation

uses
  ecode, config;

{$R *.lfm}

{ TFZamowUtwor }

procedure TFZamowUtwor.BitBtn1Click(Sender: TObject);
begin
  close;
end;

procedure TFZamowUtwor.BitBtn2Click(Sender: TObject);
var
  ss: TStringList;
  s: string;
  err,a: integer;
begin
  ss:=TStringList.Create;
  try
    html.UrlData:='wykonawca='+wykonawca.Text+'&tytul='+tytul.Text+'&od='+od_kogo.Text+'&dla='+dla_kogo.Text+'&utwor=Zam%C3%B3w+utw%C3%B3r';
    err:=html.execute_get_post('https://radiofortyplus.panelradiowy.pl/embed.php?script=utwor',ss);
    s:=ss.Text;
    a:=pos('<b>Zamawianie utworów wyłączone!</b>',s);
    if a>0 then
    begin
      mess.ShowInformation(RS_INFO_11+'^^'+RS_INFO_12);
      exit;
    end;
  finally
    ss.Free;
  end;
  close;
end;

procedure TFZamowUtwor.FormCreate(Sender: TObject);
begin
  PropStorage.FileName:=MyConfDir('config.xml');
  PropStorage.Active:=true;
end;

procedure TFZamowUtwor.wykonawcaChange(Sender: TObject);
begin
  BitBtn2.Enabled:=(wykonawca.Text<>'') and (tytul.Text<>'') and (od_kogo.Text<>'') and (dla_kogo.Text<>'');
end;

end.

