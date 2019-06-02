unit fileconf;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons;

type

  { TFFileConf }

  TFFileConf = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    CheckBox1: TCheckBox;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    vs_changes,vs_nosubtitle: boolean;
    vs_audio,vs_subtitle: string;
    vs_iso,vs_ffactor,vs_subpos,vs_subscale: integer;
  public
    procedure Init(aAudio: string = ''; aSubtitle: string = ''; aISO: integer = 0; aFFactor: integer = 0; aNoSubtitle: boolean = false; aSubPos: integer = 0; aSubScale: integer = 0);
    function GetData(var aAdio, aSubtitle: string; var aISO, aFFactor, aSubPos, aSubScale: integer; var aNoSubtitle: boolean): boolean;
  end;

var
  FFileConf: TFFileConf;

implementation

{$R *.lfm}

{ TFFileConf }

procedure TFFileConf.BitBtn1Click(Sender: TObject);
begin
  vs_changes:=false;
  close;
end;

procedure TFFileConf.BitBtn2Click(Sender: TObject);
begin
  vs_changes:=true;
  vs_audio:=trim(Edit1.Text);
  vs_subtitle:=trim(Edit2.Text);
  vs_iso:=ComboBox1.ItemIndex;
  vs_nosubtitle:=CheckBox1.Checked;
  vs_ffactor:=ComboBox2.ItemIndex;
  vs_subpos:=ComboBox3.ItemIndex;
  vs_subscale:=ComboBox4.ItemIndex;
  close;
end;

procedure TFFileConf.Init(aAudio: string; aSubtitle: string; aISO: integer;
  aFFactor: integer; aNoSubtitle: boolean; aSubPos: integer; aSubScale: integer
  );
begin
  vs_changes:=false;
  vs_audio:=aAudio;
  vs_subtitle:=aSubtitle;
  vs_iso:=aISO;
  vs_ffactor:=aFFactor;
  vs_nosubtitle:=aNoSubtitle;
  vs_subpos:=aSubPos;
  vs_subscale:=aSubScale;
  Edit1.Text:=vs_audio;
  Edit2.Text:=vs_subtitle;
  ComboBox1.ItemIndex:=vs_iso;
  ComboBox2.ItemIndex:=vs_ffactor;
  CheckBox1.Checked:=vs_nosubtitle;
  ComboBox3.ItemIndex:=vs_subpos;
  ComboBox4.ItemIndex:=vs_subscale;
end;

function TFFileConf.GetData(var aAdio, aSubtitle: string; var aISO, aFFactor,
  aSubPos, aSubScale: integer; var aNoSubtitle: boolean): boolean;
begin
  aAdio:=vs_audio;
  aSubtitle:=vs_subtitle;
  aISO:=vs_iso;
  aFFactor:=vs_ffactor;
  aNoSubtitle:=vs_nosubtitle;
  aSubPos:=vs_subpos;
  aSubScale:=vs_subscale;
  result:=vs_changes;
end;

end.

