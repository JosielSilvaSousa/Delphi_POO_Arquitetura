unit Post.Movimentacao.Abastecimento.Controller;

interface
Uses
 Post.Movimentacao.Abastecimento.Interfaces,
 System.Generics.Collections;

type
 TAbastecimentoController = class(TInterfacedObject,IAbastecimentoController)
  private
  FRepository : IAbastecimentoRepository;
  public
    function Gravar(aModel:IAbastecimentoModel) : Boolean;
    function Excluir(aCodigo : Integer) : Boolean;
    function RetornarBomba(aBomba : Integer) : IAbastecimentoModel;
    function RetornarLista(aData: TDateTime): TList<IAbastecimentoModel>;
    function RetornarRelatorioLista: TList<IAbastecimentoModel>;
  constructor create(aRepository : IAbastecimentoRepository);
 end;


implementation
uses Post.Abastecimento.Conexao.Interfaces;

{ TAbastecimentoControlelr }

constructor TAbastecimentoController.create(aRepository: IAbastecimentoRepository);
begin
  FRepository := aRepository;
end;

function TAbastecimentoController.Excluir(aCodigo: Integer): Boolean;
begin
  vConexaoFirebird.RetorgarConexao.StartTransaction;
  result := FRepository.Excluir(aCodigo);

  if result then
    vConexaoFirebird.RetorgarConexao.Commit
  else
    vConexaoFirebird.RetorgarConexao.Rollback;
end;

function TAbastecimentoController.Gravar(aModel: IAbastecimentoModel): Boolean;
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

function TAbastecimentoController.RetornarBomba(
  aBomba: Integer): IAbastecimentoModel;
begin
 Result := FRepository.RetornarBomba(aBomba);
end;

function TAbastecimentoController.RetornarLista(aData: TDateTime): TList<IAbastecimentoModel>;
begin
  result := FRepository.RetornarLista(aData);
end;

function TAbastecimentoController.RetornarRelatorioLista : TList<IAbastecimentoModel>;
begin
 result := FRepository.RetornarRelatorioLista;
end;

end.
