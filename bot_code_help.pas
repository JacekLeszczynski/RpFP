unit bot_code_help;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Grids, Buttons;

type

  { TFPomocKodera }

  TFPomocKodera = class(TForm)
    BitBtn1: TBitBtn;
    StringGrid1: TStringGrid;
    procedure BitBtn1Click(Sender: TObject);
  private

  public

  end;

var
  FPomocKodera: TFPomocKodera;

implementation

{$R *.lfm}

{ TFPomocKodera }

procedure TFPomocKodera.BitBtn1Click(Sender: TObject);
begin
  close;
end;

end.

