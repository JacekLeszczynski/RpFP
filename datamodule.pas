unit datamodule;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDataset, ZSqlProcessor,
  ZTransaction, NetSynHTTP, db;

type

  { Tdm }

  Tdm = class(TDataModule)
    db_create_disk: TZSQLProcessor;
    db_insert_var: TZQuery;
    db_count_var: TZQuery;
    db_stacje: TZQuery;
    db_update_var: TZQuery;
    db_delete_var: TZQuery;
    http: TNetSynHTTP;
    m_emotkiid: TLongintField;
    m_emotkikategoria: TLongintField;
    m_emotkinazwa: TStringField;
    m_emotkiplik: TStringField;
    m_emotkiseks: TBooleanField;
    conn: TZConnection;
    m_emotki: TZQuery;
    m_kategorieid: TLongintField;
    m_kategorienazwa: TStringField;
    trans: TZTransaction;
    db_read_var: TZQuery;
    conn_mem: TZConnection;
    trans_mem: TZTransaction;
    m_kategorie: TZQuery;
    m_create: TZSQLProcessor;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure _OPEN_CLOSE(DataSet: TDataSet);
  private
    procedure refresh_db_emotki;
  public
    function GetZmienna(zmienna: string): string;
    procedure SetZmienna(zmienna,wartosc: string);
    procedure DeleteZmienna(zmienna: string);
  end;

var
  dm: Tdm;
  StartingPoint : TPoint;

implementation

uses
  ecode, config, math, LResources, LCLType, fpjson;

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

{ Tdm }

procedure Tdm.DataModuleCreate(Sender: TObject);
var
  s: string;
  b: boolean;
begin
  conn_mem.Connect;
  m_create.Execute;
  refresh_db_emotki;
  s:=MyConfDir('db.sqlite');
  b:=FileExists(s);
  conn.Database:=s;
  conn.Connect;
  if not b then db_create_disk.Execute;
end;

procedure Tdm.DataModuleDestroy(Sender: TObject);
begin
  conn_mem.Disconnect;
  conn.Disconnect;
end;

procedure Tdm._OPEN_CLOSE(DataSet: TDataSet);
begin
  m_emotki.Active:=DataSet.Active;
end;

procedure Tdm.refresh_db_emotki;
var
  jData: TJSONData;
  jObject: TJSONObject;
  jArray: TJSONArray;
  i,nr,id,seks: integer;
  s,nazwa,plik: string;
begin
  http.execute('https://polfan.pl/emoticons/option/applet-json',s);
  jData:=GetJSON(s);
  jObject:=TJSONObject(jData);

  m_kategorie.Open;
  trans_mem.StartTransaction;

  jArray:=jObject.Arrays['categories'];
  for i:=0 to jArray.Count-1 do
  begin
    nr:=jArray[i].Items[0].AsInteger;
    nazwa:=jArray[i].Items[1].AsString;
    m_kategorie.Append;
    m_kategorie.FieldByName('nr').AsInteger:=nr;
    m_kategorie.FieldByName('nazwa').AsString:=nazwa;
    m_kategorie.Post;
  end;

  jArray:=jObject.Arrays['emoticons'];
  for i:=0 to jArray.Count-1 do
  begin
    nazwa:=jArray[i].Items[0].AsString;
    plik:=StringReplace(jArray[i].Items[1].AsString,'https://polfan.pl/','',[]);
    nr:=jArray[i].Items[2].AsInteger;
    seks:=jArray[i].Items[3].AsInteger;
    m_emotki.Append;
    m_emotki.FieldByName('nazwa').AsString:=nazwa;
    m_emotki.FieldByName('plik').AsString:=plik;
    m_emotki.FieldByName('kategoria').AsInteger:=nr;
    m_emotki.FieldByName('seks').AsInteger:=seks;
    m_emotki.Post;
  end;

  trans_mem.Commit;
  m_kategorie.Close;
end;

function Tdm.GetZmienna(zmienna: string): string;
begin
  db_read_var.ParamByName('zmienna').AsString:=zmienna;
  db_read_var.Open;
  if db_read_var.RecordCount=0 then result:='' else result:=db_read_var.FieldByName('wartosc').AsString;
  db_read_var.Close;
end;

procedure Tdm.SetZmienna(zmienna, wartosc: string);
var
  s: string;
  b_insert,b_update: boolean;
begin
  db_read_var.ParamByName('zmienna').AsString:=zmienna;
  db_read_var.Open;
  b_insert:=db_read_var.RecordCount=0;
  b_update:=not b_insert;
  if b_update then s:=db_read_var.FieldByName('wartosc').AsString;
  db_read_var.Close;
  if b_update and (s=wartosc) then exit;
  if b_insert then
  begin
    db_insert_var.ParamByName('zmienna').AsString:=zmienna;
    db_insert_var.ParamByName('wartosc').AsString:=wartosc;
    db_insert_var.ExecSQL;
  end else begin
    db_update_var.ParamByName('zmienna').AsString:=zmienna;
    db_update_var.ParamByName('wartosc').AsString:=wartosc;
    db_update_var.ExecSQL;
  end;
end;

procedure Tdm.DeleteZmienna(zmienna: string);
begin
  db_delete_var.ParamByName('zmienna').AsString:=zmienna;
  db_delete_var.ExecSQL;
end;

end.

