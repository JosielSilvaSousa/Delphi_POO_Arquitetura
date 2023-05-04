unit Post.Cadastro.Bomba.TesteIntegracao;

interface
uses
  DUnitX.TestFramework,
  system.SysUtils,
  Spring.Container,
  Post.Cadastro.Bomba.Interfaces,
  Post.Abastecimento.Conexao.Interfaces,
  Post.Cadastro.Bomba.Controller;

type
  [TestFixture]
  TBombaTestIntegracao = class
  private
  FRepository : IBombaRepository;
  function RetonarModel : IBombaModel;
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


procedure TBombaTestIntegracao.DeveValidarExcluir;
var vRetorno : Boolean;
begin
  var vModel := RetonarModel;
  FRepository := GlobalContainer.Resolve<IBombaRepository>;

  FRepository.Inserir(vModel);
  var vRetornoLista := FRepository.Retornar(vModel.Id);

  if vRetornoLista.Existe then
  begin
   vRetorno := FRepository.Excluir(vModel.Id);
   assert.IsTrue(vRetorno,'Erro ao validar Exclusão.');
  end;
end;

procedure TBombaTestIntegracao.DeveValidarGravar;
begin
  var vModel := RetonarModel;
  FRepository := GlobalContainer.Resolve<IBombaRepository>;
  var vRetorno := FRepository.Inserir(vModel);

  assert.IsTrue(vRetorno,'Erro ao validar gravação.');

end;

function TBombaTestIntegracao.RetonarModel: IBombaModel;
begin
 Result := GlobalContainer.Resolve<IBombaModel>;
 Result.id := 999;
 Result.TipoCombustivel := 1;
end;

procedure TBombaTestIntegracao.Setup;
begin
 vConexaoFirebird.RetorgarConexao.StartTransaction;
end;

procedure TBombaTestIntegracao.TearDown;
begin
 vConexaoFirebird.RetorgarConexao.Rollback;
end;

initialization
  TDUnitX.RegisterTestFixture(TBombaTestIntegracao);

end.


