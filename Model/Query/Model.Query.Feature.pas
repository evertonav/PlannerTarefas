unit Model.Query.Feature;

interface

uses
  Model.Query.FireDAC,
  Model.Conexao.Feature;

type
  IModelQueryFeature = interface
    ['{D698A379-9099-49E5-9CFC-A75551DC508F}']
    function Query: IModelQuery; overload;
    function Query(const pConexao: IModelConexaoFeature): IModelQuery; overload;
  end;

  TModelQueryFeature = class(TInterfacedObject, IModelQueryFeature)
  private
    FQuery: IModelQuery;
    FConexao: IModelConexaoFeature;

    function Query: IModelQuery; overload;
    function Query(const pConexao: IModelConexaoFeature): IModelQuery; overload;
  public
    class function Criar: IModelQueryFeature;
  end;

implementation

{ TModelQueryFeature }

class function TModelQueryFeature.Criar: IModelQueryFeature;
begin
  Result := Self.Create;
end;

function TModelQueryFeature.Query: IModelQuery;
begin
  if not Assigned(FQuery) then
  begin
    FConexao := TModelConexaoFeature.Criar;
    FQuery := TModelQueryFireDac.Criar(FConexao.Conexao);
  end;

  Result := FQuery;
end;

function TModelQueryFeature.Query(
  const pConexao: IModelConexaoFeature): IModelQuery;
begin
  if not Assigned(FQuery) then
    FQuery := TModelQueryFireDac.Criar(pConexao.Conexao);

  Result := FQuery;
end;

end.
