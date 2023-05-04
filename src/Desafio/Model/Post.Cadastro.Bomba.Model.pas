unit Post.Cadastro.Bomba.Model;

interface

uses Post.Cadastro.Bomba.Interfaces;

type
  TBombaModel = class(TInterfacedObject, IBombaModel)
  private
    FId: Integer;
    FTipoCombustivel: Integer;
    FExiste: Boolean;
    FCombustivel: String;
    procedure SetId(const Value: Integer);
    procedure SetTipoCombustivel(const Value: Integer);
    procedure SetExiste(const Value: Boolean);
    function GetId: Integer;
    function GetTipoCombustivel: Integer;
    function GetExiste: Boolean;
    procedure SetCombustivel(const Value: String);
    function GetCombustivel: String;
  public
    property Id: Integer read GetId write SetId;
    property TipoCombustivel: Integer read GetTipoCombustivel write SetTipoCombustivel;
    property Existe: Boolean read GetExiste write SetExiste;
    property Combustivel : String read GetCombustivel write SetCombustivel;

  end;

implementation

{ TBombaModel }

function TBombaModel.GetCombustivel: String;
begin
 Result := FCombustivel;
end;

function TBombaModel.GetExiste: Boolean;
begin
  Result := FExiste;
end;

function TBombaModel.GetId: Integer;
begin
  Result := FId;
end;

function TBombaModel.GetTipoCombustivel: Integer;
begin
  Result := FTipoCombustivel;
end;

procedure TBombaModel.SetCombustivel(const Value: String);
begin
  FCombustivel := Value;
end;

procedure TBombaModel.SetExiste(const Value: Boolean);
begin
  FExiste := Value;
end;

procedure TBombaModel.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TBombaModel.SetTipoCombustivel(const Value: Integer);
begin
  FTipoCombustivel := Value;
end;

end.
