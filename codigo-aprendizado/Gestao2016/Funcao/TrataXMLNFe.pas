unit TrataXMLNFe;

interface

uses       System.SysUtils, System.Classes, Xml.XMLDoc, Xml.XMLIntf, System.Variants, System.AnsiStrings;

function LocalName(const NodeName: string): string;
function FindNodeRecursive(Node: IXMLNode; const ALocalName: string): IXMLNode;
function FindNodeInDocument(Doc: IXMLDocument; const ALocalName: string): IXMLNode;
function FindFirstByLocalName(Parent: IXMLNode; const ALocal: string): IXMLNode;
function EnsureAttrOnOpenTag(const Xml, TagName, AttrName, AttrValue: string): string;
function EnsureXmlnsOnNFeXml(const NFeXml: string): string;
function EnsureVersaoOnProtXml(const ProtXml: string): string;

procedure SaveAsNfeProcExact(const InFile, OutFile: string);


implementation

const
  NS_NFE  = 'http://www.portalfiscal.inf.br/nfe';
  VERSAO  = '4.00';

function LocalName(const NodeName: string): string;
var
  p: Integer;
begin
  p := LastDelimiter(':', NodeName);
  if p > 0 then
    Result := Copy(NodeName, p + 1, MaxInt)
  else
    Result := NodeName;
end;

function FindNodeRecursive(Node: IXMLNode; const ALocalName: string): IXMLNode;
var
  i: Integer;
begin
  Result := nil;
  if not Assigned(Node) then Exit;

  // compara o nome local do n�
  if SameText(LocalName(Node.NodeName), ALocalName) then
    Exit(Node);

  // percorre os filhos recursivamente
  for i := 0 to Node.ChildNodes.Count - 1 do
  begin
    Result := FindNodeRecursive(Node.ChildNodes[i], ALocalName);
    if Assigned(Result) then
      Exit;
  end;
end;

function FindNodeInDocument(Doc: IXMLDocument; const ALocalName: string): IXMLNode;
begin
  Result := nil;
  if not Assigned(Doc) or not Assigned(Doc.DocumentElement) then Exit;
  Result := FindNodeRecursive(Doc.DocumentElement, ALocalName);
end;


function FindFirstByLocalName(Parent: IXMLNode; const ALocal: string): IXMLNode;
var
  i: Integer;
begin
  Result := nil;
  if Parent = nil then Exit;
  for i := 0 to Parent.ChildNodes.Count - 1 do
  begin
    if SameText(LocalName(Parent.ChildNodes[i].NodeName), ALocal) then
      Exit(Parent.ChildNodes[i]);
  end;
end;

function EnsureAttrOnOpenTag(const Xml, TagName, AttrName, AttrValue: string): string;
var
  openTag, s: string;
  p1, p2: Integer;
begin
  // injeta atributo se ainda não existir no elemento de abertura
  Result := Xml;
  openTag := '<' + TagName;
  p1 := Pos(openTag, Xml);
  if p1 = 0 then Exit;

  // já tem o atributo?
  s := Copy(Xml, p1, 512); // janela suficiente pro come�o da tag
  if Pos(AttrName + '=', s) > 0 then Exit;

  // inserir antes do '>' ou '/>'
  p2 := p1 + Length(openTag);
  // pula poss�veis espa�os já existentes
  while (p2 <= Length(Xml)) and (Xml[p2] in [' ', #9, #10, #13]) do Inc(p2);
  // achamos o '>' correspondente
  // solução simples: inserir antes do primeiro '>'
  p2 := PosEx('>', Xml, p1);
  if p2 = 0 then Exit;

  Result := Copy(Xml, 1, p2-1)
         + Format(' %s="%s"', [AttrName, AttrValue])
         + Copy(Xml, p2, MaxInt);
end;

function EnsureXmlnsOnNFeXml(const NFeXml: string): string;
begin
  // garante xmlns no elemento <NFe>
  Result := EnsureAttrOnOpenTag(NFeXml, 'NFe', 'xmlns', NS_NFE);
end;

function EnsureVersaoOnProtXml(const ProtXml: string): string;
begin
  // garante versao no elemento <protNFe>
  Result := EnsureAttrOnOpenTag(ProtXml, 'protNFe', 'versao', VERSAO);
end;

procedure SaveAsNfeProcExact(const InFile, OutFile: string);
var
  Doc: IXMLDocument;
  Root, NFeNode, ProtNode: IXMLNode;
  SL: TStringList;
  NFeXml, ProtXml: string;
begin
  Doc := TXMLDocument.Create(nil);
  Doc.LoadFromFile(InFile);
  Doc.Active := True;

  NFeNode  := FindNodeInDocument(Doc, 'NFe');
  ProtNode := FindNodeInDocument(Doc, 'protNFe');

  if not Assigned(NFeNode) then
    raise Exception.Create('Tag <NFe> não encontrada.');
  if not Assigned(ProtNode) then
    raise Exception.Create('Tag <protNFe> não encontrada.');

  // Serializa os conte�dos e normaliza os atributos exigidos
  NFeXml  := EnsureXmlnsOnNFeXml(NFeNode.XML);
  ProtXml := EnsureVersaoOnProtXml(ProtNode.XML);

  //Delete de file to create another one
  if FileExists(InFile) then
    DeleteFile(InFile);

  SL := TStringList.Create;
  try
    SL.Add('<?xml version="1.0" encoding="utf-8"?>');
    SL.Add(Format('<nfeProc xmlns="%s" versao="%s">', [NS_NFE, VERSAO]));
    SL.Add(NFeXml);
    SL.Add(ProtXml);
    SL.Add('</nfeProc>');
    SL.SaveToFile(OutFile, TEncoding.UTF8);
  finally
    SL.Free;
  end;
end;

// Exemplo de uso:
// SaveAsNfeProcExact('C:\xml\entrada.xml', 'C:\xml\saida_nfeProc.xml');



end.
