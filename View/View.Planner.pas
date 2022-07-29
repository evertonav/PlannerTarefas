unit View.Planner;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.ListBox, FMX.StdCtrls, FMX.ScrollBox, FMX.Memo, FMX.Controls.Presentation,
  FMX.Objects, FMX.TabControl, System.Actions, FMX.ActnList, FMX.Effects,
  FMX.Filter.Effects, System.Math.Vectors, FMX.Controls3D, FMX.Layers3D,
  FMX.Memo.Types;

type
  TViewPlanner = class(TForm)
    tbcPlanner: TTabControl;
    tbiPlanner: TTabItem;
    rtcContainer: TRectangle;
    lytContainer: TLayout;
    rtcContainerTarefas: TRectangle;
    lytContainerSegunda: TLayout;
    lytTituloSegunda: TLayout;
    rtcTituloSegunda: TRectangle;
    lytTituloDataEDiaSemana: TLayout;
    lblTituloSegunda: TLabel;
    lneTituloSegunda: TLine;
    lblTituloDataSegunda: TLabel;
    rtcTarefasSegunda: TRectangle;
    vsbTarefaSegunda: TVertScrollBox;
    lytContainerTerca: TLayout;
    lytTituloTerca: TLayout;
    Rectangle4: TRectangle;
    Layout10: TLayout;
    lblTituloTerca: TLabel;
    Line4: TLine;
    lblTituloDataTerca: TLabel;
    rtcTarefasTerca: TRectangle;
    vsbTarefaTerca: TVertScrollBox;
    lytContainerQuarta: TLayout;
    lytTituloQuarta: TLayout;
    Rectangle6: TRectangle;
    Layout8: TLayout;
    lblTituloQuarta: TLabel;
    Line5: TLine;
    lblTituloDataQuarta: TLabel;
    rtcTarefasQuarta: TRectangle;
    vsbTarefaQuarta: TVertScrollBox;
    lytContainerQuinta: TLayout;
    lytTituloQuinta: TLayout;
    Rectangle1: TRectangle;
    Layout4: TLayout;
    lblTituloQuinta: TLabel;
    Line1: TLine;
    lblTituloDataQuinta: TLabel;
    rtcTarefasQuinta: TRectangle;
    vsbTarefaQuinta: TVertScrollBox;
    lytContainerSexta: TLayout;
    lytTituloSexta: TLayout;
    Rectangle3: TRectangle;
    Layout6: TLayout;
    lblTituloSexta: TLabel;
    Line2: TLine;
    lblTituloDataSexta: TLabel;
    rtcTarefasSexta: TRectangle;
    vsbTarefaSexta: TVertScrollBox;
    lytContainerSabado: TLayout;
    lytTituloSabado: TLayout;
    Rectangle9: TRectangle;
    Layout12: TLayout;
    lblTituloSabado: TLabel;
    Line3: TLine;
    lblTituloDataSabado: TLabel;
    rtcTarefasSabado: TRectangle;
    vsbTarefaSabado: TVertScrollBox;
    lytContainerDomingo: TLayout;
    lytTituloDomingo: TLayout;
    rtcCabecalhoDomingo: TRectangle;
    lytContainerCabecalhoDomingo: TLayout;
    lblTituloDomingo: TLabel;
    Line6: TLine;
    lblTituloDataDomingo: TLabel;
    rtcTarefasDomingo: TRectangle;
    vsbTarefaDomingo: TVertScrollBox;
    lytSuperior: TLayout;
    btnVoltarSemana: TSpeedButton;
    btnProximaSemana: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnVoltarSemanaClick(Sender: TObject);
    procedure btnProximaSemanaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure AtualizarLabelDataDiaSemana(const pData: TDate);

    procedure AtualizarTicketTarefaSemana(const pDataAtualizar: TDate);

    procedure AtualizarTicketTarefaDia(const pContainer: TVertScrollBox;
                                       const pDataTarefas: TDate);

    procedure LimparTodasTarefas;

    procedure SetarSemana(const pProximo: Boolean);
  public
  end;

var
  ViewPlanner: TViewPlanner;

implementation

uses
  View.Funcionalidades.InserirTIcketTarefa,
  Controller.Utils,
  Controller.TipoDados.Utils,
  Controller,
  Data.DB,
  View.DiaSemana,
  Controller.Helper,
  VariaveisGlobal,
  Model.Conexao.Feature;

{$R *.fmx}

procedure TViewPlanner.AtualizarTicketTarefaDia(
  const pContainer: TVertScrollBox; const pDataTarefas: TDate);
var
  lItemTarefa: TItensTarefa;
  lTarefa: TDataSet;
  lGetTarefas: IController;
begin
  lGetTarefas := TController.Criar;
  lTarefa := lGetTarefas.BuscarTarefas.DiaTarefa(pDataTarefas).Executar;

  lTarefa.First;

  while not lTarefa.Eof do
  begin
    lItemTarefa.ID := lTarefa.FieldByName('ID').AsInteger;
    lItemTarefa.Tarefa := lTarefa.FieldByName('TITULO_TAREFA').AsString;
    lItemTarefa.InicioTarefa := lTarefa.FieldByName('INICIO_TAREFA').AsDateTime;
    lItemTarefa.FimTarefa := lTarefa.FieldByName('FIM_TAREFA').AsDateTime;
    lItemTarefa.DataTarefa := pDataTarefas;

    TViewFuncionalidadesInserirTicketTarefa
      .Criar
      .Container(pContainer)
      .ItemTarefa(lItemTarefa)
      .Executar;

    lTarefa.Next;
  end;
end;

procedure TViewPlanner.AtualizarTicketTarefaSemana(const pDataAtualizar: TDate);
begin
  AtualizarTicketTarefaDia(vsbTarefaSegunda, TViewDiaSemana.GetDataDiasSemana(pDataAtualizar, dsSegunda));
  AtualizarTicketTarefaDia(vsbTarefaTerca, TViewDiaSemana.GetDataDiasSemana(pDataAtualizar, dsTerca));
  AtualizarTicketTarefaDia(vsbTarefaQuarta, TViewDiaSemana.GetDataDiasSemana(pDataAtualizar, dsQuarta));
  AtualizarTicketTarefaDia(vsbTarefaQuinta, TViewDiaSemana.GetDataDiasSemana(pDataAtualizar, dsQuinta));
  AtualizarTicketTarefaDia(vsbTarefaSexta, TViewDiaSemana.GetDataDiasSemana(pDataAtualizar, dsSexta));
  AtualizarTicketTarefaDia(vsbTarefaSabado, TViewDiaSemana.GetDataDiasSemana(pDataAtualizar, dsSabado));
  AtualizarTicketTarefaDia(vsbTarefaDomingo, TViewDiaSemana.GetDataDiasSemana(pDataAtualizar, dsDomingo));
end;

procedure TViewPlanner.btnProximaSemanaClick(Sender: TObject);
begin
  SetarSemana(True)
end;

procedure TViewPlanner.btnVoltarSemanaClick(Sender: TObject);
begin
  SetarSemana(False)
end;

procedure TViewPlanner.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;
  GConexao := TModelConexaoFeature.Criar;
end;

procedure TViewPlanner.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkF5 then
  begin
    LimparTodasTarefas;
    AtualizarLabelDataDiaSemana(StrToDate(lblTituloDataSegunda.Text));
    Application.ProcessMessages;
    AtualizarTicketTarefaSemana(StrToDate(lblTituloDataSegunda.Text));
  end;
end;

procedure TViewPlanner.FormResize(Sender: TObject);
var
  lTamanhoContainerTarefa: Integer;
begin
  lTamanhoContainerTarefa := Trunc(ViewPlanner.Width / 7);

  lytContainerSegunda.Width := lTamanhoContainerTarefa;
  lytContainerTerca.Width := lTamanhoContainerTarefa;
  lytContainerQuarta.Width := lTamanhoContainerTarefa;
  lytContainerQuinta.Width := lTamanhoContainerTarefa;
  lytContainerSexta.Width := lTamanhoContainerTarefa;
  lytContainerSabado.Width := lTamanhoContainerTarefa;
end;

procedure TViewPlanner.FormShow(Sender: TObject);
begin
  AtualizarLabelDataDiaSemana(Now);
  AtualizarTicketTarefaSemana(Now);
end;

procedure TViewPlanner.LimparTodasTarefas;
begin
  TFuncLista.LimparListaFrameTicket(vsbTarefaSegunda, '');
  TFuncLista.LimparListaFrameTicket(vsbTarefaTerca, '');
  TFuncLista.LimparListaFrameTicket(vsbTarefaQuarta, '');
  TFuncLista.LimparListaFrameTicket(vsbTarefaQuinta, '');
  TFuncLista.LimparListaFrameTicket(vsbTarefaSexta, '');
  TFuncLista.LimparListaFrameTicket(vsbTarefaSabado, '');
  TFuncLista.LimparListaFrameTicket(vsbTarefaDomingo, '');

  TFuncLista.LimparListaTotalizadorTicket(rtcTarefasSegunda, '');
  TFuncLista.LimparListaTotalizadorTicket(rtcTarefasTerca, '');
  TFuncLista.LimparListaTotalizadorTicket(rtcTarefasQuarta, '');
  TFuncLista.LimparListaTotalizadorTicket(rtcTarefasQuinta, '');
  TFuncLista.LimparListaTotalizadorTicket(rtcTarefasSexta, '');
  TFuncLista.LimparListaTotalizadorTicket(rtcTarefasSabado, '');
  TFuncLista.LimparListaTotalizadorTicket(rtcTarefasDomingo, '');
end;

procedure TViewPlanner.SetarSemana(const pProximo: Boolean);
var
  lData: TDate;
begin
  if pProximo then
    lData := StrToDate(lblTituloDataSegunda.Text) + 7
  else
    lData := StrToDate(lblTituloDataSegunda.Text) - 7;

  LimparTodasTarefas;
  AtualizarLabelDataDiaSemana(lData);
  AtualizarTicketTarefaSemana(lData)
end;

procedure TViewPlanner.AtualizarLabelDataDiaSemana(const pData: TDate);
begin
  lblTituloDataSegunda.Text := TViewDiaSemana.GetDataDiasSemana(pData, dsSegunda).FormatoDataVisual;
  lblTituloDataTerca.Text := TViewDiaSemana.GetDataDiasSemana(pData, dsTerca).FormatoDataVisual;
  lblTituloDataQuarta.Text := TViewDiaSemana.GetDataDiasSemana(pData, dsQuarta).FormatoDataVisual;
  lblTituloDataQuinta.Text := TViewDiaSemana.GetDataDiasSemana(pData, dsQuinta).FormatoDataVisual;
  lblTituloDataSexta.Text := TViewDiaSemana.GetDataDiasSemana(pData, dsSexta).FormatoDataVisual;
  lblTituloDataSabado.Text := TViewDiaSemana.GetDataDiasSemana(pData, dsSabado).FormatoDataVisual;
  lblTituloDataDomingo.Text := TViewDiaSemana.GetDataDiasSemana(pData, dsDomingo).FormatoDataVisual;
end;

end.
