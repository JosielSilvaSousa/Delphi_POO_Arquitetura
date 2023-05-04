unit Post.Cadastro.Bomba.TesteUnitario;

interface
 {$M+}
uses
  DUnitX.TestFramework,
  Spring.Container,
  System.Rtti,
  Delphi.Mocks,
  Post.Cadastro.Bomba.Interfaces,
  Post.Cadastro.Bomba.Controller;

type
  [TestFixture]
  TBombaTestUnitatio = class
  private
  FRepository : TMock<IBombaRepository>;
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


procedure TBombaTestUnitatio.DeveValidarExcluir;
var vController : TBombaController;
begin
  var vModel := RetonarModel;
  FRepository.Setup.WillReturn(TValue.From(True)).When.Excluir(999);

  vController:= TBombaController.create(FRepository.Instance);
  var vRetorno := vController.Excluir(999);

  assert.IsTrue(vRetorno,'Erro ao validar Exclusão.');
  FRepository.Verify();
  vController.Free;
end;

procedure TBombaTestUnitatio.DeveValidarGravar;
var vController : TBombaController;
begin
  var vModel := RetonarModel;
  FRepository.Setup.WillReturn(TValue.From(True)).When.Inserir(vModel);

  vController:= TBombaController.create(FRepository.Instance);
  var vRetorno := vController.Gravar(vModel);

  assert.IsTrue(vRetorno,'Erro ao validar gravação.');
  FRepository.Verify();
  vController.Free;


end;

function TBombaTestUnitatio.RetonarModel: IBombaModel;
begin
 Result := GlobalContainer.Resolve<IBombaModel>;
 Result.id := 999;
 Result.TipoCombustivel := 1;
end;

procedure TBombaTestUnitatio.Setup;
begin
 FRepository := TMock<IBombaRepository>.Create;
end;

procedure TBombaTestUnitatio.TearDown;
begin
 FRepository.Free;
end;

initialization
  TDUnitX.RegisterTestFixture(TBombaTestUnitatio);

end.
