unit Controller.Helper;

interface

type
  TDateHelper = record Helper for TDate
    function FormatoDataVisual: string;
    function FormatoDataVisualApenasTime: string;
    function FormatoDataBanco: string;
    function FormatoDataIngles: string;
  end;

implementation

uses
  SysUtils;

{ TDateHelper }

function TDateHelper.FormatoDataIngles: string;
begin
  Result := FormatDateTime('yyyy-mm-dd', Self);
end;

function TDateHelper.FormatoDataVisual: string;
begin
  Result := FormatDateTime('dd/mm/yyyy', Self);
end;

function TDateHelper.FormatoDataVisualApenasTime: string;
begin
  Result := FormatDateTime('hh:mm:ss', Self);
end;

function TDateHelper.FormatoDataBanco: string;
begin
  Result := FormatDateTime('dd.mm.yyyy', Self);
end;

end.
