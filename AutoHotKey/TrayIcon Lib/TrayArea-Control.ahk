#Include <TrayIcon-Lib.ahk>

;TrayIcon_GetTrayBar("Shell_TrayWnd") ; Shell_TrayWnd | NotifyIconOverflowWindow |

;TrayIcon_Button("shareX.exe", "L")
;TrayIcon_Button("shareX.exe", "M")
;TrayIcon_Button("shareX.exe", "R")

TI_Info := TrayIcon_GetInfo()

Gui, Add, ListView, w800 h500 Grid -Multi, Index|Process|HwND|PID|IDcmd|Name|Tray Location|
Gui, Color, 708090 ; Slate Gray
Loop, % TI_Info.MaxIndex() {

    LV_Add("", TI_Info[A_Index].idx, TI_Info[A_Index].process, TI_Info[A_Index].pid, TI_Info[A_Index].hwnd, TI_Info[A_Index].idcmd, TI_Info[A_Index].tooltip, TI_Info[A_Index].tray)
    LV_ModifyCol() ; Auto-size columns to fit content
    Gui, Show
}
