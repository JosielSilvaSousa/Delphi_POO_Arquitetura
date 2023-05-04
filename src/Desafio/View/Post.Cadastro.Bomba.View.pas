unit Post.Cadastro.Bomba.View;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Post.Cadastro.Bomba.Interfaces,
  Post.Formulario.Heranca, Vcl.Mask;


type
  TfrmBomba = class(TfrmHeranca)
    Panel1: TPanel;
    edtCombustivel: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Panel2: TPanel;
    Button1: TButton;
    Button2: TButton;
    edtCodigo: TMaskEdit;
    edtIdCombustivel: TMaskEdit;
    Label3: TLabel;
    procedure FormShow(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
   FController : IBombaController;
   FModel  :IBombaModel;
    procedure Limpar;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBomba: TfrmBomba;

implementation
uses Spring.Container;

{$R *.dfm}

procedure TfrmBomba.Button1Click(Sender: TObject);
begin
  FModel.TipoCombustivel := StrToInt(trim(edtIdCombustivel.Text));
  FModel.Id := StrToIntDef(trim(edtCodigo.Text),0);
  var Retorno := FController.Gravar(FModel);

  if Retorno then
  begin
   ShowMessage('Operação realizada com sucesso!');
   Limpar;
  end
  else
   ShowMessage('Erro ao gravar!');

end;
procedure TfrmBomba.Limpar;
begin
  edtIdCombustivel.clear;
  edtCodigo.clear;
  edtCombustivel.Clear;
end;

procedure TfrmBomba.Button2Click(Sender: TObject);
begin
 if edtCodigo.Text = Emptystr then
  begin
    ShowMessage('Necessário informar um código');
    exit;
  end;
  var
  Retorno := FController.Excluir(StrToInt(trim(edtCodigo.Text)));

  if Retorno then
  begin
    ShowMessage('Excluido com  sucesso!');
    Limpar;
  end
  else
    ShowMessage('Erro ao excluir cadastro!');

end;

procedure TfrmBomba.edtCodigoExit(Sender: TObject);
begin
 if edtCodigo.Text <> Emptystr then
  begin
    FModel := FController.Retornar(StrToInt(trim(edtCodigo.Text)));
    edtCombustivel.Text := FModel.Combustivel;
    edtIdCombustivel.Text := IntToStr(FModel.TipoCombustivel);
  end;

end;

procedure TfrmBomba.FormShow(Sender: TObject);
begin
 inherited;
 FController := GlobalContainer.Resolve<IBombaController>;
 FModel  := GlobalContainer.Resolve<IBombaModel>;
end;

end.
