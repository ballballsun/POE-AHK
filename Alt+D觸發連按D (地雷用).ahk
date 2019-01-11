global _msgStop := "手動中止腳本"


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

;#####################################################################################
;#####################################################################################
; Alt+D
;
;#####################################################################################
; 設定觸發熱鍵alt+d (https://autohotkey.com/docs/Hotkeys.htm)
!d::
IfWinnotActive,Path of Exile
{
  MsgBox,請確認視窗已聚焦在POE上!
  return
}
TrayTip AHK, "地雷腳本啟動"
ToolTip, AHK,940,400
loop
{
  ; 長按F12結束
  if GetKeyState("F12", "P") 
  {
    ;MsgBox, %_msgStop%
    TrayTip AHK, %_msgStop%
    SetTimer, RemoveToolTip, -5000
    break
  }
  Send {d}
  ; 相隔200-500毫秒再按
  Random, rand, 200, 500
  Sleep, %rand%
}

RemoveToolTip:
ToolTip
return