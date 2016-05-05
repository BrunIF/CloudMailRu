unit RemoteProperty;

interface

uses
	Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
	Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, CloudMailRu;

type
	TPropertyForm = class(TForm)
		PublicLinkLabel: TLabel;
		WebLink: TEdit;
		AccessCB: TCheckBox;
		OkButton: TButton;
		class procedure ShowProperty(parentWindow: HWND; RemoteProperty: TCloudMailRuDirListingItem);
		procedure AccessCBClick(Sender: TObject);
		procedure FormShow(Sender: TObject);
		procedure OkButtonClick(Sender: TObject);
	private
		{ Private declarations }
	protected
		Props: TCloudMailRuDirListingItem;
	public
		{ Public declarations }

	end;

var
	PropertyForm: TPropertyForm;

implementation

{$R *.dfm}
{ TPropertyForm }

{ TPropertyForm }

procedure TPropertyForm.AccessCBClick(Sender: TObject);
begin
	WebLink.Enabled := AccessCB.checked;
end;

procedure TPropertyForm.FormShow(Sender: TObject);
begin
	if not(Props.WebLink = '') then
	begin
		WebLink.text := 'https://cloud.mail.ru/public/' + Props.WebLink;
		WebLink.SetFocus;
		WebLink.SelectAll;
	end;
	AccessCB.checked := not(Props.WebLink = '');
	WebLink.Enabled := AccessCB.checked;
end;

procedure TPropertyForm.OkButtonClick(Sender: TObject);
begin
	close;
end;

class procedure TPropertyForm.ShowProperty(parentWindow: HWND; RemoteProperty: TCloudMailRuDirListingItem);
var
	PropertyForm: TPropertyForm;
begin
	try
		PropertyForm := TPropertyForm.Create(nil);
		PropertyForm.parentWindow := parentWindow; { TODO : ���������� ���������������� ������������ ���� TC }
		PropertyForm.Caption := RemoteProperty.name;
		PropertyForm.Props := RemoteProperty;
		PropertyForm.Showmodal;
	finally
		FreeAndNil(PropertyForm);
	end;
end;

end.