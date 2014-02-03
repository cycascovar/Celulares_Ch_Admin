unit F_RecargasAlta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TFRecargasAlta = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    celulares: TMemo;
    Label5: TLabel;
    Button2: TButton;
    Button3: TButton;
    ZQRecargas: TZQuery;
    DSRecargas: TDataSource;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FRecargasAlta: TFRecargasAlta;

implementation

{$R *.dfm}

procedure TFRecargasAlta.Button1Click(Sender: TObject);
begin
    Application.MessageBox('Codigo generado.','Información',MB_ICONINFORMATION);
end;

procedure TFRecargasAlta.Button2Click(Sender: TObject);
begin
    FRecargasAlta.Close;
end;

end.
