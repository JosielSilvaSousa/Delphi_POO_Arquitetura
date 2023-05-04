unit Post.Movimentacao.Abastecimento.Repository;

interface

uses Post.Movimentacao.Abastecimento.Interfaces,
     System.Generics.Collections,
     FireDAC.Comp.Client;

type
  TAbastecimentoReporitory = Class(TInterfacedObject, IAbastecimentoRepository)
  private
  FDQuery : TFDQuery;
  public
    function Inserir(aModel:IAbastecimentoModel) : Boolean;
    function Alterar(aModel:IAbastecimentoModel) : Boolean;
    function Excluir(aCodigo : Integer) : Boolean;
    function RetornarLista(aData: TDateTime): TList<IAbastecimentoModel>;
    function RetornarRelatorioLista: TList<IAbastecimentoModel>;
    function RetornarBomba(aBomba : Integer) : IAbastecimentoModel;
  End;

implementation
 uses
 Post.Abastecimento.Conexao.Interfaces,
 Spring.Container;


{ TAbastecimentoReporitory }

function TAbastecimentoReporitory.Alterar(aModel: IAbastecimentoModel): Boolean;
begin
  FDQuery := TFDQuery.Create(Nil);
  FDQuery.SQL.Clear;
  FDQuery.Connection := vConexaoFirebird.RetorgarConexao;
  FDQuery.SQL.Add('UPDATE ABASTECIMENTO SET BOMBA =:PBOMBA,VALOR_TOTAL=:PVALOR_TOTAL,');
  FDQuery.SQL.Add(' IMPOSTO =:PIMPOSTO,VALOR=:PVALOR,TIPO_COMBUSTIVEL=:PTIPO_COMBUSTIVEL ');
  FDQuery.SQL.Add(' WHERE ID=:PID');
  FDQuery.ParamByName('PID').AsInteger := aModel.Id;
  FDQuery.ParamByName('PBOMBA').AsInteger := aModel.Bomba;
  FDQuery.ParamByName('PVALOR_TOTAL').AsFloat := aModel.ValorTotal;
  FDQuery.ParamByName('PIMPOSTO').AsFloat := aModel.Tributo;
  FDQuery.ParamByName('PVALOR').AsFloat := aModel.Valor;
  FDQuery.ParamByName('PTIPO_COMBUSTIVEL').AsString := aModel.TipoCombustivel;
  try
    FDQuery.ExecSQL;
    Result := True;
  except
    Result := false;
  end;
end;

function TAbastecimentoReporitory.Excluir(aCodigo: Integer): Boolean;
begin

 FDQuery := TFDQuery.Create(Nil);
 FDQuery.SQL.Clear;
 FDQuery.Connection := vConexaoFirebird.RetorgarConexao;
 FDQuery.SQL.Add('DELETE FROM ABASTECIMENTO ');
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

function TAbastecimentoReporitory.Inserir(aModel: IAbastecimentoModel): Boolean;
begin
  FDQuery := TFDQuery.Create(Nil);
  FDQuery.SQL.Clear;
  FDQuery.Connection := vConexaoFirebird.RetorgarConexao;
  FDQuery.SQL.Add('INSERT INTO ABASTECIMENTO (BOMBA,VALOR_TOTAL,IMPOSTO,VALOR,TIPO_COMBUSTIVEL,DATA,LITROS,TANQUE)');
  FDQuery.SQL.Add(' VALUES(:PBOMBA,:PVALOR_TOTAL,:PIMPOSTO,:PVALOR,:PTIPO_COMBUSTIVEL,:PDATA,:PLITROS,:PTANQUE)');
  FDQuery.ParamByName('PBOMBA').AsInteger := aModel.Bomba;
  FDQuery.ParamByName('PVALOR_TOTAL').AsFloat := aModel.ValorTotal;
  FDQuery.ParamByName('PIMPOSTO').AsFloat := aModel.Tributo;
  FDQuery.ParamByName('PVALOR').AsFloat := aModel.Valor;
  FDQuery.ParamByName('PTIPO_COMBUSTIVEL').AsString := aModel.TipoCombustivel;
  FDQuery.ParamByName('PDATA').AsDate := aModel.Data;
  FDQuery.ParamByName('PLITROS').AsFloat := aModel.liTros;
  FDQuery.ParamByName('PTANQUE').AsString := aModel.Tanque;

  try
    FDQuery.ExecSQL;
    Result := True;
  except
    Result := false;
  end;
  FDQuery.Free;
end;

function TAbastecimentoReporitory.RetornarLista(aData: TDateTime): TList<IAbastecimentoModel>;
begin
  FDQuery := TFDQuery.Create(Nil);
  Result := TList<IAbastecimentoModel>.create;
  FDQuery.SQL.Clear;
  FDQuery.Connection := vConexaoFirebird.RetorgarConexao;
  FDQuery.SQL.Add('SELECT ID,BOMBA,VALOR_TOTAL,IMPOSTO,VALOR,TIPO_COMBUSTIVEL,DATA FROM ABASTECIMENTO');
  FDQuery.SQL.Add(' WHERE DATA =:PDATA');
  FDQuery.ParamByName('PDATA').AsDate := Trunc(aData);
  FDQuery.Open;

  while not FDQuery.Eof do
  begin
    Var
    vModel := GlobalContainer.Resolve<IAbastecimentoModel>;
    vModel.TipoCombustivel := FDQuery.FieldByName('TIPO_COMBUSTIVEL').AsString;
    vModel.Id := FDQuery.FieldByName('ID').AsInteger;
    vModel.Valor := FDQuery.FieldByName('VALOR').AsFloat;
    vModel.ValorTotal := FDQuery.FieldByName('VALOR_TOTAL').AsFloat;
    vModel.Bomba := FDQuery.FieldByName('BOMBA').AsInteger;
    vModel.Data := FDQuery.FieldByName('DATA').AsDateTime;
    vModel.Tributo := FDQuery.FieldByName('IMPOSTO').AsInteger;
    Result.Add(vModel);
    FDQuery.Next;
  end;
  FDQuery.Free;
end;

function TAbastecimentoReporitory.RetornarRelatorioLista : TList<IAbastecimentoModel>;
begin
  FDQuery := TFDQuery.Create(Nil);
  Result := TList<IAbastecimentoModel>.create;
  FDQuery.SQL.Clear;
  FDQuery.Connection := vConexaoFirebird.RetorgarConexao;
  FDQuery.SQL.Add('SELECT DATA,TANQUE,BOMBA,VALOR_TOTAL FROM ABASTECIMENTO');
  FDQuery.Open;

  while not FDQuery.Eof do
  begin
    Var
    vModel := GlobalContainer.Resolve<IAbastecimentoModel>;
    vModel.Data := FDQuery.FieldByName('DATA').AsDateTime;
    vModel.Tanque := FDQuery.FieldByName('TANQUE').AsString;
    vModel.ValorTotal := FDQuery.FieldByName('VALOR_TOTAL').AsFloat;
    vModel.Bomba := FDQuery.FieldByName('BOMBA').AsInteger;
    Result.Add(vModel);
    FDQuery.Next;
  end;
  FDQuery.Free;
end;

function TAbastecimentoReporitory.RetornarBomba(aBomba: Integer): IAbastecimentoModel;
begin
  FDQuery := TFDQuery.Create(Nil);
  Result := GlobalContainer.Resolve<IAbastecimentoModel>;
  FDQuery.SQL.Clear;
  FDQuery.Connection := vConexaoFirebird.RetorgarConexao;
  FDQuery.SQL.Add('SELECT  A.ID ,C.TIPO_COMBUSTIVEL ,C.VALOR,C.TANQUE');
  FDQuery.SQL.Add(' FROM BOMBA A INNER JOIN COMBUSTIVEL C ON C.ID =A.ID_COMBUSTIVEL');
  FDQuery.SQL.Add(' WHERE A.ID =:PID');
  FDQuery.ParamByName('PID').AsInteger := aBomba;
  FDQuery.Open;

  if not FDQuery.IsEmpty then
  begin
    Result.TipoCombustivel := FDQuery.FieldByName('TIPO_COMBUSTIVEL').AsString;
    Result.Valor := FDQuery.FieldByName('VALOR').AsFloat;
    Result.Bomba := FDQuery.FieldByName('ID').AsInteger;
    Result.Tanque := FDQuery.FieldByName('TANQUE').AsString;
  end;
  FDQuery.Free;
end;

end.
