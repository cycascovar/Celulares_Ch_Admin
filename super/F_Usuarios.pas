unit F_Usuarios;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  Grids, DBGrids;

type
  TFUsuarios = class(TForm)
    Label1: TLabel;
    nombreEmpleado: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    PasswordEmpleado: TEdit;
    Button1: TButton;
    DSEmpleados: TDataSource;
    ZQEmpleados: TZQuery;
    listaSucursales: TDBLookupComboBox;
    DBGrid1: TDBGrid;
    DSSucursal: TDataSource;
    ZQSucursal: TZQuery;
    GroupBox1: TGroupBox;
    Empleado: TLabel;
    usuario: TLabel;
    Button2: TButton;
    Memo1: TMemo;
    Button3: TButton;
    vertodos: TCheckBox;
    procedure t(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure Button2Click(Sender: TObject);
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FUsuarios: TFUsuarios;

implementation
uses
    F_PrincipalAdmin, ComCtrls;

{$R *.dfm}

procedure TFUsuarios.Button1Click(Sender: TObject);
var
    idSucursal : Integer;
begin
    idSucursal := listaSucursales.KeyValue;

    ZQEmpleados.Close;
    ZQEmpleados.SQL.Clear;
    ZQEmpleados.SQL.Add('INSERT INTO empleado (empleado,password,idsucursal)');
    ZQEmpleados.SQL.Add('VALUES ("'+nombreEmpleado.Text+'","'+passwordEmpleado.Text+'",'+IntToStr(idSucursal)+')');
    ZQEmpleados.ExecSQL;

    ZQEmpleados.SQL.Clear;
    ZQEmpleados.SQL.Add('SELECT empleado AS Usuario, Sucursal, MD5(Password) AS Password');
    ZQEmpleados.SQL.Add('FROM empleado');
    ZQEmpleados.SQL.Add('JOIN sucursal ON sucursal.idsucursal = empleado.idsucursal');
    ZQEmpleados.ExecSQL;
    ZQEmpleados.Open;
    dbgrid1.Refresh;

    Application.MessageBox('Usuario agregado exitosamente.','Información',MB_ICONINFORMATION);
end;

procedure TFUsuarios.Button2Click(Sender: TObject);
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

procedure TFUsuarios.Button3Click(Sender: TObject);
var
    ZQMovimientoU : TZQuery;
    DSMovimientoU : TDataSource;
    barra : TProgressBar;
begin
    try
        barra := TProgressBar.Create(self);
        barra.Min := 0;
        barra.Width := 140;
        barra.Height := 25;
        barra.Left := 12;
        barra.Top := 38;
        barra.Style := pbstNormal;
        barra.Step := 1;
        barra.Visible := true;
        barra.Enabled := true;

        ZQMovimientoU := TZQuery.Create(self);
        ZQMovimientoU.Connection := FPrincipalAdmin.ZConexion;
        DSMovimientoU := TDataSource.Create(self);
        DSMovimientoU.DataSet := ZQMovimientoU;
        Memo1.Clear;

        if (vertodos.Checked = true) then
        begin
            ZQMovimientoU.Close;
            ZQMovimientoU.SQL.Clear;
            ZQMovimientoU.SQL.Add('SELECT movimiento AS Tipo, movimiento_detalles AS Movimiento, empleado, sucursal, fecha FROM empleado_movimiento');
            ZQMovimientoU.ExecSQL;
            ZQMovimientoU.Open;
            barra.Max := ZQMovimientoU.RecordCount;
            Memo1.Lines.Add('Reporte generado el día '+DateToStr(Date())+' a las '+TimeToStr(Time()));
            Memo1.Lines.Add('Usuario: Todos los usuarios.');
            Memo1.Lines.Add('Tipo                        Movimiento                                                      Empleado                Sucursal                  Fecha');
            Memo1.Lines.Add('----------------------      ------------------------------------------------------          -------------           -------------             -------------');

            with ZQMovimientoU do
            begin
                First;
                while not EOF do
                begin
                    Memo1.Lines.Add(ZQMovimientoU.FieldByName('Tipo').AsString+'            '+
                    ZQMovimientoU.FieldByName('Movimiento').AsString+'            '+
                    ZQMovimientoU.FieldByName('Empleado').AsString+'            '+
                    ZQMovimientoU.FieldByName('Sucursal').AsString+'            '+
                    ZQMovimientoU.FieldByName('Fecha').AsString+'            '+#13);
                    barra.StepIt;
                    Next;
                end;
            end;
        end else
        if (usuario.Caption <> '') then
        begin
            ZQMovimientoU.Close;
            ZQMovimientoU.SQL.Clear;
            ZQMovimientoU.SQL.Add('SELECT movimiento AS Tipo, movimiento_detalles AS Movimiento, empleado, sucursal, fecha FROM empleado_movimiento');
            ZQMovimientoU.SQL.Add('WHERE empleado="'+usuario.Caption+'"');
            ZQMovimientoU.ExecSQL;
            ZQMovimientoU.Open;
            barra.Max := ZQMovimientoU.RecordCount;
            Memo1.Lines.Add('Reporte generado el día '+DateToStr(Date())+' a las '+TimeToStr(Time()));
            Memo1.Lines.Add('Usuario: '+Usuario.Caption);
            Memo1.Lines.Add('Tipo                        Movimiento                                                      Empleado                Sucursal                  Fecha');
            Memo1.Lines.Add('----------------------      ------------------------------------------------------          -------------           -------------             -------------');
            with ZQMovimientoU do
            begin
                First;
                while not EOF do
                begin
                    Memo1.Lines.Add(ZQMovimientoU.FieldByName('Tipo').AsString+'            '+
                    ZQMovimientoU.FieldByName('Movimiento').AsString+'            '+
                    ZQMovimientoU.FieldByName('Empleado').AsString+'            '+
                    ZQMovimientoU.FieldByName('Sucursal').AsString+'            '+
                    ZQMovimientoU.FieldByName('Fecha').AsString+'            '+#13);
                    barra.StepIt;
                    Next;
                end;
            end;
        end else
            raise Exception.Create('Error: Seleccione un usuario válido.');
    finally
        barra.Visible := false;
        barra.Free;
        ZQMovimientoU.Free;
        DSMovimientoU.Free;
    end;
end;

procedure TFUsuarios.DBGrid1CellClick(Column: TColumn);
begin
    usuario.Caption := DBgrid1.Fields[0].AsString;
end;

procedure TFUsuarios.DBGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if (Key = VK_UP) or (Key = VK_DOWN) or (Key = VK_LEFT) or (Key = VK_RIGHT) then
    begin
        usuario.Caption := DBgrid1.Fields[0].AsString;
    end;
end;

procedure TFUsuarios.t(Sender: TObject);
begin
//Agregar el LookupComboBox
    usuario.Caption := '';
    ZQEmpleados.Close;
    ZQEmpleados.SQL.Clear;
    ZQEmpleados.SQL.Add('SELECT empleado AS Usuario, Sucursal, MD5(Password) AS Password');
    ZQEmpleados.SQL.Add('FROM empleado');
    ZQEmpleados.SQL.Add('JOIN sucursal ON sucursal.idsucursal = empleado.idsucursal');
    ZQEmpleados.ExecSQL;
    ZQEmpleados.Open;
    dbgrid1.Refresh;

    ZQSucursal.Close;
    ZQSucursal.SQL.Clear;
    ZQSucursal.SQL.Add('SELECT * FROM sucursal');
    ZQSucursal.ExecSQL;
    ZQSucursal.Open;

    listaSucursales.ListField := 'sucursal';
    listaSucursales.KeyField := 'idsucursal';
end;
end.
