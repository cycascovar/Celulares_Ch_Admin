object F_Recargas: TF_Recargas
  Left = 0
  Top = 0
  Caption = 'Recargas'
  ClientHeight = 611
  ClientWidth = 512
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
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 81
    Height = 24
    Caption = 'Recargas'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 200
    Top = 53
    Width = 277
    Height = 13
    Caption = 'los codigos pueden estar asociados a uno o mas  numeros'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHighlight
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 8
    Top = 34
    Width = 516
    Height = 13
    Caption = 
      'Al leer un codigo con el lector de codigo de barras, se mostrar'#225 +
      'n los celulares (numeros) asociados al c'#243'digo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHighlight
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object codigogenerado: TLabel
    Left = 93
    Top = 410
    Width = 45
    Height = 13
    Caption = '               '
  end
  object Label5: TLabel
    Left = 34
    Top = 410
    Width = 37
    Height = 13
    Caption = 'Codigo:'
  end
  object Label6: TLabel
    Left = 34
    Top = 450
    Width = 94
    Height = 13
    Caption = 'Celular o celulares: '
  end
  object Label7: TLabel
    Left = 138
    Top = 521
    Width = 182
    Height = 13
    Caption = 'Separar los numeros con una coma ","'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHighlight
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 154
    Top = 410
    Width = 123
    Height = 13
    Caption = 'Traer los c'#243'digos de la BD'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHighlight
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object codigo: TEdit
    Left = 24
    Top = 53
    Width = 170
    Height = 21
    NumbersOnly = True
    TabOrder = 0
    OnKeyUp = codigoKeyUp
  end
  object DBGrid1: TDBGrid
    Left = 24
    Top = 80
    Width = 449
    Height = 298
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Codigo'
        Width = 174
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Celulares asignados'
        Width = 235
        Visible = True
      end>
  end
  object celulares: TMemo
    Left = 135
    Top = 450
    Width = 185
    Height = 65
    TabOrder = 2
  end
  object Button3: TButton
    Left = 25
    Top = 546
    Width = 113
    Height = 34
    Caption = 'Asignar numero'
    TabOrder = 3
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 592
    Width = 512
    Height = 19
    BiDiMode = bdRightToLeft
    Panels = <
      item
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        Text = 'Fecha'
        Width = 50
      end
      item
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        Text = '  '
        Width = 50
      end>
    ParentBiDiMode = False
    ExplicitWidth = 516
  end
  object ZQuery1: TZQuery
    Connection = FPrincipal.ZConexion
    Params = <>
    Left = 368
    Top = 184
  end
  object DataSource1: TDataSource
    Left = 392
    Top = 232
  end
  object ZQRecargas: TZQuery
    Params = <>
    Left = 408
    Top = 402
  end
  object DSRecargas: TDataSource
    Left = 312
    Top = 394
  end
  object Barcode_EAN1281: TBarcode_EAN128
    TextPosition = tpBottomOut
    TextAlignment = taCenter
    TextFont.Charset = DEFAULT_CHARSET
    TextFont.Color = clWindowText
    TextFont.Height = -11
    TextFont.Name = 'Tahoma'
    TextFont.Style = []
    Ratio = 2.000000000000000000
    Left = 416
    Top = 464
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 80
    Top = 592
  end
end
