unit utabelasimulacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Grids;

type
  Tftabelasimulacao = class(TForm)
    gpb_tec: TGroupBox;
    edt_tec: TEdit;
    btn_addtec: TButton;
    lst_tec: TListView;
    Label1: TLabel;
    gpb_ts: TGroupBox;
    Label2: TLabel;
    edt_ts: TEdit;
    btn_addts: TButton;
    lst_ts: TListView;
    lbl_tempo: TLabel;
    edt_tempo: TEdit;
    stg_simulacao: TStringGrid;
    btn_limpar: TButton;
    btn_simular: TButton;
    procedure FormActivate(Sender: TObject);
    procedure stg_simulacaoDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure btn_addtecClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_addtsClick(Sender: TObject);
    procedure edt_tecKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edt_tsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_limparClick(Sender: TObject);
    procedure btn_simularClick(Sender: TObject);
  private
    { Private declarations }
    slTEC: TStringList;
    slTS: TStringList;

    procedure LimparGrid;
  public
    { Public declarations }
  end;

var
  ftabelasimulacao: Tftabelasimulacao;

implementation

{$R *.dfm}

procedure Tftabelasimulacao.btn_addtecClick(Sender: TObject);
var
  Item: TListItem;
begin
  try
    if edt_tec.Text<>'' then
    begin
      slTEC.Add(edt_tec.Text);
      // ListView
      Item := lst_tec.Items.Add;
      Item.Caption := edt_tec.Text;
    end
    else
      MessageDlg('O campo está em branco!', mtWarning, mbOKCancel, 0);
  finally
    edt_tec.Text := '';
    edt_tec.SetFocus;
  end;
end;

procedure Tftabelasimulacao.btn_addtsClick(Sender: TObject);
var
  Item: TListItem;
begin
  try
    if edt_ts.Text<>'' then
    begin
      slTS.Add(edt_ts.Text);
      // ListView
      Item := lst_ts.Items.Add;
      Item.Caption := edt_ts.Text;
    end
    else
      MessageDlg('O campo está em branco!', mtWarning, mbOKCancel, 0);
  finally
    edt_ts.Text := '';
    edt_ts.SetFocus;
  end;
end;

procedure Tftabelasimulacao.btn_limparClick(Sender: TObject);
var
  i,j:integer;
begin
  if MessageDlg('Deseja limpar os dados?', mtInformation, mbYesNo, 0) = mrYes then
  begin
    edt_tempo.Clear;
    slTEC.Clear;
    lst_tec.Clear;
    slTS.Clear;
    lst_ts.Clear;
    LimparGrid;
  end;
end;

procedure Tftabelasimulacao.btn_simularClick(Sender: TObject);
var
  i,j,iRelogio,iTFSAnt,iCliente,
  iTCS,iTLO,iTIS,iFila,iTFS,
  iTotTS,iTotFila,iTotTCS,iTotTLO: integer;
  dTMEF,dPOL,dTMS,dTMDS: double;

  procedure ZerarTotais;
  begin
    iCliente:=1;
    iRelogio:=0;
    iTFSAnt :=0;
    iTotTS  :=0;
    iTotFila:=0;
    iTotTCS :=0;
    iTotTLO :=0;
  end;

  procedure MontarTabela(iTEC,iTS:integer);
  begin
    with stg_simulacao do
    begin
      Cells[0,iCliente]:=IntToStr(iCliente);
      Cells[1,iCliente]:=IntToStr(iTEC);
      Cells[2,iCliente]:=IntToStr(iRelogio);
      Cells[3,iCliente]:=IntToStr(iTS);
      Cells[4,iCliente]:=IntToStr(iTIS);
      Cells[5,iCliente]:=IntToStr(iFila);
      Cells[6,iCliente]:=IntToStr(iTFS);
      Cells[7,iCliente]:=IntToStr(iTCS);
      Cells[8,iCliente]:=IntToStr(iTLO);
    end;
    // Tempo Final do Serviço Anterior
    iTFSAnt := iTFS;
    // Somar Totais
    iTotTS  :=iTotTS+iTS;
    iTotFila:=iTotFila+iFila;
    iTotTCS :=iTotTCS+iTCS;
    iTotTLO :=iTotTLO+iTLO;
    Inc(iCliente);
  end;
begin
  // Zerar Variaveis
  ZerarTotais;
  LimparGrid;

  while True do
  begin
    // Sortear Valor Inicial
    i:=random(slTEC.Count);
    j:=random(slTS.Count);
    // CALCULO
    iRelogio := iRelogio+StrToInt(slTEC[i]);  // Tempo de Chegada no Relógio da Simulação
    if iRelogio>StrToIntDef(edt_tempo.Text,0) then Break;
    if iTFSAnt>=iRelogio then
      iFila := iTFSAnt - iRelogio             // Tempo do Cliente na Fila
    else iFila := 0;
    iTIS := iRelogio + iFila;                 // Tempo do Início de Serviço
    iTFS := StrToIntDef(slTS[j],0) + iTIS;    // Tempo Final de Serviço
    iTCS := StrToIntDef(slTS[j],0) + iFila;   // Tempo do Cliente no Sistema
    if iTFSAnt<iRelogio then
      iTLO := iRelogio - iTFSAnt              // Tempo Livre do Operador
    else iTLO := 0;
    MontarTabela(StrToIntDef(slTEC[i],0),StrToIntDef(slTS[j],0));
  end;
  if slTEC.Count>0 then
  begin
    dTMEF:=iTotFila/slTEC.Count;
    dPOL :=iTotTLO/iTFS;
    dTMS :=iTotTS/slTEC.Count;
    dTMDS:=iTotTCS/slTEC.Count;
    stg_simulacao.RowCount:=iCliente;
    MessageDlg('Tempo Médio de Espera na Fila: '+FormatFloat('#,##0.00',dTMEF)+' min'+#13+
               'Probabilidade de um cliente esperar na fila: '+FormatFloat('#,##0.00',dTMEF)+' %'+#13+
               'Probabilidade do Operador Livre: '+FormatFloat('#,##0.00',dPOL) +' %'+#13+
               'Tempo Médio de Serviço: '+FormatFloat('#,##0.00',dTMS) +' min'+#13+
               'Tempo Médio Despendido no Sistema: '+FormatFloat('#,##0.00',dTMDS)+' min',
               mtInformation,[mbOk],0);
  end;
end;

procedure Tftabelasimulacao.edt_tecKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=13 then
    btn_addtecClick(Sender);
end;

procedure Tftabelasimulacao.edt_tsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=13 then
    btn_addtsClick(Sender);
end;

procedure Tftabelasimulacao.FormActivate(Sender: TObject);
var
  Num_Linhas, Num_Colunas: integer;
  sTexto: string;
begin
  Num_Linhas  := 2;
  Num_Colunas := 9;

  with stg_simulacao do
  begin
    RowCount := Num_Linhas;
    ColCount := Num_Colunas;

    Cells[0,0]:='Clientes';
    Cells[1,0]:='Tempo desde a última chegada (min)';
    Cells[2,0]:='Tempo de Chegada  no Relógio da Simulação';
    Cells[3,0]:='Tempo de Serviço (min)';
    Cells[4,0]:='Tempo de Início do Serviço';
    Cells[5,0]:='Tempo do Cliente na fila';
    Cells[6,0]:='Tempo Final do Serviço';
    Cells[7,0]:='Tempo do Cliente no Sistema (min)';
    Cells[8,0]:='Tempo Livre do Operador (min)';
  end;
end;

procedure Tftabelasimulacao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  slTEC.Free;
  slTS.Free;
  Action:=caFree;
end;

procedure Tftabelasimulacao.FormCreate(Sender: TObject);
begin
  slTEC := TStringList.Create;
  slTS  := TStringList.Create;
end;

procedure Tftabelasimulacao.LimparGrid;
var
  i,j:integer;
begin
  // Limpar Tabela
  for i := 1 to stg_simulacao.RowCount - 1 do
    for j := 0 to stg_simulacao.ColCount - 1 do
      stg_simulacao.Cells[j, i] := '';
end;

procedure Tftabelasimulacao.stg_simulacaoDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  sTexto: String;
begin
  // MONTAR CABEÇALHO
  if ARow = 0 then
  begin // Trata apenas as colunas da primeira linha.
    with TStringGrid(Sender) do
    begin
      Canvas.Brush.Color:=clWhite;
      RowHeights[ARow]:=72; // Altura da Linha
      Canvas.FillRect(Rect); // Limpa o conteúdo da célula.
      sTexto := Cells[ACol, ARow];
      Canvas.Font.Style:=[fsBold];
      Canvas.TextRect(Rect, sTexto, [tfWordBreak,tfVerticalCenter,tfCenter]);
    end;
  end;
end;

end.
