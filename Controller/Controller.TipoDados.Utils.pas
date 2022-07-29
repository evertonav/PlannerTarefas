unit Controller.TipoDados.Utils;

interface

type
  TItensTarefa = packed record
    ID: Integer;
    Tarefa: string;
    InicioTarefa: TDateTime;
    FimTarefa: TDateTime;
    DataTarefa: TDate;
  end;

  TDiasSemana = (dsNenhum,
                 dsDomingo,
                 dsSegunda,
                 dsTerca,
                 dsQuarta,
                 dsQuinta,
                 dsSexta,
                 dsSabado);

  TDataDiasSemana = packed record
    Segunda: TDate;
    Terca: TDate;
    Quarta: TDate;
    Quinta: TDate;
    Sexta: TDate;
    Sabado: TDate;
    Domingo: TDate;
  end;

implementation

end.
