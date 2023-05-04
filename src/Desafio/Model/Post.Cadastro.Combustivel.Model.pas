unit Post.Cadastro.Combustivel.Model;

interface
uses Post.Cadastro.Combustivel.Interfaces;
type
 TCombustivelModel = Class(TInterfacedObject,ICombustivelModel)
   private
    FValor: Double;
    FId: Integer;
    FTipoCombustivel : String;
    FExiste : Boolean;
    FTanque: String;
    procedure SetId(const Value: Integer);
    procedure SetTipoCombustivel(const Value: String);
    procedure SetExiste(const Value: Boolean);
    function GetId: Integer;
    function GetTipoCombustivel: String;
    function GetExiste: Boolean;
    function GetValor: Double;
    procedure SetValor(const Value: Double);
    procedure SetTanque(const Value: String);
    function GetTanque: String;
  public
    property Id: Integer read GetId write SetId;
    property TipoCombustivel: String read GetTipoCombustivel write SetTipoCombustivel;
    property Valor: Double read GetValor write SetValor;
    property Existe: Boolean read GetExiste write SetExiste;
    property Tanque : String read GetTanque write SetTanque;
 End;

implementation

{ TCombustivelModel }

function TCombustivelModel.GetExiste: Boolean;
begin
  Result := FExiste;
end;

function TCombustivelModel.GetId: Integer;
begin
 Result := FId;
end;

function TCombustivelModel.GetTanque: String;
begin
  Result := FTanque;
end;

function TCombustivelModel.GetTipoCombustivel: String;
begin
 Result := FTipoCombustivel;
end;

function TCombustivelModel.GetValor: Double;
begin
 Result := FValor;
end;

procedure TCombustivelModel.SetExiste(const Value: Boolean);
begin
 FExiste := Value;
end;

procedure TCombustivelModel.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TCombustivelModel.SetTanque(const Value: String);
begin
  FTanque := Value;
end;

procedure TCombustivelModel.SetTipoCombustivel(const Value: String);
begin
 FTipoCombustivel := Value;
end;

procedure TCombustivelModel.SetValor(const Value: Double);
begin
  FValor := Value;
end;

end.
