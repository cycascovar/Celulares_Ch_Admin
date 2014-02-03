object FUsuarios: TFUsuarios
  Left = 0
  Top = 0
  VertScrollBar.Visible = False
  Caption = 's'
  ClientHeight = 587
  ClientWidth = 753
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = t
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 144
    Width = 37
    Height = 13
    Caption = 'Nombre'
  end
  object Label2: TLabel
    Left = 16
    Top = 224
    Width = 40
    Height = 13
    Caption = 'Sucursal'
  end
  object Label3: TLabel
    Left = 16
    Top = 184
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object nombreEmpleado: TEdit
    Left = 72
    Top = 141
    Width = 137
    Height = 21
    TabOrder = 0
  end
  object PasswordEmpleado: TEdit
    Left = 72
    Top = 181
    Width = 137
    Height = 21
    TabOrder = 1
  end
  object Button1: TButton
    Left = 80
    Top = 263
    Width = 105
    Height = 25
    Caption = 'Agregar usuario'
    TabOrder = 2
    OnClick = Button1Click
  end
  object listaSucursales: TDBLookupComboBox
    Left = 72
    Top = 216
    Width = 137
    Height = 21
    ListSource = DSSucursal
    TabOrder = 3
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 8
    Width = 212
    Height = 120
    DataSource = DSEmpleados
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = DBGrid1CellClick
    OnKeyUp = DBGrid1KeyUp
    Columns = <
      item
        Expanded = False
        FieldName = 'Usuario'
        Width = 51
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Sucursal'
        Width = 76
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Password'
        Visible = True
      end>
  end
  object GroupBox1: TGroupBox
    Left = 226
    Top = 8
    Width = 519
    Height = 283
    Caption = 'Movimientos del empleado'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    object Empleado: TLabel
      Left = 18
      Top = 19
      Width = 58
      Height = 13
      Caption = 'Empleado:'
    end
    object usuario: TLabel
      Left = 82
      Top = 19
      Width = 35
      Height = 13
      Caption = 'usuario'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Button2: TButton
      Left = 16
      Top = 255
      Width = 145
      Height = 25
      Caption = 'Guardar movmientos'
      TabOrder = 0
      OnClick = Button2Click
    end
    object Memo1: TMemo
      Left = 16
      Top = 69
      Width = 489
      Height = 168
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 1
    end
    object Button3: TButton
      Left = 16
      Top = 38
      Width = 121
      Height = 25
      Caption = 'Ver movimientos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = Button3Click
    end
    object vertodos: TCheckBox
      Left = 143
      Top = 18
      Width = 306
      Height = 17
      Caption = 'ver movimientos de todos los empleados'
      TabOrder = 3
    end
  end
  object DSEmpleados: TDataSource
    DataSet = ZQEmpleados
    Left = 168
    Top = 80
  end
  object ZQEmpleados: TZQuery
    Connection = FPrincipalAdmin.ZConexion
    Params = <>
    Left = 168
    Top = 32
  end
  object DSSucursal: TDataSource
    DataSet = ZQSucursal
    Left = 192
    Top = 216
  end
  object ZQSucursal: TZQuery
    Connection = FPrincipalAdmin.ZConexion
    Params = <>
    Left = 16
    Top = 232
  end
end
