object FAlmacenVenta: TFAlmacenVenta
  Left = 0
  Top = 0
  Caption = 'Ventas: Venta de equipo'
  ClientHeight = 432
  ClientWidth = 634
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
  object Button1: TButton
    Left = 8
    Top = 377
    Width = 81
    Height = 33
    Caption = 'Vender'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 128
    Top = 377
    Width = 129
    Height = 33
    Caption = 'Limpiar datos cliente'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 296
    Top = 377
    Width = 81
    Height = 33
    Caption = 'Cerrar'
    TabOrder = 2
    OnClick = Button3Click
  end
end
