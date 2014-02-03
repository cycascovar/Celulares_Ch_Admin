unit CClientesGarantia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids;

type
  TC_ClientesGarantia = class(TForm)
    DBGrid1: TDBGrid;
    sucursal: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  C_ClientesGarantia: TC_ClientesGarantia;

implementation

{$R *.dfm}

end.
