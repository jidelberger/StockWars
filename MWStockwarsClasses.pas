unit MWStockwarsClasses;

{$mode objfpc}{$M+}

interface

uses
  Classes, SysUtils;

type
  TMWAktie = Record
    Preis : Integer;
    Bezeichnung : String;
    Max : Integer;
    Min : Integer;
  end;
  Aktien = Array [1..5] of TMWAktie;

  TStock = Class(TObject)
    Public
    AktStock : Aktien;
    Constructor Create();
    Procedure DatenAktualisieren();
  end;

  TIch = Class(TObject)
    Public
    Geld : Integer;
    Depot : Aktien;
    Menge : Array [1..5] of Integer;
    Constructor Create();
  end;

implementation

Constructor TStock.Create();
Begin
  AktStock[1].Bezeichnung := 'Gogol';
  AktStock[1].Preis:= 97;
  AktStock[1].Max:=720;
  Aktstock[1].Min:=95;
  AktStock[2].Bezeichnung := 'Mapfel';
  AktStock[2].Preis:= 333;
  AktStock[2].Max:=1200;
  Aktstock[2].Min:=130;
  AktStock[3].Bezeichnung := 'KleinWeich';
  AktStock[3].Preis:= 252;
  AktStock[3].Max:=666;
  Aktstock[3].Min:=30;
  AktStock[4].Bezeichnung := 'Fatzebook';
  AktStock[4].Preis:= 400;
  AktStock[4].Max:=2000;
  Aktstock[4].Min:=230;
  AktStock[5].Bezeichnung := 'TeleDoof';
  AktStock[5].Preis:= 20;
  AktStock[5].Max:=550;
  Aktstock[5].Min:=2;
end;

Procedure TStock.DatenAktualisieren();
var
  i : Integer;
Begin
  for i := 1 to 5 do
  Begin
    AktStock[i].Preis  := AktStock[i].Min + random(AktStock[i].Max - AktStock[i].Min);
  end;
end;

Constructor TIch.Create();
var
  i : Integer;
Begin
  Geld:= 1000;
  for i := 1 to 5 do
  begin
    Menge[i] := 0;
  end;

end;

end.

