unit F_PrincipalAdmin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Grids, DBGrids, ZAbstractConnection, ZConnection,
  DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, Menus, Buttons, TeEngine,
  ExtCtrls, TeeProcs, Chart, DBChart;

type
  TFPrincipalAdmin = class(TForm)
    ZQGarantias: TZQuery;
    DSGarantias: TDataSource;
    ZConexion: TZConnection;
    MainMenu1: TMainMenu;
    Catalogos1: TMenuItem;
    Salir1: TMenuItem;
    Garantias: TPageControl;
    TabSheet1: TTabSheet;
    dbgrid1: TDBGrid;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    botonclientesgtia: TBitBtn;
    TabSheet4: TTabSheet;
    gridreparaciones: TDBGrid;
    ZQReparaciones: TZQuery;
    DSReparaciones: TDataSource;
    BitBtn1: TBitBtn;
    gridmenosv: TDBGrid;
    gridmasv: TDBGrid;
    gridequipos: TDBGrid;
    Label4: TLabel;
    botonclientes: TBitBtn;
    BitBtn2: TBitBtn;
    Button1: TButton;
    Button2: TButton;
    Clientes1: TMenuItem;
    Garantas1: TMenuItem;
    Reparaciones1: TMenuItem;
    Ventas1: TMenuItem;
    Usuarios1: TMenuItem;
    Movimientosdeusuario1: TMenuItem;
    Button3: TButton;
    procedure FormShow(Sender: TObject);
    procedure Clientesgarantia1Click(Sender: TObject);
    procedure Usuarios1Click(Sender: TObject);
    procedure Inventario1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure botonclientesClick(Sender: TObject);
    procedure Movimientosdeusuario1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPrincipalAdmin: TFPrincipalAdmin;

implementation
uses
    F_Usuarios, CClientesGarantia,F_AltaEquipos, FPrincipalEmpleados,FA_MovimientosU;


{$R *.dfm}

procedure TFPrincipalAdmin.botonclientesClick(Sender: TObject);
begin
    //Cargar formulario con clientes
end;

procedure TFPrincipalAdmin.Button3Click(Sender: TObject);
begin
    FAltaEquipo.Enabled := false;
    FAltaEquipo := TFAltaEquipo.Create(self);
    FAltaEquipo.ShowModal;
end;

procedure TFPrincipalAdmin.Clientesgarantia1Click(Sender: TObject);
begin                                                        //
    C_ClientesGarantia.Enabled := false;
    C_ClientesGarantia := TC_ClientesGarantia.Create(self);
    C_ClientesGarantia.ShowModal;
end;

procedure TFPrincipalAdmin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     ZQGarantias.Free;
     ZQReparaciones.Free;
{     ZQVMenor.Free;
     DSVMenor.Free;
     ZQVMayor.Free;}
end;

procedure TFPrincipalAdmin.FormCreate(Sender: TObject);
begin
    SetWindowLong(Handle, GWL_EXSTYLE, WS_EX_APPWINDOW);
end;

procedure TFPrincipalAdmin.FormShow(Sender: TObject);
var
    ZQVMenor : TZQuery;
    DSVMenor : TDataSource;
    ZQVMayor: TZQuery;
    DSVMayor: TDataSource;
    ZQAlmacenes : TZQuery;
    DSAlmacenes : TDataSource;
begin
//
    try
        ZQVMenor := TZQuery.Create(Application);
        ZQVMenor.Connection := ZConexion;
{        ZQVMenor.ShowRecordTypes := [usUnmodified,usModified,usInserted];
        ZQVMenor.Options := [doCalcDefaults];
        ZQVMenor.AutoCalcFields := true;}

        DSVMenor := TDataSource.Create(self);
        gridmenosv.DataSource := DSVMenor;
        DSVMenor.DataSet := ZQVMenor;

        gridmenosv.Columns[0].Width := 60;
        gridmenosv.Columns[1].Width := 80;
        gridmenosv.Columns[2].Width := 40;
        gridmenosv.Columns[3].Width := 30;
        gridmenosv.Columns[4].Width := 80;
    {Separa los equipos menos vendidos de los mas vendidos}
        ZQVMenor.Close;
        ZQVMenor.SQL.Clear;
        ZQVMenor.SQL.Add('SELECT marca_celular AS Marca, modelo_celular AS Modelo, Precio, COUNT(modelo_celular) AS "Total", sucursal FROM venta_detalle');
        ZQVMenor.SQL.Add('GROUP BY modelo,sucursal');
        ZQVMenor.SQL.Add('HAVING Total < 4');
        ZQVMenor.ExecSQL;
        ZQVMenor.Open;
        gridmenosv.Update;

        ZQVMayor := TZQuery.Create(self);
        ZQVMayor.Connection := ZConexion;
        ZQVMayor.ShowRecordTypes := [usUnmodified,usModified,usInserted];
        ZQVMayor.Options := [doCalcDefaults];
        ZQVMayor.AutoCalcFields := true;

        DSVMayor := TDataSource.Create(self);
        gridmasv.DataSource := DSVMayor;
        DSVMayor.DataSet := ZQVMayor;

        ZQVMayor.Close;
        ZQVMayor.SQL.Clear;
        ZQVMayor.SQL.Add('SELECT marca_celular AS Marca, modelo_celular AS Modelo, Precio, COUNT(modelo_celular) AS "Total", sucursal FROM venta_detalle');
        ZQVMayor.SQL.Add('GROUP BY modelo,sucursal');
        ZQVMayor.SQL.Add('HAVING Total >= 4');
        ZQVMayor.ExecSQL;
        ZQVMayor.Open;
        gridmasv.Update;
        gridmasv.Columns[0].Width := 60;
        gridmasv.Columns[1].Width := 100;
        gridmasv.Columns[2].Width := 40;
        gridmasv.Columns[3].Width := 30;
        gridmasv.Columns[4].Width := 80;

        {Consulta los equipos en garantias por todas las sucursales}
        DBGrid1.Columns[0].Width := 80;
        DBGrid1.Columns[1].Width := 80;
        DBGrid1.Columns[2].Width := 80;
        DBGrid1.Columns[3].Width := 100;
        DBGrid1.Columns[4].Width := 90;
        DBGrid1.Columns[5].Width := 100;
        DBGrid1.Columns[6].Width := 120;

        ZQGarantias.Close;
        ZQGarantias.SQL.Clear;
        ZQGarantias.SQL.Add('SELECT Sucursal, empleado AS "Recibido por", marca_equipo AS Marca, modelo_equipo AS Modelo, imei_equipo AS IMEI, nombre_cliente AS Titular, Observaciones,Fecha');
        ZQGarantias.SQL.Add('FROM sucursal');
        ZQGarantias.SQL.Add('JOIN equipo_garantia ON equipo_garantia.idsucursal = sucursal.idsucursal');
        ZQGarantias.SQL.Add('JOIN cliente_garantia ON cliente_garantia.idequipo_garantia = equipo_garantia.idequipo_garantia');
        ZQGarantias.SQL.Add('JOIN empleado ON empleado.idempleado = equipo_garantia.idempleado');
        ZQGarantias.ExecSQL;
        ZQGarantias.Open;
        DBGrid1.Update;

        gridReparaciones.Columns[0].Width := 80;
        gridReparaciones.Columns[1].Width := 80;
        gridReparaciones.Columns[2].Width := 80;
        gridReparaciones.Columns[3].Width := 100;
        gridReparaciones.Columns[4].Width := 90;
        gridReparaciones.Columns[5].Width := 100;
        gridReparaciones.Columns[6].Width := 120;

        {Consulta los equipos en reparaciones por todas las sucursales}
        ZQReparaciones.Close;
        ZQReparaciones.SQL.Clear;
        ZQReparaciones.SQL.Add('SELECT Sucursal, empleado AS "Recibido por", marca_equipo AS Marca, modelo_equipo AS Modelo, imei_equipo AS IMEI, nombre_cliente AS Titular, Observaciones,Fecha');
        ZQReparaciones.SQL.Add('FROM sucursal');
        ZQReparaciones.SQL.Add('JOIN equipo_reparacion ON equipo_reparacion.idsucursal = sucursal.idsucursal');
        ZQReparaciones.SQL.Add('JOIN cliente_reparacion ON cliente_reparacion.idequipo_reparacion = equipo_reparacion.idequipo_reparacion');
        ZQReparaciones.SQL.Add('JOIN empleado ON empleado.idempleado = equipo_reparacion.idempleado');
        ZQReparaciones.ExecSQL;
        ZQReparaciones.Open;
        gridReparaciones.Update;

        {Consulta los equipos en almacenes para todas las sucursales}
        ZQAlmacenes := TZQuery.Create(self);
        ZQAlmacenes.Connection := ZConexion;
        ZQAlmacenes.ShowRecordTypes := [usUnmodified,usModified,usInserted];
        ZQAlmacenes.Options := [doCalcDefaults];
        ZQAlmacenes.AutoCalcFields := true;

        DSAlmacenes := TDataSource.Create(self);
        gridequipos.DataSource := DSAlmacenes;
        DSAlmacenes.DataSet := ZQAlmacenes;


        gridequipos.Columns[0].Width := 80;
        gridequipos.Columns[1].Width := 80;
        gridequipos.Columns[2].Width := 120;
        gridequipos.Columns[3].Width := 100;
        gridequipos.Columns[4].Width := 120;
        gridequipos.Columns[5].Width := 100;
        gridequipos.Columns[6].Width := 80;

        ZQAlmacenes.Close;
        ZQAlmacenes.SQL.Clear;
        ZQAlmacenes.SQL.Add('SELECT Sucursal, marca_celular AS Marca, modelo_celular AS Modelo, imei_celular AS IMEI, iccid_celular AS ICCID, precioCelular AS Precio, numero_celular AS "Numero"');
        ZQAlmacenes.SQL.Add('FROM equipo_almacen');
        ZQAlmacenes.SQL.Add('JOIN sucursal ON sucursal.idsucursal = equipo_almacen.idsucursal');
        ZQAlmacenes.ExecSQL;
        ZQAlmacenes.Open;
        gridequipos.Update;
    finally

    end;
end;

procedure TFPrincipalAdmin.Inventario1Click(Sender: TObject);
begin
    FAltaEquipo.Enabled := false;
    FAltaEquipo := TFAltaEquipo.Create(self);
    FaltaEquipo.ShowModal;
end;

procedure TFPrincipalAdmin.Movimientosdeusuario1Click(Sender: TObject);
begin
    FMovimientosU.Enabled := false;
    FMovimientosU := TFMovimientosU.Create(self);
    FMovimientosU.ShowModal;
end;

procedure TFPrincipalAdmin.Usuarios1Click(Sender: TObject);
begin
    FUsuarios.Enabled := false;
    FUsuarios := TFUsuarios.Create(self);
    FUsuarios.ShowModal;
end;

end.
