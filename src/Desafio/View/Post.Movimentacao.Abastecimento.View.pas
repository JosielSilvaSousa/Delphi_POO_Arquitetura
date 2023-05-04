unit Post.Movimentacao.Abastecimento.View;

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
  Vcl.Menus,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.ComCtrls,
  Vcl.Mask,
  Post.Movimentacao.Abastecimento.Interfaces,
  Post.Abastecimento.Conexao.Interfaces,
  Post.Formulario.Heranca,
  Post.Relatorio.Abastecimento.View,
  Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  Vcl.Grids,
  Vcl.DBGrids;

type
  TfrmAbastecimento = class(TfrmHeranca)
    Label1: TLabel;
    edtCumbustivel: TEdit;
    Label2: TLabel;
    edtLitros: TMaskEdit;
    Label3: TLabel;
    MainMenu1: TMainMenu;
    Combustvel1: TMenuItem;
    Bomba1: TMenuItem;
    Panel2: TPanel;
    Button3: TButton;
    Button4: TButton;
    edtnumeroBomba: TEdit;
    Label4: TLabel;
    edtValor: TMaskEdit;
    Label5: TLabel;
    rgdTipo: TRadioGroup;
    edtData: TMaskEdit;
    Label6: TLabel;
    edtValorTotal: TMaskEdit;
    Memo1: TMemo;
    edtValorCombustivel: TMaskEdit;
    DBGrid1: TDBGrid;
    FDMemTable1: TFDMemTable;
    DataSource1: TDataSource;
    FDMemTable1Id: TIntegerField;
    FDMemTable1Bomba: TIntegerField;
    FDMemTable1Valor_Total: TFloatField;
    FDMemTable1Tipo_Combustivel: TStringField;
    Relatorio1: TMenuItem;
    procedure Combustvel1Click(Sender: TObject);
    procedure Bomba1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rgdTipoClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure edtnumeroBombaExit(Sender: TObject);
    procedure edtValorTotalExit(Sender: TObject);
    procedure edtLitrosExit(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Relatorio1Click(Sender: TObject);
  private
    FController : IAbastecimentoController;
    FModel : IAbastecimentoModel;
    procedure PopularModel;
    procedure Limpar;
    procedure CarregarListaDiaria;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAbastecimento: TfrmAbastecimento;

implementation
uses
 Post.Cadastro.Combustivel.View,
 Post.Cadastro.Bomba.View,
 Spring.Container;

{$R *.dfm}

procedure TfrmAbastecimento.Bomba1Click(Sender: TObject);
begin
 frmBomba:= TfrmBomba.create(nil);
 frmBomba.ShowModal;
 frmBomba.Free;
end;

procedure TfrmAbastecimento.Limpar;
begin
  edtnumeroBomba.Clear;
  edtValorTotal.Clear;

  edtValorCombustivel.Clear;
  edtCumbustivel.Clear;
  edtLitros.Clear;
end;

procedure TfrmAbastecimento.Button3Click(Sender: TObject);
begin
  PopularModel;
  var vResultado := FController.Gravar(FModel);

  if vResultado then
  begin
   ShowMessage('Operação realizada com sucesso!');
   Limpar;
   CarregarListaDiaria;
  end
  else
   ShowMessage('Erro ao gravar!');
end;

procedure TfrmAbastecimento.Button4Click(Sender: TObject);
begin
  Limpar;
end;

procedure TfrmAbastecimento.Combustvel1Click(Sender: TObject);
begin
 frmCombustivel := TfrmCombustivel.create(nil);
 frmCombustivel.showModal;
 frmCombustivel.free;
end;

procedure TfrmAbastecimento.edtLitrosExit(Sender: TObject);
begin
 if edtLitros.Text <> EmptyStr then
 begin
  edtValorTotal.Text := FloatToStr((StrToFloat(edtLitros.Text)) * (FModel.Valor));
 end;

end;

procedure TfrmAbastecimento.edtnumeroBombaExit(Sender: TObject);
begin
  FModel := FController.RetornarBomba(StrToInt(edtnumeroBomba.Text));
  if FModel.Bomba = 0 then
  begin
    ShowMessage('Bomba não cadastrada!');
    edtnumeroBomba.SetFocus;
    Exit;
  end;
 edtValorCombustivel.Text := Trim(FloatToStr(FModel.Valor));
 edtCumbustivel.Text := FModel.TipoCombustivel;
end;

procedure TfrmAbastecimento.edtValorTotalExit(Sender: TObject);
begin
  if edtValorTotal.Text <> EmptyStr then
 begin
  edtLitros.Text := FloatToStr((StrToFloat(edtValorTotal.Text)) / (FModel.Valor));
 end;
end;

procedure TfrmAbastecimento.PopularModel;
begin
 FModel.Bomba :=   StrToIntDef(edtnumeroBomba.Text,0);
 FModel.ValorTotal := StrToFloatDef(trim(edtValorTotal.Text),0);
 FModel.Tributo := 15;
 FModel.Valor := StrToFloatDef(trim(edtValorCombustivel.Text),0);//Calcular.
 FModel.TipoCombustivel := edtCumbustivel.Text;
 FModel.liTros :=   StrToFloatDef(trim(edtLitros.Text),0);

 FModel.Data  := StrToDate(trim(edtData.Text));

end;

procedure TfrmAbastecimento.Relatorio1Click(Sender: TObject);
begin
 frmRelatorio:= TfrmRelatorio.create(nil);
 frmRelatorio.ShowModal;
 frmRelatorio.Free;
end;

procedure TfrmAbastecimento.FormShow(Sender: TObject);
begin
  FController := GlobalContainer.Resolve<IAbastecimentoController>;
  FModel := GlobalContainer.Resolve<IAbastecimentoModel>;
  if rgdTipo.ItemIndex = 0 then
   edtLitros.Enabled := false;

  edtData.Text := DateToStr(Now);
  CarregarListaDiaria;

end;

procedure TfrmAbastecimento.CarregarListaDiaria;
begin
  var
  vLista := FController.RetornarLista(Trunc(Now));
  FDMemTable1.Close;
  FDMemTable1.Open;
  for var Item in vLista do
  begin
    FDMemTable1.Append;
    FDMemTable1.FieldByName('ID').AsInteger := Item.Id;
    FDMemTable1.FieldByName('Bomba').AsInteger := Item.Bomba;
    FDMemTable1.FieldByName('Valor_Total').AsFloat := Item.ValorTotal;
    FDMemTable1.FieldByName('Tipo_Combustivel').AsString := Item.TipoCombustivel;
    FDMemTable1.Post;
  end;
end;

procedure TfrmAbastecimento.rgdTipoClick(Sender: TObject);
begin
   if rgdTipo.ItemIndex = 0 then
   begin
    edtLitros.Enabled := false;
    edtValorTotal.Enabled := True;
   end
   else
   begin
    edtLitros.Enabled := true;
    edtValorTotal.Enabled := false;
   end;
end;

end.
