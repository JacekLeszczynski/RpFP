unit dumpsrc;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, XMLPropStorage;

type

  { TFDumpSrc }

  TFDumpSrc = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ZawijajWiersze: TCheckBox;
    Memo1: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    PropStorage: TXMLPropStorage;
    SaveDialog1: TSaveDialog;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure ZawijajWierszeChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  FDumpSrc: TFDumpSrc;

implementation

uses
  ecode;

{$R *.lfm}

{ TFDumpSrc }

procedure TFDumpSrc.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction:=caFree;
end;

procedure TFDumpSrc.FormCreate(Sender: TObject);
begin
  PropStorage.FileName:=MyConfDir('config.xml');
  PropStorage.Active:=true;
end;

procedure TFDumpSrc.BitBtn2Click(Sender: TObject);
begin
  close;
end;

procedure TFDumpSrc.ZawijajWierszeChange(Sender: TObject);
begin
  Memo1.WordWrap:=ZawijajWiersze.Checked;
end;

procedure TFDumpSrc.BitBtn1Click(Sender: TObject);
begin
  if SaveDialog1.Execute then Memo1.Lines.SaveToFile(SaveDialog1.FileName);
end;

end.

