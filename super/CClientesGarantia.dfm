object C_ClientesGarantia: TC_ClientesGarantia
  Left = 0
  Top = 0
  Caption = 'C_ClientesGarantia'
  ClientHeight = 466
  ClientWidth = 1121
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 8
    Top = 51
    Width = 1089
    Height = 377
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Sucursal'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Titular'
        Visible = True
      end
      item
        Expanded = False
        Visible = True
      end
      item
        Expanded = False
        Visible = True
      end>
  end
  object sucursal: TEdit
    Left = 8
    Top = 24
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'sucursal'
  end
end
