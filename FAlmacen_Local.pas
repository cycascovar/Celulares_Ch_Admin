unit FAlmacen_Local;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Menus, Buttons, Grids, DBGrids, DB, DBClient,
  ComCtrls, ZAbstractRODataset, ZAbstractDataset, ZDataset, ValEdit, OleServer,
  ExcelXP, QRExport;

type
  TFAlmacenLocal = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    marcaCel: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    GridAlmacen: TDBGrid;
    Label3: TLabel;
    barraP: TProgressBar;
    DSAlmacen: TDataSource;
    ZQAlmacen: TZQuery;
    ZQVentas: TZQuery;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    nombreCliente: TEdit;
    telefonoCliente: TEdit;
    domicilioCliente: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    marcaCelular: TLabel;
    modeloCelular: TLabel;
    imeiCelular: TLabel;
    precioCelular: TLabel;
    Button1: TButton;
    StatusBar1: TStatusBar;
    _iccidcelular: TLabel;
    iccidcelular: TLabel;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    totalequipos: TLabel;
    Label12: TLabel;
    Excel: TExcelApplication;
    Timer1: TTimer;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure GridAlmacenCellClick(Column: TColumn);
    procedure marcaCelKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure GridAlmacenKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn4Click(Sender: TObject);
    procedure Edit3KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit2KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Timer1Timer(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Imei,iccid : String;
    Modelo: String;
    Marca: String;
    precio: Double;
    idEquipoAlmacen : Integer;
    ZQMovimiento : TZquery;

    function totalInventario(ZQAlmacen:TZQuery): Integer;
  end;

var
  FAlmacenLocal: TFAlmacenLocal;

implementation
uses FAlmacen_Venta, FPrincipalEmpleados, F_Login;
{$R *.dfm}

procedure TFAlmacenLocal.BitBtn1Click(Sender: TObject);
var
    total : Integer;
begin
    Marca := GridAlmacen.Fields[0].AsString;
    Modelo := GridAlmacen.Fields[1].AsString;
    Imei := GridAlmacen.Fields[2].AsString;
    iccid := GridAlmacen.Fields[3].AsString;
    precio := GridAlmacen.Fields[4].AsFloat;

    if (Marca <> '') then
    begin
        if (nombreCliente.Text <> '') then
        begin
            ZQAlmacen.Close;
            ZQAlmacen.SQL.Clear;
            ZQAlmacen.SQL.Add('INSERT INTO cliente (nombre, domicilio, telefono, sucursal)');
            ZQAlmacen.SQL.Add('VALUES ("'+nombreCliente.Text+'","'+domicilioCliente.Text+'","'+telefonocliente.Text+'","'+FPrincipal.sucursal+'")');
            ZQAlmacen.ExecSQL;

            ZQAlmacen.SQL.Clear;
            ZQAlmacen.SQL.Add('INSERT INTO venta_detalle (fecha_venta, modelo_celular, marca_celular, imei_celular, iccid_celular, empleado, sucursal,precio)');
            ZQAlmacen.SQL.Add('VALUES ("'+FormatDateTime('YYYY/MM/DD',Date())+'","'+modelo+'","'+marca+'","'+imei+'","'+iccid+'","'+FLogin.username.Text+'","'+FPrincipal.sucursal+'","'+FloatToStr(precio)+'")');
            ZQAlmacen.ExecSQL();

            ZQAlmacen.SQL.Clear();
            ZQAlmacen.SQL.Add('DELETE FROM equipo_almacen WHERE imei_celular="'+imei+'"');
            ZQAlmacen.ExecSQL();

            ZQAlmacen.SQL.Clear();
            ZQAlmacen.SQL.Add('SELECT COUNT(*) AS Total FROM equipo_almacen');
            ZQAlmacen.SQL.Add('WHERE idsucursal='+IntToStr(FPrincipal.idSucursal));
            ZQAlmacen.ExecSQL;
            ZQAlmacen.Open;
            total := ZQAlmacen.FieldByName('Total').AsInteger;
            totalequipos.Caption := IntToStr(total);


            ZQAlmacen.SQL.Clear();
            ZQAlmacen.SQL.Add('SELECT marca_celular Marca, modelo_celular Modelo, imei_celular IMEI, iccid_celular ICCID, precioCelular Precio');
            ZQAlmacen.SQL.Add('FROM equipo_almacen');
            ZQAlmacen.SQL.Add('JOIN sucursal ON equipo_almacen.idsucursal = sucursal.idsucursal');
            ZQAlmacen.SQL.Add('AND equipo_almacen.idsucursal = '+IntToStr(FPrincipal.idSucursal)+'');
            ZQAlmacen.ExecSQL();
            ZQAlmacen.Open();
            gridAlmacen.Update();

            ZQMovimiento.Close;
            ZQMovimiento.SQL.Clear;
            ZQMovimiento.SQL.Add('INSERT INTO empleado_movimiento (movimiento,movimiento_detalles, sucursal, empleado, fecha)');
            ZQMovimiento.SQL.Add('VALUES ("Venta de equipo.","El usuario '+Flogin.username.Text+' ha vendido un equipo el dia '+DateToStr(date())+' a las '+TimeToStr(Time())+'","'+FPrincipal.sucursal+'","'+Flogin.username.Text+'","'+FormatDateTime('YYYY/MM/DD',Date())+'")');
            ZQMovimiento.ExecSQL;

            Application.MessageBox('Equipo vendido.','Información',MB_ICONINFORMATION);
        end else
            raise Exception.Create('Error: Hace falta ingresar el nombre del cliente.');
    end
    else
//        Application.MessageBox('No hay ningun equipo seleccionado.','Información',MB_ICONINFORMATION);
        raise Exception.Create('Error: No hay ningun equipo seleccionado.');
end;

procedure TFAlmacenLocal.BitBtn2Click(Sender: TObject);
var
    i,b : Integer;
    Libro : _WORKBOOK;
    Hoja : _WORKSHEET;
begin
    try
        barraP.Visible := true;
        barraP.Max := gridAlmacen.DataSource.DataSet.RecordCount;
        i := 4;
         Libro := Excel.Workbooks.Add(NULL, 0);

         Hoja := Libro.Sheets[1] as _WORKSHEET;
         Hoja.Cells.Item[1,1].ColumnWidth := 2;
//         Definicion de columnas para reportes en Excel:

        Hoja.Cells.Item[2,3]:='Listado de equipos en almacen para la sucursal '+FPrincipal.Sucursal +' del dia '+DateToStr(Date());
        Hoja.Cells.Item[2,3].font.size:=16;
        Hoja.Cells.Item[3,3].font.size:=15;
        Hoja.Cells.Item[3,3]:='Cantidad de equipos: '+totalEquipos.Caption;
        Hoja.Cells.Item[4,2]:='Marca';
        Hoja.Cells.Item[4,2].ColumnWidth := 10;
        Hoja.Cells.Item[4,3]:='Modelo';
        Hoja.Cells.Item[4,3].ColumnWidth := 10;
        Hoja.Cells.Item[4,4]:='IMEI';
        Hoja.Cells.Item[4,4].ColumnWidth := 30;
        Hoja.Cells.Item[4,5]:='ICCID';
        Hoja.Cells.Item[4,5].ColumnWidth := 40;
        Hoja.Cells.Item[4,6]:='Precio';
        Hoja.Cells.Item[4,6].ColumnWidth := 10;


         with ZQAlmacen do
         begin
             First;
             while not EOF do
             begin
                 Application.ProcessMessages;
                 i:=i+1;
                 Hoja.Cells.Item[i,2] := gridalmacen.Fields[0].AsString;
                 Hoja.Cells.Item[i,3] := gridalmacen.Fields[1].AsString;
                 Hoja.Cells.Item[i,4] := gridalmacen.Fields[2].AsLargeInt;
                 Hoja.Cells.Item[i,4].WrapText := TRUE;
                 Hoja.Cells.Item[i,5] := gridalmacen.Fields[3].AsLargeInt;

                 Hoja.Cells.Item[i,6].WrapText := TRUE;
                 Hoja.Cells.Item[i,6] := gridalmacen.Fields[4].AsString;
                 Next;
                 barraP.StepIt();
             end;
         end;


    For b:=4 to i do
    begin
        Hoja.Range['b'+IntToStr(b),'b'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
        Hoja.Range['c'+IntToStr(b),'c'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
        Hoja.Range['d'+IntToStr(b),'d'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
        Hoja.Range['e'+IntToStr(b),'e'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
        Hoja.Range['f'+IntToStr(b),'f'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
    end;

      i:=i+3;
//      Hoja.Cells.Item[i,2]:='Total dotado en la ruta '+ltotal.Caption;
   //   Hoja.Cells.Item[i,2].Formula:='SUMA()';
      Hoja.Cells.Item[i,2].font.size:=16;
    finally
        barraP.Visible := false;
        Excel.Visible[1]:=true;
        Application.MessageBox('Datos exportados a Excel.','Información',MB_ICONINFORMATION);
    end;
end;

procedure TFAlmacenLocal.BitBtn3Click(Sender: TObject);
begin
    FAlmacenLocal.Close;
end;

procedure TFAlmacenLocal.BitBtn4Click(Sender: TObject);
begin
    marcaCel.Clear();
    Edit2.Clear();
    Edit3.Clear();

    ZQAlmacen.Close;
    ZQAlmacen.SQL.Clear;
    ZQAlmacen.SQL.Add('SELECT marca_celular Marca, modelo_celular Modelo, imei_celular IMEI, iccid_celular ICCID, precioCelular Precio');
    ZQAlmacen.SQL.Add('FROM equipo_almacen');
    ZQAlmacen.SQL.Add('JOIN sucursal ON equipo_almacen.idsucursal = sucursal.idsucursal');
    ZQAlmacen.SQL.Add('AND equipo_almacen.idsucursal = '+IntToStr(FPrincipal.idSucursal)+'');
    ZQAlmacen.ExecSQL();
    ZQAlmacen.Open;
    gridAlmacen.Update;
    ZQAlmacen.Filtered := false;
end;

procedure TFAlmacenLocal.BitBtn5Click(Sender: TObject);
var
    ZQVenta : TZQuery;
    DSVenta : TDataSource;
    Libro : _WORKBOOK;
    Hoja : _WORKSHEET;
    i,b, total: Integer;
    totalVentas : Double;
begin
    try
        FormatSettings.ShortDateFormat := 'yyyy-mm-dd';
        barraP.Visible := true;

        ZQVenta := TZQuery.Create(self);
        ZQVenta.Connection := FPrincipal.ZConexion;
        DSVenta := TDataSource.Create(self);
        DSVenta.DataSet := ZQVenta;

        ZQVenta.Close();
        ZQVenta.SQL.Clear();
        ZQVenta.SQL.Add('SELECT COUNT(*) AS Total FROM venta_detalle WHERE sucursal="'+Fprincipal.sucursal+'" AND fecha_venta="'+DateToStr(Date())+'"');
        ZQVenta.ExecSQL;
        ZQVenta.Open;

        total := ZQVenta.FieldByName('Total').AsInteger;
        barraP.Max := total;

        ZQVenta.Close();
        ZQVenta.SQL.Clear();
        ZQVenta.SQL.Add('SELECT SUM(precio) AS Venta FROM venta_detalle WHERE sucursal="'+Fprincipal.sucursal+'" AND fecha_venta="'+DateToStr(Date())+'"');
        ZQVenta.ExecSQL;
        ZQVenta.Open;
        totalVentas := ZQVenta.FieldByName('Venta').AsInteger;
// ---
        ZQVenta.Close();
        ZQVenta.SQL.Clear();
        ZQVenta.SQL.Add('SELECT fecha_venta AS "Fecha de venta", marca_celular AS "Marca", modelo_celular AS "Modelo", empleado, precio, iccid_celular AS "ICCID", sucursal');
        ZQVenta.SQL.Add('FROM venta_detalle');
        ZQVenta.SQL.Add('WHERE sucursal="'+FPrincipal.sucursal+'"');
        ZQVenta.SQL.Add('AND fecha_venta="'+DateToStr(Date())+'"');
        ZQVenta.ExecSQL();
        ZQVenta.Open();
        FormatSettings.ShortDateFormat := 'dd/mm/yyyy';
        i := 4;
        Libro := Excel.Workbooks.Add(NULL, 0);
        Hoja := Libro.Sheets[1] as _WORKSHEET;
        Hoja.Cells.Item[1,1].ColumnWidth := 2;

        {Crea una hoja en excel con las siguientes cabeceras}
        Hoja.Cells.Item[2,3]:='Listado de ventas para la sucursal '+FPrincipal.Sucursal +'. Fecha: '+DateToStr(Date());
        Hoja.Cells.Item[2,3].font.size:=16;
        Hoja.Cells.Item[3,3].font.size:=15;
        Hoja.Cells.Item[3,3]:='Cantidad de equipos vendidos: '+IntToStr(total);
        Hoja.Cells.Item[4,2]:='Fecha de Venta';
        Hoja.Cells.Item[4,2].ColumnWidth := 10;
        Hoja.Cells.Item[4,3]:='Marca';
        Hoja.Cells.Item[4,3].ColumnWidth := 15;
        Hoja.Cells.Item[4,4]:='Modelo';
        Hoja.Cells.Item[4,4].ColumnWidth := 15;
        Hoja.Cells.Item[4,5]:='Empleado';
        Hoja.Cells.Item[4,5].ColumnWidth := 15;
        Hoja.Cells.Item[4,6]:='Precio';
        Hoja.Cells.Item[4,6].ColumnWidth := 12;
        Hoja.Cells.Item[4,7]:='ICCID';
        Hoja.Cells.Item[4,7].ColumnWidth := 14;
        Hoja.Cells.Item[4,8]:='Sucursal';
        Hoja.Cells.Item[4,8].ColumnWidth := 15;

        Hoja.Cells.Item[2,10] := 'Total: $'+FloatToStr(totalVentas);
        Hoja.Cells.Item[2,10].font.size := 15;

         with ZQVenta do
         begin
             First;
             while not EOF do
             begin
                Application.ProcessMessages;
                 i:=i+1;
                 Hoja.Cells.Item[i,2] := ZQVenta.FieldByName('Fecha de Venta').AsDateTime;
                 Hoja.Cells.Item[i,3] := ZQVenta.FieldByName('Marca').AsString;
                 Hoja.Cells.Item[i,4] := ZQVenta.FieldByName('Modelo').AsString;
                 Hoja.Cells.Item[i,4].WrapText := TRUE;
                 Hoja.Cells.Item[i,5] := ZQVenta.FieldByName('Empleado').AsString;
                 Hoja.Cells.Item[i,6] := ZQVenta.FieldByName('Precio').AsCurrency;
                 Hoja.Cells.Item[i,6].WrapText := TRUE;
                 Hoja.Cells.Item[i,7] := ZQVenta.FieldByName('ICCID').AsString;
                 Hoja.Cells.Item[i,8] := ZQVenta.FieldByName('Sucursal').AsString;
                 Next;
                 barraP.StepIt();
             end;
         end;


    For b:=4 to i do
    begin
        Hoja.Range['b'+IntToStr(b),'b'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
        Hoja.Range['c'+IntToStr(b),'c'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
        Hoja.Range['d'+IntToStr(b),'d'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
        Hoja.Range['e'+IntToStr(b),'e'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
        Hoja.Range['f'+IntToStr(b),'f'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
        Hoja.Range['g'+IntToStr(b),'g'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
        Hoja.Range['h'+IntToStr(b),'h'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
    end;

      i:=i+3;
//      Hoja.Cells.Item[i,2]:='Total dotado en la ruta '+ltotal.Caption;
   //   Hoja.Cells.Item[i,2].Formula:='SUMA()';
      Hoja.Cells.Item[i,2].font.size:=16;
//        for i := barraP.Min to barraP.Max do
//            barraP.StepIt();

    finally
        barraP.Visible := false;
        Excel.Visible[1]:=true;
        ZQVenta.Free;
        DSVenta.Free;
    end;
end;

procedure TFAlmacenLocal.Button1Click(Sender: TObject);
begin
    nombreCliente.Clear;
    telefonoCliente.Clear;
    domicilioCliente.Clear;
end;

procedure TFAlmacenLocal.Button2Click(Sender: TObject);
begin
//
    ZQAlmacen.Close;
    ZQAlmacen.SQL.Clear;
    ZQAlmacen.SQL.Add('SELECT marca_celular Marca, modelo_celular Modelo, imei_celular IMEI, iccid_celular ICCID, precioCelular Precio');
    ZQAlmacen.SQL.Add('FROM equipo_almacen');
    ZQAlmacen.SQL.Add('JOIN sucursal ON equipo_almacen.idsucursal = sucursal.idsucursal');
    ZQAlmacen.SQL.Add('AND equipo_almacen.idsucursal = '+IntToStr(FPrincipal.idSucursal)+'');
    ZQAlmacen.ExecSQL();
    ZQAlmacen.Open;
    gridAlmacen.Update;

end;

procedure TFAlmacenLocal.Edit2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    ZQAlmacen.Filtered := false;
    ZQAlmacen.Filter := 'Modelo LIKE '+QuotedStr('*'+Edit2.Text+'*');
    ZQAlmacen.Filtered := true;
end;

procedure TFAlmacenLocal.Edit3KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    ZQAlmacen.Filtered := false;
    ZQAlmacen.Filter := 'IMEI LIKE '+QuotedStr('*'+Edit3.Text+'*');
    ZQAlmacen.Filtered := true;
end;

procedure TFAlmacenLocal.marcaCelKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    ZQAlmacen.Filtered := false;
    ZQAlmacen.Filter := 'Marca LIKE '+QuotedStr('*'+marcaCel.Text+'*');
    ZQAlmacen.Filtered := true;
end;

procedure TFAlmacenLocal.Timer1Timer(Sender: TObject);
begin
    StatusBar1.Panels[1].Text := TimeToStr(Time());
end;

function TFAlmacenLocal.totalInventario(ZQAlmacen: TZQuery): Integer;
begin
//codigo para contar elementos actuales
end;

procedure TFAlmacenLocal.FormShow(Sender: TObject);
var
    total : Integer;
begin
    StatusBar1.Panels[0].Text := DateToStr(Date()); //fecha
    StatusBar1.Panels[0].Width := 70;
    FAlmacenLocal.Caption := 'Inventario - Celulares "Chapulh", (sucursal '+FPrincipal.sucursal+')';
    BitBtn1.Caption := 'Vender '+#13+'equipo';

    ZQMovimiento := TZQuery.Create(self);
    ZQMovimiento.Connection := FPrincipal.ZConexion;
    ZQMovimiento.ShowRecordTypes := [usUnmodified,usModified,usInserted];
    ZQMovimiento.Options := [doCalcDefaults];
    ZQMovimiento.AutoCalcFields := true;

    barraP.Visible := false;
    barraP.Step := 1;
    barraP.Min := 0;
//    barraP.Max := 5000; //cambiar por el total de elementos mostrados

    ZQAlmacen.Close();
    ZQAlmacen.SQL.Clear();
    ZQAlmacen.SQL.Add('SELECT COUNT(*) AS Total FROM equipo_almacen');
    ZQAlmacen.SQL.Add('WHERE idsucursal='+IntToStr(FPrincipal.idSucursal));
    ZQAlmacen.ExecSQL;
    ZQAlmacen.Open;
    total := ZQAlmacen.FieldByName('Total').AsInteger;
    totalequipos.Caption := IntToStr(total);

    ZQAlmacen.Close();
    ZQAlmacen.SQL.Clear();
    ZQAlmacen.SQL.Add('SELECT marca_celular Marca, modelo_celular Modelo, imei_celular IMEI, iccid_celular ICCID, precioCelular Precio');
    ZQAlmacen.SQL.Add('FROM equipo_almacen');
    ZQAlmacen.SQL.Add('JOIN sucursal ON equipo_almacen.idsucursal = sucursal.idsucursal');
    ZQAlmacen.SQL.Add('AND equipo_almacen.idsucursal = '+IntToStr(FPrincipal.idSucursal)+'');
    ZQAlmacen.ExecSQL();
    ZQAlmacen.Open;
    gridAlmacen.Update;
end;

procedure TFAlmacenLocal.GridAlmacenCellClick(Column: TColumn);
begin
    //
    marcaCelular.Caption := gridAlmacen.Fields[0].AsString;
    modeloCelular.Caption := gridAlmacen.Fields[1].AsString;
    imeiCelular.Caption := gridAlmacen.Fields[2].AsString;
    iccidCelular.Caption := GridAlmacen.Fields[3].AsString;
    preciocelular.Caption := '$'+FloatToStr(GridAlmacen.Fields[4].AsFloat);
end;

procedure TFAlmacenLocal.GridAlmacenKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if (Key = VK_UP) or (Key = VK_DOWN) or (Key = VK_LEFT) or (Key = VK_RIGHT) then
    begin
        marcaCelular.Caption := gridAlmacen.Fields[0].AsString;
        modeloCelular.Caption := gridAlmacen.Fields[1].AsString;
        imeiCelular.Caption := gridAlmacen.Fields[2].AsString;
        iccidCelular.Caption := GridAlmacen.Fields[3].AsString;
        preciocelular.Caption := '$'+FloatToStr(GridAlmacen.Fields[4].AsFloat);
    end;
end;

end.
