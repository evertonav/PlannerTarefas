unit Model.DAO.BuscarTarefas;

interface

uses
  Data.DB,
  Model.Query.Feature,
  Controller.Helper;

type
  IModelDAOBuscarTarefa = Interface
    ['{0058F9AA-13ED-447A-9A91-F71B193BC1D9}']
    function DiaTarefa(const pValor: TDate): IModelDAOBuscarTarefa;
    function NomeTarefa(const pValor: string): IModelDAOBuscarTarefa;
    function Executar: TDataSet;
  End;

  TModelDAOBuscarTarefas = class(TInterfacedObject, IModelDAOBuscarTarefa)
  private
    FDiaTarefa: TDate;
    FQuery: IModelQueryFeature;
    FNomeTarefa: string;

    function AdicionarWhereSQL(const pSQL: string): string;
  public
    constructor Create;

    class function Criar: IModelDAOBuscarTarefa;

    function DiaTarefa(const pValor: TDate): IModelDAOBuscarTarefa;
    function NomeTarefa(const pValor: string): IModelDAOBuscarTarefa;
    function Executar: TDataSet;
  end;

implementation

uses
  System.SysUtils,
  VariaveisGlobal;

{ TModelDAOBuscarTarefas }

function TModelDAOBuscarTarefas.AdicionarWhereSQL(const pSQL: string): string;
begin
  Result := pSQL + ' WHERE 1 = 1';

  if FDiaTarefa <> 0 then
  begin
    Result := Result
            + ' AND DIA_TAREFA = '
            + ''''
            + FDiaTarefa.FormatoDataIngles
            + ''''
  end;

  if FNomeTarefa <> EmptyStr then
  begin
    Result := Result
            + ' AND  titulo_tarefa like '
            + ''''
            + FNomeTarefa.Trim + '%'
            + '''';
  end;
end;

constructor TModelDAOBuscarTarefas.Create;
begin
  FQuery := TModelQueryFeature.Criar;
  FNomeTarefa := EmptyStr;
  FDiaTarefa := 0;
end;

class function TModelDAOBuscarTarefas.Criar: IModelDAOBuscarTarefa;
begin
  Result := Self.Create;
end;

function TModelDAOBuscarTarefas.DiaTarefa(
  const pValor: TDate): IModelDAOBuscarTarefa;
begin
  FDiaTarefa := pValor;

  Result := Self;
end;

function TModelDAOBuscarTarefas.Executar: TDataSet;
const
  CONST_BUSCAR_TAREFAS_POR_DIA = 'SELECT '
                               + '  ID, '
                               + '  INICIO_TAREFA, '
                               + '  FIM_TAREFA, '
                               + '  TITULO_TAREFA '
                               + 'FROM itens_tarefa ';
var
  lSqlBuscarTarefasPorDia: string;
begin
  lSqlBuscarTarefasPorDia := AdicionarWhereSQL(CONST_BUSCAR_TAREFAS_POR_DIA)
                           + ' ORDER BY INICIO_TAREFA';

  Result := FQuery
              .Query(VariaveisGlobal.GConexao)
              .FecharDataSet
              .AdicionarSQL(lSqlBuscarTarefasPorDia)
              .AbrirDataSet
              .GetQuery;
end;

function TModelDAOBuscarTarefas.NomeTarefa(
  const pValor: string): IModelDAOBuscarTarefa;
begin
  FNomeTarefa := pValor;

  Result := Self;
end;

end.
