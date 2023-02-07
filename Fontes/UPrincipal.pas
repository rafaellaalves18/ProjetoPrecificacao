unit UPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus;

type
  TFrmPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    Cadastros1: TMenuItem;
    CadastrodeProduto1: TMenuItem;
    SimulaodePreo1: TMenuItem;
    Consulta1: TMenuItem;
    ConsultaSimulaodePreo1: TMenuItem;
    Sair1: TMenuItem;
    procedure Sair1Click(Sender: TObject);
    procedure SimulaodePreo1Click(Sender: TObject);
    procedure CadastrodeProduto1Click(Sender: TObject);
    procedure ConsultaSimulaodePreo1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }

  public

    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

Uses USimulacaoPreco, UCadProduto , UConsultaSimulacao;

{$R *.dfm}

procedure TFrmPrincipal.CadastrodeProduto1Click(Sender: TObject);
begin
   Application.CreateForm(TFrmCadProduto,FrmCadProduto );
   FrmCadProduto.ShowModal;

end;

procedure TFrmPrincipal.ConsultaSimulaodePreo1Click(Sender: TObject);
var consulta : TFrmConsultaSimulacao ;
begin
   consulta := TFrmConsultaSimulacao.Create(self);
   consulta.ShowModal;

end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
   Application.CreateForm(TFrmConsultaSimulacao,FrmConsultaSimulacao );
   FrmConsultaSimulacao.ShowModal;
   FrmConsultaSimulacao.Free;
end;

procedure TFrmPrincipal.Sair1Click(Sender: TObject);
begin
   Close;
end;

procedure TFrmPrincipal.SimulaodePreo1Click(Sender: TObject);
begin
   Application.CreateForm(TFrmSimulacaoPreco,FrmSimulacaoPreco );
   FrmSimulacaoPreco.ShowModal;

end;

end.
