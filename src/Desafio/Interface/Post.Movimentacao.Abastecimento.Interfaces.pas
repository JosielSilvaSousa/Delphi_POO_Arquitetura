unit Post.Movimentacao.Abastecimento.Interfaces;

interface
  {$M+}
uses System.Generics.Collections;

type

  IAbastecimentoModel = interface
    ['{CC888BF2-64CC-4AED-8EB6-DD86DA4DBEE9}']
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

  IAbastecimentoController = interface
    ['{25D7AB8F-4D63-4DDB-B6E4-74AF037FD238}']
    function Gravar(aModel:IAbastecimentoModel) : Boolean;
    function Excluir(aCodigo : Integer) : Boolean;
    function RetornarBomba(aBomba : Integer) : IAbastecimentoModel;
    function RetornarLista(aData: TDateTime): TList<IAbastecimentoModel>;
    function RetornarRelatorioLista: TList<IAbastecimentoModel>;
  end;

  IAbastecimentoRepository = interface
    ['{B365FB5C-B0EB-4E00-93DD-0CAE60FB7512}']
    function Inserir(aModel:IAbastecimentoModel) : Boolean;
    function Alterar(aModel:IAbastecimentoModel) : Boolean;
    function Excluir(aCodigo : Integer) : Boolean;
    function RetornarBomba(aBomba : Integer) : IAbastecimentoModel;
    function RetornarLista(aData: TDateTime): TList<IAbastecimentoModel>;
    function RetornarRelatorioLista: TList<IAbastecimentoModel>;
  end;

implementation

end.
