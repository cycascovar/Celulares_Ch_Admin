unit uUtils;

interface

implementation
//La siguiente unit contiene funciones y procedimientos para conversion de fechas y otras cosas
{
    Notas de movimientos:

    ZQMovimiento.Close;
    ZQMovimiento.SQL.Clear;
    ZQMovimiento.SQL.Add('INSERT INTO empleado_movimiento (movimiento, movimiento_detalles, sucursal,empleado,fecha)');
    ZQMovimiento.SQL.Add('VALUES ("Movimiento", "El usuario '+Flogin.username.Text+' ha hecho tal cosa el dia '+DateToStr(Date())+' a las '+TimetoStr(Time())+'", "'+FPrincipal.sucursal+'","'+FLogin.username.Text+'","'+FormatDateTime('YYYY/MM/DD',Date())+'")');
    ZQMovimiento.ExecSQL;
}
end.
