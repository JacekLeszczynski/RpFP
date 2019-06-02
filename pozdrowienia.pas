unit pozdrowienia;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  XMLPropStorage, ExtCtrls, NetSynHTTP, ExtMessage;

type

  { TFPozdrowienia }

  TFPozdrowienia = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    mess: TExtMessage;
    nadawca: TEdit;
    html: TNetSynHTTP;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    tresc: TMemo;
    PropStorage: TXMLPropStorage;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure nadawcaChange(Sender: TObject);
    procedure trescChange(Sender: TObject);
  private

  public

  end;

var
  FPozdrowienia: TFPozdrowienia;

implementation

uses
  ecode, config;

{$R *.lfm}

{ TFPozdrowienia }

procedure TFPozdrowienia.trescChange(Sender: TObject);
begin
  Label3.Caption:='Liczba znaków: '+IntToStr(200-Length(tresc.Lines.Text));
  BitBtn2.Enabled:=(nadawca.Text<>'') and (tresc.Lines.Text<>'');
end;

procedure TFPozdrowienia.FormCreate(Sender: TObject);
begin
  PropStorage.FileName:=MyConfDir('config.xml');
  PropStorage.Active:=true;
end;

procedure TFPozdrowienia.nadawcaChange(Sender: TObject);
begin
  BitBtn2.Enabled:=(nadawca.Text<>'') and (tresc.Lines.Text<>'');
end;

procedure TFPozdrowienia.BitBtn1Click(Sender: TObject);
begin
  close;
end;

procedure TFPozdrowienia.BitBtn2Click(Sender: TObject);
var
  ss: TStringList;
  s: string;
  err,a: integer;
begin
  ss:=TStringList.Create;
  try
    html.UrlData:='tresc='+tresc.Lines.Text+'&countdown='+IntToStr(200-length(tresc.Lines.Text))+'&nadawca='+nadawca.Caption+'&coile=30&pozdrowienia=Wy%C5%9Blij+pozdrowienia';
    err:=html.execute_get_post('https://radiofortyplus.panelradiowy.pl/embed.php?script=pozdrowienia',ss);
    a:=pos('<b>Wysyłanie pozdrowień wyłączone!</b>',s);
    if a>0 then
    begin
      mess.ShowInformation(RS_INFO_9+'^^'+RS_INFO_10);
      exit;
    end;
  finally
    ss.Free;
  end;
  close;
end;

end.

