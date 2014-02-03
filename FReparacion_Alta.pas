unit FReparacion_Alta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TFReparacionesAlta = class(TForm)
    LReparacion_Alta: TLabel;
    GroupBox1: TGroupBox;
    LRTitular: TLabel;
    LRPhone: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ETitular: TEdit;
    EPhone: TEdit;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    EIMEI: TEdit;
    EFolio: TEdit;
    Memo1: TMemo;
    Memo2: TMemo;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FReparacionesAlta: TFReparacionesAlta;

implementation

{$R *.dfm}

procedure TFReparacionesAlta.BitBtn1Click(Sender: TObject);
begin
    Application.MessageBox('El equipo se agregó a reparaciones','Información',MB_ICONINFORMATION);
end;

procedure TFReparacionesAlta.BitBtn2Click(Sender: TObject);
begin
    FReparacionesAlta.Close;
end;

end.
