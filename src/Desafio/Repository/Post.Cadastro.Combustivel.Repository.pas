unit Post.Cadastro.Combustivel.Repository;

interface

uses Post.Cadastro.Combustivel.Interfaces,
     System.Generics.Collections,
     FireDAC.Comp.Client;

type
  TCombustivelReporitory = Class(TInterfacedObject, ICombustivelRepository)
  private
  FDQuery : TFDQuery;
  public
    function Inserir(aModel:ICombustivelModel) : Boolean;
    function Alterar(aModel:ICombustivelModel) : Boolean;
    function Excluir(aCodigo : Integer) : Boolean;
    function Retornar(aCodigo : Integer) : ICombustivelModel;
    constructor create;
    destructor Destroy;Override;
  End;

implementation
 uses Spring.Container,
 Post.Abastecimento.Conexao.Interfaces;

{ TCombustivelReporitory }

function TCombustivelReporitory.Alterar(aModel: ICombustivelModel): Boolean;
begin
 FDQuery := TFDQuery.Create(Nil);
 FDQuery.SQL.Clear;
 FDQuery.Connection := vConexaoFirebird.RetorgarConexao;
 FDQuery.SQL.Add('UPDATE COMBUSTIVEL SET TIPO_COMBUSTIVEL =:PTIPO_COMBUSTIVEL, ');
 FDQuery.SQL.Add(' VALOR =:VALOR WHERE ID=:PID');
 FDQuery.ParamByName('PID').AsInteger := aModel.Id;
 FDQuery.ParamByName('PTIPO_COMBUSTIVEL').AsString := aModel.TipoCombustivel;
 FDQuery.ParamByName('PTIPO_COMBUSTIVEL').AsFloat := aModel.Valor;
 try
  FDQuery.ExecSQL;
  Result := True;
 except
  Result := false;
 end;

 FDQuery.Free;
end;

constructor TCombustivelReporitory.create;
begin

end;

destructor TCombustivelReporitory.Destroy;
begin
end;

function TCombustivelReporitory.Excluir(aCodigo: Integer): Boolean;
begin
 FDQuery := TFDQuery.Create(Nil);
 FDQuery.SQL.Clear;
 FDQuery.Connection := vConexaoFirebird.RetorgarConexao;
 FDQuery.SQL.Add('DELETE FROM COMBUSTIVEL ');
 FDQuery.SQL.Add(' WHERE ID=:PID');
 FDQuery.ParamByName('PID').AsInteger := aCodigo;
 try
  FDQuery.ExecSQL;
  Result := True;
 except
  Result := false;
 end;

 FDQuery.Free;
end;

function TCombustivelReporitory.Inserir(aModel: ICombustivelModel): Boolean;
begin
  FDQuery := TFDQuery.Create(Nil);
  FDQuery.SQL.Clear;
  FDQuery.Connection := vConexaoFirebird.RetorgarConexao;
  FDQuery.SQL.Add('INSERT INTO COMBUSTIVEL (ID,TIPO_COMBUSTIVEL,VALOR,TANQUE)');
  FDQuery.SQL.Add(' VALUES(:PID,:PCOMBUSTIVEL,:PVALOR,:PTANQUE)');
  FDQuery.ParamByName('PCOMBUSTIVEL').AsString := aModel.TipoCombustivel;
  FDQuery.ParamByName('PVALOR').AsFloat := aModel.Valor;
  FDQuery.ParamByName('PID').AsFloat := aModel.Id;
  FDQuery.ParamByName('PTANQUE').AsString := aModel.Tanque;

  try
    FDQuery.ExecSQL;
    Result := True;
  except
    Result := false;
  end;
  FDQuery.Free;
end;

function TCombustivelReporitory.Retornar(aCodigo: Integer): ICombustivelModel;
begin
 FDQuery := TFDQuery.Create(Nil);
 Result := GlobalContainer.Resolve<ICombustivelModel>;
 FDQuery.Connection := vConexaoFirebird.RetorgarConexao;
 FDQuery.SQL.Clear;
 FDQuery.SQL.Add('SELECT ID,TIPO_COMBUSTIVEL,VALOR,TANQUE FROM COMBUSTIVEL');
 FDQuery.SQL.Add(' WHERE ID =:ID');
 FDQuery.ParamByName('ID').asInteger := aCodigo;
 FDQuery.Open;

 Result.TipoCombustivel := FDQuery.FieldByName('TIPO_COMBUSTIVEL').AsString;
 Result.Id :=  FDQuery.FieldByName('ID').AsInteger;
 Result.Valor := FDQuery.FieldByName('VALOR').AsFloat;
 Result.Tanque := FDQuery.FieldByName('TANQUE').AsString;

 if Result.Id > 0 then
 Result.Existe := true
 else
 Result.Existe := false;

 FDQuery.Free;
end;

end.
