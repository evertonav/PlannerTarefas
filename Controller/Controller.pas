unit Controller;

interface

uses
  Model.DAO.BuscarTarefas;

type
  IController = Interface
    ['{69A6F041-7235-46FD-8333-5712B000F189}']
    function BuscarTarefas: IModelDAOBuscarTarefa;
  End;

  TController = class(TInterfacedObject, IController)
  private
    FBuscarTarefas: IModelDAOBuscarTarefa;
  public
    class function Criar: IController;

    function BuscarTarefas: IModelDAOBuscarTarefa;
  end;

implementation

{ TController }

function TController.BuscarTarefas: IModelDAOBuscarTarefa;
begin
  if not Assigned(FBuscarTarefas) then
    FBuscarTarefas := TModelDAOBuscarTarefas.Criar;

  Result := FBuscarTarefas;
end;

class function TController.Criar: IController;
begin
  Result := Self.Create;
end;

end.
