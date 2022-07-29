unit Model.Conexao.FireDac;

interface

uses
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.VCLUI.Wait,
  FireDAC.FMXUI.Wait,
  FireDAC.Comp.Client,
  FireDAC.Phys.FB,
  Data.DB;

type
  IModelConexao = interface
    ['{285D813E-69A2-4CBD-A03A-972174AEDB0A}']
    function Porta(const pValor: string): IModelConexao;
    function DriverID(const pValor: string): IModelConexao;
    function CaminhoDataBase(const pValor: string): IModelConexao;
    function Usuario(const pValor: string): IModelConexao;
    function Senha(const pValor: string): IModelConexao;

    function Conectar: TCustomConnection;
  end;

  TModelConexaoFireDac = class(TInterfacedObject, IModelConexao)
  private
    FConexao: TFDConnection;

    FPorta: string;
    FDriverID: string;
    FCaminhoDataBase: string;
    FUsuario: string;
    FSenha: string;
  protected
    function Conexao: TCustomConnection;
  public
    class function Criar: IModelConexao;

    constructor Create;
    destructor Destroy; override;

    function Porta(const pValor: string): IModelConexao;
    function DriverID(const pValor: string): IModelConexao;
    function CaminhoDataBase(const pValor: string): IModelConexao;
    function Usuario(const pValor: string): IModelConexao;
    function Senha(const pValor: string): IModelConexao;

    function Conectar: TCustomConnection; virtual;
  end;

implementation

uses
  System.SysUtils;

{ TModelConexaoFireDac }

function TModelConexaoFireDac.Conectar: TCustomConnection;
begin
  FConexao.Connected := False;
  try
    FConexao.Params.Values['Port'] := FPorta;
    FConexao.Params.Values['DriverID'] := FDriverID;
    FConexao.Params.Values['Database'] := FCaminhoDataBase;
    FConexao.Params.Values['USER_NAME'] := FUsuario;
    FConexao.Params.Values['Password'] := FSenha;
    FConexao.LoginPrompt := False;
    FConexao.Connected := True;

    Result := FConexao;
  except
    on E: Exception do
      raise Exception.Create('Erro de conexão com o banco de dados: ' + E.Message);
  end;
end;

function TModelConexaoFireDac.Conexao: TCustomConnection;
begin
  Result := FConexao;
end;

constructor TModelConexaoFireDac.Create;
begin
  FConexao := TFDConnection.Create(nil);
end;

class function TModelConexaoFireDac.Criar: IModelConexao;
begin
  Result := Self.Create;
end;

destructor TModelConexaoFireDac.Destroy;
begin
  if Assigned(FConexao) then
    FConexao.Free;

  inherited;
end;

function TModelConexaoFireDac.CaminhoDataBase(
  const pValor: string): IModelConexao;
begin
  FCaminhoDataBase := pValor;

  Result := Self;
end;

function TModelConexaoFireDac.DriverID(const pValor: string): IModelConexao;
begin
  FDriverID := pValor;

  Result := Self;
end;

function TModelConexaoFireDac.Porta(const pValor: string): IModelConexao;
begin
  FPorta := pValor;

  Result := Self;
end;

function TModelConexaoFireDac.Senha(const pValor: string): IModelConexao;
begin
  FSenha := pValor;

  Result := Self;
end;

function TModelConexaoFireDac.Usuario(const pValor: string): IModelConexao;
begin
  FUsuario := pValor;

  Result := Self;
end;

end.

