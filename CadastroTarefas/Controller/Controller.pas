unit Controller;

interface

uses
  Model.DAO.Cadastro.Interfaces,
  Model.DAO.CadastroTarefas,
  Data.DB;

type
  IController = Interface
    ['{30944A54-3C6A-4C94-8E03-438FCDDAD2D1}']
    function CadastroTarefas(pDataSource: TDataSource): IModelDAOCadastro;
  End;

  TController = class(TInterfacedObject, IController)
    FCadastroTarefas: IModelDAOCadastro;
  public
    class function Criar: IController;

    function CadastroTarefas(pDataSource: TDataSource): IModelDAOCadastro;
  end;

implementation

{ TController }

function TController.CadastroTarefas(pDataSource: TDataSource): IModelDAOCadastro;
begin
  if not Assigned(FCadastroTarefas) then
    FCadastroTarefas := TModelDAOCadastroTarefas.Criar(pDataSource);

  Result := FCadastroTarefas;
end;

class function TController.Criar: IController;
begin
  Result := Self.Create;
end;

end.
