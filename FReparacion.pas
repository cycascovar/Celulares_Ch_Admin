unit FReparacion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, Grids, DBGrids, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, ComCtrls, Buttons, ExtCtrls;

type
  TFReparaciones = class(TForm)
    DBGrid1: TDBGrid;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    DSReparaciones: TDataSource;
    ZQReparaciones: TZQuery;
    GroupBox1: TGroupBox;
    titular: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    telefonoContacto: TEdit;
    GroupBox2: TGroupBox;
    imei: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    modelo: TEdit;
    marca: TEdit;
    Label8: TLabel;
    observaciones: TMemo;
    Label10: TLabel;
    Label11: TLabel;
    iccidequipo: TEdit;
    StatusBar1: TStatusBar;
    fecharecibido: TDateTimePicker;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    entregarboton: TBitBtn;
    Timer1: TTimer;
    procedure Button3Click(Sender: TObject);
    procedure entregarBotonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure fecharecibidoChange(Sender: TObject);
    procedure Edit1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit2KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit3KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    idEquipoReparacion : Integer;
    ZQMovimiento: TZQuery;
    ZQClienteReparacion: TZquery;
    ZQTemp : TZQuery;
  public
    { Public declarations }
  end;

var
  FReparaciones: TFReparaciones;

implementation
uses
    FReparacion_Alta,FPrincipalEmpleados,F_login;
{$R *.dfm}

procedure TFReparaciones.entregarBotonClick(Sender: TObject);
var
    imei : String;
begin
    imei := DBGrid1.Fields[2].AsString;

    ZQReparaciones.Close;
    ZQReparaciones.SQL.Clear;
    ZQReparaciones.SQL.Add('SELECT idequipo_reparacion AS idReparacion');
    ZQReparaciones.SQL.Add('FROM equipo_reparacion');
    ZQReparaciones.SQL.Add('WHERE imei_equipo='+imei+'');
    ZQReparaciones.ExecSQL;
    ZQReparaciones.Open;

    idEquipoReparacion := ZQReparaciones.FieldByName('idReparacion').AsInteger;
//    ShowMessage(IntToStr(idEquipoReparacion));

    ZQReparaciones.Close;
    ZQReparaciones.SQL.Clear;
    ZQReparaciones.SQL.Add('INSERT INTO equipo_entregado (fecha_entrega, tipo, empleado, imei_equipo, sucursal)');
    ZQReparaciones.SQL.Add('VALUES ("'+FormatDateTime('YYYY/MM/DD',Date())+'","Reparacion","'+FLogin.username.Text+'","'+imei+'","'+FPrincipal.sucursal+'")');
    ZQReparaciones.ExecSQL;

    ZQReparaciones.Close;
    ZQReparaciones.SQL.Clear;
    ZQReparaciones.SQL.Add('DELETE FROM cliente_reparacion WHERE idequipo_reparacion='+IntToStr(idEquipoReparacion)+'');
    ZQReparaciones.ExecSQL;

    ZQReparaciones.SQL.Clear;
    ZQReparaciones.SQL.Add('DELETE FROM equipo_reparacion WHERE idequipo_reparacion='+IntToStr(idEquipoReparacion)+'');
    ZQReparaciones.ExecSQL;

    ZQMovimiento.Close;
    ZQMovimiento.SQL.Clear;
    ZQMovimiento.SQL.Add('INSERT INTO empleado_movimiento (movimiento,movimiento_detalles, sucursal, empleado, fecha)');
    ZQMovimiento.SQL.Add('VALUES ("Entrega de equipo (reparacion).","El usuario '+Flogin.username.Text+' ha entregado un equipo en reparacion el dia '+DateToStr(date())+' a las '+TimeToStr(Time())+'","'+FPrincipal.sucursal+'","'+Flogin.username.Text+'","'+FormatDateTime('YYYY/MM/DD',Date())+'")');
    ZQMovimiento.ExecSQL;

    ZQReparaciones.Close;
    ZQReparaciones.SQL.Clear;
    ZQReparaciones.SQL.Add('SELECT marca_equipo AS Marca, modelo_equipo AS Modelo, imei_equipo AS IMEI, nombre_cliente as Titular, telefono_contacto AS "Telefono titular", fecha AS "Fecha Recibido"');
    ZQReparaciones.SQL.Add('FROM equipo_reparacion');
    ZQReparaciones.SQL.Add('JOIN cliente_reparacion ON equipo_reparacion.idequipo_reparacion = cliente_reparacion.idequipo_reparacion');
    ZQReparaciones.SQL.Add('JOIN sucursal ON sucursal.idsucursal = equipo_reparacion.idsucursal');
    ZQReparaciones.SQL.Add('AND equipo_reparacion.idsucursal = '+IntToStr(FPrincipal.idSucursal)+'');
    ZQReparaciones.SQL.Add('ORDER BY fecha DESC');
    ZQReparaciones.ExecSQL;
    ZQReparaciones.Open;
    DBGrid1.Update;

    Application.MessageBox('El equipo ha sido entregado y no esta mas en garantía.','Información',MB_ICONINFORMATION);

end;

procedure TFReparaciones.fecharecibidoChange(Sender: TObject);
begin
    FormatSettings.ShortDateFormat := 'yyyy-mm-dd';

    ZQReparaciones.Close;
    ZQReparaciones.SQL.Clear;
    ZQReparaciones.SQL.Add('SELECT marca_equipo AS Marca, modelo_equipo AS Modelo, imei_equipo AS IMEI, nombre_cliente as Titular, telefono_contacto AS "Telefono titular", fecha AS "Fecha Recibido"');
    ZQReparaciones.SQL.Add('FROM equipo_reparacion');
    ZQReparaciones.SQL.Add('JOIN cliente_reparacion ON equipo_reparacion.idequipo_reparacion = cliente_reparacion.idequipo_reparacion');
    ZQReparaciones.SQL.Add('JOIN sucursal ON sucursal.idsucursal = equipo_reparacion.idsucursal');
    ZQReparaciones.SQL.Add('AND equipo_reparacion.idsucursal = '+IntToStr(FPrincipal.idSucursal)+'');
    ZQReparaciones.SQL.Add('AND fecha="'+DateToStr(fecharecibido.Date)+'"');
    ZQReparaciones.ExecSQL;
    ZQReparaciones.Open;
    FormatSettings.ShortDateFormat := 'dd/mm/yyyy';
    DBGrid1.Update;
end;

procedure TFReparaciones.BitBtn1Click(Sender: TObject);
begin
    ZQReparaciones.Close;
    ZQReparaciones.SQL.Clear;
    ZQReparaciones.SQL.Add('SELECT marca_equipo AS Marca, modelo_equipo AS Modelo, imei_equipo AS IMEI, nombre_cliente as Titular, telefono_contacto AS "Telefono titular", fecha AS "Fecha Recibido"');
    ZQReparaciones.SQL.Add('FROM equipo_reparacion');
    ZQReparaciones.SQL.Add('JOIN cliente_reparacion ON equipo_reparacion.idequipo_reparacion = cliente_reparacion.idequipo_reparacion');
    ZQReparaciones.SQL.Add('JOIN sucursal ON sucursal.idsucursal = equipo_reparacion.idsucursal');
    ZQReparaciones.SQL.Add('AND equipo_reparacion.idsucursal = '+IntToStr(FPrincipal.idSucursal)+'');
    ZQReparaciones.SQL.Add('ORDER BY fecha DESC');
    ZQReparaciones.ExecSQL;
    ZQReparaciones.Open;
    DBGrid1.Update;
end;

procedure TFReparaciones.BitBtn2Click(Sender: TObject);
begin
    if application.MessageBox (pchar('¿Desea limpiar los datos del cliente?'), pchar('Confirmar'), (MB_YESNO + MB_ICONQUESTION)) = IDYES then
    begin
        titular.Clear;
        telefonocontacto.Clear;
    end;
end;

procedure TFReparaciones.BitBtn3Click(Sender: TObject);
var
    idEquiposR: Integer;
    idEquipo : Integer;
begin
    ZQTemp.Close;
    ZQTemp.SQL.Clear;
    ZQTemp.SQL.Add('SELECT MAX(idequipo) AS idEquipo');
    ZQTemp.SQL.Add('FROM equipo_reparacion');
    ZQTemp.ExecSQL;
    ZQTemp.Open;
    idEquipo := ZQTemp.FieldByName('idEquipo').AsInteger;

    if titular.Text = '' then
        Application.MessageBox('Por favor ingrese un titular válido.','Información',MB_ICONINFORMATION);
    if imei.Text = '' then
        Application.MessageBox('Por favor ingrese un IMEI válido.','Información',MB_ICONINFORMATION);

    if idEquipo = 0 then
    begin
        idEquipo := 1;

        ZQReparaciones.Close;
        ZQReparaciones.SQL.Clear;
        ZQReparaciones.SQL.Add('INSERT INTO equipo_reparacion(idempleado,marca_equipo, modelo_equipo,imei_equipo,idequipo,fecha,idsucursal,observaciones)');
        ZQReparaciones.SQL.Add('VALUES ('+IntToStr(FPrincipal.idEmpleado)+',"'+marca.Text+'","'+modelo.Text+'","'+imei.Text+'","'+IntToStr(idEquipo)+'","'+FormatDateTime('YYYY/MM/DD',Date())+'",'+IntToStr(FPrincipal.idSucursal)+',"'+observaciones.Text+'")');
        ZQReparaciones.ExecSQL;

        ZQReparaciones.SQL.Clear;
        ZQReparaciones.SQL.Add('SELECT idequipo_reparacion FROM equipo_reparacion WHERE idequipo='+IntToStr(idEquipo)+'');
        ZQReparaciones.ExecSQL;
        ZQReparaciones.Open;

        idEquiposR := ZQReparaciones.FieldByName('idequipo_reparacion').AsInteger;

        ZQClienteReparacion.Close;
        ZQClienteReparacion.SQL.Clear;
        ZQClienteReparacion.SQL.Add('INSERT INTO cliente_reparacion(idequipo_garantia,nombre_cliente,telefono_contacto)');
        ZQClienteReparacion.SQL.Add('VALUES ("'+IntToStr(idEquiposR)+'","'+titular.Text+'","'+telefonoContacto.Text+'")');
        ZQClienteReparacion.ExecSQL;
    end
    else
    begin
        ZQReparaciones.Close;
        ZQReparaciones.SQL.Clear;
        ZQReparaciones.SQL.Add('INSERT INTO equipo_reparacion(idempleado,marca_equipo, modelo_equipo,imei_equipo,idequipo,fecha,idsucursal,observaciones)');
        ZQReparaciones.SQL.Add('VALUES ('+IntToStr(FPrincipal.idEmpleado)+',"'+marca.Text+'","'+modelo.Text+'","'+imei.Text+'","'+IntToStr(idEquipo+1)+'","'+FormatDateTime('YYYY/MM/DD',Date())+'",'+IntToStr(FPrincipal.idSucursal)+',"'+observaciones.Text+'")');
        ZQReparaciones.ExecSQL;

        ZQReparaciones.SQL.Clear;
        ZQReparaciones.SQL.Add('SELECT idequipo_reparacion FROM equipo_reparacion WHERE idequipo='+IntToStr(idEquipo+1)+'');
        ZQReparaciones.ExecSQL;
        ZQReparaciones.Open;

        idEquiposR := ZQReparaciones.FieldByName('idequipo_reparacion').AsInteger;

        ZQClienteReparacion.Close;
        ZQClienteReparacion.SQL.Clear;
        ZQClienteReparacion.SQL.Add('INSERT INTO cliente_reparacion(idequipo_reparacion,nombre_cliente,telefono_contacto)');
        ZQClienteReparacion.SQL.Add('VALUES ("'+IntToStr(idEquiposR)+'","'+titular.Text+'","'+telefonoContacto.Text+'")');
        ZQClienteReparacion.ExecSQL;
    end;

    //Al refrescar el grid, entonces se tienen que mostrar los equipos POR SUCURSAL
    ZQReparaciones.Close;
    ZQReparaciones.SQL.Clear;
    ZQReparaciones.SQL.Add('SELECT marca_equipo AS Marca, modelo_equipo AS Modelo, imei_equipo AS IMEI, nombre_cliente as Titular, telefono_contacto AS "Telefono titular", fecha AS "Fecha Recibido"');
    ZQReparaciones.SQL.Add('FROM equipo_reparacion');
    ZQReparaciones.SQL.Add('JOIN cliente_reparacion ON equipo_reparacion.idequipo_reparacion = cliente_reparacion.idequipo_reparacion');
    ZQReparaciones.SQL.Add('JOIN sucursal ON sucursal.idsucursal = equipo_reparacion.idsucursal');
    ZQReparaciones.SQL.Add('AND equipo_reparacion.idsucursal = '+IntToStr(FPrincipal.idSucursal)+'');
    ZQReparaciones.ExecSQL;
    ZQReparaciones.Open;
    DBGrid1.Update;

    ZQMovimiento.Close;
    ZQMovimiento.SQL.Clear;
    ZQMovimiento.SQL.Add('INSERT INTO empleado_movimiento (movimiento,movimiento_detalles, sucursal, empleado, fecha)');
    ZQMovimiento.SQL.Add('VALUES ("Alta de equipo en reparacion.","El usuario '+Flogin.username.Text+' ha dado de alta un equipo en reparacion el dia '+DateToStr(date())+' a las '+TimeToStr(Time())+'","'+FPrincipal.sucursal+'","'+Flogin.username.Text+'","'+FormatDateTime('YYYY/MM/DD',Date())+'")');
    ZQMovimiento.ExecSQL;

    Application.MessageBox('El equipo ha sido agregado a reparación.','Información',MB_ICONINFORMATION);
end;

procedure TFReparaciones.BitBtn4Click(Sender: TObject);
begin
    if application.MessageBox (pchar('¿Desea limpiar los datos del celular?'), pchar('Confirmar'), (MB_YESNO + MB_ICONQUESTION)) = IDYES then
    begin
        imei.Clear;
        modelo.Clear;
        marca.Clear;
        observaciones.Clear;
        iccidequipo.Clear;
    end;
end;

procedure TFReparaciones.Button2Click(Sender: TObject);
var
    idEquiposR: Integer;
    idEquipo : Integer;
begin
    ZQTemp.Close;
    ZQTemp.SQL.Clear;
    ZQTemp.SQL.Add('SELECT MAX(idequipo) AS idEquipo');
    ZQTemp.SQL.Add('FROM equipo_reparacion');
    ZQTemp.ExecSQL;
    ZQTemp.Open;
    idEquipo := ZQTemp.FieldByName('idEquipo').AsInteger;

    if titular.Text = '' then
        Application.MessageBox('Por favor ingrese un titular válido.','Información',MB_ICONINFORMATION);
    if imei.Text = '' then
        Application.MessageBox('Por favor ingrese un IMEI válido.','Información',MB_ICONINFORMATION);

    if idEquipo = 0 then
    begin
        idEquipo := 1;

        ZQReparaciones.Close;
        ZQReparaciones.SQL.Clear;
        ZQReparaciones.SQL.Add('INSERT INTO equipo_reparacion(idempleado,marca_equipo, modelo_equipo,imei_equipo,idequipo,fecha,idsucursal,observaciones)');
        ZQReparaciones.SQL.Add('VALUES ('+IntToStr(FPrincipal.idEmpleado)+',"'+marca.Text+'","'+modelo.Text+'","'+imei.Text+'","'+IntToStr(idEquipo)+'","'+FormatDateTime('YYYY/MM/DD',Date())+'",'+IntToStr(FPrincipal.idSucursal)+',"'+observaciones.Text+'")');
        ZQReparaciones.ExecSQL;

        ZQReparaciones.SQL.Clear;
        ZQReparaciones.SQL.Add('SELECT idequipo_reparacion FROM equipo_reparacion WHERE idequipo='+IntToStr(idEquipo)+'');
        ZQReparaciones.ExecSQL;
        ZQReparaciones.Open;

        idEquiposR := ZQReparaciones.FieldByName('idequipo_reparacion').AsInteger;

        ZQClienteReparacion.Close;
        ZQClienteReparacion.SQL.Clear;
        ZQClienteReparacion.SQL.Add('INSERT INTO cliente_reparacion(idequipo_garantia,nombre_cliente,telefono_contacto)');
        ZQClienteReparacion.SQL.Add('VALUES ("'+IntToStr(idEquiposR)+'","'+titular.Text+'","'+telefonoContacto.Text+'")');
        ZQClienteReparacion.ExecSQL;
    end
    else
    begin
        ZQReparaciones.Close;
        ZQReparaciones.SQL.Clear;
        ZQReparaciones.SQL.Add('INSERT INTO equipo_reparacion(idempleado,marca_equipo, modelo_equipo,imei_equipo,idequipo,fecha,idsucursal,observaciones)');
        ZQReparaciones.SQL.Add('VALUES ('+IntToStr(FPrincipal.idEmpleado)+',"'+marca.Text+'","'+modelo.Text+'","'+imei.Text+'","'+IntToStr(idEquipo+1)+'","'+FormatDateTime('YYYY/MM/DD',Date())+'",'+IntToStr(FPrincipal.idSucursal)+',"'+observaciones.Text+'")');
        ZQReparaciones.ExecSQL;

        ZQReparaciones.SQL.Clear;
        ZQReparaciones.SQL.Add('SELECT idequipo_reparacion FROM equipo_reparacion WHERE idequipo='+IntToStr(idEquipo+1)+'');
        ZQReparaciones.ExecSQL;
        ZQReparaciones.Open;

        idEquiposR := ZQReparaciones.FieldByName('idequipo_reparacion').AsInteger;

        ZQClienteReparacion.Close;
        ZQClienteReparacion.SQL.Clear;
        ZQClienteReparacion.SQL.Add('INSERT INTO cliente_reparacion(idequipo_reparacion,nombre_cliente,telefono_contacto)');
        ZQClienteReparacion.SQL.Add('VALUES ("'+IntToStr(idEquiposR)+'","'+titular.Text+'","'+telefonoContacto.Text+'")');
        ZQClienteReparacion.ExecSQL;
    end;

    //Al refrescar el grid, entonces se tienen que mostrar los equipos POR SUCURSAL
    ZQReparaciones.Close;
    ZQReparaciones.SQL.Clear;
    ZQReparaciones.SQL.Add('SELECT marca_equipo AS Marca, modelo_equipo AS Modelo, imei_equipo AS IMEI, nombre_cliente as Titular, telefono_contacto AS "Telefono titular", fecha AS "Fecha Recibido"');
    ZQReparaciones.SQL.Add('FROM equipo_reparacion');
    ZQReparaciones.SQL.Add('JOIN cliente_reparacion ON equipo_reparacion.idequipo_reparacion = cliente_reparacion.idequipo_reparacion');
    ZQReparaciones.SQL.Add('JOIN sucursal ON sucursal.idsucursal = equipo_reparacion.idsucursal');
    ZQReparaciones.SQL.Add('AND equipo_reparacion.idsucursal = '+IntToStr(FPrincipal.idSucursal)+'');
    ZQReparaciones.ExecSQL;
    ZQReparaciones.Open;
    DBGrid1.Update;

    ZQMovimiento.Close;
    ZQMovimiento.SQL.Clear;
    ZQMovimiento.SQL.Add('INSERT INTO empleado_movimiento (movimiento,movimiento_detalles, sucursal, empleado, fecha)');
    ZQMovimiento.SQL.Add('VALUES ("Alta de equipo en reparacion.","El usuario '+Flogin.username.Text+' ha dado de alta un equipo en reparacion el dia '+DateToStr(date())+' a las '+TimeToStr(Time())+'","'+FPrincipal.sucursal+'","'+Flogin.username.Text+'","'+FormatDateTime('YYYY/MM/DD',Date())+'")');
    ZQMovimiento.ExecSQL;

    Application.MessageBox('El equipo ha sido agregado a reparación.','Información',MB_ICONINFORMATION);
end;

procedure TFReparaciones.Button3Click(Sender: TObject);
begin
//    FReparaciones.Close;
    ShowMessage(FormatDateTime('YYYY/MM/DD',Now()));
end;

procedure TFReparaciones.Button4Click(Sender: TObject);
begin
    if application.MessageBox (pchar('¿Desea limpiar los datos del cliente?'), pchar('Confirmar'), (MB_YESNO + MB_ICONQUESTION)) = IDYES then
    begin
        titular.Clear;
        telefonocontacto.Clear;
    end;
end;

procedure TFReparaciones.Button5Click(Sender: TObject);
begin
    if application.MessageBox (pchar('¿Desea limpiar los datos del celular?'), pchar('Confirmar'), (MB_YESNO + MB_ICONQUESTION)) = IDYES then
    begin
        imei.Clear;
        modelo.Clear;
        marca.Clear;
        observaciones.Clear;
        iccidequipo.Clear;
    end;
end;

procedure TFReparaciones.Button6Click(Sender: TObject);
begin
    ZQReparaciones.Close;
    ZQReparaciones.SQL.Clear;
    ZQReparaciones.SQL.Add('SELECT marca_equipo AS Marca, modelo_equipo AS Modelo, imei_equipo AS IMEI, nombre_cliente as Titular, telefono_contacto AS "Telefono titular", fecha AS "Fecha Recibido"');
    ZQReparaciones.SQL.Add('FROM equipo_reparacion');
    ZQReparaciones.SQL.Add('JOIN cliente_reparacion ON equipo_reparacion.idequipo_reparacion = cliente_reparacion.idequipo_reparacion');
    ZQReparaciones.SQL.Add('JOIN sucursal ON sucursal.idsucursal = equipo_reparacion.idsucursal');
    ZQReparaciones.SQL.Add('AND equipo_reparacion.idsucursal = '+IntToStr(FPrincipal.idSucursal)+'');
    ZQReparaciones.ExecSQL;
    ZQReparaciones.Open;
    DBGrid1.Update;
end;

procedure TFReparaciones.DBGrid1CellClick(Column: TColumn);
begin
    entregarBoton.Enabled := true;
end;

procedure TFReparaciones.Edit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    ZQReparaciones.Filtered := false;
    ZQReparaciones.Filter :='Marca LIKE'+QuotedStr('*'+edit1.Text+'*');
    ZQReparaciones.Filtered := true;
end;

procedure TFReparaciones.Edit2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    ZQReparaciones.Filtered := false;
    ZQReparaciones.Filter := 'Modelo LIKE'+QuotedStr('*'+edit2.Text+'*');
    ZQReparaciones.Filtered := true;
end;

procedure TFReparaciones.Edit3KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    ZQReparaciones.Filtered := false;
    ZQReparaciones.Filter := 'IMEI LIKE'+QuotedStr('*'+edit3.Text+'*');
    ZQReparaciones.Filtered := true;
end;

procedure TFReparaciones.FormCreate(Sender: TObject);
begin
    ZQMovimiento := TZQuery.Create(self);
    ZQMovimiento.Connection := FPrincipal.ZConexion;
    ZQMovimiento.ShowRecordTypes := [usUnmodified,usModified,usInserted];
    ZQMovimiento.Options := [doCalcDefaults];
    ZQMovimiento.AutoCalcFields := true;

    ZQTemp := TZQuery.Create(self);
    ZQTemp.Connection := FPrincipal.ZConexion;
    ZQTemp.ShowRecordTypes := [usUnmodified,usModified,usInserted];
    ZQTemp.Options := [doCalcDefaults];
    ZQTemp.AutoCalcFields := true;


    ZQClienteReparacion := TZQuery.Create(self);
    ZQClienteReparacion.Connection := FPrincipal.ZConexion;
    ZQClienteReparacion.ShowRecordTypes := [usUnmodified,usModified,usInserted];
    ZQClienteReparacion.Options := [doCalcDefaults];
    ZQClienteReparacion.AutoCalcFields := true;
end;

procedure TFReparaciones.FormShow(Sender: TObject);
begin
    entregarBoton.Enabled := false;
    fecharecibido.Date := Date();
    StatusBar1.Panels[0].Text := DateToStr(Date()); //fecha
    StatusBar1.Panels[0].Width := 70;
    FReparaciones.Caption := 'Equipos en garantía - Celulares "Chapulh", (sucursal '+FPrincipal.sucursal+')';

    FormatSettings.ShortDateFormat := 'yyyy-mm-dd';

    ZQReparaciones.Close;
    ZQReparaciones.SQL.Clear;
    ZQReparaciones.SQL.Add('SELECT marca_equipo Marca, modelo_equipo Modelo, imei_equipo IMEI, nombre_cliente Titular, telefono_contacto AS "Telefono de contacto", fecha AS "Fecha recibido"');
    ZQReparaciones.SQL.Add('FROM equipo_reparacion');
    ZQReparaciones.SQL.Add('JOIN cliente_reparacion ON equipo_reparacion.idequipo_reparacion = cliente_reparacion.idequipo_reparacion');
    ZQReparaciones.SQL.Add('JOIN sucursal ON sucursal.idsucursal = equipo_reparacion.idsucursal');
    ZQReparaciones.SQL.Add('AND equipo_reparacion.idsucursal = '+IntToStr(FPrincipal.idSucursal)+'');
    ZQReparaciones.SQL.Add('AND fecha="'+DateToStr(fecharecibido.Date)+'"');
    ZQReparaciones.ExecSQL;
    ZQReparaciones.Open;
    FormatSettings.ShortDateFormat := 'dd/mm/yyyy';
    DBGrid1.Update;
end;

procedure TFReparaciones.Timer1Timer(Sender: TObject);
begin
    StatusBar1.Panels[1].Text := TimeToStr(Time());
end;

end.
