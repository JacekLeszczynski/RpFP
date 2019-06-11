unit bot_edytor_kodu;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, process, Forms, Controls, Graphics, Dialogs, Buttons,
  XMLPropStorage, Menus, StdCtrls, ExtMessage, SynEdit, SynHighlighterPas;

type

  { TFBotEdytorKodu }

  TFBotEdytorKodu = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    CheckBox1: TCheckBox;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    N1: TMenuItem;
    mess: TExtMessage;
    OpenDialog1: TOpenDialog;
    PopupMenu1: TPopupMenu;
    proc: TProcess;
    PropStorage: TXMLPropStorage;
    SaveDialog1: TSaveDialog;
    SynEdit1: TSynEdit;
    SynPasSyn1: TSynPasSyn;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
  private
    procedure conf_load;
    procedure conf_save;
  public
    out_ok: boolean;
  end;

var
  FBotEdytorKodu: TFBotEdytorKodu;

implementation

uses
  LCLType, ecode, bot, bot_code_help;

{$R *.lfm}

{ TFBotEdytorKodu }

procedure TFBotEdytorKodu.BitBtn2Click(Sender: TObject);
begin
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

procedure TFBotEdytorKodu.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction:=caFree;
end;

procedure TFBotEdytorKodu.BitBtn1Click(Sender: TObject);
begin
  conf_save;
  if CheckBox1.Checked then
  begin
    {$IFDEF WINDOWS}
    proc.Executable:=MyDir('radio-player-bot.exe');
    {$ELSE}
    proc.Executable:=MyDir('radio-player-bot');
    {$ENDIF}
    proc.Parameters.Clear;
    proc.Parameters.Add('reload');
    proc.Execute;
  end else begin
    out_ok:=true;
    close;
  end;
end;

procedure TFBotEdytorKodu.FormCreate(Sender: TObject);
begin
  PropStorage.FileName:=MyConfDir('config.xml');
  PropStorage.Active:=true;
  out_ok:=false;
  conf_load;
end;

procedure TFBotEdytorKodu.MenuItem1Click(Sender: TObject);
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

procedure TFBotEdytorKodu.MenuItem2Click(Sender: TObject);
begin
  if OpenDialog1.Execute then SynEdit1.Lines.LoadFromFile(OpenDialog1.FileName);
end;

procedure TFBotEdytorKodu.MenuItem3Click(Sender: TObject);
begin
  if SaveDialog1.Execute then SynEdit1.Lines.SaveToFile(SaveDialog1.FileName);
end;

procedure TFBotEdytorKodu.conf_load;
begin
  if FileExists(MyConfDir('config_bot.script')) then
    SynEdit1.Lines.LoadFromFile(MyConfDir('config_bot.script'));
end;

procedure TFBotEdytorKodu.conf_save;
begin
  SynEdit1.Lines.SaveToFile(MyConfDir('config_bot.script'));
end;

end.

