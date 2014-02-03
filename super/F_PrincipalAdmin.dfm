object FPrincipalAdmin: TFPrincipalAdmin
  Left = 0
  Top = 0
  Caption = 'Sistema para administradores: Res'#250'men general'
  ClientHeight = 396
  ClientWidth = 805
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Garantias: TPageControl
    Left = 5
    Top = 8
    Width = 792
    Height = 377
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Garantias'
      object dbgrid1: TDBGrid
        Left = 3
        Top = 3
        Width = 770
        Height = 280
        DataSource = DSGarantias
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
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
            Width = 120
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Recibido por'
            Width = 69
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Marca'
            Width = 113
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Modelo'
            Width = 96
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'IMEI'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Titular'
            Width = 46
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Observaciones'
            Width = 154
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Fecha'
            Visible = True
          end>
      end
      object botonclientesgtia: TBitBtn
        Left = 16
        Top = 295
        Width = 97
        Height = 34
        Caption = 'Ver clientes'
        DoubleBuffered = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentDoubleBuffered = False
        ParentFont = False
        TabOrder = 1
      end
      object Button1: TButton
        Left = 119
        Top = 295
        Width = 145
        Height = 34
        Caption = 'Equipos entregados'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Reparaciones'
      ImageIndex = 1
      object gridreparaciones: TDBGrid
        Left = 3
        Top = 3
        Width = 765
        Height = 278
        DataSource = DSReparaciones
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
            FieldName = 'Recibido por'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Marca'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Modelo'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'IMEI'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Titular'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Observaciones'
            Width = 115
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Fecha'
            Visible = True
          end>
      end
      object BitBtn2: TBitBtn
        Left = 16
        Top = 295
        Width = 97
        Height = 34
        Caption = 'Ver clientes'
        DoubleBuffered = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentDoubleBuffered = False
        ParentFont = False
        TabOrder = 1
      end
      object Button2: TButton
        Left = 119
        Top = 295
        Width = 145
        Height = 34
        Caption = 'Equipos entregados'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Ventas'
      ImageIndex = 2
      object Label1: TLabel
        Left = 3
        Top = 3
        Width = 107
        Height = 13
        Caption = 'Estadisticas de ventas'
      end
      object Label2: TLabel
        Left = 3
        Top = 40
        Width = 105
        Height = 13
        Caption = 'Equipos mas vendidos'
      end
      object Label3: TLabel
        Left = 395
        Top = 40
        Width = 117
        Height = 13
        Caption = 'Equipos menos vendidos'
      end
      object gridmenosv: TDBGrid
        Left = 395
        Top = 59
        Width = 366
        Height = 230
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'Marca'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Modelo'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Precio'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Total'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Sucursal'
            Visible = True
          end>
      end
      object gridmasv: TDBGrid
        Left = 3
        Top = 59
        Width = 350
        Height = 230
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      object botonclientes: TBitBtn
        Left = 278
        Top = 295
        Width = 75
        Height = 41
        Caption = 'Ver clientes'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 2
        OnClick = botonclientesClick
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Almacenes'
      ImageIndex = 3
      object Label4: TLabel
        Left = 3
        Top = 3
        Width = 98
        Height = 13
        Caption = 'Equipos por sucursal'
      end
      object BitBtn1: TBitBtn
        Left = 478
        Top = 201
        Width = 75
        Height = 25
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 0
      end
      object gridequipos: TDBGrid
        Left = 3
        Top = 22
        Width = 778
        Height = 243
        TabOrder = 1
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
            FieldName = 'Marca'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Modelo'
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
            FieldName = 'Precio'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Numero'
            Visible = True
          end>
      end
      object Button3: TButton
        Left = 272
        Top = 288
        Width = 105
        Height = 41
        Caption = 'Agregar equipo'
        TabOrder = 2
        OnClick = Button3Click
      end
    end
  end
  object ZQGarantias: TZQuery
    Connection = ZConexion
    Params = <>
    Left = 16
    Top = 320
  end
  object DSGarantias: TDataSource
    DataSet = ZQGarantias
    Left = 16
    Top = 288
  end
  object ZConexion: TZConnection
    Catalog = 'chdesarrollo'
    Protocol = 'mysql-5'
    HostName = 'localhost'
    Database = 'chdesarrollo'
    User = 'root'
    Password = 'toor'
    Left = 624
    Top = 336
  end
  object MainMenu1: TMainMenu
    Left = 544
    Top = 336
    object Catalogos1: TMenuItem
      Caption = 'Catalogos'
      object Clientes1: TMenuItem
        Caption = 'Clientes'
        object Ventas1: TMenuItem
          Caption = 'Ventas'
        end
        object Reparaciones1: TMenuItem
          Caption = 'Reparaciones'
        end
        object Garantas1: TMenuItem
          Caption = 'Garant'#237'as'
        end
      end
      object Usuarios1: TMenuItem
        Caption = 'Usuarios'
        OnClick = Usuarios1Click
      end
      object Movimientosdeusuario1: TMenuItem
        Caption = 'Movimientos de usuario'
        OnClick = Movimientosdeusuario1Click
      end
    end
    object Salir1: TMenuItem
      Caption = 'Salir'
    end
  end
  object ZQReparaciones: TZQuery
    Connection = ZConexion
    Params = <>
    Left = 720
    Top = 208
  end
  object DSReparaciones: TDataSource
    DataSet = ZQReparaciones
    Left = 720
    Top = 256
  end
end
