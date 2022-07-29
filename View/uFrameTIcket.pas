unit uFrameTIcket;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.Objects, FMX.Menus;

type
  TFrameTicket = class(TFrame)
    rtcContainer: TRectangle;
    lytSuperiorContainer: TLayout;
    lblTarefa: TLabel;
    lytMeioContainer: TLayout;
    lblInicioTarefa: TLabel;
    lblDataInicioTarefa: TLabel;
    lytInferiorContainer: TLayout;
    lblFimTarefa: TLabel;
    lblDataFimTarefa: TLabel;
    lytFimTarefa: TLayout;
    lytInicioTarefa: TLayout;
    lblTituloTarefa: TLabel;
    lytTempoEsforco: TLayout;
    lblEsforco: TLabel;
    lblTempoEsforco: TLabel;
    lytFormatoHoras: TLayout;
    rtcContainerEsforço: TRectangle;
    lytEsforço: TLayout;
    rbtHora: TRadioButton;
    rbtMinutos: TRadioButton;
    lblFormato: TLabel;
    ppmFuncoesTicket: TPopupMenu;
    mniCalcularTotalEsforco: TMenuItem;
    procedure rbtMinutosClick(Sender: TObject);
    procedure rbtHoraClick(Sender: TObject);
    procedure mniCalcularTotalEsforcoClick(Sender: TObject);
  private
    FTarefa: string;
    FFimTarefa: TDate;
    FInicioTarefa: TDate;
    FIdTarefa: Integer;
    FDataTarefa: TDate;
    procedure SetTarefa(const Value: string);
    procedure SetFimTarefa(const Value: TDate);
    procedure SetInicioTarefa(const Value: TDate);

    procedure FormatarTempoEsforco(const pFormatoHora: Boolean);
    procedure MostrarHoraMinutos(const pHabilitarHora: Boolean);
    procedure ExecutarProcessoHoraMinutos(const pExecutaHora: Boolean);
    procedure SetIdTarefa(const Value: Integer);
    procedure SetDataTarefa(const Value: TDate);
    { Private declarations }
  public
    { Public declarations }
    property IdTarefa:  Integer write SetIdTarefa;
    property Tarefa: string read FTarefa write SetTarefa;
    property InicioTarefa: TDate read FInicioTarefa write SetInicioTarefa;
    property FimTarefa: TDate read FFimTarefa write SetFimTarefa;
    property DataTarefa: TDate write SetDataTarefa;

    procedure SetarTempoEsforco(const pFormatoHora: Boolean);
  end;

implementation

uses
  Controller.Helper,
  DateUtils,
  Controller.Utils,
  View.Funcionalidades.InserirTotalizadorEsforco;

{$R *.fmx}

{ TFrameTicket }

procedure TFrameTicket.ExecutarProcessoHoraMinutos(const pExecutaHora: Boolean);
begin
  MostrarHoraMinutos(not pExecutaHora);
  FormatarTempoEsforco(pExecutaHora);
end;

procedure TFrameTicket.FormatarTempoEsforco(const pFormatoHora: Boolean);
begin
  if (FInicioTarefa <> 0)
  and (FFimTarefa <> 0) then
  begin
    lytTempoEsforco.Visible := True;

    if pFormatoHora then
    begin
      lblTempoEsforco.Text := TFormatarHorario.TransformarMinutosParaHoras(
                                MinutesBetween(FInicioTarefa,
                                               FFimTarefa));
    end
    else
      begin
        lblTempoEsforco.Text := MinutesBetween(FInicioTarefa, FFimTarefa).ToString
                              + ' minutos';
      end;
  end
end;

procedure TFrameTicket.mniCalcularTotalEsforcoClick(Sender: TObject);
begin
  TInserirTotalizadorEsforco
    .Criar
    .Container(Self.Parent.Parent.Parent)
    .NomeTarefa(FTarefa)
    .DataTarefas(FDataTarefa)
    .IdTarefa(FIdTarefa)
    .Executar(True);
end;

procedure TFrameTicket.MostrarHoraMinutos(const pHabilitarHora: Boolean);
begin
  rbtHora.Visible := pHabilitarHora;
  rbtMinutos.Visible := not pHabilitarHora;
end;

procedure TFrameTicket.rbtHoraClick(Sender: TObject);
begin
  ExecutarProcessoHoraMinutos(True);
end;

procedure TFrameTicket.rbtMinutosClick(Sender: TObject);
begin
  ExecutarProcessoHoraMinutos(False)
end;

procedure TFrameTicket.SetarTempoEsforco(const pFormatoHora: Boolean);
begin
  lytTempoEsforco.Visible := (FInicioTarefa <> 0) and (FFimTarefa <> 0);

  ExecutarProcessoHoraMinutos(pFormatoHora);
  FormatarTempoEsforco(pFormatoHora);
end;

procedure TFrameTicket.SetDataTarefa(const Value: TDate);
begin
  FDataTarefa := Value;
end;

procedure TFrameTicket.SetFimTarefa(const Value: TDate);
begin
  FFimTarefa := Value;

  if Value = 0 then
    lblDataFimTarefa.Text := EmptyStr
  else
    lblDataFimTarefa.Text := Value.FormatoDataVisualApenasTime;
end;

procedure TFrameTicket.SetIdTarefa(const Value: Integer);
begin
  FIdTarefa := Value;
end;

procedure TFrameTicket.SetInicioTarefa(const Value: TDate);
begin
  FInicioTarefa := Value;

  if Value = 0 then
    lblDataInicioTarefa.Text := EmptyStr
  else
    lblDataInicioTarefa.Text := Value.FormatoDataVisualApenasTime;
end;

procedure TFrameTicket.SetTarefa(const Value: string);
begin
  FTarefa := Value;

  lblTituloTarefa.Text := FTarefa;
end;

end.
