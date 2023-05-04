unit Post.Abastecimento.Conexao.Interfaces;

interface
uses FireDAC.Comp.Client;

type
  IConexaoFirebird = Interface
    ['{E6064204-6118-4F82-A587-EBD5AC167689}']
    function Conectar : boolean;
    function Desconecta : boolean;
    Function RetorgarConexao: TFDConnection;
  End;

  var vConexaoFirebird : IConexaoFirebird;

implementation

end.
