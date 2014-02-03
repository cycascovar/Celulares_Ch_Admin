unit FAcerca_De;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset;

type
  TFAcercaDe = class(TForm)
    Label1: TLabel;
    label33: TLabel;
    ver: TLabel;
    Label2: TLabel;
    LinkLabel1: TLinkLabel;
    Label3: TLabel;
    Label4: TLabel;
    sucursal: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure FormClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LinkLabel1Click(Sender: TObject);
  private
    { Private declarations }
    ZQSucursal : TZQuery;
  public
    { Public declarations }
  end;

var
    FAcercaDe: TFAcercaDe;

implementation
uses
    FPrincipalEmpleados;

{$R *.dfm}

procedure TFAcercaDe.FormClick(Sender: TObject);
begin
    FAcercaDe.Close;
end;

procedure TFAcercaDe.FormShow(Sender: TObject);
var
  verblock:PVSFIXEDFILEINFO;
  versionMS,versionLS:cardinal;
  verlen:cardinal;
  rs:TResourceStream;
  m:TMemoryStream;
  p:pointer;
  s:cardinal;
begin
    sucursal.Caption := FPrincipal.sucursal;
    sucursal.Update;
end;

procedure TFAcercaDe.LinkLabel1Click(Sender: TObject);
begin
    //agregar un link para enviar un correo
end;

end.
