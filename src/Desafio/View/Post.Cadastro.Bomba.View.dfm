object frmBomba: TfrmBomba
  Left = 0
  Top = 0
  Caption = 'Cadastro de bomba'
  ClientHeight = 124
  ClientWidth = 406
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
    Width = 406
    Height = 83
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 13
      Width = 32
      Height = 13
      Caption = 'Bomba'
    end
    object Label2: TLabel
      Left = 87
      Top = 13
      Width = 70
      Height = 13
      Caption = 'ID combust'#237'vel'
    end
    object Label3: TLabel
      Left = 187
      Top = 13
      Width = 58
      Height = 13
      Caption = 'Combustivel'
    end
    object edtCombustivel: TEdit
      Left = 187
      Top = 32
      Width = 142
      Height = 21
      Enabled = False
      TabOrder = 1
    end
    object edtCodigo: TMaskEdit
      Left = 9
      Top = 32
      Width = 72
      Height = 21
      EditMask = '999'
      MaxLength = 3
      TabOrder = 0
      Text = '   '
      OnExit = edtCodigoExit
    end
    object edtIdCombustivel: TMaskEdit
      Left = 87
      Top = 32
      Width = 93
      Height = 21
      EditMask = '99;0;_'
      MaxLength = 2
      TabOrder = 2
      Text = ''
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 83
    Width = 406
    Height = 41
    Align = alBottom
    TabOrder = 1
    object Button1: TButton
      Left = 40
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Gravar'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 208
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Excluir'
      TabOrder = 1
      OnClick = Button2Click
    end
  end
end
