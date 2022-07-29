unit Model.DAO.Cadastro;

interface

uses
  Model.DAO.Cadastro.Interfaces,
  Data.DB,
  Model.Query.FireDAC,
  Model.Query.Feature;

type
  TModelDAOCadastro = class(TInterfacedObject, IModelDAOCadastro)
  private
    FQuery: IModelQueryFeature;
  protected
    function Query: IModelQuery;
  public
    function Consultar: IModelDAOCadastro; virtual; abstract;

    constructor Create(pDataSource: TDataSource);
    destructor Destroy; override;

    class function Criar(pDataSource: TDataSource): IModelDAOCadastro; virtual;
  end;

implementation

uses
  System.SysUtils;

{ TModelDAOCadastro }

constructor TModelDAOCadastro.Create(pDataSource: TDataSource);
begin
  FQuery :=  TModelQueryFeature.Criar;
  pDataSource.DataSet := FQuery.Query.GetQuery;
end;

class function TModelDAOCadastro.Criar(pDataSource: TDataSource): IModelDAOCadastro;
begin
  Result := Self.Create(pDataSource);
end;

destructor TModelDAOCadastro.Destroy;
begin

  inherited;
end;

function TModelDAOCadastro.Query: IModelQuery;
begin
  Result := FQuery.Query;
end;

end.
