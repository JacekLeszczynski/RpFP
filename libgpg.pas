unit LibGPG;

{$mode delphi}{$H+}

interface

uses
  Classes, SysUtils;

function ListKeys: string;

implementation

uses
  config,
  //gpgme,
  gpgme_h;

const
  {$IFDEF LINUX}
  SO = '/usr/lib/libgpgme.so';
  {$ENDIF}
  {$IFDEF WINDOWS}
  SO = 'libgpgme.dll';
  {$ENDIF}

function ListKeys: string;
var
  LogM: TStringList;
  s: string;
  context: Tgpgme_ctx_t;
  y: Tgpgme_error;
  info: Pgpgme_engine_info;
  key: Pgpgme_key;
  uid: Pgpgme_user_id;
  subkey: Pgpgme_subkey;
  zeile: String;
  temp: String;
begin
  LogM:=TStringList.Create;
  try
    zeile := '';
    LogM.Clear;
    y := gpgme_new(@context);
    if y.error <> 0 then raise Exception.Create('cannot create context');
    info := gpgme_ctx_get_engine_info(context);
    if not assigned(info) then raise Exception.Create('could not get engine info');
    LogM.Append(gpgme_get_protocol_name(info.protocol) + ' ' + info.version + ' ' + info.file_name + ' ' + info.home_dir);

    y := gpgme_op_keylist_start(context, nil, false);
    CheckGpgmeError(y);
    try
      y := gpgme_op_keylist_next(context, @key);
      while y.error = 0 do begin
        uid := key.uids;
        while assigned(uid) do begin
          if zeile <> '' then Zeile := Zeile + '; ';
          if Assigned(uid.uid) then zeile := uid.uid else zeile := 'unknown UID';
          zeile := zeile + ': ';
          if Assigned(uid.name) then temp := uid.name else temp := 'unknowm name';
          zeile := zeile + temp;
          zeile := zeile + ' (';
          if assigned(uid.comment) then temp := uid.comment else temp := '';
          zeile := zeile + temp;
          zeile := zeile + ') ';
          if Assigned(uid.email) then temp := uid.email else temp := '';
          zeile := zeile + temp;
          uid := uid.next;
        end;
        LogM.Append(zeile);

        LogM.Append('  ownertrust: ' + IntToStr(key.owner_trust));

        subkey := key.subkeys;
        while assigned(subkey) do begin
          zeile := '    Key ID: ' + subkey.keyid;
          LogM.Append(Zeile);
          zeile := '      can encrypt: ' + BoolToStr(subkey.can_encrypt, true);
          LogM.Append(zeile);
          zeile := '      can sign: ' + BoolToStr(subkey.can_sign, true);
          LogM.Append(zeile);
          subkey := subkey.next;
        end;

        y := gpgme_op_keylist_next(context, @key);
        //Application.ProcessMessages;
      end;
      //y := y and ($FFFF);
      if y.errorcode <> GPG_ERR_EOF then raise Exception.Create('cannot finish listing the keys');
    finally
      y := gpgme_op_keylist_end(context);
      if y.error <> 0 then raise Exception.Create('error when closing down key listing operation');
    end;

    gpgme_release(context);
    s:=LogM.Text;
  finally
    LogM.Free;
  end;
  result:=s;
end;

initialization
  //_GPG:=LoadGpgme(SO);

end.

