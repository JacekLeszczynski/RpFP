unit chat_pomoc;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  FXMaterialButton;

type

  { TFChatPomoc }

  TFChatPomoc = class(TForm)
    FXMaterialButton1: TFXMaterialButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FXMaterialButton1Click(Sender: TObject);
  private

  public

  end;

var
  FChatPomoc: TFChatPomoc;

implementation

{$R *.lfm}

{ TFChatPomoc }

procedure TFChatPomoc.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction:=caFree;
end;

procedure TFChatPomoc.FXMaterialButton1Click(Sender: TObject);
begin
  close;
end;

end.

