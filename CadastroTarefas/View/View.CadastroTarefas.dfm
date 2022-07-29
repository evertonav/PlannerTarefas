object ViewCadastroTarefas: TViewCadastroTarefas
  Left = 0
  Top = 0
  Caption = 'Cadastro de Tarefas'
  ClientHeight = 349
  ClientWidth = 503
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlCabecalho: TPanel
    Left = 0
    Top = 0
    Width = 503
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Color = 13153533
    ParentBackground = False
    TabOrder = 0
    object lblCadastroTarefas: TLabel
      AlignWithMargins = True
      Left = 0
      Top = 10
      Width = 503
      Height = 31
      Margins.Left = 0
      Margins.Top = 10
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alClient
      Alignment = taCenter
      Caption = 'Cadastro de Tarefas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = cl3DDkShadow
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 150
      ExplicitHeight = 18
    end
  end
  object pnlContainer: TPanel
    Left = 0
    Top = 41
    Width = 503
    Height = 267
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 1
    object lblDataTarefa: TLabel
      Left = 9
      Top = 53
      Width = 73
      Height = 13
      Caption = 'Data da Tarefa'
    end
    object lblInicioTarefa: TLabel
      Left = 9
      Top = 99
      Width = 75
      Height = 13
      Caption = 'In'#237'cio da Tarefa'
    end
    object lblFimTarefa: TLabel
      Left = 9
      Top = 145
      Width = 66
      Height = 13
      Caption = 'Fim da Tarefa'
    end
    object lblTituloTarefa: TLabel
      Left = 9
      Top = 7
      Width = 76
      Height = 13
      Caption = 'T'#237'tulo da Tarefa'
    end
    object edtDataTarefa: TDBEdit
      Left = 9
      Top = 72
      Width = 121
      Height = 21
      DataField = 'DIA_TAREFA'
      DataSource = dsCadastroTarefas
      TabOrder = 0
    end
    object edtInicioTarefa: TDBEdit
      Left = 9
      Top = 118
      Width = 121
      Height = 21
      DataField = 'INICIO_TAREFA'
      DataSource = dsCadastroTarefas
      TabOrder = 1
    end
    object edtFimTarefa: TDBEdit
      Left = 8
      Top = 164
      Width = 121
      Height = 21
      DataField = 'FIM_TAREFA'
      DataSource = dsCadastroTarefas
      TabOrder = 2
    end
    object edtTituloTarefa: TDBEdit
      Left = 8
      Top = 26
      Width = 265
      Height = 21
      DataField = 'TITULO_TAREFA'
      DataSource = dsCadastroTarefas
      TabOrder = 3
    end
  end
  object pnlBotoesAcoes: TPanel
    Left = 0
    Top = 308
    Width = 503
    Height = 41
    Align = alBottom
    Color = clWhite
    ParentBackground = False
    TabOrder = 2
    object nvgCadastro: TDBNavigator
      Left = 1
      Top = 1
      Width = 501
      Height = 39
      DataSource = dsCadastroTarefas
      Align = alClient
      TabOrder = 0
    end
  end
  object dsCadastroTarefas: TDataSource
    Left = 352
    Top = 89
  end
end
