object FRecargasAlta: TFRecargasAlta
  Left = 0
  Top = 0
  Caption = 'Recargas: Alta de c'#243'digo'
  ClientHeight = 266
  ClientWidth = 377
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 37
    Width = 198
    Height = 13
    Caption = 'Se generara un codigo al abrir la ventana'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHighlight
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 98
    Top = 56
    Width = 37
    Height = 13
    Caption = '$codigo'
  end
  object Label3: TLabel
    Left = 34
    Top = 56
    Width = 37
    Height = 13
    Caption = 'Codigo:'
  end
  object Label4: TLabel
    Left = 34
    Top = 112
    Width = 94
    Height = 13
    Caption = 'Celular o celulares: '
  end
  object Label5: TLabel
    Left = 138
    Top = 183
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
  object Button1: TButton
    Left = 139
    Top = 216
    Width = 113
    Height = 41
    Caption = 'Generar otro c'#243'digo'
    TabOrder = 0
    OnClick = Button1Click
  end
  object celulares: TMemo
    Left = 135
    Top = 112
    Width = 185
    Height = 65
    TabOrder = 1
  end
  object Button2: TButton
    Left = 260
    Top = 216
    Width = 113
    Height = 41
    Caption = 'Cerrar'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 11
    Top = 216
    Width = 113
    Height = 41
    Caption = 'Guardar'
    TabOrder = 3
    OnClick = Button1Click
  end
  object ZQRecargas: TZQuery
    Params = <>
    Left = 304
    Top = 48
  end
  object DSRecargas: TDataSource
    Left = 240
    Top = 64
  end
end
