unit View.CadastroTarefas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask,
  Vcl.DBCtrls, Data.DB, Controller;

type
  TViewCadastroTarefas = class(TForm)
    pnlCabecalho: TPanel;
    pnlContainer: TPanel;
    pnlBotoesAcoes: TPanel;
    edtDataTarefa: TDBEdit;
    edtInicioTarefa: TDBEdit;
    edtFimTarefa: TDBEdit;
    edtTituloTarefa: TDBEdit;
    lblDataTarefa: TLabel;
    lblInicioTarefa: TLabel;
    lblFimTarefa: TLabel;
    lblTituloTarefa: TLabel;
    nvgCadastro: TDBNavigator;
    dsCadastroTarefas: TDataSource;
    lblCadastroTarefas: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FControllerCadastroTarefas: IController;
  public
    { Public declarations }
  end;

var
  ViewCadastroTarefas: TViewCadastroTarefas;

implementation


{$R *.dfm}

procedure TViewCadastroTarefas.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;
end;

procedure TViewCadastroTarefas.FormShow(Sender: TObject);
begin
  FControllerCadastroTarefas := TController.Criar;
  FControllerCadastroTarefas.CadastroTarefas(dsCadastroTarefas).Consultar;
end;

end.
