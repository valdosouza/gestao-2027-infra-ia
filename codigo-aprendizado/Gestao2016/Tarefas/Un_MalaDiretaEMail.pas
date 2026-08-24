unit Un_MalaDiretaEMail;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Buttons, ExtCtrls, ComCtrls, DB, STQuery, Grids, StdCtrls, Mask, QEdit_Setes, DBGrids, OleCtrls, SHDocVw, MSHTML, Vcl.Samples.Gauges;

const
   IDM_MARCADOR = 2184;
   IDM_MARCADOR_LISTA = 2185;
   IDM_OUTDENT = 2187;
   IDM_INDENT = 2186;
   IDM_ALINHARESQ = 59;
   IDM_CENTRALIZAR = 57;
   IDM_ALINHADIR = 60;
   IDM_IMAGEM = 2168;
   IDM_LINHAHORIZ = 2150;
   IDM_RECORTAR = 16;
   IDM_COPIAR = 15;
   IDM_COLAR = 26;
   IDM_HYPERLINK = 2124;
   IDM_DESFAZER = 43;
     
type
  TFr_MalaDiretaEMail = class(TForm)
    Pg_email: TPageControl;
    tbs_EnvioEmail: TTabSheet;
    Panel3: TPanel;
    Qr_Email: TSTQuery;
    Ds_Qr_Email: TDataSource;
    TabSheet1: TTabSheet;
    Panel1: TPanel;
    Label2: TLabel;
    E_Assunto: TEdit;
    Label3: TLabel;
    Panel11: TPanel;
    Panel16: TPanel;
    Label38: TLabel;
    ComboSize: TComboBox;
    Panel12: TPanel;
    Panel13: TPanel;
    sb_negrito: TSpeedButton;
    Sb_Italico: TSpeedButton;
    Sb_Sublinhado: TSpeedButton;
    Sb_Cor: TSpeedButton;
    Panel14: TPanel;
    Sb_NumList: TSpeedButton;
    Sb_btnBullet: TSpeedButton;
    btnDecreaseIndent: TSpeedButton;
    btnIncreaseIndent: TSpeedButton;
    Panel15: TPanel;
    btnAlignLeft: TSpeedButton;
    btnCenter: TSpeedButton;
    btnAlignRight: TSpeedButton;
    Panel17: TPanel;
    btnHR: TSpeedButton;
    Panel19: TPanel;
    btnCut: TSpeedButton;
    btnCopy: TSpeedButton;
    btnPaste: TSpeedButton;
    Sb_Hiperlink: TSpeedButton;
    Sb_Desfazer: TSpeedButton;
    Label5: TLabel;
    Label8: TLabel;
    Cb_NameFont: TComboBox;
    Cb_SizeFonte: TComboBox;
    WebBrowser: TWebBrowser;
    cdColor: TColorDialog;
    StrGrd_email: TStringGrid;
    Qr_EmailMLG_TIPO: TStringField;
    Qr_EmailMLG_EMAIL: TStringField;
    Qr_EmailMLG_NOME: TStringField;
    Pnl_Progresso: TPanel;
    Gg_Progresso: TGauge;
    Lb_Processamento: TLabel;
    Panel4: TPanel;
    SpeedButton6: TSpeedButton;
    Sb_Busca_Email: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton4: TSpeedButton;
    Panel2: TPanel;
    UpD_PausaTempo: TUpDown;
    E_TempPausa: TEdit;
    Label1: TLabel;
    RE_Status: TRichEdit;
    Label4: TLabel;
    SB_Bl_Add_Tudo: TSpeedButton;
    SB_Bl_Retirar_Tudo: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure Sb_Busca_EmailClick(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure sb_negritoClick(Sender: TObject);
    procedure Sb_ItalicoClick(Sender: TObject);
    procedure Sb_SublinhadoClick(Sender: TObject);
    procedure Sb_CorClick(Sender: TObject);
    procedure Sb_NumListClick(Sender: TObject);
    procedure Sb_btnBulletClick(Sender: TObject);
    procedure btnDecreaseIndentClick(Sender: TObject);
    procedure btnIncreaseIndentClick(Sender: TObject);
    procedure btnAlignLeftClick(Sender: TObject);
    procedure btnCenterClick(Sender: TObject);
    procedure btnAlignRightClick(Sender: TObject);
    procedure btnHRClick(Sender: TObject);
    procedure btnCutClick(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
    procedure btnPasteClick(Sender: TObject);
    procedure Sb_DesfazerClick(Sender: TObject);
    procedure Sb_HiperlinkClick(Sender: TObject);
    procedure Cb_NameFontChange(Sender: TObject);
    procedure Cb_SizeFonteChange(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure StrGrd_emailClick(Sender: TObject);
    procedure StrGrd_emailDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure SpeedButton4Click(Sender: TObject);
    procedure WebBrowserDocumentComplete(ASender: TObject;
      const pDisp: IDispatch; const [Ref] URL: OleVariant);
    procedure SB_Bl_Add_TudoClick(Sender: TObject);
    procedure SB_Bl_Retirar_TudoClick(Sender: TObject);
  private
    function GetIEHandle(WebBrowser: TWebBrowser; ClassName: string): HWND;
  public
    { Public declarations }
      Procedure Pc_FormataTela;
      Procedure Pc_IniciaVariaveis;

      procedure Pc_LimpaStringGrid(Pc_Grid:TStringGrid);
      procedure Pc_PreencheEmail;
      procedure Pc_Buscar_Email;
      Function Fc_Valida_Envio_Email():Boolean;

      function Fc_Gera_Email(NomeContato:String):String;
      procedure Pc_EnviaEmailGrupo;
      procedure Pc_EnviaEmail(email,NomeContato:String);
      Function Fc_Valida_Envio_EmailAtrasado():Boolean;

  end;

var
  Fr_MalaDiretaEMail: TFr_MalaDiretaEMail;
  HTMLDocumento: IHTMLDocument2;

implementation

uses     UN_MSG, UN_Sistema, Un_DM, Un_Fc_Sored_Procedures, Un_envia_email, Un_Regra_Negocio, Un_WebService, env;
{$R *.dfm}

procedure DocumentoEmBranco(WebBrowser: TWebBrowser);
begin
   WebBrowser.Navigate('about:blank');
end;


Procedure TFr_MalaDiretaEMail.Pc_FormataTela;
Var
  I:Integer;
Begin
  //--- Editor HTML
  DocumentoEmBranco(WebBrowser);
  (WebBrowser.Document as IHTMLDocument2).designMode := 'On';
  Cb_NameFont.Items := screen.Fonts;  

  //Formata Grid Clientes
  with StrGrd_email,Qr_email do
  Begin
    ColCount := FieldCount + 3;
    ColWidths[0]:=17;
    ColWidths[1]:=54;
    ColWidths[2]:=-1;
    Cols[1].Add('Selecionar');
    For I:= 0 to FieldCount -1 do
    Begin
      ColWidths[I + 3]:= Fields[I].Tag;
      Cols[I + 3].Add(Fields[I].DisplayLabel);
    end;
  end;
end;

Procedure TFr_MalaDiretaEMail.Pc_IniciaVariaveis;
Var
  Lc_TExto : TStringList;
BEgin
  Pg_email.ActivePageIndex := 1;
  Lc_TExto := TStringList.Create;
  Lc_TExto.Clear;
  Lc_TExto.SaveToFile(GbPathExe + 'Temp\Arquivo.html');
  WebBrowser.Navigate(GbPathExe + 'Temp\Arquivo.html');
  Pg_email.ActivePageIndex := 0;
end;


procedure TFr_MalaDiretaEMail.Pc_LimpaStringGrid(Pc_Grid:TStringGrid);
Begin


end;

procedure TFr_MalaDiretaEMail.Pc_PreencheEmail;
Var
  I, Lc_registro: Integer;
Begin
  with Qr_Email,StrGrd_Email do
  Begin
    First;
    Lc_registro := 0;
    while not Eof do
    Begin
      Lc_registro := Lc_registro + 1;
      RowCount := Lc_registro + 1;
      For I:= 0 to FieldCount -1 do
      Begin
        if (Fields.Fields[I].DataType = ftFloat) OR (Fields.Fields[I].DataType = ftBCD) then
          Cells[I + 3,Lc_registro] := FloatToStrF(Fields[I].AsFloat,ffFixed,10,2)
        else
          Cells[I + 3,Lc_registro] := Fields[I].AsString;
      end;
      Next;
    end;
  Repaint;
  end;
end;

procedure TFr_MalaDiretaEMail.FormShow(Sender: TObject);
begin
  Pc_FormataTela;
  Pc_IniciaVariaveis;
end;



function TFr_MalaDiretaEMail.GetIEHandle(WebBrowser: TWebBrowser;
  ClassName: string): HWND;
var
   hwndChild, hwndTmp: HWND;
   oleCtrl: TOleControl;
   szClass: array[0..255] of char;
begin
   oleCtrl := WebBrowser;
   hwndTmp := oleCtrl.Handle;
   while (true) do
   begin
      hwndChild := GetWindow(hwndTmp, GW_CHILD);
      GetClassName(hwndChild, szClass, SizeOf(szClass));
      if (string(szClass) = ClassName) then
      begin
         Result := hwndChild;
         Exit;
      end;
      hwndTmp := hwndChild;
   end;
   Result := 0;


end;

procedure TFr_MalaDiretaEMail.Pc_Buscar_Email;
Begin
  with Qr_Email do
  Begin
    Active := False;
    Active := True;
    FetchAll;
    SB_Bl_Add_Tudo.Enabled:= (RecordCount > 0);
    SB_Bl_Retirar_Tudo.Enabled:= (RecordCount > 0);
  end;
end;


procedure TFr_MalaDiretaEMail.Sb_Busca_EmailClick(Sender: TObject);
begin
  Pc_Buscar_Email;
  Pc_PreencheEmail;
end;

Function TFr_MalaDiretaEMail.Fc_Valida_Envio_Email():Boolean;
BEgin
  REsult := True;


end;

Function TFr_MalaDiretaEMail.Fc_Valida_Envio_EmailAtrasado():Boolean;
BEgin
  REsult := True;
end;

function TFr_MalaDiretaEMail.Fc_Gera_Email(NomeContato:String):String;
Var
  e: IHTMLElement;
begin
  Result := '';
  if Assigned(WebBrowser.Document) then
  begin
     e := (WebBrowser.Document as IHTMLDocument2).body;

     while e.parentElement <> nil do
     begin
       e := e.parentElement;
     end;

     Result := e.outerHTML;
    //Destinatario
    Result :=  StringReplace(Result, '$Destinatario', Trim(NomeContato), [rfreplaceAll]);
  end;
end;


procedure TFr_MalaDiretaEMail.Pc_EnviaEmailGrupo;
var
  Lc_Destinatario : TStringList;
  Lc_Anexo : TStringList;
  Lc_AssuntoEmail : string;
  I : Integer;
  Pausa : Integer;
  Lc_Form : TFr_envia_email;
begin
  //Barra de Progress
  Gg_Progresso.MinValue := 0;
  Gg_Progresso.MAxValue := StrGrd_email.RowCount - 1;
  Gg_Progresso.Progress := 0;
  Pnl_Progresso.visible := True;
  Application.ProcessMessages;

  Lc_Anexo := TStringList.Create;
  Lc_Anexo.Add('Sem anexo');

  Lc_Destinatario := TStringList.Create;
  Lc_Form := TFr_envia_email.Create(nil);
  Lc_Form.It_Tipo_Envio := 'S';
  Lc_Form.It_Assunto := E_Assunto.Text;
  Lc_Form.Pc_Define_RemententeAtivo;
  Lc_Form.It_Anexo   := Lc_Anexo;

  I := 1;
  For I := 1 to (StrGrd_email.RowCount - 1) do
  Begin
    if ( StrGrd_email.Cells[2,I]= 'X' ) then
    Begin
      Lc_Form.it_Cancela := False;
      RE_Status.Clear;
      Lb_Processamento.Caption := 'Processando: ' + StrGrd_email.Cells[4,I];
      Gg_Progresso.Progress := Gg_Progresso.Progress + 1;
      Application.ProcessMessages;
      Lc_Destinatario.Clear;
      Lc_Destinatario.Add(' ' + StrGrd_email.Cells[4,I] );
      //Lc_Destinatario.Add(' valdo@setes.com.br' );
      Lc_Form.It_Destino := Lc_Destinatario;
      Lc_Form.It_Corpo   := Fc_Gera_Email(StrGrd_email.Cells[5,I]);
      Lc_Form.Fc_EnviaEmail;
      while not Lc_Form.it_Cancela do
      Begin
        RE_Status.Text := Lc_Form.RE_Status.Text;
        Application.ProcessMessages;
        Sleep(100);
      End;
      Application.ProcessMessages;
      Pausa := StrtoIntDef(E_TempPausa.Text,5);
      Pausa := Pausa * 1000;//segundos
      Sleep(Pausa);
    End;
  End;

  Pnl_Progresso.Visible := False;
  Application.ProcessMessages;
  Lc_Form.Close;
  FreeAndNil(Lc_Form);
end;


procedure TFr_MalaDiretaEMail.Pc_EnviaEmail(email,NomeContato:String);
var
  Lc_Destinatario : TStringList;
  Lc_Anexo : TStringList;
  Lc_AssuntoEmail : string;
  LcEnviaemail : TFr_envia_email;
begin
  Try
    Lc_Destinatario := TStringList.Create;
    Lc_Destinatario.Add(' ' + email);
    //Lc_Destinatario.Add(' valdo@setes.com.br');

    Lc_Anexo := TStringList.Create;
    Lc_Anexo.Add('Sem anexo');
    Lc_AssuntoEmail :=  E_Assunto.Text;
    LcEnviaemail := TFr_envia_email.create(nil);
    with LcEnviaemail do
    begin
      It_Tipo_Envio := 'S';
      It_Assunto := Lc_AssuntoEmail;
      It_Anexo   := Lc_Anexo;
      It_Destino := Lc_Destinatario;
      It_Corpo   := '';
      It_Corpo   := Fc_Gera_Email(NomeContato);
      ShowModal;
    end;
  Finally
    FreeAndNil(LcEnviaemail);
  End;
end;


procedure TFr_MalaDiretaEMail.SpeedButton8Click(Sender: TObject);
begin
  try
    Pc_ProcesoAguarde(Self,'I');
    Application.ProcessMessages;
    Self.Enabled := False;
    if Fc_Valida_Envio_Email then
    Begin
      Pc_EnviaEmailGrupo;
    end;
  finally
    Pc_ProcesoAguarde(Self,'F');
    Self.Enabled := True;
  end;

end;

procedure TFr_MalaDiretaEMail.StrGrd_emailClick(Sender: TObject);
begin
  with StrGrd_email do
  Begin
    IF Cells[2,Row]= 'X' then
      Cells[2,Row] := ''
    else
      Cells[2,Row] := 'X';
    Repaint;
  end;
end;

procedure TFr_MalaDiretaEMail.StrGrd_emailDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
Var
  LarguraTexto, AlturaTexto, X, Y: integer;
  Texto: string;
begin
  with Qr_Email, StrGrd_Email do
  Begin
    if (ACol = 1)and(ARow>0) Then
    begin
      if (Cells[3,ARow] <> '') then
      Begin
      if (Cells[2,ARow] = 'X') then
        DrawFrameControl(Canvas.Handle, Rect,DFC_BUTTON, DFCS_BUTTONCHECK or DFCS_CHECKED) // Desenha o CheckBox desmarcado
      else
        DrawFrameControl(Canvas.Handle, Rect,   DFC_BUTTON, DFCS_BUTTONCHECK); // Desenha o CheckBox marcado
      end;
    end
    else
    Begin
      If (arow > 0) and (acol >0) then // testa se não � a primeira linha (fixa)
      Begin
        if (Cells[2,ARow] = '') then
        Begin
          Canvas.Font.Color:= clBlack;
          Canvas.Brush.Color:= clCream;
        end
        else
        Begin
          Canvas.Font.Color:= clBlack;
          Canvas.Brush.Color:= clMoneyGreen;
        end;
        Canvas.FillRect(Rect); // redesenha a celula
        Canvas.TextOut(Rect.Left+2,Rect.Top,Cells[acol,arow]); // reimprime o texto.
        // Pega o texto da c�lula
        Texto := Cells[acol, ARow];
        //{ Calcura largura e altura (em pontos) do texto
        LarguraTexto := Canvas.TextWidth(Texto);
        AlturaTexto := Canvas.TextHeight(Texto);
        // Calcula a posição horizontal do in�cio do texto
        if (Acol > 2) then
        Begin
          if (Fields[ACol-3].Alignment = taLeftJustify) then   // esquerda
            X := Rect.Left + 2
          else
          if (Fields[ACol-3].Alignment = taCenter) then // Centro
            X := Rect.Left + (Rect.Right - Rect.Left) div 2 - LarguraTexto div 2
          else // Direita
            X := Rect.Right - LarguraTexto - 2;
        end;
        // Calcula a posição vertical do in�cio do texto para que seja impresso no centro (verticalmente) da c�lula
        Y := Rect.Top + (Rect.Bottom - Rect.Top) div 2 - AlturaTexto div 2;
        Canvas.TextRect(Rect, X, Y, Texto);
      end;
    end;
  end;

end;

procedure TFr_MalaDiretaEMail.WebBrowserDocumentComplete(ASender: TObject;
  const pDisp: IDispatch; const [Ref] URL: OleVariant);
begin
  ((aSender as TWebBrowser).Document as IHTMLDocument2).designMode := 'on';
end;

procedure TFr_MalaDiretaEMail.SpeedButton4Click(Sender: TObject);
begin
  with StrGrd_email do
  Begin
    Pc_EnviaEmail(Cells[4,StrGrd_email.Row],Cells[5,StrGrd_email.Row]);
  End;
end;

procedure TFr_MalaDiretaEMail.SpeedButton6Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_MalaDiretaEMail.sb_negritoClick(Sender: TObject);
begin
  HTMLDocumento := WebBrowser.Document as IHTMLDocument2;
  HTMLDocumento.execCommand('Bold', False, 0);
end;

procedure TFr_MalaDiretaEMail.Sb_ItalicoClick(Sender: TObject);
begin
  HTMLDocumento := WebBrowser.Document as IHTMLDocument2;
  HTMLDocumento.execCommand('Italic', False, 0);
end;

procedure TFr_MalaDiretaEMail.Sb_SublinhadoClick(Sender: TObject);
begin
  HTMLDocumento := WebBrowser.Document as IHTMLDocument2;
  HTMLDocumento.execCommand('Underline', False, 0);
end;

procedure TFr_MalaDiretaEMail.Sb_CorClick(Sender: TObject);
begin
   HTMLDocumento := WebBrowser.Document as IHTMLDocument2;
   if cdColor.Execute then
      HTMLDocumento.execCommand('ForeColor', False, cdColor.Color)
   else
      abort;
end;

procedure TFr_MalaDiretaEMail.Sb_NumListClick(Sender: TObject);
begin
   SendMessage(GetIEHandle(WebBrowser, 'Internet Explorer_Server'),
      WM_COMMAND, IDM_MARCADOR, 0);
end;

procedure TFr_MalaDiretaEMail.SB_Bl_Add_TudoClick(Sender: TObject);
Var
  Lc_I : Integer;
begin
  with StrGrd_email do
  Begin
    For LC_I := 1 to RowCount -1 do
      Begin
      Cells[2,Lc_I] := 'X';
      end;
    Repaint;
  end;
end;

procedure TFr_MalaDiretaEMail.SB_Bl_Retirar_TudoClick(Sender: TObject);
Var
  Lc_I : Integer;
begin
  with StrGrd_email do
  Begin
    For LC_I := 1 to RowCount -1 do
      Begin
      Cells[2,Lc_I] := '';
      end;
    Repaint;
  end;
end;

procedure TFr_MalaDiretaEMail.Sb_btnBulletClick(Sender: TObject);
begin
   SendMessage(GetIEHandle(WebBrowser, 'Internet Explorer_Server'),
      WM_COMMAND, IDM_MARCADOR_LISTA, 0);
end;

procedure TFr_MalaDiretaEMail.btnDecreaseIndentClick(Sender: TObject);
begin
   SendMessage(GetIEHandle(WebBrowser, 'Internet Explorer_Server'),
      WM_COMMAND, IDM_OUTDENT, 0);
end;

procedure TFr_MalaDiretaEMail.btnIncreaseIndentClick(Sender: TObject);
begin
   SendMessage(GetIEHandle(WebBrowser, 'Internet Explorer_Server'),
      WM_COMMAND, IDM_INDENT, 0);
end;

procedure TFr_MalaDiretaEMail.btnAlignLeftClick(Sender: TObject);
begin
   SendMessage(GetIEHandle(WebBrowser, 'Internet Explorer_Server'),
      WM_COMMAND, IDM_ALINHARESQ, 0);
end;

procedure TFr_MalaDiretaEMail.btnCenterClick(Sender: TObject);
begin
   SendMessage(GetIEHandle(WebBrowser, 'Internet Explorer_Server'),
      WM_COMMAND, IDM_CENTRALIZAR, 0);
end;

procedure TFr_MalaDiretaEMail.btnAlignRightClick(Sender: TObject);
begin
   SendMessage(GetIEHandle(WebBrowser, 'Internet Explorer_Server'),
      WM_COMMAND, IDM_ALINHADIR, 0);
end;

procedure TFr_MalaDiretaEMail.btnHRClick(Sender: TObject);
begin
   SendMessage(GetIEHandle(WebBrowser, 'Internet Explorer_Server'),
      WM_COMMAND, IDM_LINHAHORIZ, 0);
end;

procedure TFr_MalaDiretaEMail.btnCutClick(Sender: TObject);
begin
   SendMessage(GetIEHandle(WebBrowser, 'Internet Explorer_Server'),
      WM_COMMAND, IDM_RECORTAR, 0);
end;

procedure TFr_MalaDiretaEMail.btnCopyClick(Sender: TObject);
begin
   SendMessage(GetIEHandle(WebBrowser, 'Internet Explorer_Server'),
      WM_COMMAND, IDM_COPIAR, 0);
end;

procedure TFr_MalaDiretaEMail.btnPasteClick(Sender: TObject);
begin
   SendMessage(GetIEHandle(WebBrowser, 'Internet Explorer_Server'),
      WM_COMMAND, IDM_COLAR, 0);
end;

procedure TFr_MalaDiretaEMail.Sb_DesfazerClick(Sender: TObject);
begin
   SendMessage(GetIEHandle(WebBrowser, 'Internet Explorer_Server'),
      WM_COMMAND, IDM_DESFAZER, 0);
end;

procedure TFr_MalaDiretaEMail.Sb_HiperlinkClick(Sender: TObject);
begin
   SendMessage(GetIEHandle(WebBrowser, 'Internet Explorer_Server'),
      WM_COMMAND, IDM_HYPERLINK, 0);
end;

procedure TFr_MalaDiretaEMail.Cb_NameFontChange(Sender: TObject);
begin
   HTMLDocumento := WebBrowser.Document as IHTMLDocument2;
   HTMLDocumento.execCommand('FontName', False, Cb_NameFont.Text);
end;

procedure TFr_MalaDiretaEMail.Cb_SizeFonteChange(Sender: TObject);
begin
   HTMLDocumento := WebBrowser.Document as IHTMLDocument2;
   case Cb_SizeFonte.ItemIndex of
      0: HTMLDocumento.execCommand('FontSize', False, 1);
      1: HTMLDocumento.execCommand('FontSize', False, 2);
      2: HTMLDocumento.execCommand('FontSize', False, 3);
      3: HTMLDocumento.execCommand('FontSize', False, 5);
      4: HTMLDocumento.execCommand('FontSize', False, 6);
      5: HTMLDocumento.execCommand('FontSize', False, 7);
   end;
end;

end.
