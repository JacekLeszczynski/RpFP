unit NetOpenDialog;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  ExtCtrls, Grids, Buttons, DirectoryPack;

type

  { TFNetOpenDialog }

  TFNetOpenDialog = class(TForm)
    anuluj: TBitBtn;
    dir: TDirectoryPack;
    otworz: TBitBtn;
    filter: TComboBox;
    sciezka: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    foldery: TListBox;
    Panel1: TPanel;
    Panel2: TPanel;
    pliki: TStringGrid;
    TabControl: TTabControl;
    procedure anulujClick(Sender: TObject);
    procedure dirExecute(Sender: TObject; AFolders, AFiles: TStringList;
      ASignature: string);
    procedure folderyDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure otworzClick(Sender: TObject);
    procedure plikiDblClick(Sender: TObject);
    procedure TabControlChange(Sender: TObject);
  private
    BLOKUJ_ZMIANY: boolean;
    fkatalog: string;
    __F: string;
    procedure setkatalog(AValue: string);
  public
    out_ok: boolean;
    out_ramka: string;
    procedure Init(aKatalog,aSeparator,aDrives: string);
    procedure SetSeparator(aSeparator: string);
    procedure wczytaj(aPackRecord: string);
  published
    property katalog: string read fkatalog write setkatalog;
  end;

var
  FNetOpenDialog: TFNetOpenDialog;

implementation

uses
  client, config, ecode;

{$R *.lfm}

{ TFNetOpenDialog }

procedure TFNetOpenDialog.FormCreate(Sender: TObject);
begin
  BLOKUJ_ZMIANY:=false;
  out_ok:=false;
  net_open_dialog_active:=true;
  FClient.TcpSend(2,200);
end;

procedure TFNetOpenDialog.dirExecute(Sender: TObject; AFolders,
  AFiles: TStringList; ASignature: string);
var
  i: integer;
begin
  foldery.Items.Assign(AFolders);
  pliki.BeginUpdate;
  pliki.RowCount:=1;
  for i:=0 to AFiles.Count-1 do
  begin
    pliki.RowCount:=pliki.RowCount+1;
    //pliki.Cols[0].Assign(AFiles);
    pliki.Cells[0,i+1]:=AFiles[i];
  end;
  pliki.EndUpdate;
end;

procedure TFNetOpenDialog.anulujClick(Sender: TObject);
begin
  close;
end;

procedure TFNetOpenDialog.folderyDblClick(Sender: TObject);
var
  s: string;
begin
  BLOKUJ_ZMIANY:=true;
  s:=foldery.Items[foldery.ItemIndex];
  if s='..' then
  begin
    {cofam się o jeden folder wstecz}
    if katalog='/' then exit;
    katalog:=ExtractFileDir(katalog);
  end else begin
    {wchodzę do wybranego folderu}
    if katalog='/' then katalog:='/'+s else katalog:=katalog+__F+s;
  end;
  sciezka.Text:=katalog;
  FClient.TcpSend(2,201,katalog+#9+'*.*');
  BLOKUJ_ZMIANY:=false;
end;

procedure TFNetOpenDialog.FormDestroy(Sender: TObject);
begin
  net_open_dialog_active:=false;
end;

procedure TFNetOpenDialog.otworzClick(Sender: TObject);
var
  s: string;
  i,l: integer;
begin
  s:='';
  l:=0;
  for i:=1 to pliki.RowCount do if pliki.IsCellSelected[0,i] then
  begin
    inc(l);
    s:=s+katalog+__F+pliki.Cells[0,i]+#9;
  end;
  if l>0 then
  begin
    out_ramka:=s;
    out_ok:=true;
  end;
  close;
end;

procedure TFNetOpenDialog.plikiDblClick(Sender: TObject);
begin
  otworz.Click;
end;

procedure TFNetOpenDialog.TabControlChange(Sender: TObject);
var
  i: integer;
  s: string;
begin
  if BLOKUJ_ZMIANY then exit;
  s:='';
  if __F='/' then
  begin
    for i:=1 to TabControl.TabIndex do s:=s+__F+TabControl.Tabs[i];
  end else begin
    for i:=0 to TabControl.TabIndex do if s='' then s:=TabControl.Tabs[i] else s:=s+__F+TabControl.Tabs[i];
  end;
  fkatalog:=s;
  sciezka.Text:=fkatalog;
  FClient.TcpSend(2,201,fkatalog+#9+'*.*');
end;

procedure TFNetOpenDialog.setkatalog(AValue: string);
var
  s: string;
  l,i: integer;
begin
  if fkatalog=AValue then Exit;
  fkatalog:=AValue;
  l:=length(fkatalog);
  if (fkatalog[l]=__F) and (l>0) then delete(fkatalog,l,1);
  TabControl.Tabs.Clear;
  if fkatalog[1]='/' then
  begin
    TabControl.Tabs.Add('/');
    i:=2;
  end else begin
    {windowsy}
    i:=1;
  end;
  while true do
  begin
    s:=GetLineToStr(fkatalog,i,__F[1]);
    if s='' then break;
    TabControl.Tabs.Add(s);
    inc(i);
  end;
  TabControl.TabIndex:=TabControl.Tabs.Count-1;
end;

procedure TFNetOpenDialog.Init(aKatalog, aSeparator, aDrives: string);
begin
  BLOKUJ_ZMIANY:=true;
  __F:=aSeparator;
  katalog:=aKatalog;
  sciezka.Text:=katalog;
  FClient.TcpSend(2,201,katalog+#9+'*.*');
  BLOKUJ_ZMIANY:=false;
end;

procedure TFNetOpenDialog.SetSeparator(aSeparator: string);
begin
  __F:=aSeparator;
end;

procedure TFNetOpenDialog.wczytaj(aPackRecord: string);
begin
  dir.SetSeparator(__F[1]);
  dir.Execute(aPackRecord);
end;

end.

