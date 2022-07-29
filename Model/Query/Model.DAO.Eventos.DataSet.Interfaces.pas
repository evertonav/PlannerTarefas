unit Model.DAO.Eventos.DataSet.Interfaces;

interface

uses
  Data.DB, FireDAC.Comp.DataSet;

type
  IModelDAOEventosDataSet = interface
    ['{D7F15A75-EA9F-4096-AA83-EC3A194D5FED}']
    function BeforePost(pValor: TDataSetNotifyEvent): IModelDAOEventosDataSet; overload;
    function BeforePost: TDataSetNotifyEvent; overload;
    function AfterDelete(pValor: TDataSetNotifyEvent): IModelDAOEventosDataSet; overload;
    function AfterDelete: TDataSetNotifyEvent; overload;
    function NewRecord(pValor: TDataSetNotifyEvent): IModelDAOEventosDataSet; overload;
    function NewRecord: TDataSetNotifyEvent; overload;
    function PostError(pValor: TDataSetErrorEvent): IModelDAOEventosDataSet; overload;
    function PostError: TDataSetErrorEvent;overload;
    function UpdateError: TFDUpdateErrorEvent; overload;
    function UpdateError(pValor: TFDUpdateErrorEvent): IModelDAOEventosDataSet; overload;

  end;

implementation

end.
