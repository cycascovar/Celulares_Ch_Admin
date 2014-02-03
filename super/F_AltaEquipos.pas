unit F_AltaEquipos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, Grids, DBGrids, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset;

type
  TFAltaEquipo = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    listaSucursales: TDBLookupComboBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    marcaequipo: TEdit;
    modeloequipo: TEdit;
    imeiequipo: TEdit;
    iccidequipo: TEdit;
    numeroequipo: TEdit;
    Button1: TButton;
    Button2: TButton;
    precioequipo: TEdit;
    Label8: TLabel;
    DBAlmacenes: TDBGrid;
    ZQSucursales: TZQuery;
    DSSucursales: TDataSource;
    sucursal: TEdit;
    DSListaSuc: TDataSource;
    ZQListaSuc: TZQuery;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure sucursalKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    ZQMovimientos: TZQuery;
  public
    { Public declarations }
  end;

var
  FAltaEquipo: TFAltaEquipo;

implementation
uses
    FPrincipalEmpleados,F_PrincipalAdmin;

{$R *.dfm}

procedure TFAltaEquipo.Button1Click(Sender: TObject);
var
    idSucursal : Integer;
begin
    idSucursal := listaSucursales.KeyValue.

    ZQSucursales.Close;
    ZQSucursales.SQL.Clear;
    ZQSucursales.SQL.Add('INSERT INTO equipo_almacen (idsucursal,marca_celular, modelo_celular, iccid_celular, imei_celular, numero_celular, precioCelular)');
    ZQSucursales.SQL.Add('VALUES ('+IntToStr(idSucursal)+',"'+marcaequipo.Text+'","'+modeloequipo.Text+'","'+iccidequipo.Text+'","'+imeiequipo.Text+'","'+numeroequipo.Text+'","'+precioequipo.Text+'")');
    ZQSucursales.ExecSQL;
    ZQSucursales.Close;
    ZQSucursales.SQL.Clear;
    ZQSucursales.SQL.Add('SELECT sucursal, marca_celular AS Marca, modelo_celular AS Modelo, imei_celular AS IMEI, iccid_celular AS ICCID, numero_celular AS Numero, precioCelular AS Precio');
    ZQSucursales.SQL.Add('FROM equipo_almacen');
    ZQSucursales.SQL.Add('JOIN sucursal ON sucursal.idsucursal = equipo_almacen.idsucursal;');
    ZQSucursales.ExecSQL;
    ZQSucursales.Open();
    DBAlmacenes.Update;
    Application.MessageBox('Equipo agregado exitosamente.','Información',MB_ICONINFORMATION);
end;

procedure TFAltaEquipo.FormCreate(Sender: TObject);
begin
    ZQMovimientos := TZQuery.Create(self);
    ZQMovimientos.Connection := FPrincipalAdmin.ZConexion;
    ZQMovimientos.ShowRecordTypes := [usUnmodified,usModified,usInserted];
    ZQMovimientos.Options := [doCalcDefaults];
    ZQMovimientos.AutoCalcFields := true;
end;

procedure TFAltaEquipo.FormShow(Sender: TObject);
begin
//Generar ZQuery
    ZQSucursales.Close;
    ZQSucursales.SQL.Clear;
    ZQSucursales.SQL.Add('SELECT sucursal, marca_celular AS Marca, modelo_celular AS Modelo, imei_celular AS IMEI, iccid_celular AS ICCID, numero_celular AS Numero, precioCelular AS Precio');
    ZQSucursales.SQL.Add('FROM equipo_almacen');
    ZQSucursales.SQL.Add('JOIN sucursal ON sucursal.idsucursal = equipo_almacen.idsucursal;');
    ZQSucursales.ExecSQL;
    ZQSucursales.Open();
    DBAlmacenes.Update;

    DBAlmacenes.Columns[6].Width := 45;

    ZQListaSuc.Close;
    ZQListaSuc.SQL.Clear;
    ZQListaSuc.SQL.Add('SELECT * FROM sucursal');
    ZQListaSuc.ExecSQL;
    ZQListaSuc.Open;

    listaSucursales.ListField := 'sucursal';
    listaSucursales.KeyField := 'idsucursal';
end;

procedure TFAltaEquipo.sucursalKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    ZQSucursales.Filtered := false;
    ZQSucursales.Filter := 'Sucursal LIKE'+QuotedStr('*'+sucursal.Text+'*');
    ZQSucursales.Filtered := true;
end;

end.
