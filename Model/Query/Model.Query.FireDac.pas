unit Model.Query.FireDac;

interface

uses
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  FireDAC.Dapt,
  Data.DB,
  Model.Conexao.Feature,
  Model.DAO.Eventos.DataSet.Interfaces,
  Model.DAO.Eventos.DataSet;

type
  IModelQuery = interface
    ['{A1667309-C453-49D5-B8E7-C98F334BE3D5}']
    function FecharDataSet: IModelQuery;

    function AdicionarSQL(const pSQL: string): IModelQuery;

    function AdicionarParametro(const pNomeParametro: string;
                                const pValor: Variant): IModelQuery;

    function AbrirDataSet: IModelQuery;

    function GetQuery: TDataSet;

    function EventosDataSet: IModelDAOEventosDataSet;
    function AdicionarEventosDataSet: IModelQuery;

    function AdicionarMascara(const pNomeCampo: string;
                              const pMascara: string): IModelQuery;

    function AdicionarMascaraDisplay(const pNomeCampo: string;
                                     const pMascara: string): IModelQuery;

    function ExecutarSQL: IModelQuery;
  end;

  TModelQueryFireDac = class(TInterfacedObject,
                             IModelQuery)
  private
    FConexao: TCustomConnection;
    FQuery: TFDQuery;
    FEventosDataSet: IModelDAOEventosDataSet;

    function FecharDataSet: IModelQuery;

    function AdicionarSQL(const pSQL: string): IModelQuery;

    function AdicionarParametro(const pNomeParametro: string;
                                const pValor: Variant): IModelQuery;

    function AbrirDataSet: IModelQuery;

    function GetQuery: TDataSet;

    function EventosDataSet: IModelDAOEventosDataSet;
    function AdicionarEventosDataSet: IModelQuery;

    function AdicionarMascara(const pNomeCampo: string;
                              const pMascara: string): IModelQuery;

    function AdicionarMascaraDisplay(const pNomeCampo: string;
                                     const pMascara: string): IModelQuery;

    function ExecutarSQL: IModelQuery;
  public
    constructor Create(Conexao: TCustomConnection);
    destructor Destroy; override;

    class function Criar(Conexao: TCustomConnection): IModelQuery;
  end;

implementation

{ TModelQueryFireDac }

function TModelQueryFireDac.AbrirDataSet: IModelQuery;
begin
  FQuery.Open;

  Result := Self;
end;

function TModelQueryFireDac.AdicionarEventosDataSet: IModelQuery;
begin
  if Assigned(FEventosDataSet.BeforePost) then
    FQuery.BeforePost := FEventosDataSet.BeforePost;

  if Assigned(FEventosDataSet.NewRecord) then
    FQuery.OnNewRecord := FEventosDataSet.NewRecord;

  if Assigned(FEventosDataSet.AfterDelete) then
    FQuery.AfterDelete := FEventosDataSet.AfterDelete;

  Result := Self;
end;

function TModelQueryFireDac.AdicionarMascara(const pNomeCampo,
  pMascara: string): IModelQuery;
begin
  TField(FQuery.FieldByName(pNomeCampo)).EditMask := pMascara;

  Result := Self;
end;

function TModelQueryFireDac.AdicionarMascaraDisplay(const pNomeCampo,
  pMascara: string): IModelQuery;
begin
  TNumericField(FQuery.FieldByName(pNomeCampo)).DisplayFormat := pMascara;

  Result := Self;
end;

function TModelQueryFireDac.AdicionarParametro(const pNomeParametro: string;
  const pValor: Variant): IModelQuery;
begin
  FQuery.Params.ParamByName(pNomeParametro).Value := pValor;

  Result := Self;
end;

function TModelQueryFireDac.AdicionarSQL(const pSQL: string): IModelQuery;
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add(pSQL);

  Result := Self;
end;

constructor TModelQueryFireDac.Create(Conexao: TCustomConnection);
begin
  if not Assigned(Conexao) then
    FConexao := TModelConexaoFeature.Criar.Conexao
  else
    FConexao := Conexao;

  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := TFDConnection(FConexao);
end;

class function TModelQueryFireDac.Criar(Conexao: TCustomConnection): IModelQuery;
begin
  Result := Self.Create(Conexao);
end;

destructor TModelQueryFireDac.Destroy;
begin
  if Assigned(FQuery) then
    FQuery.Free;

  inherited;
end;

function TModelQueryFireDac.EventosDataSet: IModelDAOEventosDataSet;
begin
  if not Assigned(FEventosDataSet) then
    FEventosDataSet := TModelDAOEventosDataSet.Criar;

  Result := FEventosDataSet;
end;

function TModelQueryFireDac.ExecutarSQL: IModelQuery;
begin
  FQuery.ExecSQL;

  Result := Self;
end;

function TModelQueryFireDac.FecharDataSet: IModelQuery;
begin
  FQuery.Close;

  Result := Self;
end;

function TModelQueryFireDac.GetQuery: TDataSet;
begin
  Result := FQuery;
end;

end.
