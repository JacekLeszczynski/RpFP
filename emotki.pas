unit emotki;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, NetSynHTTP, ExtMessage;

type

  { TFEmotki }

  TFEmotki = class(TForm)
    BitBtn1: TBitBtn;
    mess: TExtMessage;
    Label1: TLabel;
    http: TNetSynHTTP;
    Panel1: TPanel;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private
  public

  end;

var
  FEmotki: TFEmotki;

implementation

uses
  config, ecode, chat, fpjson, jsonparser;

type
  TKategoria = record
    id: integer;
    nazwa: string;
  end;
  TEmotka = record
    alt,source: string;
    id_kategorii: integer;
    seks: integer;
  end;

{$R *.lfm}

{ TFEmotki }

procedure TFEmotki.BitBtn1Click(Sender: TObject);
var
  str: TStringList;
  jData: TJSONData;
  jObject: TJSONObject;
  jArray: TJSONArray;
  i: integer;
  kategorie: array of TKategoria;
  emotki: array of TEmotka;
begin
  str:=TStringList.Create;
  try
    http.execute('https://polfan.pl/emoticons/option/applet-json',str);
    str.SaveToFile(MyConfDir('emotki.json'));
    jData:=GetJSON(str.Text);
    jObject:=TJSONObject(jData);

    jArray:=jObject.Arrays['categories'];
    SetLength(kategorie,jArray.Count);
    for i:=0 to jArray.Count-1 do
    begin
      kategorie[i].id:=jArray[i].Items[0].AsInteger;
      kategorie[i].nazwa:=jArray[i].Items[1].AsString;
    end;

    jArray:=jObject.Arrays['emoticons'];
    SetLength(emotki,jArray.Count);
    for i:=0 to jArray.Count-1 do
    begin
      emotki[i].alt:=jArray[i].Items[0].AsString;
      emotki[i].source:=StringReplace(jArray[i].Items[1].AsString,'http://polfan.pl/','',[]);
      emotki[i].id_kategorii:=jArray[i].Items[2].AsInteger;
      emotki[i].seks:=jArray[i].Items[3].AsInteger;
      lista_download.Add(emotki[i].source);
    end;
    SetLength(kategorie,0);
    SetLength(emotki,0);
    //FChat.StartDownload;
    mess.ShowInformation('Baza obrazków została zapisana/zaktualizowana.^^Ściąganie obrazków rozpoczęło się.');
  finally
    jData.Free;
    str.Free;
  end;
end;

procedure TFEmotki.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction:=caFree;
end;

end.

