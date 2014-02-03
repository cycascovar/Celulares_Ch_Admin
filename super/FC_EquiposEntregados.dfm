object FCEquiposEntregados: TFCEquiposEntregados
  Left = 0
  Top = 0
  Caption = 'Equipos entregados'
  ClientHeight = 340
  ClientWidth = 727
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
    Top = 43
    Width = 711
    Height = 145
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Tipo'
        Width = 93
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Sucursal'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'IMEI'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ICCID'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Fecha entrega'
        Width = 84
        Visible = True
      end>
  end
  object DBLookupComboBox1: TDBLookupComboBox
    Left = 8
    Top = 16
    Width = 105
    Height = 21
    TabOrder = 1
  end
  object Button1: TButton
    Left = 176
    Top = 16
    Width = 75
    Height = 21
    Caption = 'Ver todos'
    TabOrder = 2
  end
end
