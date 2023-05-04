unit Post.Cadastro.Combustivel.Controller;

interface
Uses
Post.Cadastro.Combustivel.Interfaces,
System.Generics.Collections;

type
 TCombustivelController  = class(TInterfacedObject,ICombustivelController)
  private
  FRepository : ICombustivelRepository;
  public
    function Gravar(aModel:ICombustivelModel) : Boolean;
    function Excluir(aCodigo : Integer) : Boolean;
    function Retornar(aCodigo : Integer) : ICombustivelModel;
  constructor create(aRepository : ICombustivelRepository);
 end;

implementation
uses Post.Abastecimento.Conexao.Interfaces;

{ TCombustivelControlelr }

constructor TCombustivelController.create(aRepository: ICombustivelRepository);
begin
 FRepository := aRepository;
end;

function TCombustivelController.Excluir(aCodigo: Integer): Boolean;
begin
  vConexaoFirebird.RetorgarConexao.StartTransaction;
  result := FRepository.Excluir(aCodigo);

  if result then
    vConexaoFirebird.RetorgarConexao.Commit
  else
    vConexaoFirebird.RetorgarConexao.Rollback;
end;

function TCombustivelController.Gravar(aModel: ICombustivelModel): Boolean;
begin
  vConexaoFirebird.RetorgarConexao.StartTransaction;

  if aModel.Existe then
    result := FRepository.Alterar(aModel)
  else
    result := FRepository.Inserir(aModel);

  if result then
    vConexaoFirebird.RetorgarConexao.Commit
  else
    vConexaoFirebird.RetorgarConexao.Rollback;
end;

function TCombustivelController.Retornar(aCodigo: Integer): ICombustivelModel;
begin
 result := FRepository.Retornar(aCodigo);
end;

end.
