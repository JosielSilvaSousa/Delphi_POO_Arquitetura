unit Post.Cadastro.Combustivel.View;

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
  Vcl.ExtCtrls,
  Post.Cadastro.Combustivel.Interfaces,
  Post.Formulario.Heranca, Vcl.Mask;

type
  TfrmCombustivel = class(TfrmHeranca)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit2: TEdit;
    Panel2: TPanel;
    btnGravar: TButton;
    btnExcluir: TButton;
    edtvalor: TMaskEdit;
    Codigo: TMaskEdit;
    edttanque: TEdit;
    Label4: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure CodigoExit(Sender: TObject);
  private
  FController : ICombustivelController;
  FModel : ICombustivelModel;
  FExiste : Boolean;
    procedure Limpar;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCombustivel: TfrmCombustivel;

implementation
uses Spring.Container;

{$R *.dfm}

procedure TfrmCombustivel.btnGravarClick(Sender: TObject);
begin
  FModel.TipoCombustivel := Edit2.Text;
  FModel.Valor := StrToFloat(trim(edtvalor.Text));
  FModel.Id :=  StrToInt(trim(Codigo.Text));
  FModel.Tanque := edttanque.Text;

  var vRetorno := FController.Gravar(FModel);

  if vRetorno then
  begin
   ShowMessage('Operação realizada com sucesso!');
   Limpar;
  end
  else
   ShowMessage('Erro ao gravar!');
end;

procedure TfrmCombustivel.Limpar;
begin
  Edit2.Clear;
  edtvalor.Clear;
  Codigo.Clear;
  edttanque.Clear;
end;

procedure TfrmCombustivel.btnExcluirClick(Sender: TObject);
begin
 if Codigo.Text = Emptystr then
 begin
  ShowMessage('Necessário informar um código');
  exit;
 end;
 FExiste := FController.Excluir(StrToInt(trim(Codigo.Text)));

 if FExiste then
  begin
    ShowMessage('Excluido com  sucesso!');
    Limpar;
  end
  else
 ShowMessage('Erro ao excluir cadastro!');

end;

procedure TfrmCombustivel.CodigoExit(Sender: TObject);
begin
  if Codigo.Text <> Emptystr then
 begin
   FModel := FController.Retornar(StrToInt(Trim(Codigo.Text)));
   Edit2.Text := FModel.TipoCombustivel;
   edtvalor.Text := FloatToStr(FModel.Valor);
   edttanque.Text := FModel.Tanque;
 end;
end;

procedure TfrmCombustivel.FormShow(Sender: TObject);
begin
  inherited;
  FController := GlobalContainer.Resolve<ICombustivelController>;
  FModel := GlobalContainer.Resolve<ICombustivelModel>;
end;

end.
