unit Post.Abastecimento.Conexao;

interface

uses
   FireDAC.Comp.Client,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.FB,
  FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait,
  FireDAC.DApt,
  Post.Abastecimento.Conexao.Interfaces;

Type
  TConexaoFirebird = class(TInterfacedObject, IConexaoFirebird)
  private
  FDConnection1: TFDConnection;
  public
    function Conectar : boolean;
    function Desconecta : boolean;
    Function RetorgarConexao: TFDConnection;
    constructor create;
    destructor Destroy; override;
  end;

implementation

{ TConexaoFirebird }

function TConexaoFirebird.Conectar: boolean;
begin
  FDConnection1.Connected := false;
  FDConnection1.Params.Add('DriverId=' + 'FB');
  FDConnection1.Params.Add('USER_NAME=' + 'SYSDBA');
  FDConnection1.Params.Add('PASSWORD=' + 'masterkey');
  FDConnection1.Params.Add('database=' + 'C:\ProjetoDelphi\src\Banco\POSTO.FDB');
  try
    FDConnection1.LoginPrompt := false;
    FDConnection1.Connected := true;
    result := true;
  except
    result := false;
  end;
end;

constructor TConexaoFirebird.create;
begin
 FDConnection1 := TFDConnection.Create(Nil);
end;

function TConexaoFirebird.Desconecta: boolean;
begin
  if assigned(FDConnection1) then
  begin
    FDConnection1.Connected := false;
    FDConnection1.Free;
  end;

end;

destructor TConexaoFirebird.Destroy;
begin
  if assigned(FDConnection1) then
  FDConnection1.Free;
  inherited;
end;

function TConexaoFirebird.RetorgarConexao: TFDConnection;
begin
 Result := FDConnection1;
end;

end.
