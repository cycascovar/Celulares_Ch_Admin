unit SQLMovimientos;

interface
//Descripcion: Esta unidad contiene los SQL de los movimientos del sistemauses
uses
     {Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, Menus, ExtCtrls,
    ZConnection, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
    ZAbstractConnection;}

  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, StdCtrls, pngimage, ZAbstractConnection, ZConnection,
  DB, ZAbstractRODataset, ZAbstractDataset, ZDataset;


var
    ZQMovimiento : TZquery;

    procedure creaZQuery();
    procedure agregaMovimiento(Movimiento : String; Detalles:String);

implementation
uses
    FPrincipalEmpleados;
procedure creaZQuery();
begin
    ZQMovimiento := TZQuery.Create(nil);
    ZQMovimiento.Connection := FPrincipal.ZConexion;
    ZQMovimiento.ShowRecordTypes := [usUnmodified,usModified,usInserted];
    ZQMovimiento.Options := [doCalcDefaults];
    ZQMovimiento.AutoCalcFields := true;
end;

procedure agregaMovimiento(Movimiento : String; Detalles:String);
begin
    ZQMovimiento.Close;
    ZQMovimiento.SQL.Clear;
    ZQMovimiento.SQL.Add('INSERT INTO empleado_movimiento (movimiento,movimiento_detalles)');
    ZQMovimiento.SQL.Add('VALUES ("'+Movimiento+'","'+Detalles+'")');
    ZQMovimiento.ExecSQL;
end;


end.
