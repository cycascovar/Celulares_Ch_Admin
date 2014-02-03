unit FA_Login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, pngimage, ExtCtrls;

type
  TFALogin = class(TForm)
    BitBtn1: TBitBtn;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    BitBtn2: TBitBtn;
    Image1: TImage;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FALogin: TFALogin;

implementation
uses
    F_PrincipalAdmin;

{$R *.dfm}

procedure TFALogin.BitBtn1Click(Sender: TObject);
begin
    FPrincipalAdmin.Enabled := false;
    FPrincipalAdmin := TFPrincipalAdmin.Create(self);
    FPrincipalAdmin.ShowModal;
end;

end.
