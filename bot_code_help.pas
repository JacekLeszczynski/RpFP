unit bot_code_help;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Grids, Buttons,
  XMLPropStorage, StdCtrls;

type

  { TFPomocKodera }

  TFPomocKodera = class(TForm)
    BitBtn1: TBitBtn;
    Label1: TLabel;
    PropStorage: TXMLPropStorage;
    StringGrid1: TStringGrid;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  FPomocKodera: TFPomocKodera;

implementation

uses
  ecode;

{$R *.lfm}

{ TFPomocKodera }

procedure TFPomocKodera.BitBtn1Click(Sender: TObject);
begin
  close;
end;

procedure TFPomocKodera.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  CloseAction:=caFree;
end;

procedure TFPomocKodera.FormCreate(Sender: TObject);
begin
  PropStorage.FileName:=MyConfDir('config.xml');
  PropStorage.Active:=true;
end;

end.

