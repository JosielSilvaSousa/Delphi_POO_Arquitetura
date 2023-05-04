unit Post.Cadastro.Bomba.Repository;

interface

uses Post.Cadastro.Bomba.Interfaces,
     FireDAC.Comp.Client,
     System.Generics.Collections;

type
  TBombaReporitory = Class(TInterfacedObject, IBombaRepository)
  private
   FDQuery : TFDQuery;
  public
    function Inserir(aModel:IBombaModel) : Boolean;
    function Alterar(aModel:IBombaModel) : Boolean;
    function Excluir(aCodigo:Integer) : Boolean;
    function Retornar(aCodigo:Integer) : IBombaModel;
  End;

implementation
uses  Spring.Container,
       Post.Abastecimento.Conexao.Interfaces;

{ TBombaReporitory }

function TBombaReporitory.Alterar(aModel: IBombaModel): Boolean;
begin
 FDQuery := TFDQuery.Create(Nil);
 FDQuery.SQL.Clear;
 FDQuery.Connection := vConexaoFirebird.RetorgarConexao;
 FDQuery.SQL.Add('UPDATE BOMBA SET ID_COMBUSTIVEL =:PID_COMBUSTIVEL ');
 FDQuery.SQL.Add(' WHERE ID=:PID ');
 FDQuery.ParamByName('PID').AsInteger := aModel.Id;
 FDQuery.ParamByName('PID_COMBUSTIVEL').AsInteger := aModel.TipoCombustivel;
 try
  FDQuery.ExecSQL;
  Result := True;
 except
  Result := false;
 end;
 FDQuery.Free;
end;

function TBombaReporitory.Excluir(aCodigo: Integer): Boolean;
begin
 FDQuery := TFDQuery.Create(Nil);
 FDQuery.SQL.Clear;
 FDQuery.Connection := vConexaoFirebird.RetorgarConexao;
 FDQuery.SQL.Add('DELETE FROM BOMBA ');
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

function TBombaReporitory.Inserir(aModel: IBombaModel): Boolean;
begin
 FDQuery := TFDQuery.Create(Nil);
 FDQuery.SQL.Clear;
 FDQuery.Connection := vConexaoFirebird.RetorgarConexao;
 FDQuery.SQL.Add('INSERT INTO BOMBA (ID,ID_COMBUSTIVEL)');
 FDQuery.SQL.Add(' VALUES(:PID,:PID_COMBUSTIVEL)');
 FDQuery.ParamByName('PID_COMBUSTIVEL').AsInteger := aModel.TipoCombustivel;
 FDQuery.ParamByName('PID').AsInteger := aModel.Id;

  try
  FDQuery.ExecSQL;
  Result := True;
 except
  Result := false;
 end;

 FDQuery.Free;
end;

function TBombaReporitory.Retornar(aCodigo: Integer): IBombaModel;
begin

 Result := GlobalContainer.Resolve<IBombaModel>;
 FDQuery := TFDQuery.Create(Nil);
 FDQuery.SQL.Clear;
 FDQuery.Connection := vConexaoFirebird.RetorgarConexao;
 FDQuery.SQL.Add('SELECT  A.ID ,A.ID_COMBUSTIVEL,C.TIPO_COMBUSTIVEL as COMBUSTIVEL');
 FDQuery.SQL.Add(' FROM BOMBA a INNER JOIN COMBUSTIVEL C ON C.ID=A.ID_COMBUSTIVEL');
 FDQuery.SQL.Add(' WHERE A.ID =:ID');
 FDQuery.ParamByName('ID').asInteger := aCodigo;
 FDQuery.Open;


 Result.TipoCombustivel := FDQuery.FieldByName('ID_COMBUSTIVEL').AsInteger;
 Result.Id :=  FDQuery.FieldByName('ID').AsInteger;
 Result.Combustivel := FDQuery.FieldByName('COMBUSTIVEL').AsString;
 if Result.Id > 0 then
 Result.Existe := true
 else
 Result.Existe := false;

 FDQuery.Free;
end;

end.
