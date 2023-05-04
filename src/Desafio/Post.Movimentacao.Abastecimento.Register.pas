unit Post.Movimentacao.Abastecimento.Register;

interface

uses Spring.Container;

Procedure RegisterTypes(const Container: TContainer);

implementation

uses Post.Movimentacao.Abastecimento.Controller,
  Post.Movimentacao.Abastecimento.Model,
  Post.Movimentacao.Abastecimento.Repository;

Procedure RegisterTypes(const Container: TContainer);
begin
  Container.RegisterType<TAbastecimentoModel>;
  Container.RegisterType<TAbastecimentoController>;
  Container.RegisterType<TAbastecimentoReporitory>;
  Container.build;
end;

end.
