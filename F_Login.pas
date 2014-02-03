unit F_Login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  ZAbstractConnection, ZConnection, pngimage, ExtCtrls;

type
  TFLogin = class(TForm)
    login: TButton;
    username: TEdit;
    password: TEdit;
    LUsuario: TLabel;
    LPass: TLabel;
    exit: TButton;
    Label3: TLabel;
    ZCDesarrollo: TZConnection;
    Image1: TImage;

    procedure loginClick(Sender: TObject);
    procedure exitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure passwordKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    ZQLogin: TZQuery;
    ZQMovimiento: TZQuery;
  public
    { Public declarations }
  end;

var
  FLogin: TFLogin;

implementation
uses
    FAcerca_De,FPrincipalEmpleados, FAlmacen_Venta;
{$R *.dfm}

procedure TFLogin.exitClick(Sender: TObject);
begin
    FLogin.Close;
    ZCDesarrollo.Free;
    ZQLogin.Free;
end;

procedure TFLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    ZCDesarrollo.Free;
    ZQLogin.Close;
end;

procedure TFLogin.FormShow(Sender: TObject);
begin
    Application.MainFormOnTaskBar := true;
    Application.Title := 'Celulares Chapulh.';
    ZQLogin := TZQuery.Create(self);
    ZQLogin.Connection := ZCDesarrollo;
    ZQLogin.ShowRecordTypes := [usUnmodified,usModified,usInserted];
    ZQLogin.Options := [doCalcDefaults];
    ZQLogin.AutoCalcFields := true;

    ZQMovimiento := TZQuery.Create(self);
    ZQMovimiento.Connection := ZCDesarrollo;
    ZQMovimiento.ShowRecordTypes := [usUnmodified,usModified,usInserted];
    ZQMovimiento.Options := [doCalcDefaults];
    ZQMovimiento.AutoCalcFields := true;
end;

procedure TFLogin.loginClick(Sender: TObject);
begin
    try
        ZQLogin.Close;
        ZQLogin.SQL.Clear;
        ZQLogin.SQL.Add('SELECT idempleado, empleado, idsucursal');
        ZQLogin.SQL.Add('FROM empleado');
        ZQLogin.SQL.Add('WHERE empleado="'+username.Text+'" AND password="'+password.Text+'"');
        ZQLogin.ExecSQL;
        ZQLogin.Open;

        if ZQLogin.FieldByName('idempleado').IsNull <> true then
        begin
            FLogin.Visible := false;
            FPrincipal.Enabled := false;
            FPrincipal := TFPrincipal.Create(self);
            FPrincipal.ShowModal;
        end
        else
        begin
            Application.MessageBox('Usuario o contraseña incorrectos.','Acceso denegado', MB_ICONSTOP);
            ZQMovimiento.Close;
            ZQMovimiento.SQL.Clear;
            ZQMovimiento.SQL.Add('INSERT INTO empleado_movimiento (movimiento, movimiento_detalles,empleado,fecha)');
            ZQMovimiento.SQL.Add('VALUES ("Intento de login fallido.","El usuario: '+username.Text+', ingreso datos incorrectos.","'+username.Text+'","'+FormatDateTime('YYYY/MM/DD',Date())+'")');
            ZQMovimiento.ExecSQL;
        end;
    except
    on E: Exception do
    begin
        Application.MessageBox('No se puede conectar a la base de datos.','Atención',MB_ICONINFORMATION);
        ZQMovimiento.Close;
        ZQMovimiento.SQL.Clear;
        ZQMovimiento.SQL.Add('INSERT INTO empleado_movimiento (movimiento, movimiento_detalles)');
        ZQMovimiento.SQL.Add('VALUES ("Intento de conexión a la BD.","Se realizó un intento fallido el día '+DateToStr(Now())+'.")');
        ZQMovimiento.ExecSQL;
    end;
    end;
end;

procedure TFLogin.passwordKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = #13 then
    begin
        try
            ZQLogin.Close;
            ZQLogin.SQL.Clear;
            ZQLogin.SQL.Add('SELECT idempleado, empleado');
            ZQLogin.SQL.Add('FROM empleado');
            ZQLogin.SQL.Add('WHERE empleado="'+username.Text+'" AND password="'+password.Text+'"');
            ZQLogin.ExecSQL;
            ZQLogin.Open;

            if ZQLogin.FieldByName('idempleado').IsNull <> true then
            begin
                FLogin.Visible := false;
                FPrincipal.Enabled := false;
                FPrincipal := TFPrincipal.Create(self);
                FPrincipal.ShowModal;
            end
            else
            begin
                Application.MessageBox( 'Usuario o contraseña incorrectos.','Acceso denegado', MB_ICONSTOP);
                ZQMovimiento.Close;
                ZQMovimiento.SQL.Clear;
                ZQMovimiento.SQL.Add('INSERT INTO empleado_movimiento (movimiento, movimiento_detalles,empleado,fecha)');
                ZQMovimiento.SQL.Add('VALUES ("Intento de login fallido.","El usuario: '+username.Text+', ingreso datos incorrectos.","'+username.Text+'","'+FormatDateTime('YYYY/MM/DD',Date())+'")');
                ZQMovimiento.ExecSQL;
            end;
    except
        on E: Exception do
        begin
            Application.MessageBox('No se puede conectar a la base de datos.','Atención',MB_ICONINFORMATION);
            ZQMovimiento.Close;
            ZQMovimiento.SQL.Clear;
            ZQMovimiento.SQL.Add('INSERT INTO empleado_movimiento (movimiento, movimiento_detalles,empleado,fecha)');
            ZQMovimiento.SQL.Add('VALUES ("Intento de conexión a la BD.","Se realizó un intento fallido el día '+DateToStr(Now())+'.","'+username.Text+'","'+FormatDateTime('YYYY/MM/DD',Date())+'")');
            ZQMovimiento.ExecSQL;
        end;
        end;
    end;
end;

end.
