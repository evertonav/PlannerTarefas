unit Model.DAO.CadastroTarefas;

interface

uses
  Model.DAO.Cadastro,
  Model.DAO.Cadastro.Interfaces,
  Model.Query.FireDac,
  Model.Query.Feature,
  Controller.Helper,
  Data.DB;

type
  TModelDAOFuncoesValidacaoCadastroTarefa = class
  public
    class function ExisteTarefa(const pDataTarefa: TDate): Boolean;
  end;

  TModelDAOInserirTarefa = class
    FDiaTarefa: TDate;
  public
    function DiaTarefa(const pValor: TDate): TModelDAOInserirTarefa;
    function Executar: TModelDAOInserirTarefa;
  end;

  TModelDAOCadastroTarefas = class(TModelDAOCadastro)
  private
    procedure BeforePost(DataSet: TDataSet);
  public
    function Consultar: IModelDAOCadastro; override;
  end;

implementation

uses
  System.SysUtils;

{ TModelDAOCadastroTarefas }

function TModelDAOCadastroTarefas.Consultar: IModelDAOCadastro;
const
  CONST_BUSCAR_TODAS_TAREFAS = 'SELECT '
                             + '  INICIO_TAREFA, '
                             + '  FIM_TAREFA, '
                             + '  TITULO_TAREFA, '
                             + '  DIA_TAREFA '
                             + 'FROM '
                             + '  itens_tarefa';
begin
  Query
    .FecharDataSet
    .AdicionarSQL(CONST_BUSCAR_TODAS_TAREFAS)
    .AbrirDataSet
    .EventosDataSet
    .BeforePost(BeforePost);

  Result := Self;
end;

procedure TModelDAOCadastroTarefas.BeforePost(DataSet: TDataSet);
var
  lInserirTarefa: TModelDAOInserirTarefa;
begin
  if not TModelDAOFuncoesValidacaoCadastroTarefa.ExisteTarefa(DataSet.FieldByName('DIA_TAREFA').AsDateTime) then
  begin
    lInserirTarefa := TModelDAOInserirTarefa.Create;
    try
      lInserirTarefa.FDiaTarefa := DataSet.FieldByName('DIA_TAREFA').AsDateTime;
      lInserirTarefa.Executar;
    finally
      lInserirTarefa.Free;
    end;
  end;
end;

{ TModelDAOFuncoesValidacaoCadastroTarefa }

class function TModelDAOFuncoesValidacaoCadastroTarefa.ExisteTarefa(
  const pDataTarefa: TDate): Boolean;
const
  CONST_VALIDAR_TAREFA = 'SELECT FIRST 1 '
                       + '  1 '
                       + 'FROM '
                       + '  TAREFA '
                       + 'WHERE DIA_TAREFA = :DIA_TAREFA ';
var
  lQuery: IModelQuery;
begin
  lQuery := TModelQueryFeature.Criar.Query;
  Result := not lQuery
                  .FecharDataSet
                  .AdicionarSQL(CONST_VALIDAR_TAREFA)
                  .AdicionarParametro('DIA_TAREFA', pDataTarefa.FormatoDataBanco)
                  .AbrirDataSet
                  .GetQuery
                  .IsEmpty;
end;

{ TModelDAOInserirTarefa }

function TModelDAOInserirTarefa.DiaTarefa(
  const pValor: TDate): TModelDAOInserirTarefa;
begin
  FDiaTarefa := pValor;

  Result := Self;
end;

function TModelDAOInserirTarefa.Executar: TModelDAOInserirTarefa;
const
  CONST_INSERIR_TAREFA = 'INSERT INTO TAREFA(DIA_TAREFA) '
                       + 'VALUES(:DIA_TAREFA)';
var
  lQuery: IModelQueryFeature;
begin
  lQuery := TModelQueryFeature.Criar;

  try
    lQuery
      .Query
      .FecharDataSet
      .AdicionarSQL(CONST_INSERIR_TAREFA)
      .AdicionarParametro('DIA_TAREFA', FDiaTarefa.FormatoDataIngles)
      .ExecutarSQL;
  Except
    on E: Exception do
    begin
      raise Exception.Create('Não foi possível inserir a tarefa!'
                            + #13
                            + 'Erro apresentado: '
                            + #13
                            + E.Message);
    end;
  end;

  Result := Self;
end;

end.
