unit Post.Register;

interface
uses Spring.Container;

Procedure RegisterTypes(const Container: TContainer);

implementation

uses Post.Cadastro.Bomba.Register,
  Post.Cadastro.Combustivel.Register,
  Post.Movimentacao.Abastecimento.Register,
  Post.Abastecimento.Conexao;

Procedure RegisterTypes(const Container: TContainer);
begin
  Post.Cadastro.Bomba.Register.RegisterTypes(Container);
  Post.Cadastro.Combustivel.Register.RegisterType(Container);
  Post.Movimentacao.Abastecimento.Register.RegisterTypes(Container);
  Container.RegisterType<TConexaoFirebird>;
  Container.build;
end;
end.
