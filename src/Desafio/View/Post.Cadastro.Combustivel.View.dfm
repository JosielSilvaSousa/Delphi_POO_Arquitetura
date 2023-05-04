object frmCombustivel: TfrmCombustivel
  Left = 0
  Top = 0
  Caption = 'Cadastro de combust'#237'vel'
  ClientHeight = 115
  ClientWidth = 463
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 463
    Height = 74
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 13
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
    end
    object Label2: TLabel
      Left = 88
      Top = 13
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
    end
    object Label3: TLabel
      Left = 390
      Top = 13
      Width = 24
      Height = 13
      Caption = 'Valor'
    end
    object Label4: TLabel
      Left = 270
      Top = 13
      Width = 36
      Height = 13
      Caption = 'Tanque'
    end
    object Edit2: TEdit
      Left = 88
      Top = 32
      Width = 176
      Height = 21
      TabOrder = 1
    end
    object edtvalor: TMaskEdit
      Left = 390
      Top = 32
      Width = 62
      Height = 21
      EditMask = '0,00'
      MaxLength = 4
      TabOrder = 3
      Text = ' ,  '
    end
    object Codigo: TMaskEdit
      Left = 17
      Top = 32
      Width = 65
      Height = 21
      EditMask = '999'
      MaxLength = 3
      TabOrder = 0
      Text = '   '
      OnExit = CodigoExit
    end
    object edttanque: TEdit
      Left = 270
      Top = 32
      Width = 114
      Height = 21
      TabOrder = 2
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 74
    Width = 463
    Height = 41
    Align = alBottom
    TabOrder = 1
    object btnGravar: TButton
      Left = 72
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Gravar'
      TabOrder = 0
      OnClick = btnGravarClick
    end
    object btnExcluir: TButton
      Left = 270
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Excluir'
      TabOrder = 1
      OnClick = btnExcluirClick
    end
  end
end
