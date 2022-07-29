unit View.Funcionalidades.InserirTIcketTarefa;

interface

uses
  FMX.Types,
  Controller.TipoDados.Utils;

type
  IViewFuncionalidadesInserirTicketTarefa = Interface
  ['{0B4C48A1-D994-445C-9209-CCDA988C2B48}']
    function Container(pValor: TFmxObject): IViewFuncionalidadesInserirTicketTarefa;
    function ItemTarefa(const pValor: TItensTarefa): IViewFuncionalidadesInserirTicketTarefa;

    function Executar: IViewFuncionalidadesInserirTicketTarefa;
  End;

  TViewFuncionalidadesInserirTicketTarefa = class(TInterfacedObject,
                                                  IViewFuncionalidadesInserirTicketTarefa)
  private
    FContainer: TFmxObject;
    FItemTarefa: TItensTarefa;

    procedure AtualizarValorContainer;
  public
    class function Criar: IViewFuncionalidadesInserirTicketTarefa;

    function Container(pValor: TFmxObject): IViewFuncionalidadesInserirTicketTarefa;
    function ItemTarefa(const pValor: TItensTarefa): IViewFuncionalidadesInserirTicketTarefa;

    function Executar: IViewFuncionalidadesInserirTicketTarefa;
  end;

implementation

uses
  FMX.StdCtrls,
  FMX.Objects,
  uFrameTicket,
  SysUtils;

{ TViewFuncionalidadesInserirTicketTarefa }

procedure TViewFuncionalidadesInserirTicketTarefa.AtualizarValorContainer;
var
  fttTicketTarefa: TFrameTicket;
begin
  fttTicketTarefa := TFrameTicket.Create(FContainer);

  fttTicketTarefa.IdTarefa := FItemTarefa.ID;
  fttTicketTarefa.Tarefa := FItemTarefa.Tarefa;
  fttTicketTarefa.InicioTarefa := FItemTarefa.InicioTarefa;
  fttTicketTarefa.FimTarefa := FItemTarefa.FimTarefa;
  fttTicketTarefa.DataTarefa := FItemTarefa.DataTarefa;
  fttTicketTarefa.Parent := FContainer;
  fttTicketTarefa.Name := 'TFrameTicket_' + FItemTarefa.ID.ToString;
  fttTicketTarefa.SetarTempoEsforco(True);
end;

function TViewFuncionalidadesInserirTicketTarefa.Container(
  pValor: TFmxObject): IViewFuncionalidadesInserirTicketTarefa;
begin
  FContainer := pValor;

  Result := Self;
end;

class function TViewFuncionalidadesInserirTicketTarefa.Criar: IViewFuncionalidadesInserirTicketTarefa;
begin
  Result := Self.Create;
end;

function TViewFuncionalidadesInserirTicketTarefa.Executar: IViewFuncionalidadesInserirTicketTarefa;
begin
  AtualizarValorContainer;

  Result := Self;
end;

function TViewFuncionalidadesInserirTicketTarefa.ItemTarefa(
  const pValor: TItensTarefa): IViewFuncionalidadesInserirTicketTarefa;
begin
  FItemTarefa := pValor;

  Result := Self;
end;

end.
