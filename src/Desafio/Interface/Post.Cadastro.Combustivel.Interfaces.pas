unit Post.Cadastro.Combustivel.Interfaces;

interface
 {$M+}
uses System.Generics.Collections;

type
  ICombustivelModel = interface
    ['{1CB81993-0554-4C87-A620-D8634EB8F06D}']
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
    property Id: Integer read GetId write SetId;
    property TipoCombustivel: String read GetTipoCombustivel write SetTipoCombustivel;
    property Valor: Double read GetValor write SetValor;
    property Existe: Boolean read GetExiste write SetExiste;
    property Tanque : String read GetTanque write SetTanque;
  end;

  ICombustivelController = interface
    ['{31D3E9B2-D447-465D-92B3-6F4810580930}']
    function Gravar(aModel:ICombustivelModel) : Boolean;
    function Excluir(aCodigo : Integer) : Boolean;
    function Retornar(aCodigo : Integer) : ICombustivelModel;
  end;

  ICombustivelRepository = interface
    ['{1B13A5DA-C255-4EBD-BD83-4A43FA856451}']
    function Inserir(aModel:ICombustivelModel) : Boolean;
    function Alterar(aModel:ICombustivelModel) : Boolean;
    function Excluir(aCodigo : Integer) : Boolean;
    function Retornar(aCodigo : Integer) : ICombustivelModel;
  end;

implementation

end.
