unit Post.Cadastro.Bomba.Controller;

interface

Uses
  Post.Cadastro.Bomba.Interfaces,
  System.Generics.Collections,
  Post.Abastecimento.Conexao.Interfaces;

type
 TBombaController = class(TInterfacedObject,IBombaController)
  private
  FRepository : IBombaRepository;
  public
    function Gravar(aModel:IBombaModel) : Boolean;
    function Excluir(aCodigo : Integer) : Boolean;
    function Retornar(aCodigo : Integer) : IBombaModel;
    constructor create(aRepository : IBombaRepository);
 end;

implementation

{ TBombaControlelr }

constructor TBombaController.create(aRepository: IBombaRepository);
begin
 FRepository := aRepository;
end;

function TBombaController.Excluir(aCodigo: Integer): Boolean;
begin
 vConexaoFirebird.RetorgarConexao.StartTransaction;

 result := FRepository.Excluir(aCodigo);

  if Result then
  vConexaoFirebird.RetorgarConexao.Commit
  else
  vConexaoFirebird.RetorgarConexao.Rollback;
end;

function TBombaController.Gravar(aModel: IBombaModel): Boolean;
begin

  vConexaoFirebird.RetorgarConexao.StartTransaction;

   if aModel.Existe then
    Result := FRepository.Alterar(aModel)
  else
    Result := FRepository.Inserir(aModel);

  if Result then
  vConexaoFirebird.RetorgarConexao.Commit
  else
  vConexaoFirebird.RetorgarConexao.Rollback;
end;

function TBombaController.Retornar(aCodigo: Integer): IBombaModel;
begin
 Result := FRepository.Retornar(aCodigo);
end;

end.
