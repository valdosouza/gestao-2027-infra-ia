// Compiler switches:
//              Debug Info      Optimisation
// DEBUG            On              Off
// RELEASE          Off             On
{$IFDEF DBG}
    {$D+}
    {$O-}
{$ELSE}
    {$D-}
    {$O+}
{$ENDIF}