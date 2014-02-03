unit FC_EquiposEntregados;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DBCtrls, StdCtrls;

type
  TFCEquiposEntregados = class(TForm)
    DBGrid1: TDBGrid;
    DBLookupComboBox1: TDBLookupComboBox;
    Button1: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCEquiposEntregados: TFCEquiposEntregados;

implementation

{$R *.dfm}

end.
