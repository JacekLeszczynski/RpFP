unit consola;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  XMLPropStorage, Menus;

type

  { TFConsola }

  TFConsola = class(TForm)
    Memo1: TMemo;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    N1: TMenuItem;
    PopupMenu1: TPopupMenu;
    PropStorage: TXMLPropStorage;
    SaveDialog1: TSaveDialog;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
  private
  public
    NoClose: boolean;
    procedure Info;
    procedure Clear;
    procedure Add(AText: string);
  end;

var
  FConsola: TFConsola;

implementation

uses
  config, ecode;

{$R *.lfm}

{ TFConsola }

procedure TFConsola.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if NoClose then
  begin
    CloseAction:=caNone;
    exit;
  end;
  Memo1.Clear;
end;

procedure TFConsola.FormCreate(Sender: TObject);
begin
  PropStorage.FileName:=MyConfDir('config.xml');
  PropStorage.Active:=true;
end;

procedure TFConsola.MenuItem1Click(Sender: TObject);
begin
  if SaveDialog1.Execute then Memo1.Lines.SaveToFile(SaveDialog1.FileName);
end;

procedure TFConsola.MenuItem2Click(Sender: TObject);
begin
  Clear;
end;

procedure TFConsola.Info;
begin
  NoClose:=true;
  Clear;
end;

procedure TFConsola.Clear;
begin
  Memo1.Clear;
  Add('---------------------------------');
  Add('Konsola Radio Mplayer Forty Plus:');
  Add('---------------------------------');
end;

procedure TFConsola.Add(AText: string);
begin
  Memo1.Append(AText);
  Memo1.SelStart:=length(Memo1.Text);
end;

end.

