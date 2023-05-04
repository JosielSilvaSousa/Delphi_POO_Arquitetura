unit Post.Cadastro.Combustivel.TesteUnitario;

interface
 {$M+}
uses
  DUnitX.TestFramework,
  Spring.Container,
  System.Rtti,
  Delphi.Mocks,
  Post.Cadastro.Combustivel.Interfaces,
  Post.Cadastro.Combustivel.Controller;

type
  [TestFixture]
  TCombustivelTestUnitatio = class
  private
  FRepository : TMock<ICombustivelRepository>;
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


procedure TCombustivelTestUnitatio.DeveValidarExcluir;
var vController : TCombustivelController;
begin
  var vModel := RetonarModel;
  FRepository.Setup.WillReturn(TValue.From(True)).When.Excluir(999);

  vController:= TCombustivelController.create(FRepository.Instance);
  var vRetorno := vController.Excluir(999);

  assert.IsTrue(vRetorno,'Erro ao validar Exclusão.');
  FRepository.Verify();
  vController.Free;
end;

procedure TCombustivelTestUnitatio.DeveValidarGravar;
var vController : TCombustivelController;
begin
  var vModel := RetonarModel;
  FRepository.Setup.WillReturn(TValue.From(True)).When.Inserir(vModel);

  vController:= TCombustivelController.create(FRepository.Instance);
  var vRetorno := vController.Gravar(vModel);

  assert.IsTrue(vRetorno,'Erro ao validar gravação.');
  FRepository.Verify();
  vController.Free;


end;

function TCombustivelTestUnitatio.RetonarModel: ICombustivelModel;
begin
 Result := GlobalContainer.Resolve<ICombustivelModel>;
 Result.id := 999;
 Result.TipoCombustivel := 'TESTE';
 Result.Valor := 5.99;
end;

procedure TCombustivelTestUnitatio.Setup;
begin
 FRepository := TMock<ICombustivelRepository>.Create;
end;

procedure TCombustivelTestUnitatio.TearDown;
begin
 FRepository.Free;
end;

initialization
  TDUnitX.RegisterTestFixture(TCombustivelTestUnitatio);

end.

