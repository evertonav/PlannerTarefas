unit View.Funcionalidades.InserirTotalizadorEsforco;

interface

uses
  FMX.Types;

type
  IInserirTotalizadorEsforco = Interface
  ['{0B4C48A1-D994-445C-9209-CCDA988C2B48}']
    function Container(pValor: TFmxObject): IInserirTotalizadorEsforco;
    function NomeTarefa(const pValor: string): IInserirTotalizadorEsforco;
    function IdTarefa(const pValor: Integer): IInserirTotalizadorEsforco;
    function DataTarefas(const pValor: TDate): IInserirTotalizadorEsforco;

    function Executar(const pValidar: Boolean): IInserirTotalizadorEsforco;
  End;

  TInserirTotalizadorEsforco = class(TInterfacedObject, IInserirTotalizadorEsforco)
  private
    FContainer: TFmxObject;
    FNomeTarefa: string;
    FIdTarefa: Integer;
    FDataTarefas: TDate;
  public
    function Container(pValor: TFmxObject): IInserirTotalizadorEsforco;
    function NomeTarefa(const pValor: string): IInserirTotalizadorEsforco;
    function IdTarefa(const pValor: Integer): IInserirTotalizadorEsforco;
    function DataTarefas(const pValor: TDate): IInserirTotalizadorEsforco;

    function Executar(const pValidar: Boolean): IInserirTotalizadorEsforco;

    class function Criar: IInserirTotalizadorEsforco;
  end;

implementation

uses
  uFrameTotalizadorEsforco,
  System.SysUtils,
  FMX.Dialogs,
  Controller.Utils;

{ TInserirTotalizadorEsforce }

function TInserirTotalizadorEsforco.Container(
  pValor: TFmxObject): IInserirTotalizadorEsforco;
begin
  FContainer := pValor;

  Result := Self;
end;

class function TInserirTotalizadorEsforco.Criar: IInserirTotalizadorEsforco;
begin
  Result := Self.Create;
end;

function TInserirTotalizadorEsforco.DataTarefas(
  const pValor: TDate): IInserirTotalizadorEsforco;
begin
  FDataTarefas := pValor;

  Result := Self;
end;

function TInserirTotalizadorEsforco.Executar(const pValidar: Boolean): IInserirTotalizadorEsforco;
var
  frmTotalizadorEsforco: TfrmTotalizadorEsforco;
  lInserirTotalizador: Boolean;
begin
  lInserirTotalizador := True;

  frmTotalizadorEsforco := TfrmTotalizadorEsforco.Create(FContainer);

  if pValidar then
  begin
    lInserirTotalizador := not TVerificarComponente.ExisteComponente(FContainer,
                                                                 frmTotalizadorEsforco)
  end;

  if lInserirTotalizador then
  begin
    try
      frmTotalizadorEsforco.Name := 'TfrmTotalizadorEsforco_' + FIdTarefa.ToString;
      frmTotalizadorEsforco.Parent := FContainer;
      frmTotalizadorEsforco.NomeTarefa := FNomeTarefa;
      frmTotalizadorEsforco.DataTarefas := FDataTarefas;
      frmTotalizadorEsforco.AtualizarTotalizador;
    except
      on E: Exception do
      begin
        FreeAndNil(frmTotalizadorEsforco);

        if DebugHook <> 0 then
          ShowMessage(E.Message)
      end;
    end;
  end
  else
    begin
      if Assigned(frmTotalizadorEsforco) then
        FreeAndNil(frmTotalizadorEsforco);
    end;

  Result := Self;
end;

function TInserirTotalizadorEsforco.IdTarefa(
  const pValor: Integer): IInserirTotalizadorEsforco;
begin
  FIdTarefa := pValor;

  Result := Self;
end;

function TInserirTotalizadorEsforco.NomeTarefa(
  const pValor: string): IInserirTotalizadorEsforco;
begin
   FNomeTarefa := pValor;

   Result := Self;
end;

end.
