unit Post.Movimentacao.Abastecimento.TesteIntegracao;

interface
uses
  DUnitX.TestFramework,
  system.SysUtils,
  Spring.Container,
  Post.Movimentacao.Abastecimento.Interfaces,
  Post.Abastecimento.Conexao.Interfaces,
  Post.Movimentacao.Abastecimento.Controller;

type
  [TestFixture]
  TAbastecimentoTestIntegracao = class
  private
  FRepository : IAbastecimentoRepository;
  function RetonarModel : IAbastecimentoModel;
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


procedure TAbastecimentoTestIntegracao.DeveValidarExcluir;
var vRetorno : Boolean;
begin
  var vModel := RetonarModel;
  FRepository := GlobalContainer.Resolve<IAbastecimentoRepository>;

  FRepository.Inserir(vModel);
  var vRetornoLista := FRepository.RetornarLista(trunc(now));

  if vRetornoLista.Count > 0 then
  begin
   vRetorno := FRepository.Excluir(vModel.Id);
   assert.IsTrue(vRetorno,'Erro ao validar Exclusão.');
  end;
end;

procedure TAbastecimentoTestIntegracao.DeveValidarGravar;
begin
  var vModel := RetonarModel;
  FRepository := GlobalContainer.Resolve<IAbastecimentoRepository>;
  var vRetorno := FRepository.Inserir(vModel);

  assert.IsTrue(vRetorno,'Erro ao validar gravação.');

end;

function TAbastecimentoTestIntegracao.RetonarModel: IAbastecimentoModel;
begin
 Result := GlobalContainer.Resolve<IAbastecimentoModel>;
 Result.id := 999;
 Result.TipoCombustivel := 'TESTE';
 Result.Valor := 5.99;
end;

procedure TAbastecimentoTestIntegracao.Setup;
begin
 vConexaoFirebird.RetorgarConexao.StartTransaction;
end;

procedure TAbastecimentoTestIntegracao.TearDown;
begin
 vConexaoFirebird.RetorgarConexao.Rollback;
end;

initialization
  TDUnitX.RegisterTestFixture(TAbastecimentoTestIntegracao);

end.

