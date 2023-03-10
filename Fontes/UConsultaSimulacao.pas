unit UConsultaSimulacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, Vcl.ExtCtrls, Vcl.StdCtrls, cxButtons,
  Vcl.ComCtrls, LMDControl, LMDCustomControl, LMDCustomPanel,
  LMDCustomBevelPanel, LMDCustomParentPanel, LMDCustomPanelFill, LMDPanelFill,
  Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, ppDB, ppDBPipe, ppDBBDE, ppComm, ppRelatv, ppProd,
  ppClass, ppReport, ppBands, ppCache, ppDesignLayer, ppParameter, ppCtrls,
  ppVar, ppPrnabl, cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxButtonEdit;

type
  TFrmConsultaSimulacao = class(TForm)
    StatusBar1: TStatusBar;
    pnlBotoes: TLMDPanelFill;
    btnCancelar: TcxButton;
    btnSair: TcxButton;
    btnPesquisar: TcxButton;
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    btnImprimir: TcxButton;
    qryconsulta: TFDQuery;
    dsconsulta: TDataSource;
    qryconsultaCODIGO_PRODUTO: TIntegerField;
    qryconsultaPRECO_COMPRA: TSingleField;
    qryconsultaPERC_ICMS: TSingleField;
    qryconsultaPERC_FRETE: TSingleField;
    qryconsultaPERC_OUTRAS_DESPESAS: TSingleField;
    qryconsultaPERC_IPI: TSingleField;
    qryconsultaPERC_PIS: TSingleField;
    qryconsultaPERC_COFINS: TSingleField;
    qryconsultaMARKUP: TSingleField;
    qryconsultaPRECO_SUGERIDO: TSingleField;
    qryconsultaCUSTO_FINAL: TSingleField;
    qryconsultaSUB_TRIBUTARIA: TSingleField;
    pnlTopo: TLMDPanelFill;
    txtdescricao: TEdit;
    Panel16: TPanel;
    ppReport1: TppReport;
    ppBDEPipeline1: TppBDEPipeline;
    ppParameterList1: TppParameterList;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppLabel1: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppSystemVariable2: TppSystemVariable;
    ppLabel2: TppLabel;
    ppDBText1: TppDBText;
    ppLabel3: TppLabel;
    ppDBText2: TppDBText;
    ppLabel4: TppLabel;
    ppDBText3: TppDBText;
    pnlTitulo: TLMDPanelFill;
    ppLine1: TppLine;
    ppLabel5: TppLabel;
    ppDBText4: TppDBText;
    ppLabel6: TppLabel;
    ppLabel7: TppLabel;
    ppLabel8: TppLabel;
    ppLabel9: TppLabel;
    ppLabel10: TppLabel;
    ppLabel11: TppLabel;
    ppDBText6: TppDBText;
    ppDBText7: TppDBText;
    ppDBText8: TppDBText;
    ppDBText9: TppDBText;
    ppDBText10: TppDBText;
    ppDBText11: TppDBText;
    ppLabel12: TppLabel;
    ppDBText12: TppDBText;
    txtcodproduto: TcxButtonEdit;
    qryaux: TFDQuery;
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure txtcodprodutoExit(Sender: TObject);
    procedure txtcodprodutoPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmConsultaSimulacao: TFrmConsultaSimulacao;

implementation

  uses Udados, UFuncoes, UConsultaProduto;

{$R *.dfm}

procedure TFrmConsultaSimulacao.btnCancelarClick(Sender: TObject);
begin
  qryconsulta.Close;
  txtcodproduto.Text := '';
  txtdescricao.Text  :=''
end;

procedure TFrmConsultaSimulacao.btnImprimirClick(Sender: TObject);
begin
   if qryconsulta.RecordCount > 0 then
      ppReport1.Print
   else
   begin
     ShowMessage('N?o existe dados para gerar o relatorio!');
     exit;
   end;
end;

procedure TFrmConsultaSimulacao.btnPesquisarClick(Sender: TObject);
begin
   qryconsulta.Close;
   qryconsulta.SQL.add ( ' SELECT *                               ');
   qryconsulta.SQL.add ( '       from simulacao_preco             ');
   qryconsulta.SQL.add ( iif(txtcodproduto.Text <> '' , ' WHERE codigo_produto = '+ txtcodproduto.Text, ''));
   qryconsulta.Open();
end;

procedure TFrmConsultaSimulacao.btnSairClick(Sender: TObject);
begin
   close;
end;

procedure TFrmConsultaSimulacao.txtcodprodutoExit(Sender: TObject);
begin
   if txtcodproduto.Text <> '' then
   begin
       qryaux.Close;
       qryaux.SQL.Text := ' select descricao_prod from produto where codigo_produto ='+txtcodproduto.Text;
       qryaux.Open();
       if qryaux.RecordCount > 0 then
          txtdescricao.Text := qryaux.FieldByName('descricao_prod').AsString;

   end;
end;

procedure TFrmConsultaSimulacao.txtcodprodutoPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
   Application.CreateForm(TFrmConsultaProduto,FrmConsultaProduto );
   FrmConsultaProduto.ShowModal;
   FrmConsultaProduto.Free;
end;

end.
