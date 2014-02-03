object FAlmacenSucursales: TFAlmacenSucursales
  Left = 0
  Top = 0
  Caption = 'FAlmacenSucursales'
  ClientHeight = 382
  ClientWidth = 690
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
    Left = 16
    Top = 16
    Width = 290
    Height = 13
    Caption = 'Mostrar sucursal, municipio, localidad, modelo, marca, precio'
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 80
    Width = 657
    Height = 169
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
end
