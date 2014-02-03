object FGarantiasAlta: TFGarantiasAlta
  Left = 0
  Top = 0
  Caption = 'Alta de equipos en garant'#237'a'
  ClientHeight = 558
  ClientWidth = 428
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 8
    Width = 233
    Height = 24
    Caption = 'Agregar equipo a garantia'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object BitBtn1: TBitBtn
    Left = 302
    Top = 514
    Width = 115
    Height = 36
    Caption = 'Cerrar'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object BitBtn3: TBitBtn
    Left = 24
    Top = 514
    Width = 106
    Height = 36
    Caption = 'Guardar'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 1
    OnClick = BitBtn3Click
  end
  object datosClienteBox: TGroupBox
    Left = 8
    Top = 38
    Width = 409
    Height = 126
    Caption = 'Datos del cliente'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object LTitular: TLabel
      Left = 16
      Top = 25
      Width = 34
      Height = 13
      Caption = 'Titular:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object LPhone: TLabel
      Left = 16
      Top = 65
      Width = 106
      Height = 13
      Caption = 'Tel'#233'fono de contacto:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Edit1: TEdit
      Left = 56
      Top = 24
      Width = 288
      Height = 21
      TabOrder = 0
    end
    object Edit2: TEdit
      Left = 128
      Top = 57
      Width = 216
      Height = 21
      TabOrder = 1
    end
  end
  object datosEquipoBox: TGroupBox
    Left = 8
    Top = 184
    Width = 409
    Height = 313
    Caption = 'Datos del equipo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    object Label5: TLabel
      Left = 16
      Top = 119
      Width = 55
      Height = 13
      Caption = 'Accesorios:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 16
      Top = 71
      Width = 22
      Height = 13
      Caption = 'IMEI'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 16
      Top = 32
      Width = 29
      Height = 13
      Caption = 'Marca'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 3
      Top = 216
      Width = 75
      Height = 13
      Caption = 'Observaciones:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object imeiCelular: TEdit
      Left = 77
      Top = 71
      Width = 259
      Height = 27
      TabOrder = 0
    end
    object Edit5: TEdit
      Left = 77
      Top = 23
      Width = 259
      Height = 27
      TabOrder = 1
    end
  end
  object Memo1: TMemo
    Left = 85
    Top = 305
    Width = 259
    Height = 89
    TabOrder = 4
  end
  object Memo2: TMemo
    Left = 85
    Top = 400
    Width = 259
    Height = 89
    TabOrder = 5
  end
  object MainMenu1: TMainMenu
    Left = 312
    Top = 8
    object Inventario1: TMenuItem
      Caption = 'Inventario'
    end
    object Recargas1: TMenuItem
      Caption = 'Recargas'
    end
    object Garantas1: TMenuItem
      Caption = 'Garant'#237'as'
    end
    object Reparaciones1: TMenuItem
      Caption = 'Reparaciones'
    end
    object Ayuda1: TMenuItem
      Caption = 'Ayuda'
    end
    object Salir1: TMenuItem
      Caption = 'Salir'
    end
  end
end
