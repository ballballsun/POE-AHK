Loop, %0%  
  {
    param := %A_Index%  
    params .= A_Space . param
  }
ShellExecute := A_IsUnicode ? "shell32\ShellExecute":"shell32\ShellExecuteA"
 
if not A_IsAdmin
{
    If A_IsCompiled
       DllCall(ShellExecute, uint, 0, str, "RunAs", str, A_ScriptFullPath, str, params , str, A_WorkingDir, int, 1)
    Else
       DllCall(ShellExecute, uint, 0, str, "RunAs", str, A_AhkPath, str, """" . A_ScriptFullPath . """" . A_Space . params, str, A_WorkingDir, int, 1)
    ExitApp
}


t::
IfWinnotActive,Path of Exile
{
  MsgBox,請確認視窗已聚焦在POE上!
  return
}
TrayTip AHK, "觸發"
ToolTip, AHK,940,400

Send, {t}
Random, rand, 30, 100
Sleep, %rand%
Send, {r}
Return

RemoveToolTip:
ToolTip
return