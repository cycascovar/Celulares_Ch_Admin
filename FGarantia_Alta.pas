unit FGarantia_Alta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, ComCtrls, Buttons,ZConnection, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  ZAbstractConnection, SQLMovimientos;

type
  TFGarantiasAlta = class(TForm)
    MainMenu1: TMainMenu;
    Inventario1: TMenuItem;
    Recargas1: TMenuItem;
    Garantas1: TMenuItem;
    Reparaciones1: TMenuItem;
    Ayuda1: TMenuItem;
    Salir1: TMenuItem;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    datosClienteBox: TGroupBox;
    datosEquipoBox: TGroupBox;
    Edit1: TEdit;
    LTitular: TLabel;
    LPhone: TLabel;
    Edit2: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    imeiCelular: TEdit;
    Edit5: TEdit;
    Label7: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    Label2: TLabel;
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    ZQMovimiento: TZQuery;
  public
    { Public declarations }
  end;

var
  FGarantiasAlta: TFGarantiasAlta;

implementation
uses
    FPrincipalEmpleados,F_Login;

{$R *.dfm}

procedure TFGarantiasAlta.BitBtn1Click(Sender: TObject);
begin
    FGarantiasAlta.Close;
end;

procedure TFGarantiasAlta.BitBtn3Click(Sender: TObject);
begin
    Application.MessageBox('El equipo se agregó a garantía.','Información',MB_ICONINFORMATION);
    ZQMovimiento.Close;
    ZQMovimiento.SQL.Clear;
    ZQMovimiento.SQL.Add('INSERT INTO empleado_movimiento (movimiento, movimiento_detalles)');
    ZQMovimiento.SQL.Add('VALUES ("Se agrego equipo a garantia.","El empleado '+FLogin.username.Text+' dio de alta un equipo en garantia, con imei: '+imeiCelular.Text+' el dia '+DateToStr(Now())+'")');
    ZQMovimiento.ExecSQL;
end;

procedure TFGarantiasAlta.FormShow(Sender: TObject);
begin
    ZQMovimiento := TZQuery.Create(self);
    ZQMovimiento.Connection := FPrincipal.ZConexion;
    ZQMovimiento.ShowRecordTypes := [usUnmodified,usModified,usInserted];
    ZQMovimiento.Options := [doCalcDefaults];
    ZQMovimiento.AutoCalcFields := true;
end;

end.


