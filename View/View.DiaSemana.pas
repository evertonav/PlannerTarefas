unit View.DiaSemana;

interface

uses
  Controller.TipoDados.Utils;

type
  TViewDiaSemana = class
  private
    function GetDataDiaSemana(const pDataSegunda: TDate;
                              const pDiasSemana: TDiasSemana): TDate;

    function GetDataSegunda(const pDataAtual: TDate): TDate;
  public
    class function GetDataDiasSemana(const pDataAtual: TDate;
                                     const pDiasSemana: TDiasSemana): TDate; overload;

    class function GetDataDiasSemana(const pDataAtual: TDate): TDataDiasSemana; overload;
  end;



implementation

uses
  System.SysUtils;

{ TViewDiaSemana }

function TViewDiaSemana.GetDataDiaSemana(const pDataSegunda: TDate;
  const pDiasSemana: TDiasSemana): TDate;
begin
  Result := pDataSegunda;

  case pDiasSemana of
    dsTerca: Result := pDataSegunda + 1;
    dsQuarta: Result := pDataSegunda + 2;
    dsQuinta: Result := pDataSegunda + 3;
    dsSexta: Result := pDataSegunda + 4;
    dsSabado: Result := pDataSegunda + 5;
    dsDomingo: Result := pDataSegunda + 6;
  end;
end;

class function TViewDiaSemana.GetDataDiasSemana(const pDataAtual: TDate;
  const pDiasSemana: TDiasSemana): TDate;
var
  lDataDiaSemana: TViewDiaSemana;
begin
  lDataDiaSemana := TViewDiaSemana.Create;
  try
    Result := lDataDiaSemana.GetDataDiaSemana(lDataDiaSemana.GetDataSegunda(pDataAtual), pDiasSemana);
  finally
    lDataDiaSemana.Free;
  end;
end;

class function TViewDiaSemana.GetDataDiasSemana(
  const pDataAtual: TDate): TDataDiasSemana;
var
  lDataDiaSemana: TViewDiaSemana;
begin
  lDataDiaSemana := TViewDiaSemana.Create;
  try
    Result.Segunda := lDataDiaSemana.GetDataDiaSemana(lDataDiaSemana.GetDataSegunda(pDataAtual), dsSegunda);
    Result.Terca := lDataDiaSemana.GetDataDiaSemana(lDataDiaSemana.GetDataSegunda(pDataAtual), dsTerca);
    Result.Quarta := lDataDiaSemana.GetDataDiaSemana(lDataDiaSemana.GetDataSegunda(pDataAtual), dsQuarta);
    Result.Quinta := lDataDiaSemana.GetDataDiaSemana(lDataDiaSemana.GetDataSegunda(pDataAtual), dsQuinta);
    Result.Sexta := lDataDiaSemana.GetDataDiaSemana(lDataDiaSemana.GetDataSegunda(pDataAtual), dsSexta);
    Result.Sabado := lDataDiaSemana.GetDataDiaSemana(lDataDiaSemana.GetDataSegunda(pDataAtual), dsSabado);
    Result.Domingo := lDataDiaSemana.GetDataDiaSemana(lDataDiaSemana.GetDataSegunda(pDataAtual), dsDomingo);
  finally
    lDataDiaSemana.Free;
  end;
end;

function TViewDiaSemana.GetDataSegunda(const pDataAtual: TDate): TDate;
begin
  Result := pDataAtual;

  case TDiasSemana(DayOfWeek(pDataAtual)) of
    dsDomingo: Result := pDataAtual - 6; //DOMINGO
    dsTerca: Result := pDataAtual - 1;
    dsQuarta: Result := pDataAtual - 2;
    dsQuinta: Result := pDataAtual - 3;
    dsSexta: Result := pDataAtual - 4;
    dsSabado: Result := pDataAtual - 5;
  end;
end;

end.
