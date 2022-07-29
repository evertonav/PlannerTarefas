unit Model.Conexao.Feature;

interface

uses
  Data.DB,
  Model.Conexao.FireDac;

type
  IModelConexaoFeature = Interface
    ['{3C21BFA5-DB09-40A1-A1F2-B5EDB5601E7D}']
    function Conexao: TCustomConnection;
  end;

  TModelConexaoFeature = class(TInterfacedObject, IModelConexaoFeature)
  private
    FConexao: IModelConexao;
  public
    class function Criar: IModelConexaoFeature;
    function Conexao: TCustomConnection;
  end;

implementation

uses
  Model.Conexao.ConfiguracaoBanco,
  Model.Conexao.FireDac.PostGre,
  System.SysUtils;

{ TModelConexaoFeature }

function TModelConexaoFeature.Conexao: TCustomConnection;
var
  lConfiguracaoBanco: IModelConexaoConfiguracaoBanco;
begin
  lConfiguracaoBanco := TModelConexaoConfiguracaoBanco.Criar;

  if not Assigned(FConexao) then
  begin
    if lConfiguracaoBanco.DriverBanco = 'PG' then
      FConexao := TModelConexaoFireDacPostGre.Criar
    else
      FConexao := TModelConexaoFireDac.Criar;
  end;

  Result := FConexao
              .DriverID(lConfiguracaoBanco.DriverBanco)
              .CaminhoDataBase(lConfiguracaoBanco.CaminhoCompleto.Trim)
              .Usuario(lConfiguracaoBanco.Usuario.Trim)
              .Senha(lConfiguracaoBanco.Senha.Trim)
              .Porta(lConfiguracaoBanco.Porta.Trim)
              .Conectar;
end;

class function TModelConexaoFeature.Criar: IModelConexaoFeature;
begin
  Result := Self.Create;
end;

end.
