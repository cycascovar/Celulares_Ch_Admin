program CelularesChapulh;

uses
  Forms,
  F_Login in 'F_Login.pas' {FLogin},
  splashScreen in 'splashScreen.pas' {Form2},
  FPrincipalEmpleados in 'FPrincipalEmpleados.pas' {FPrincipal},
  FGarantia in 'FGarantia.pas' {FGarantias},
  FReparacion in 'FReparacion.pas' {FReparaciones},
  FAlmacen_Local in 'FAlmacen_Local.pas' {FAlmacenLocal},
  FAcerca_De in 'FAcerca_De.pas' {FAcercaDe},
  FRecargas in 'FRecargas.pas' {F_Recargas},
  F_RecargasAlta in 'F_RecargasAlta.pas' {FRecargasAlta},
  SQLMovimientos in 'SQLMovimientos.pas',
  uUtils in 'uUtils.pas',
  FR_VentaDiario in 'FR_VentaDiario.pas' {FRVentaDiario},
  FA_Login in 'super\FA_Login.pas' {FALogin},
  F_PrincipalAdmin in 'super\F_PrincipalAdmin.pas' {FPrincipalAdmin},
  C_Usuarios in 'super\C_Usuarios.pas' {CUsuarios},
  CClientesGarantia in 'super\CClientesGarantia.pas' {C_ClientesGarantia},
  F_AltaEquipos in 'super\F_AltaEquipos.pas' {FAltaEquipo},
  F_Usuarios in 'super\F_Usuarios.pas' {FUsuarios};

{$R *.res}
begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFLogin, FLogin);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.CreateForm(TFGarantias, FGarantias);
  Application.CreateForm(TFReparaciones, FReparaciones);
  Application.CreateForm(TFAlmacenLocal, FAlmacenLocal);
  Application.CreateForm(TFAcercaDe, FAcercaDe);
  Application.CreateForm(TF_Recargas, F_Recargas);
  Application.CreateForm(TFRecargasAlta, FRecargasAlta);
  Application.CreateForm(TFRVentaDiario, FRVentaDiario);
  Application.CreateForm(TFALogin, FALogin);
  Application.CreateForm(TFPrincipalAdmin, FPrincipalAdmin);
  Application.CreateForm(TCUsuarios, CUsuarios);
  Application.CreateForm(TC_ClientesGarantia, C_ClientesGarantia);
  Application.CreateForm(TFAltaEquipo, FAltaEquipo);
  Application.CreateForm(TFUsuarios, FUsuarios);
  Application.Run;
end.
