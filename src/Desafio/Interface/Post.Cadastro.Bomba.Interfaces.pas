unit Post.Cadastro.Bomba.Interfaces;

interface
 {$M+}
uses System.Generics.Collections;

type

  IBombaModel = interface
    ['{267BDD0D-770B-422D-8376-993513B7071E}']
    procedure SetId(const Value: Integer);
    procedure SetTipoCombustivel(const Value: Integer);
    procedure SetExiste(const Value: Boolean);
    function GetId: Integer;
    function GetTipoCombustivel: Integer;
    function GetExiste: Boolean;
    procedure SetCombustivel(const Value: String);
    function GetCombustivel: String;
    property Id: Integer read GetId write SetId;
    property TipoCombustivel: Integer read GetTipoCombustivel write SetTipoCombustivel;
    property Existe: Boolean read GetExiste write SetExiste;
    property Combustivel : String read GetCombustivel write SetCombustivel;
  end;

  IBombaController = interface
   ['{93B9BE95-57BD-49B9-8255-69F991AFDB49}']
    function Gravar(aModel:IBombaModel) : Boolean;
    function Excluir(aCodigo : Integer) : Boolean;
    function Retornar(aCodigo : Integer) : IBombaModel;
  end;

  IBombaRepository = interface
    ['{665AE451-07D8-4D59-9D5B-4CB49DEFE167}']
    function Inserir(aModel:IBombaModel) : Boolean;
    function Alterar(aModel:IBombaModel) : Boolean;
    function Excluir(aCodigo:Integer) : Boolean;
    function Retornar(aCodigo:Integer) : IBombaModel;
  end;

implementation

end.
