unit Post.Cadastro.Combustivel.Register;

interface

uses
  Spring.Container;
Procedure RegisterType(const Container: TContainer);

implementation

uses
  Post.Cadastro.Combustivel.Controller,
  Post.Cadastro.Combustivel.Model,
  Post.Cadastro.Combustivel.Repository;

Procedure RegisterType(const Container: TContainer);
begin
  Container.RegisterType<TCombustivelController>;
  Container.RegisterType<TCombustivelReporitory>;
  Container.RegisterType<TCombustivelModel>;

  Container.build;
end;

end.
