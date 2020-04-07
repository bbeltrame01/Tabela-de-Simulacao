object ftabelasimulacao: Tftabelasimulacao
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Tabela de Simula'#231#227'o'
  ClientHeight = 559
  ClientWidth = 1133
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    1133
    559)
  PixelsPerInch = 96
  TextHeight = 13
  object lbl_tempo: TLabel
    Left = 8
    Top = 11
    Width = 128
    Height = 13
    Caption = 'Tempo da Simula'#231#227'o (min):'
  end
  object gpb_tec: TGroupBox
    Left = 8
    Top = 39
    Width = 169
    Height = 233
    Caption = 'TEC'
    TabOrder = 1
    DesignSize = (
      169
      233)
    object Label1: TLabel
      Left = 10
      Top = 79
      Width = 110
      Height = 13
      Caption = 'Lista de Entradas (min)'
    end
    object edt_tec: TEdit
      Left = 10
      Top = 19
      Width = 145
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      NumbersOnly = True
      TabOrder = 0
      OnKeyDown = edt_tecKeyDown
    end
    object btn_addtec: TButton
      Left = 10
      Top = 43
      Width = 145
      Height = 30
      Anchors = [akTop, akRight]
      Caption = 'Adicionar'
      TabOrder = 1
      OnClick = btn_addtecClick
    end
    object lst_tec: TListView
      Left = 10
      Top = 94
      Width = 145
      Height = 131
      Anchors = [akLeft, akTop, akRight, akBottom]
      Columns = <>
      RowSelect = True
      SortType = stText
      TabOrder = 2
      ViewStyle = vsSmallIcon
    end
  end
  object gpb_ts: TGroupBox
    Left = 8
    Top = 278
    Width = 169
    Height = 233
    Caption = 'TS'
    TabOrder = 2
    DesignSize = (
      169
      233)
    object Label2: TLabel
      Left = 10
      Top = 80
      Width = 107
      Height = 13
      Caption = 'Lista de Servi'#231'os (min)'
    end
    object edt_ts: TEdit
      Left = 10
      Top = 19
      Width = 145
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      NumbersOnly = True
      TabOrder = 0
      OnKeyDown = edt_tsKeyDown
    end
    object btn_addts: TButton
      Left = 10
      Top = 43
      Width = 145
      Height = 30
      Anchors = [akTop, akRight]
      Caption = 'Adicionar'
      TabOrder = 1
      OnClick = btn_addtsClick
    end
    object lst_ts: TListView
      Left = 10
      Top = 95
      Width = 145
      Height = 131
      Anchors = [akLeft, akTop, akRight, akBottom]
      Columns = <>
      RowSelect = True
      SortType = stText
      TabOrder = 2
      ViewStyle = vsSmallIcon
    end
  end
  object edt_tempo: TEdit
    Left = 148
    Top = 8
    Width = 81
    Height = 21
    NumbersOnly = True
    TabOrder = 0
  end
  object stg_simulacao: TStringGrid
    Left = 183
    Top = 39
    Width = 942
    Height = 472
    Anchors = [akLeft, akTop, akRight, akBottom]
    ColCount = 9
    DefaultColWidth = 100
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
    TabOrder = 3
    OnDrawCell = stg_simulacaoDrawCell
  end
  object btn_limpar: TButton
    Left = 857
    Top = 517
    Width = 131
    Height = 36
    Anchors = [akRight, akBottom]
    Caption = 'Limpar'
    TabOrder = 5
    OnClick = btn_limparClick
  end
  object btn_simular: TButton
    Left = 994
    Top = 517
    Width = 131
    Height = 36
    Anchors = [akRight, akBottom]
    Caption = 'Simular'
    TabOrder = 4
    OnClick = btn_simularClick
  end
end
