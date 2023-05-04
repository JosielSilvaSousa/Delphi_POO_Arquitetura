program PostoTestes;

{$IFNDEF TESTINSIGHT}
{$APPTYPE CONSOLE}
{$ENDIF}
{$STRONGLINKTYPES ON}
uses
  System.SysUtils,
  {$IFDEF TESTINSIGHT}
  TestInsight.DUnitX,
  {$ELSE}
  DUnitX.Loggers.Console,
  DUnitX.Loggers.Xml.NUnit,
  {$ENDIF }
  DUnitX.TestFramework,
  Spring.Container,
  Post.Cadastro.Bomba.TesteUnitario in 'Post.Cadastro.Bomba.TesteUnitario.pas',
  Post.Register in '..\Desafio\Post.Register.pas',
  Post.Abastecimento.Conexao.Interfaces in '..\Desafio\Post.Abastecimento.Conexao.Interfaces.pas',
  Post.Cadastro.Combustivel.TesteUnitario in 'Post.Cadastro.Combustivel.TesteUnitario.pas',
  Post.Movimentacao.Abastecimento.TesteUnitario in 'Post.Movimentacao.Abastecimento.TesteUnitario.pas',
  Post.Movimentacao.Abastecimento.TesteIntegracao in 'Post.Movimentacao.Abastecimento.TesteIntegracao.pas',
  Post.Cadastro.Bomba.TesteIntegracao in 'Post.Cadastro.Bomba.TesteIntegracao.pas',
  Post.Cadastro.Combustivel.TesteIntegracao in 'Post.Cadastro.Combustivel.TesteIntegracao.pas';

{$IFNDEF TESTINSIGHT}
var
  runner: ITestRunner;
  results: IRunResults;
  logger: ITestLogger;
  nunitLogger : ITestLogger;
{$ENDIF}
begin
{$IFDEF TESTINSIGHT}
  TestInsight.DUnitX.RunRegisteredTests;
{$ELSE}
  try
    //Check command line options, will exit if invalid
    TDUnitX.CheckCommandLine;
    //Create the test runner
    runner := TDUnitX.CreateRunner;
    //Tell the runner to use RTTI to find Fixtures
    runner.UseRTTI := True;
    //When true, Assertions must be made during tests;
    runner.FailsOnNoAsserts := False;

    //tell the runner how we will log things
    //Log to the console window if desired
    if TDUnitX.Options.ConsoleMode <> TDunitXConsoleMode.Off then
    begin
      logger := TDUnitXConsoleLogger.Create(TDUnitX.Options.ConsoleMode = TDunitXConsoleMode.Quiet);
      runner.AddLogger(logger);
    end;
    //Generate an NUnit compatible XML File
    nunitLogger := TDUnitXXMLNUnitFileLogger.Create(TDUnitX.Options.XMLOutputFile);
    runner.AddLogger(nunitLogger);

    //Run tests
    Post.Register.RegisterTypes(GlobalContainer);
    vConexaoFirebird := GlobalContainer.Resolve<IConexaoFirebird>;
    vConexaoFirebird.Conectar;
    results := runner.Execute;
    if not results.AllPassed then
      System.ExitCode := EXIT_ERRORS;

    {$IFNDEF CI}
    //We don't want this happening when running under CI.
    if TDUnitX.Options.ExitBehavior = TDUnitXExitBehavior.Pause then
    begin
      System.Write('Done.. press <Enter> key to quit.');
      System.Readln;
    end;
    {$ENDIF}
  except
    on E: Exception do
      System.Writeln(E.ClassName, ': ', E.Message);
  end;
{$ENDIF}
end.
