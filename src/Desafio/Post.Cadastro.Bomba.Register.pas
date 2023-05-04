unit Post.Cadastro.Bomba.Register;

interface

uses Spring.Container;

Procedure RegisterTypes(const Container: TContainer);

implementation

uses Post.Cadastro.Bomba.Controller,
  Post.Cadastro.Bomba.Model,
  Post.Cadastro.Bomba.Repository;

Procedure RegisterTypes(const Container: TContainer);
begin
  Container.RegisterType<TBombaModel>;
  Container.RegisterType<TBombaController>;
  Container.RegisterType<TBombaReporitory>;
  Container.build;
end;

end.
