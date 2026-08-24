unit tblIbscbsCredpresIbszfm;

interface

Uses     GenericEntity, CAtribEntity;

Type
  [TableName('TB_IBSCBS_CREDPRES_IBSZFM')]
  TIbscbsCredpresIbszfm = class(TGenericEntity)
  private
    FVcredpresibszfm: Double;
    FIbscbsId: Integer;
    FTcpbensconsumofinal: String;
    procedure setFIbscbsId(const Value: Integer);
    procedure setFTcpbensconsumofinal(const Value: String);
    procedure setFVcredpresibszfm(const Value: Double);

  public
    [KeyField('TB_IBSCBS_ID')]
    [FieldName('TB_IBSCBS_ID')]
    property IbscbsId: Integer read FIbscbsId write setFIbscbsId;

    [FieldName('TCPBENSCONSUMOFINAL')]
    property Tcpbensconsumofinal: String read FTcpbensconsumofinal write setFTcpbensconsumofinal;

    [FieldName('VCREDPRESIBSZFM')]
    property Vcredpresibszfm: Double read FVcredpresibszfm write setFVcredpresibszfm;
  end;

implementation


{ TIbscbsCredpresIbszfm }

procedure TIbscbsCredpresIbszfm.setFIbscbsId(const Value: Integer);
begin
  FIbscbsId := Value;
end;

procedure TIbscbsCredpresIbszfm.setFTcpbensconsumofinal(const Value: String);
begin
  FTcpbensconsumofinal := Value;
end;

procedure TIbscbsCredpresIbszfm.setFVcredpresibszfm(const Value: Double);
begin
  FVcredpresibszfm := Value;
end;

end.
