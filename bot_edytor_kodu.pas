unit bot_edytor_kodu;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, ExtMessage,
  SynEdit, SynHighlighterPas;

type

  { TFBotEdytorKodu }

  TFBotEdytorKodu = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    mess: TExtMessage;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    SynEdit1: TSynEdit;
    SynPasSyn1: TSynPasSyn;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  public
    out_ok: boolean;
  end;

var
  FBotEdytorKodu: TFBotEdytorKodu;

implementation

uses
  LCLType, bot, bot_code_help;

{$R *.lfm}

{ TFBotEdytorKodu }

procedure TFBotEdytorKodu.BitBtn2Click(Sender: TObject);
begin
  out_ok:=true;
  close;
end;

procedure TFBotEdytorKodu.BitBtn3Click(Sender: TObject);
var
  q: TBot;
  b: boolean;
begin
  q:=TBot.Create(true);
  try
    b:=q.TestCompilation(SynEdit1.Lines.Text);
  finally
    q.Free;
  end;
  if b then mess.ShowInformation('Kompilacja udana.') else mess.ShowWarning('Wystąpiły błędy podczas kompilacji!');
end;

procedure TFBotEdytorKodu.BitBtn4Click(Sender: TObject);
begin
  FPomocKodera:=TFPomocKodera.Create(self);
  FPomocKodera.Show;
end;

procedure TFBotEdytorKodu.BitBtn5Click(Sender: TObject);
begin
  if OpenDialog1.Execute then SynEdit1.Lines.LoadFromFile(OpenDialog1.FileName);
end;

procedure TFBotEdytorKodu.BitBtn6Click(Sender: TObject);
begin
  if SaveDialog1.Execute then SynEdit1.Lines.SaveToFile(SaveDialog1.FileName);
end;

procedure TFBotEdytorKodu.BitBtn7Click(Sender: TObject);
var
  res: TResourceStream;
begin
  if mess.ShowConfirmationYesNo('Czy wypełnić kod przykładową zawartością?^^Poprzednia zawartość kodu zostanie całkowicie nadpisana!') then
  begin
    try
      res:=TResourceStream.Create(hInstance,'EXAMPLE_CODE',RT_RCDATA);
      SynEdit1.Lines.LoadFromStream(res);
    finally
      res.Free;
    end;
  end;
end;

procedure TFBotEdytorKodu.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction:=caFree;
end;

procedure TFBotEdytorKodu.BitBtn1Click(Sender: TObject);
begin
  close;
end;

procedure TFBotEdytorKodu.FormCreate(Sender: TObject);
begin
  out_ok:=false;
end;

end.

