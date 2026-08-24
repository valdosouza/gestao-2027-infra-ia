unit Un_IsAdministrator;

interface

function IsAdmin: Boolean;

implementation

uses
      Windows;

const
  SECURITY_NT_AUTHORITY: TSIDIdentifierAuthority = (Value: (0, 0, 0, 0, 0, 5));
  SECURITY_BUILTIN_DOMAIN_RID = $00000020;
  DOMAIN_ALIAS_RID_ADMINS = $00000220;

type
  TOpenThreadToken = function (ThreadHandle: THandle; DesiredAccess: DWORD; OpenAsSelf: BOOL; var TokenHandle: THandle): BOOL; stdcall;
  TGetTokenInformation = function (TokenHandle: THandle; TokenInformationClass: TTokenInformationClass; TokenInformation: Pointer; TokenInformationLength: DWORD; var ReturnLength: DWORD): BOOL; stdcall;
  TOpenProcessToken = function (ProcessHandle: THandle; DesiredAccess: DWORD; var TokenHandle: THandle): BOOL; stdcall;
  TEqualSid = function (pSid1, pSid2: Pointer): BOOL; stdcall;
  TAllocateAndInitializeSid = function (const pIdentifierAuthority: TSIDIdentifierAuthority; nSubAuthorityCount: Byte; nSubAuthority0, nSubAuthority1: DWORD; nSubAuthority2, nSubAuthority3, nSubAuthority4: DWORD; nSubAuthority5, nSubAuthority6, nSubAuthority7: DWORD; var pSid: Pointer): BOOL; stdcall;
  TFreeSid = function (pSid: Pointer): Pointer; stdcall;

function IsAdmin: boolean;
var
  iAccessToken: THandle;
  ptgGroups: PTokenGroups;
  dwInfoBufferSize: DWORD;
  psidAdministrators: PSID;
  iCount: integer;
  fSuccess: BOOL;
  pOpenThreadToken: TOpenThreadToken;
  pOpenProcessToken: TOpenProcessToken;
  pGetTokenInformation: TGetTokenInformation;
  pEqualSid: TEqualSid;
  pAllocateAndInitializeSid: TAllocateAndInitializeSid;
  pFreeSid: TFreeSid;
  iDll: integer;
begin
  Result := false;
  iDll := LoadLibrary(advapi32);
  if iDll = 0 then
    exit;
  try
    pOpenThreadToken := GetProcAddress(iDll, 'OpenThreadToken');
    pOpenProcessToken := GetProcAddress(iDll, 'OpenProcessToken');
    pGetTokenInformation := GetProcAddress(iDll, 'GetTokenInformation');
    pEqualSid := GetProcAddress(iDll, 'EqualSid');
    pAllocateAndInitializeSid := GetProcAddress(iDll, 'AllocateAndInitializeSid');
    pFreeSid := GetProcAddress(iDll, 'FreeSid');
    if not Assigned(pOpenThreadToken) or not Assigned(pOpenProcessToken) or not Assigned(pGetTokenInformation) or not Assigned(pEqualSid) or not Assigned(pFreeSid) or not Assigned(pAllocateAndInitializeSid) then
      exit;
    fSuccess := pOpenThreadToken(GetCurrentThread, TOKEN_QUERY, true, iAccessToken);
    if not fSuccess then
    begin
      if GetLastError = ERROR_NO_TOKEN then
        fSuccess := pOpenProcessToken(GetCurrentProcess, TOKEN_QUERY, iAccessToken);
    end;
    if fSuccess then
    begin
      GetMem(ptgGroups, 1024);
      try
        fSuccess := pGetTokenInformation(iAccessToken, TokenGroups, ptgGroups, 1024, dwInfoBufferSize);
        CloseHandle(iAccessToken);
        if fSuccess then
        begin
          pAllocateAndInitializeSid(SECURITY_NT_AUTHORITY, 2, SECURITY_BUILTIN_DOMAIN_RID, DOMAIN_ALIAS_RID_ADMINS, 0, 0, 0, 0, 0, 0, psidAdministrators);
          try
            for iCount := 0 to ptgGroups.GroupCount - 1 do
              if pEqualSid(psidAdministrators, ptgGroups.Groups[iCount].Sid) then
              begin
                Result := true;
                break;
              end;
          finally
            pFreeSid(psidAdministrators);
          end;
        end;
      finally
        FreeMem(ptgGroups);
      end;
    end;
  finally
    FreeLibrary(iDll);
  end;
end;

end.
