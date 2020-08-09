unit mainunit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Menus,
  StdCtrls, Buttons, TplMultiGraphUnit, MWStockwarsClasses, math;

type

  { TFrmMain }

  TFrmMain = class(TForm)
    BtnKaufen: TBitBtn;
    BtnVerkaufen: TBitBtn;
    EdtMenge: TEdit;
    ImgStock: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    LblGeld: TLabel;
    LstStock: TListBox;
    LstDepot: TListBox;
    MainMenu1: TMainMenu;
    Timer1: TTimer;
    Ich : TIch;
    Stock : TStock;
    procedure BtnKaufenClick(Sender: TObject);
    procedure BtnVerkaufenClick(Sender: TObject);
    procedure DatenAnzeigen();
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure LstDepotClick(Sender: TObject);
    procedure LstStockClick(Sender: TObject);
    procedure LstStockSelectionChange(Sender: TObject; User: boolean);
    procedure Timer1Timer(Sender: TObject);
  private
    _rag : TRAG;
    _graph : TRAGGraph;
  public

  end;

var
  FrmMain: TFrmMain;
  StockWahl : Integer;

implementation

{$R *.frm}

{ TFrmMain }

procedure TFrmMain.DatenAnzeigen();
var
  i : Integer;
Begin
  // Hier kommt die Aktualisierung der Daten hin.
  FrmMain.LstStock.Clear;
  FrmMain.LstDepot.Clear;
  for i := 1 to 5 do
  Begin
    FrmMain.LstStock.Items.Add(Stock.AktStock[i].Bezeichnung + ': ' + IntToStr(Stock.AktStock[i].Preis));
    FrmMain.LstDepot.Items.Add(Ich.Depot[i].Bezeichnung + ': ' + IntToStr(Ich.Menge[i]));

  end;
  LblGeld.Caption:=IntToStr(Ich.Geld) + ' €';
  EdtMenge.Text:='';
end;

procedure TFrmMain.BtnKaufenClick(Sender: TObject);
var
  Anzahl, Nummer : Integer;
begin
  Timer1.Enabled:=False;
  Anzahl := StrToInt(EdtMenge.Text);
  Nummer := LstStock.ItemIndex+1;
  if (Anzahl * Stock.AktStock[Nummer].Preis) <= Ich.Geld then
  Begin
    Ich.Geld:= Ich.Geld - (Anzahl * Stock.AktStock[Nummer].Preis);
    Ich.Menge[Nummer] := Ich.Menge[Nummer] + Anzahl;
    Ich.Depot := Stock.AktStock;
  end;
  DatenAnzeigen();
  Timer1.Enabled := true;
end;

procedure TFrmMain.BtnVerkaufenClick(Sender: TObject);
var
  Anzahl, Nummer : Integer;
begin
  Timer1.Enabled:=False;
  Anzahl := StrToInt(EdtMenge.Text);
  Nummer := LStDepot.ItemIndex+1;
  if Anzahl <= Ich.Menge[Nummer] then
  Begin
    Ich.Geld:= Ich.Geld + (Anzahl * Stock.AktStock[Nummer].Preis);
    Ich.Menge[Nummer] := Ich.Menge[Nummer] - Anzahl;
    Ich.Depot := Stock.AktStock;
  end;
  DatenAnzeigen();
  Timer1.Enabled := true;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  _rag := TRAG.Create(ImgStock.Width, ImgStock.Height);
  _rag.GridStepHorz := 10;
  _rag.GridStepVert := 40;
  _rag.BackColor:= clBlack;
  _rag.TextColor:=clWhite;
  _rag.XScalar := 2;

  _graph := TRAGGraph.Create(125);
  _graph.Color := clWhite;
  _graph.GraphType := gtLines;
  _rag.AddGraph(_graph);

  _rag.RedrawGraphs(True);
  ImgStock.Picture := _rag.Picture;
  Ich := TIch.Create();
  Stock := TStock.Create();
  Ich.Depot := Stock.AktStock;
  StockWahl := 1;
  DatenAnzeigen();
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Ich);
  FreeAndNil(Stock);
end;

procedure TFrmMain.LstDepotClick(Sender: TObject);
var
  i : Integer;
begin
  i := LstDepot.ItemIndex+1;
  EdtMenge.Text:=IntToStr(Ich.Menge[i]);
end;

procedure TFrmMain.LstStockClick(Sender: TObject);
var
  i : Integer;
begin
  i := LstStock.ItemIndex + 1;
  StockWahl :=i;
  EdtMenge.Text:=IntToStr(floor(Ich.Geld / Stock.AktStock[i].Preis));
end;

procedure TFrmMain.LstStockSelectionChange(Sender: TObject; User: boolean);
begin

end;

procedure TFrmMain.Timer1Timer(Sender: TObject);
var
  Akt : Integer;
begin
  Stock.DatenAktualisieren();
  Akt := Stock.AktStock[StockWahl].Preis;
  DatenAnzeigen();
  _rag.AddValue(0,Akt);
  _rag.TextRightTop    := IntToStr(Stock.AktStock[StockWahl].Max);
  _rag.TextRightBottom := IntToStr(Stock.AktStock[StockWahl].Min);
  _rag.RedrawGraphs(True);
  ImgStock.Picture := _rag.Picture;
end;

end.

