object FMovimientosU: TFMovimientosU
  Left = 0
  Top = 0
  Caption = 'FMovimientosU'
  ClientHeight = 315
  ClientWidth = 647
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 288
    Top = 264
    Width = 105
    Height = 25
    Caption = 'Exportar a texto'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 8
    Top = 48
    Width = 631
    Height = 210
    TabOrder = 1
  end
  object Button2: TButton
    Left = 288
    Top = 17
    Width = 105
    Height = 25
    Caption = 'cargar'
    TabOrder = 2
    OnClick = Button2Click
  end
  object ZQuery1: TZQuery
    Connection = FPrincipal.ZConexion
    Params = <>
    Left = 464
    Top = 16
  end
  object DataSource1: TDataSource
    DataSet = ZQuery1
    Left = 496
    Top = 56
  end
end
