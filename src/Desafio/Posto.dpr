program Posto;

uses
  Vcl.Forms,
  Post.Movimentacao.Abastecimento.View in 'View\Post.Movimentacao.Abastecimento.View.pas' {frmAbastecimento},
  Post.Movimentacao.Abastecimento.Model in 'Model\Post.Movimentacao.Abastecimento.Model.pas',
  Post.Movimentacao.Abastecimento.Repository in 'Repository\Post.Movimentacao.Abastecimento.Repository.pas',
  Post.Cadastro.Bomba.View in 'View\Post.Cadastro.Bomba.View.pas' {frmBomba},
  Post.Cadastro.Bomba.Model in 'Model\Post.Cadastro.Bomba.Model.pas',
  Post.Cadastro.Bomba.Repository in 'Repository\Post.Cadastro.Bomba.Repository.pas',
  Post.Cadastro.Bomba.Register in 'Post.Cadastro.Bomba.Register.pas',
  Post.Movimentacao.Abastecimento.Register in 'Post.Movimentacao.Abastecimento.Register.pas',
  Post.Cadastro.Bomba.Interfaces in 'Interface\Post.Cadastro.Bomba.Interfaces.pas',
  Post.Movimentacao.Abastecimento.Interfaces in 'Interface\Post.Movimentacao.Abastecimento.Interfaces.pas',
  Post.Abastecimento.Conexao in 'Post.Abastecimento.Conexao.pas',
  Post.Abastecimento.Conexao.Interfaces in 'Post.Abastecimento.Conexao.Interfaces.pas',
  Post.Register in 'Post.Register.pas',
  Spring.Container,
  Post.Cadastro.Bomba.Controller in 'Controller\Post.Cadastro.Bomba.Controller.pas',
  Post.Movimentacao.Abastecimento.Controller in 'Controller\Post.Movimentacao.Abastecimento.Controller.pas',
  Post.Cadastro.Combustivel.View in 'View\Post.Cadastro.Combustivel.View.pas' {frmCombustivel},
  Post.Cadastro.Combustivel.Interfaces in 'Interface\Post.Cadastro.Combustivel.Interfaces.pas',
  Post.Cadastro.Combustivel.Model in 'Model\Post.Cadastro.Combustivel.Model.pas',
  Post.Cadastro.Combustivel.Controller in 'Controller\Post.Cadastro.Combustivel.Controller.pas',
  Post.Cadastro.Combustivel.Repository in 'Repository\Post.Cadastro.Combustivel.Repository.pas',
  Post.Formulario.Heranca in 'Post.Formulario.Heranca.pas' {frmHeranca},
  Post.Relatorio.Abastecimento.View in 'Relatorio\Post.Relatorio.Abastecimento.View.pas' {frmRelatorio};

{$R *.res}

begin
  Application.Initialize;
  Post.Register.RegisterTypes(GlobalContainer);

  vConexaoFirebird := GlobalContainer.Resolve<IConexaoFirebird>;
  vConexaoFirebird.Conectar;

  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmAbastecimento, frmAbastecimento);
  Application.CreateForm(TfrmBomba, frmBomba);
  Application.CreateForm(TfrmCombustivel, frmCombustivel);
  Application.CreateForm(TfrmCombustivel, frmCombustivel);
  Application.CreateForm(TfrmHeranca, frmHeranca);
  Application.CreateForm(TfrmRelatorio, frmRelatorio);
  Application.Run;
end.
