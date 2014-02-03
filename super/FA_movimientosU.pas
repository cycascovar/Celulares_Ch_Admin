unit FA_movimientosU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, StdCtrls;

type
  TFMovimientosU = class(TForm)
    ZQuery1: TZQuery;
    DataSource1: TDataSource;
    Button1: TButton;
    Memo1: TMemo;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMovimientosU: TFMovimientosU;

implementation
uses
    FPrincipalEmpleados;

{$R *.dfm}

procedure TFMovimientosU.Button1Click(Sender: TObject);
var
    guardar : TSaveDialog;
begin
    try
        guardar := TSaveDialog.Create(self);
        guardar.Title := 'Guardar log de movimientos de empleados';
        guardar.Filter := 'Archivos de texto|*.txt';
        guardar.DefaultExt := 'txt';
        guardar.FileName := 'logusuarios.txt';
        guardar.InitialDir := GetCurrentDir;
        if guardar.Execute then
            memo1.Lines.SaveToFile(guardar.FileName);
    finally
        guardar.Free;
    end;

end;

procedure TFMovimientosU.Button2Click(Sender: TObject);
begin
    ZQuery1.Close;
    ZQuery1.SQL.Clear;
    ZQuery1.SQL.Add('SELECT movimiento AS Tipo, movimiento_detalles AS Movimiento, empleado, sucursal, fecha FROM empleado_movimiento');
    ZQuery1.ExecSQL;
    ZQuery1.Open;

    with ZQuery1 do
    begin
        First;
        while not EOF do
        begin
            Memo1.Lines.Add(ZQuery1.FieldByName('Tipo').AsString+'            '+
            ZQuery1.FieldByName('Movimiento').AsString+'            '+
            ZQuery1.FieldByName('Empleado').AsString+'            '+
            ZQuery1.FieldByName('Sucursal').AsString+'            '+
            ZQuery1.FieldByName('Fecha').AsString+'            ');
            Next;
        end;
    end;
end;

end.
