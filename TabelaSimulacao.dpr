program TabelaSimulacao;

uses
  Vcl.Forms,
  utabelasimulacao in 'utabelasimulacao.pas' {ftabelasimulacao};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tftabelasimulacao, ftabelasimulacao);
  Application.Run;
end.
