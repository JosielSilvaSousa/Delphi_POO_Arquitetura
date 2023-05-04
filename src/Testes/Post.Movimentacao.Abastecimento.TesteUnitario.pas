unit Post.Movimentacao.Abastecimento.TesteUnitario;

interface
 {$M+}
uses
  DUnitX.TestFramework,
  Spring.Container,
  System.Rtti,
  Delphi.Mocks,
  Post.Movimentacao.Abastecimento.Interfaces,
  Post.Movimentacao.Abastecimento.Controller;

type
  [TestFixture]
  TAbastecimentoTestUnitatio = class
  private
  FRepository : TMock<IAbastecimentoRepository>;
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


procedure TAbastecimentoTestUnitatio.DeveValidarExcluir;
var vController : TAbastecimentoController;
begin
  var vModel := RetonarModel;
  FRepository.Setup.WillReturn(TValue.From(True)).When.Excluir(999);

  vController:= TAbastecimentoController.create(FRepository.Instance);
  var vRetorno := vController.Excluir(999);

  assert.IsTrue(vRetorno,'Erro ao validar Exclusão.');
  FRepository.Verify();
  vController.Free;
end;

procedure TAbastecimentoTestUnitatio.DeveValidarGravar;
var vController : TAbastecimentoController;
begin
  var vModel := RetonarModel;
  FRepository.Setup.WillReturn(TValue.From(True)).When.Inserir(vModel);

  vController:= TAbastecimentoController.create(FRepository.Instance);
  var vRetorno := vController.Gravar(vModel);

  assert.IsTrue(vRetorno,'Erro ao validar gravação.');
  FRepository.Verify();
  vController.Free;


end;

function TAbastecimentoTestUnitatio.RetonarModel: IAbastecimentoModel;
begin
 Result := GlobalContainer.Resolve<IAbastecimentoModel>;
 Result.id := 999;
 Result.TipoCombustivel := 'TESTE';
 Result.Valor := 5.99;
end;

procedure TAbastecimentoTestUnitatio.Setup;
begin
 FRepository := TMock<IAbastecimentoRepository>.Create;
end;

procedure TAbastecimentoTestUnitatio.TearDown;
begin
 FRepository.Free;
end;

initialization
  TDUnitX.RegisterTestFixture(TAbastecimentoTestUnitatio);

end.

