unit Post.Movimentacao.Abastecimento.Model;

interface
uses
 Post.Movimentacao.Abastecimento.Interfaces;

type
  TAbastecimentoModel = Class(TInterfacedObject, IAbastecimentoModel)
  private
    FId: Integer;
    FTipoCombustivel: String;
    FExiste: Boolean;
    FBomba: Integer;
    FValor: Double;
    FValorTotal: Double;
    FTributo: Double;
    FData: TDateTime;
    FLitros: Double;
    FTanque: String;
    procedure SetId(const Value: Integer);
    procedure SetExiste(const Value: Boolean);
    function GetId: Integer;
    function GetExiste: Boolean;
    procedure SetBomba(const Value: Integer);
    procedure SetTipoCombustivel(const Value: String);
    procedure SetTributo(const Value: Double);
    procedure SetValor(const Value: Double);
    procedure SetValorTotal(const Value: Double);
    function GetBomba: Integer;
    function GetTipoCombustivel: String;
    function GetTributo: Double;
    function GetValor: Double;
    function GetValorTotal: Double;
    procedure SetData(const Value: TDateTime);
    function GetData: TDateTime;
    procedure SetLitros(const Value: Double);
    function GetLitros: Double;
    procedure SetTanque(const Value: String);
    function GetTanque: String;
  public
    property Id: Integer read GetId write SetId;
    property Bomba : Integer read GetBomba write SetBomba;
    property ValorTotal : Double read GetValorTotal write SetValorTotal;
    property Valor : Double read GetValor write SetValor;
    property TipoCombustivel : String read GetTipoCombustivel write SetTipoCombustivel;
    property Tributo : Double read GetTributo write SetTributo;
    property Data : TDateTime read GetData write SetData;
    property Existe: Boolean read GetExiste write SetExiste;
    property Litros : Double read GetLitros write SetLitros;
    property Tanque : String read GetTanque write SetTanque;

  end;

implementation

{ TBombaModel }

function TAbastecimentoModel.GetBomba: Integer;
begin
 Result := FBomba;
end;

function TAbastecimentoModel.GetData: TDateTime;
begin
 Result := FData;
end;

function TAbastecimentoModel.GetExiste: Boolean;
begin
  Result := FExiste;
end;

function TAbastecimentoModel.GetId: Integer;
begin
  Result := FId;
end;

function TAbastecimentoModel.GetLitros: Double;
begin
 result := FLitros;
end;

function TAbastecimentoModel.GetTanque: String;
begin
 result := FTanque;
end;

function TAbastecimentoModel.GetTipoCombustivel: String;
begin
 Result := FTipoCombustivel;
end;

function TAbastecimentoModel.GetTributo: Double;
begin
 Result := FTributo;
end;

function TAbastecimentoModel.GetValor: Double;
begin
 Result := FValor;
end;

function TAbastecimentoModel.GetValorTotal: Double;
begin
 Result := FValorTotal;
end;

procedure TAbastecimentoModel.SetBomba(const Value: Integer);
begin
  FBomba := Value;
end;

procedure TAbastecimentoModel.SetData(const Value: TDateTime);
begin
  FData := Value;
end;

procedure TAbastecimentoModel.SetExiste(const Value: Boolean);
begin
  FExiste := Value;
end;

procedure TAbastecimentoModel.SetId(const Value: Integer);
begin
  FId := Value;
end;
procedure TAbastecimentoModel.SetLitros(const Value: Double);
begin
  FLitros := Value;
end;

procedure TAbastecimentoModel.SetTanque(const Value: String);
begin
  FTanque := Value;
end;

procedure TAbastecimentoModel.SetTipoCombustivel(const Value: String);
begin
  FTipoCombustivel := Value;
end;

procedure TAbastecimentoModel.SetTributo(const Value: Double);
begin
  FTributo := Value;
end;

procedure TAbastecimentoModel.SetValor(const Value: Double);
begin
  FValor := Value;
end;

procedure TAbastecimentoModel.SetValorTotal(const Value: Double);
begin
  FValorTotal := Value;
end;

end.
