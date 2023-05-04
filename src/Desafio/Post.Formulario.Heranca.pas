unit Post.Formulario.Heranca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TfrmHeranca = class(TForm)
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmHeranca: TfrmHeranca;

implementation

{$R *.dfm}

procedure TfrmHeranca.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    self.Perform(WM_NextDlgCtl, 0, 0);
  end;
  if (Key = #27) then
  begin
    Key := #0;
    self.Perform(WM_NextDlgCtl, 1, 0);
  end;
end;

end.
