unit setes_forms;

interface

uses
      Vcl.Forms, System.SysUtils;

type
  TSetesForms = class
  public
    class procedure Show(FormClass: TFormClass);
  end;

implementation

class procedure TSetesForms.Show(FormClass: TFormClass);
var
  Lc_form: TForm;
begin
  Lc_form := FormClass.Create(nil);
  try
    Lc_form.ShowModal;
  finally
    FreeAndNil( Lc_form );
  end;
end;

end.
