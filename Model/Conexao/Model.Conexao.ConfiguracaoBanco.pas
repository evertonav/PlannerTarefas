unit Model.Conexao.ConfiguracaoBanco;

interface

uses
  System.IniFiles;

type
  TQualBanco = (qbFireBird, qbPostGre);

  IModelConexaoConfiguracaoBanco = interface
    ['{B8C8D127-A72A-4F31-A325-9B675FABE0F0}']
    function DriverBanco: string;
    function Porta: string;
    function Nome: string;
    function Caminho: string;
    function CaminhoCompleto: string;
    function Usuario: string;
    function Senha: string;
  end;

  TModelConexaoConfiguracaoBanco = class(TInterfacedObject, IModelConexaoConfiguracaoBanco)
  private
    FConfiguracao: TMemIniFile;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;

    function DriverBanco: string;
    function Nome: string;
    function Caminho: string;
    function CaminhoCompleto: string;
    function Usuario: string;
    function Senha: string;
    function Porta: string;

    class function Criar: IModelConexaoConfiguracaoBanco;
  end;

implementation

uses
  System.SysUtils;

{ TModelConexaoConfiguracaoBanco }

function TModelConexaoConfiguracaoBanco.Caminho: string;
begin
  Result := IncludeTrailingPathDelimiter(FConfiguracao.ReadString('BANCO_DADOS', 'CAMINHO', GetCurrentDir));
end;

function TModelConexaoConfiguracaoBanco.CaminhoCompleto: string;
begin
  if DriverBanco = 'PG' then
    Result := Nome
  else
    Result := Caminho + Nome;
end;

constructor TModelConexaoConfiguracaoBanco.Create;
begin
  FConfiguracao := TMemIniFile.Create(GetCurrentDir + '\Configuracao.ini');
end;

class function TModelConexaoConfiguracaoBanco.Criar: IModelConexaoConfiguracaoBanco;
begin
  Result := Self.Create;
end;

destructor TModelConexaoConfiguracaoBanco.Destroy;
begin
  if Assigned(FConfiguracao) then
    FConfiguracao.Free;

  inherited;
end;

function TModelConexaoConfiguracaoBanco.DriverBanco: string;
var
  lQualBanco: TQualBanco;
begin
  lQualBanco := TQualBanco(FConfiguracao.ReadInteger('BANCO_DADOS', 'QUAL_BANCO', 0));

  case lQualBanco of
    qbFireBird: Result := 'FB';
    qbPostGre: Result := 'PG';
  end;
end;

function TModelConexaoConfiguracaoBanco.Nome: string;
begin
  Result := FConfiguracao.ReadString('BANCO_DADOS', 'NOME', 'BANCO.FDB');
end;

function TModelConexaoConfiguracaoBanco.Porta: string;
begin
  Result := FConfiguracao.ReadString('BANCO_DADOS', 'PORTA', '');
end;

function TModelConexaoConfiguracaoBanco.Senha: string;
begin
  Result := FConfiguracao.ReadString('BANCO_DADOS', 'SENHA', 'masterkey');
end;

function TModelConexaoConfiguracaoBanco.Usuario: string;
begin
  Result := FConfiguracao.ReadString('BANCO_DADOS', 'USUARIO', 'SYSDBA');
end;

end.
