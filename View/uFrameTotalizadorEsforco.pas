unit uFrameTotalizadorEsforco;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects;

type
  TfrmTotalizadorEsforco = class(TFrame)
    rtcTotalizadorEsforço: TRectangle;
    lblTarefa: TLabel;
    lblValorTarefa: TLabel;
    lblTotalEsforco: TLabel;
    lblValorTotalEsforco: TLabel;
  private
    FNomeTarefa: string;
    FDataTarefas: TDate;
    procedure SetNomeTarefa(const Value: string);

    function GetEsforcoTotal: Integer;
    procedure SetDataTarefas(const Value: TDate);
    { Private declarations }
  public
    { Public declarations }
    property NomeTarefa: string Write SetNomeTarefa;
    property DataTarefas: TDate write SetDataTarefas;
    procedure AtualizarTotalizador;
  end;

implementation

USES
  Controller,
  Data.DB,
  System.DateUtils,
  Controller.Utils;

{$R *.fmx}

{ TfrmTotalizadorEsforco }

procedure TfrmTotalizadorEsforco.AtualizarTotalizador;
begin
  if FNomeTarefa.IsEmpty then
    raise Exception.Create('Você precisa preencher o nome da tarefa!');

  if FDataTarefas = 0 then
    raise Exception.Create('Você precisa preencher a data da tarefa!');

  lblValorTarefa.Text := FNomeTarefa;
  lblValorTotalEsforco.Text := TFormatarHorario.TransformarMinutosParaHoras(GetEsforcoTotal);
end;

function TfrmTotalizadorEsforco.GetEsforcoTotal: Integer;
var
  lBuscarTarefas: IController;
  lTarefas: TDataSet;
begin
  Result := 0;
  lBuscarTarefas := TController.Criar;
  lTarefas := lBuscarTarefas
                .BuscarTarefas
                .NomeTarefa(FNomeTarefa)
                .DiaTarefa(FDataTarefas)
                .Executar;

  lTarefas.First;
  while not lTarefas.Eof do
  begin
    Result := Result
            + MinutesBetween(lTarefas.FieldByName('INICIO_TAREFA').AsDateTime,
                             lTarefas.FieldByName('FIM_TAREFA').AsDateTime);

    lTarefas.Next;
  end;
end;

procedure TfrmTotalizadorEsforco.SetDataTarefas(const Value: TDate);
begin
  FDataTarefas := Value;
end;

procedure TfrmTotalizadorEsforco.SetNomeTarefa(const Value: string);
begin
  FNomeTarefa := Value;
end;

end.
