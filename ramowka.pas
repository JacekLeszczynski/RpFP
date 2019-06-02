unit ramowka;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Grids, Buttons,
  StdCtrls, Types;

type

  { TFRamowka }

  TFRamowka = class(TForm)
    BitBtn1: TBitBtn;
    kalendarz: TStringGrid;
    Label1: TLabel;
    Label2: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure kalendarzDrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
  private
    bb: boolean;
    procedure dodaj_pozycje(dzien,audycja,prezenter,godzina: string; opis: string = ''; trwa: boolean = false);
    procedure dodaj(nazwa_dnia,tresc: string);
  public
    poniedzialek,wtorek,sroda,czwartek,piatek,sobota,niedziela: string;

  end;

var
  FRamowka: TFRamowka;

implementation

uses
  ecode, config;

{$R *.lfm}

{ TFRamowka }

procedure TFRamowka.FormCreate(Sender: TObject);
begin
  bb:=true;
  kalendarz.Clear;
  kalendarz.Columns.Add;
  kalendarz.Columns.Add;
  kalendarz.Columns.Add;
  kalendarz.Columns.Add;
  kalendarz.Columns[0].Title.Caption:=RS_DZIEN;
  kalendarz.Columns[0].Width:=100;
  //if FBoldTitle then kalendarz.Columns[0].Title.Font.Style:=[fsBold];
  kalendarz.Columns[0].Alignment:=taRightJustify;
  kalendarz.Columns[1].Title.Caption:=RS_AUDYCJA;
  kalendarz.Columns[1].Width:=400;
  //if FBoldTitle then kalendarz.Columns[1].Title.Font.Style:=[fsBold];
  kalendarz.Columns[2].Title.Caption:=RS_PREZENTER;
  kalendarz.Columns[2].Width:=130;
  //if FBoldTitle then self.Columns[2].Title.Font.Style:=[fsBold];
  kalendarz.Columns[2].Alignment:=taCenter;
  //kalendarz.Columns[2].Font.Color:=clRed;
  //if FBoldTitle then kalendarz.Columns[2].Font.Style:=[fsBold];
  kalendarz.Columns[3].Title.Caption:=RS_GODZINA;
  kalendarz.Columns[3].Width:=120;
  //if FBoldTitle then kalendarz.Columns[3].Title.Font.Style:=[fsBold];
  kalendarz.Clean([gzNormal]);
  kalendarz.RowCount:=1;
  kalendarz.FixedCols:=0;
  kalendarz.FixedRows:=0;
end;

procedure TFRamowka.FormShow(Sender: TObject);
begin
  if bb then
  begin
    dodaj(RS_PONIEDZIALEK,poniedzialek);
    dodaj(RS_WTOREK,wtorek);
    dodaj(RS_SRODA,sroda);
    dodaj(RS_CZWARTEK,czwartek);
    dodaj(RS_PIATEK,piatek);
    dodaj(RS_SOBOTA,sobota);
    dodaj(RS_NIEDZIELA,niedziela);
    //kalendarz.AutoSizeColumns;
  end;
end;

procedure TFRamowka.kalendarzDrawCell(Sender: TObject; aCol, aRow: Integer;
  aRect: TRect; aState: TGridDrawState);
const
  CL_MENU = clSilver;
var
  zawartosc: string;
  s: string;
begin
  zawartosc:=TStringGrid(Sender).Cells[aCol,aRow];
  s:=TStringGrid(Sender).Cells[0,aRow];
  TStringGrid(Sender).Canvas.FillRect(aRect);
  { bez zmian }
  TStringGrid(Sender).Canvas.Brush.Color:=clWhite;
  TStringGrid(Sender).Canvas.Font.Style:=[];
  { zmiany }
  if (s<>'') and (s<>'[TRWA!]') then
  begin
    TStringGrid(Sender).Canvas.Brush.Color:=CL_MENU;
    TStringGrid(Sender).Canvas.GradientFill(aRect,CL_MENU,CL_MENU,gdVertical);
    TStringGrid(Sender).Canvas.Font.Style:=[fsBold];
  end;
  if s='[TRWA!]' then
  begin
    //if zawartosc='[TRWA!]' then zawartosc:='';
    TStringGrid(Sender).Canvas.Font.Style:=[fsBold];
    TStringGrid(Sender).Canvas.Font.Color:=clRed;
    TStringGrid(Sender).Canvas.Brush.Color:=clYellow;
  end;
  TStringGrid(Sender).Canvas.TextOut(aRect.Left,aRect.Top,zawartosc);
end;

procedure TFRamowka.dodaj_pozycje(dzien, audycja, prezenter, godzina: string;
  opis: string; trwa: boolean);
var
  a: integer;
begin
  a:=kalendarz.RowCount;
  if kalendarz.Cells[1,a-1]='' then dec(a) else kalendarz.InsertColRow(False,a);
  if trwa then kalendarz.Cells[0,a]:='[TRWA!]' else kalendarz.Cells[0,a]:=dzien;
  kalendarz.Cells[1,a]:=audycja;
  kalendarz.Cells[2,a]:=prezenter;
  kalendarz.Cells[3,a]:=godzina;
end;

procedure ss_zapisz(s,plik: string);
var
  ss: TStringList;
begin
  ss:=TStringList.Create;
  try
    ss.Add(s);
    ss.SaveToFile(plik);
  finally
    ss.Free;
  end;
end;

procedure TFRamowka.dodaj(nazwa_dnia, tresc: string);
const
  wDEBUG = false;
var
  s,s1,s2,s3,opis: string;
  trwa,enter,src,a: integer;
  b_trwa: boolean;
begin
  dodaj_pozycje(nazwa_dnia,RS_AUDYCJA,RS_PREZENTER,RS_GODZINA);
  s:=tresc+#10;
  a:=pos('</tr>',s);
  delete(s,1,a+5);
  s:=StringReplace(s,'pole pole2','pole',[rfReplaceAll,rfIgnoreCase]);
  s:=StringReplace(s,'<font color=''red''>','',[rfReplaceAll,rfIgnoreCase]);
  while true do
  begin
    opis:='';
    enter:=pos(#10,s);
    trwa:=pos('<b>TRWA! </b>',s);
    b_trwa:=(trwa>0) and (trwa<enter);
    if b_trwa then s:=StringReplace(s,'<b>TRWA! </b>','',[rfReplaceAll,rfIgnoreCase]);
    a:=pos('class='+#39+'pole'+#39+'>',s);
    if a=0 then break;
    delete(s,1,a+12);
    s1:=GetLineToStr(s,1,'<');
    IF wDEBUG and B_TRWA THEN WRITELN('[A] ',s1,' [SOURCE]: ',s);
    if trim(s1)='' then
    begin
      a:=pos('title=',s);
      delete(s,1,a+6);
      opis:=GetLineToStr(s,1,#39);
      a:=pos('>',s);
      delete(s,1,a);
      s1:=GetLineToStr(s,1,'<');
      IF wDEBUG and B_TRWA THEN WRITELN('[B] ',s1,' [SOURCE]: ',s);
    end;

    enter:=pos(#10,s);
    src:=pos('src',s);
    if (src<enter) and (src>0) then
    begin
      a:=pos('>">',s);
      delete(s,1,a+2);
      s2:=GetLineToStr(s,1,'<');
      IF wDEBUG and B_TRWA THEN WRITELN('[C] ',s2,' [SOURCE]: ',s);
    end else begin
      a:=pos('class='+#39+'pole'+#39+'>',s);
      delete(s,1,a+12);
      s2:=GetLineToStr(s,1,'<');
      IF wDEBUG and B_TRWA THEN WRITELN('[D] ',s2,' [SOURCE]: ',s);
    end;

    a:=pos('class='+#39+'pole'+#39+'>',s);
    delete(s,1,a+12);
    s3:=GetLineToStr(s,1,'<');
    IF wDEBUG and B_TRWA THEN WRITELN('[E] ',s3,' [SOURCE]: ',s);
    if b_trwa and (s3='') then
    begin
      a:=pos('color=''red''>',s);
      delete(s,1,a+12);
      s3:=GetLineToStr(s,1,'<');
      IF wDEBUG and B_TRWA THEN WRITELN('[F] ',s3,' [SOURCE]: ',s);
    end;
    dodaj_pozycje('',s1,s2,s3,opis,b_trwa);
    a:=pos('</tr>',s);
    delete(s,1,a+5);
  end;
end;

procedure TFRamowka.BitBtn1Click(Sender: TObject);
begin
  close;
end;

end.

