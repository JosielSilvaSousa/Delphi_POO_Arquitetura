unit Post.Cadastro.Combustivel.TesteIntegracao;

interface
uses
  DUnitX.TestFramework,
  system.SysUtils,
  Spring.Container,
  Post.Cadastro.Combustivel.Interfaces,
  Post.Abastecimento.Conexao.Interfaces,
  Post.Cadastro.Combustivel.Controller;

type
  [TestFixture]
  TCombustivelTestIntegracao = class
  private
  FRepository : ICombustivelRepository;
  function RetonarModel : ICombustivelModel;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
 published
 procedure DeveValidarGravar;
 procedure DeveValidarExcluir;
  end;

implementation


procedure TCombustivelTestIntegracao.DeveValidarExcluir;
var vRetorno : Boolean;
begin
  var vModel := RetonarModel;
  FRepository := GlobalContainer.Resolve<ICombustivelRepository>;

  FRepository.Inserir(vModel);
  var vRetornoLista := FRepository.Retornar(vModel.Id);

  if vRetornoLista.Existe then
  begin
   vRetorno := FRepository.Excluir(vModel.Id);
   assert.IsTrue(vRetorno,'Erro ao validar Exclusão.');
  end;
end;

procedure TCombustivelTestIntegracao.DeveValidarGravar;
begin
  var vModel := RetonarModel;
  FRepository := GlobalContainer.Resolve<ICombustivelRepository>;
  var vRetorno := FRepository.Inserir(vModel);

  assert.IsTrue(vRetorno,'Erro ao validar gravação.');

end;

function TCombustivelTestIntegracao.RetonarModel: ICombustivelModel;
begin
 Result := GlobalContainer.Resolve<ICombustivelModel>;
 Result.id := 999;
 Result.TipoCombustivel := 'GASOLINA';
 Result.Valor := 7.99;
end;

procedure TCombustivelTestIntegracao.Setup;
begin
 vConexaoFirebird.RetorgarConexao.StartTransaction;
end;

procedure TCombustivelTestIntegracao.TearDown;
begin
 vConexaoFirebird.RetorgarConexao.Rollback;
end;

initialization
  TDUnitX.RegisterTestFixture(TCombustivelTestIntegracao);

end.


