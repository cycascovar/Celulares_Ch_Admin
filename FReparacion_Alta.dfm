object FReparacionesAlta: TFReparacionesAlta
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Agregar equipo a reparaci'#243'n'
  ClientHeight = 558
  ClientWidth = 386
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object LReparacion_Alta: TLabel
    Left = 16
    Top = 8
    Width = 253
    Height = 24
    Caption = 'Agregar equipo a reparaci'#243'n'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 38
    Width = 369
    Height = 139
    Caption = 'Datos del cliente'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object LRTitular: TLabel
      Left = 16
      Top = 24
      Width = 52
      Height = 19
      Caption = 'Titular:'
    end
    object LRPhone: TLabel
      Left = 16
      Top = 64
      Width = 154
      Height = 19
      Caption = 'Telefono de contacto:'
    end
    object ETitular: TEdit
      Left = 88
      Top = 28
      Width = 230
      Height = 27
      TabOrder = 0
    end
    object EPhone: TEdit
      Left = 176
      Top = 61
      Width = 142
      Height = 27
      TabOrder = 1
    end
  end
  object BitBtn1: TBitBtn
    Left = 16
    Top = 517
    Width = 105
    Height = 33
    Caption = 'Agregar'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 1
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 273
    Top = 517
    Width = 105
    Height = 33
    Caption = 'Cerrar'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 2
    OnClick = BitBtn2Click
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 190
    Width = 369
    Height = 321
    Caption = 'Datos del equipo'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBackground = False
    ParentColor = False
    ParentFont = False
    TabOrder = 3
    object Label1: TLabel
      Left = 16
      Top = 32
      Width = 26
      Height = 13
      Caption = 'IMEI:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 16
      Top = 72
      Width = 26
      Height = 13
      Caption = 'Folio:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 16
      Top = 112
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
    object Label5: TLabel
      Left = 16
      Top = 227
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
    object EIMEI: TEdit
      Left = 61
      Top = 29
      Width = 257
      Height = 27
      TabOrder = 0
    end
    object EFolio: TEdit
      Left = 62
      Top = 69
      Width = 257
      Height = 27
      TabOrder = 1
    end
    object Memo1: TMemo
      Left = 97
      Top = 112
      Width = 222
      Height = 89
      TabOrder = 2
    end
    object Memo2: TMemo
      Left = 97
      Top = 221
      Width = 221
      Height = 89
      TabOrder = 3
    end
  end
end
