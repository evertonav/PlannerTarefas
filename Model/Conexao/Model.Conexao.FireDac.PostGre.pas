unit Model.Conexao.FireDac.PostGre;

interface

uses
  Model.Conexao.FireDac,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Phys.PG;

type
  TModelConexaoFireDacPostGre = class(TModelConexaoFireDac)
  private
    FpgdDriverLink: TFDPhysPgDriverLink;
  public
    function Conectar: TCustomConnection; override;
  end;

implementation

uses
  System.SysUtils;

{ TModelConexaoFireDacPostGre }

function TModelConexaoFireDacPostGre.Conectar: TCustomConnection;
begin
  if not Assigned(FpgdDriverLink) then
    FpgdDriverLink := TFDPhysPgDriverLink.Create(Self.Conexao);

  FpgdDriverLink.VendorHome := GetCurrentDir;

  inherited;

  Result := Self.Conexao;
end;

end.
