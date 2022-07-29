program PlannerTrabalho;

uses
  System.StartUpCopy,
  FMX.Forms,
  View.Funcionalidades.InserirTIcketTarefa in 'View\Funcionalidades\View.Funcionalidades.InserirTIcketTarefa.pas',
  uFrameTIcket in 'View\uFrameTIcket.pas' {FrameTicket: TFrame},
  View.DiaSemana in 'View\View.DiaSemana.pas',
  Controller.Helper in 'Controller\Controller.Helper.pas',
  Controller in 'Controller\Controller.pas',
  Controller.TipoDados.Utils in 'Controller\Controller.TipoDados.Utils.pas',
  Controller.Utils in 'Controller\Controller.Utils.pas',
  Model.Conexao.ConfiguracaoBanco in 'Model\Conexao\Model.Conexao.ConfiguracaoBanco.pas',
  Model.DAO.BuscarTarefas in 'Model\DAO\Model.DAO.BuscarTarefas.pas',
  Model.Query.Feature in 'Model\Query\Model.Query.Feature.pas',
  Model.Query.FireDac in 'Model\Query\Model.Query.FireDac.pas',
  View.Planner in 'View\View.Planner.pas' {ViewPlanner},
  Model.Conexao.Feature in 'Model\Conexao\Model.Conexao.Feature.pas',
  Model.Conexao.FireDac in 'Model\Conexao\Model.Conexao.FireDac.pas',
  Model.Conexao.FireDac.PostGre in 'Model\Conexao\Model.Conexao.FireDac.PostGre.pas',
  Model.DAO.Eventos.DataSet.Interfaces in 'Model\Query\Model.DAO.Eventos.DataSet.Interfaces.pas',
  Model.DAO.Eventos.DataSet in 'Model\Query\Model.DAO.Eventos.DataSet.pas',
  View.Funcionalidades.InserirTotalizadorEsforco in 'View\Funcionalidades\View.Funcionalidades.InserirTotalizadorEsforco.pas',
  uFrameTotalizadorEsforco in 'View\uFrameTotalizadorEsforco.pas' {frmTotalizadorEsforco: TFrame},
  VariaveisGlobal in 'Controller\VariaveisGlobal.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TViewPlanner, ViewPlanner);
  Application.Run;
end.
