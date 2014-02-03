unit FPrincipalEmpleados;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, StdCtrls, pngimage, ZAbstractConnection, ZConnection,
  DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, ComCtrls;

type
  TFPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    Garantas1: TMenuItem;
    Reparacin1: TMenuItem;
    Verequiposengaranta1: TMenuItem;
    Verequiposenreparacin1: TMenuItem;
    Ayuda1: TMenuItem;
    Acercade1: TMenuItem;
    Cmousarelsistema1: TMenuItem;
    Equipos1: TMenuItem;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Recargas1: TMenuItem;
    Salir1: TMenuItem;
    Button4: TButton;
    Button5: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Verequiposenalmacen1: TMenuItem;
    Vercelularesasignados1: TMenuItem;
    ZConexion: TZConnection;
    N2: TMenuItem;
    Salir2: TMenuItem;
    ZQuery1: TZQuery;
    StatusBar1: TStatusBar;
    Timer1: TTimer;
    Reportes1: TMenuItem;
    Equipos2: TMenuItem;
    Garanta1: TMenuItem;
    Reparacin2: TMenuItem;
    Inventario1: TMenuItem;
    Ventasdeldia1: TMenuItem;
    Label4: TLabel;
    Administrador1: TMenuItem;
    Iniciar1: TMenuItem;
    procedure Acercade1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Verequiposenreparacin1Click(Sender: TObject);
    procedure Llenarsolicitud1Click(Sender: TObject);
    procedure Llenarsolicitud2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Verequiposenalmacen1Click(Sender: TObject);
    procedure Generarcdigos1Click(Sender: TObject);
    procedure Vercelularesasignados1Click(Sender: TObject);
    procedure Verequiposengaranta1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Salir2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Iniciar1Click(Sender: TObject);
  private
    { Private declarations }
    ZQMovimiento : TZQuery;
  public
    { Public declarations }
    idEmpleado, idSucursal : Integer;
    sucursal : String;
  end;

var
  FPrincipal: TFPrincipal;

implementation
uses
    FAcerca_De,F_Login,FAlmacen_Local,FGarantia,FReparacion,
    FRecargas,FGarantia_Alta, FReparacion_Alta, FAlmacen_Venta,
    F_RecargasAlta,FA_Login;


{$R *.dfm}

procedure TFPrincipal.Acercade1Click(Sender: TObject);
begin
    FAcercaDe.Enabled := false;
    FAcercaDe := TFAcercaDe.Create(self);
    FAcercaDe.ShowModal;
end;

procedure TFPrincipal.Button1Click(Sender: TObject);
begin
    FAlmacenLocal.Enabled := false;
    FAlmacenLocal := TFAlmacenLocal.Create(self);
    FAlmacenLocal.ShowModal;
end;

procedure TFPrincipal.Button2Click(Sender: TObject);
begin
    F_Recargas.Enabled := false;
    F_Recargas := TF_Recargas.Create(self);
    F_Recargas.ShowModal;
end;

procedure TFPrincipal.Button3Click(Sender: TObject);
begin
    FGarantias.Enabled := false;
    FGarantias := TFGarantias.Create(self);
    FGarantias.ShowModal;
end;

procedure TFPrincipal.Button4Click(Sender: TObject);
begin
    FReparaciones.Enabled := false;
    FReparaciones := TFReparaciones.Create(self);
    FReparaciones.ShowModal;
end;

procedure TFPrincipal.Button5Click(Sender: TObject);
begin
    try
        if application.MessageBox (pchar('¿Desea salir del programa?'), pchar('Confirmar'), (MB_YESNO + MB_ICONQUESTION)) = IDYES then
        begin
            ZQMovimiento.Close;
            ZQMovimiento.SQL.Clear;
            ZQMovimiento.SQL.Add('INSERT INTO empleado_movimiento (movimiento,movimiento_detalles,sucursal,empleado,fecha)');
            ZQMovimiento.SQL.Add('VALUES ("Salida del programa.","El usuario '+FLogin.username.Text+' dejó de usar el sistema el dia '+DateToStr(Date())+' a las '+TimeToStr(Time())+'","'+sucursal+'","'+FLogin.username.Text+'","'+FormatDateTime('YYYY/MM/DD',Date())+'")');
            ZQMovimiento.ExecSQL;
            FLogin.Close;
        end;
    finally
        ZQMovimiento.Free;
    end;
end;

procedure TFPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    try
        ZQMovimiento.Close;
        ZQMovimiento.SQL.Clear;
        ZQMovimiento.SQL.Add('INSERT INTO empleado_movimiento (movimiento,movimiento_detalles,sucursal,empleado,fecha)');
        ZQMovimiento.SQL.Add('VALUES ("Salida del programa.","El usuario '+FLogin.username.Text+' dejó de usar el sistema el dia '+DateToStr(Date())+' a las '+TimeToStr(Time())+'","'+sucursal+'","'+FLogin.username.Text+'","'+FormatDateTime('YYYY/MM/DD',Date())+'")');
        ZQMovimiento.ExecSQL;
        FLogin.Close;
    finally
        ZQMovimiento.Free;
    end;
end;

procedure TFPrincipal.FormCreate(Sender: TObject);
begin
    SetWindowLong(Handle, GWL_EXSTYLE, WS_EX_APPWINDOW);
end;

procedure TFPrincipal.FormShow(Sender: TObject);
begin
    Label2.Caption := FLogin.username.Text;
    FormatDateTime('YYYY/MM/DD',Date());
    StatusBar1.Panels[0].Text := DateToStr(Date()); //fecha
    StatusBar1.Panels[0].Width := 70;

    ZQMovimiento := TZQuery.Create(Application);
    ZQMovimiento.Connection := ZConexion;
    ZQMovimiento.ShowRecordTypes := [usUnmodified,usModified,usInserted];
    ZQMovimiento.Options := [doCalcDefaults];
    ZQMovimiento.AutoCalcFields := true;

    ZQuery1.Close;
    ZQuery1.SQL.Clear;
    ZQuery1.SQL.Add('SELECT idempleado,idsucursal');
    ZQuery1.SQL.Add('FROM empleado');
    ZQuery1.SQL.Add('WHERE password="'+FLogin.password.Text+'"');
    ZQuery1.ExecSQL;
    ZQuery1.Open;

    idEmpleado := ZQuery1.FieldByName('idempleado').AsInteger;
    idSucursal := ZQuery1.FieldByName('idsucursal').AsInteger;

    ZQuery1.Close;
    ZQuery1.SQL.Clear;
    ZQuery1.SQL.Add('SELECT sucursal');
    ZQuery1.SQL.Add('FROM sucursal');
    ZQuery1.SQL.Add('WHERE idsucursal='+IntToStr(idSucursal)+'');
    ZQuery1.ExecSQL;
    ZQuery1.Open;
    Sucursal := ZQuery1.FieldByName('sucursal').AsString;

    FPrincipal.Caption := 'Principal - Celulares "Chapulh", (sucursal '+sucursal+')';
    Application.Title := 'Celulares "Chapulh", (sucursal '+sucursal+')';

    ZQMovimiento.Close;
    ZQMovimiento.SQL.Clear;
    ZQMovimiento.SQL.Add('INSERT INTO empleado_movimiento (movimiento,movimiento_detalles,sucursal,empleado,fecha)');
    ZQMovimiento.SQL.Add('VALUES ("Inicio de sesión.","El usuario '+FLogin.username.Text+' inicio sesion corectamente.","'+sucursal+'","'+FLogin.username.Text+'","'+FormatDateTime('YYYY/MM/DD',Date())+'")');
    ZQMovimiento.ExecSQL;

end;

procedure TFPrincipal.Generarcdigos1Click(Sender: TObject);
begin
    FRecargasAlta.Enabled := false;
    FRecargasAlta := TFRecargasAlta.Create(self);
    FRecargasAlta.ShowModal;
end;

procedure TFPrincipal.Iniciar1Click(Sender: TObject);
begin
    FALogin.Enabled := false;
    FALogin := TFALogin.Create(self);
    FALogin.ShowModal();
end;

procedure TFPrincipal.Llenarsolicitud1Click(Sender: TObject);
begin
    FGarantiasAlta.Enabled := false;
    FGarantiasAlta := TFGarantiasAlta.Create(self);
    FGarantiasAlta.ShowModal;
end;

procedure TFPrincipal.Llenarsolicitud2Click(Sender: TObject);
begin
    FReparacionesAlta.Enabled := false;
    FReparacionesAlta := TFReparacionesAlta.Create(self);
    FReparacionesAlta.ShowModal;
end;

procedure TFPrincipal.Salir2Click(Sender: TObject);
begin
    if application.MessageBox (pchar('¿Desea salir del programa?'), pchar('Confirmar'), (MB_YESNO + MB_ICONQUESTION)) = IDYES then
    begin
        ZQMovimiento.Close;
        ZQMovimiento.SQL.Clear;
        ZQMovimiento.SQL.Add('INSERT INTO empleado_movimiento (movimiento,movimiento_detalles,sucursal)');
        ZQMovimiento.SQL.Add('VALUES ("Salida del programa.","El usuario '+FLogin.username.Text+' dejó de usar el sistema el dia '+DateToStr(Date())+'a las '+TimeToStr(Time())+'.","'+sucursal+'")');
        ZQMovimiento.ExecSQL;
        FLogin.Close;
    end;
end;

procedure TFPrincipal.Timer1Timer(Sender: TObject);
begin
    StatusBar1.Panels[1].Text := TimeToStr(Time());
end;

procedure TFPrincipal.Vercelularesasignados1Click(Sender: TObject);
begin
    F_Recargas.Enabled := false;
    F_Recargas := TF_Recargas.Create(self);
    F_Recargas.ShowModal;
end;

procedure TFPrincipal.Verequiposenalmacen1Click(Sender: TObject);
begin
    FAlmacenLocal.Enabled := false;
    FAlmacenLocal := TFAlmacenLocal.Create(self);
    FAlmacenLocal.ShowModal;
end;

procedure TFPrincipal.Verequiposengaranta1Click(Sender: TObject);
begin
    FGarantias.Enabled := false;
    FGarantias := TFGarantias.Create(self);
    FGarantias.ShowModal;
end;

procedure TFPrincipal.Verequiposenreparacin1Click(Sender: TObject);
begin
    FReparaciones.Enabled := false;
    FReparaciones := TFReparaciones.Create(self);
    FReparaciones.ShowModal;
end;

end.




