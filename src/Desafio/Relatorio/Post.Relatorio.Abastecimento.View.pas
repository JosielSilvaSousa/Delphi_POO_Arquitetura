unit Post.Relatorio.Abastecimento.View;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  frxClass,
  frxDBSet,
  Post.Movimentacao.Abastecimento.Interfaces;

type
  TfrmRelatorio = class(TForm)
    Button1: TButton;
    frxReport1: TfrxReport;
    frxDBDataset1: TfrxDBDataset;
    MenRelatorio: TFDMemTable;
    MenRelatorioTanque: TStringField;
    MenRelatorioBomba: TIntegerField;
    MenRelatorioValor: TFloatField;
    MenRelatorioData: TDateTimeField;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
  FController : IAbastecimentoController;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelatorio: TfrmRelatorio;

implementation
uses Spring.Container;

{$R *.dfm}

procedure TfrmRelatorio.Button1Click(Sender: TObject);
begin
  MenRelatorio.Close;
  MenRelatorio.Open;
  var
  vLista := FController.RetornarRelatorioLista;
   for var Item in vLista do
  begin
    MenRelatorio.Append;
    MenRelatorio.FieldByName('Data').AsDateTime := Item.Data;
    MenRelatorio.FieldByName('Bomba').AsInteger := Item.Bomba;
    MenRelatorio.FieldByName('Tanque').AsString := Item.Tanque;
    MenRelatorio.FieldByName('valor').AsFloat := Item.ValorTotal;
    MenRelatorio.Post;
  end;
  frxReport1.ShowReport;
end;

procedure TfrmRelatorio.FormShow(Sender: TObject);
begin
  FController := GlobalContainer.Resolve<IAbastecimentoController>;
end;

end.
