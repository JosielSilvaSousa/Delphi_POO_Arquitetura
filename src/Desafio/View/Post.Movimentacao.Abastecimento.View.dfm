object frmAbastecimento: TfrmAbastecimento
  Left = 0
  Top = 0
  Caption = 'Abastecimento Di'#225'rio'
  ClientHeight = 350
  ClientWidth = 468
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 64
    Top = 8
    Width = 331
    Height = 42
    Caption = 'Abastecimento do dia'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -35
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 255
    Top = 171
    Width = 58
    Height = 13
    Caption = 'Combustivel'
  end
  object Label3: TLabel
    Left = 345
    Top = 214
    Width = 97
    Height = 13
    Caption = 'Quantidade de litros'
  end
  object Label4: TLabel
    Left = 255
    Top = 125
    Width = 62
    Height = 13
    Caption = 'N'#186' da Bomba'
  end
  object Label5: TLabel
    Left = 255
    Top = 214
    Width = 44
    Height = 13
    Caption = 'Pagar R$'
  end
  object Label6: TLabel
    Left = 329
    Top = 125
    Width = 94
    Height = 13
    Caption = 'Valor o Combust'#237'vel'
  end
  object edtCumbustivel: TEdit
    Left = 255
    Top = 190
    Width = 181
    Height = 21
    TabOrder = 3
  end
  object edtLitros: TMaskEdit
    Left = 344
    Top = 233
    Width = 92
    Height = 21
    TabOrder = 5
    Text = ''
    OnExit = edtLitrosExit
  end
  object Panel2: TPanel
    Left = 0
    Top = 309
    Width = 468
    Height = 41
    Align = alBottom
    TabOrder = 6
    object Button3: TButton
      Left = 112
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Gravar'
      TabOrder = 0
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 344
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Limpar'
      TabOrder = 1
      OnClick = Button4Click
    end
  end
  object edtnumeroBomba: TEdit
    Left = 255
    Top = 144
    Width = 62
    Height = 21
    MaxLength = 1
    TabOrder = 2
    OnExit = edtnumeroBombaExit
  end
  object edtValor: TMaskEdit
    Left = -169
    Top = 352
    Width = 84
    Height = 21
    TabOrder = 7
    Text = ''
  end
  object rgdTipo: TRadioGroup
    Left = 255
    Top = 86
    Width = 185
    Height = 33
    Caption = 'Abastecer por'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Valor'
      'Litro')
    TabOrder = 1
    OnClick = rgdTipoClick
  end
  object edtData: TMaskEdit
    Left = 255
    Top = 59
    Width = 181
    Height = 21
    Enabled = False
    EditMask = '!99/99/0000;1;_'
    MaxLength = 10
    TabOrder = 0
    Text = '  /  /    '
  end
  object edtValorTotal: TMaskEdit
    Left = 255
    Top = 233
    Width = 57
    Height = 21
    TabOrder = 4
    Text = ''
    OnExit = edtValorTotalExit
  end
  object Memo1: TMemo
    Left = 255
    Top = 260
    Width = 185
    Height = 49
    Enabled = False
    Lines.Strings = (
      'Bombas 1 e 2 - Gasolina'
      'Bombas 3 e 4 - Diesel'
      'Imposto 15%')
    TabOrder = 8
  end
  object edtValorCombustivel: TMaskEdit
    Left = 329
    Top = 144
    Width = 107
    Height = 21
    TabOrder = 9
    Text = ''
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 57
    Width = 241
    Height = 252
    DataSource = DataSource1
    TabOrder = 10
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Id'
        Title.Caption = 'C'#243'digo'
        Width = 36
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Bomba'
        Width = 39
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Valor_Total'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Tipo_Combustivel'
        Title.Caption = 'Combustivel'
        Visible = True
      end>
  end
  object MainMenu1: TMainMenu
    Left = 16
    Top = 16
    object Combustvel1: TMenuItem
      Caption = 'Combust'#237'vel'
      OnClick = Combustvel1Click
    end
    object Bomba1: TMenuItem
      Caption = 'Bomba'
      OnClick = Bomba1Click
    end
    object Relatorio1: TMenuItem
      Caption = 'Relatorio'
      OnClick = Relatorio1Click
    end
  end
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 160
    Top = 128
    object FDMemTable1Id: TIntegerField
      FieldName = 'Id'
    end
    object FDMemTable1Bomba: TIntegerField
      FieldName = 'Bomba'
    end
    object FDMemTable1Valor_Total: TFloatField
      FieldName = 'Valor_Total'
    end
    object FDMemTable1Tipo_Combustivel: TStringField
      FieldName = 'Tipo_Combustivel'
      Size = 25
    end
  end
  object DataSource1: TDataSource
    DataSet = FDMemTable1
    Left = 152
    Top = 72
  end
end
