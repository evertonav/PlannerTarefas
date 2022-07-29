program CadastroTarefas;

uses
  Vcl.Forms,
  Model.DAO.Cadastro.Interfaces in 'Model\DAO\Model.DAO.Cadastro.Interfaces.pas',
  Model.DAO.Cadastro in 'Model\DAO\Model.DAO.Cadastro.pas',
  Model.DAO.CadastroTarefas in 'Model\DAO\Model.DAO.CadastroTarefas.pas',
  Controller.Helper in '..\Controller\Controller.Helper.pas',
  Controller in 'Controller\Controller.pas',
  View.CadastroTarefas in 'View\View.CadastroTarefas.pas' {ViewCadastroTarefas},
  Model.Conexao.ConfiguracaoBanco in '..\Model\Conexao\Model.Conexao.ConfiguracaoBanco.pas',
  Model.Conexao.Feature in '..\Model\Conexao\Model.Conexao.Feature.pas',
  Model.Conexao.FireDac in '..\Model\Conexao\Model.Conexao.FireDac.pas',
  Model.Conexao.FireDac.PostGre in '..\Model\Conexao\Model.Conexao.FireDac.PostGre.pas',
  Model.Query.Feature in '..\Model\Query\Model.Query.Feature.pas',
  Model.Query.FireDac in '..\Model\Query\Model.Query.FireDac.pas',
  Model.DAO.Eventos.DataSet.Interfaces in '..\Model\Query\Model.DAO.Eventos.DataSet.Interfaces.pas',
  Model.DAO.Eventos.DataSet in '..\Model\Query\Model.DAO.Eventos.DataSet.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TViewCadastroTarefas, ViewCadastroTarefas);
  Application.Run;
end.
