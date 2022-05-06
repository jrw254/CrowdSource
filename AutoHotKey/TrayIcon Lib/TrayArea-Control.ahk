#Include <TrayIcon-Lib.ahk>
#Include <LV_Color_Lib.ahk>

;TrayIcon_GetTrayBar("Shell_TrayWnd") ; Shell_TrayWnd | NotifyIconOverflowWindow |

;TrayIcon_Button("shareX.exe", "L")
;TrayIcon_Button("shareX.exe", "M")
;TrayIcon_Button("shareX.exe", "R")

TI_Info := TrayIcon_GetInfo()

Gui, Add, ListView, w800 h500 Grid -Multi, Index|Process|HwND|PID|IDcmd|Name|Tray Location|
Gui, Color, 708090 ; Slate Gray

Gui, Add, DropDownList, vChoice gOnSelect, Log Results|Error|Clear
Gui, Font, s10
Gui, Add, Text, x+20 , Choose one of three options. 1: Log Results of Listview. 2: Red Error Highlighter. 3: Clear Results of log.

Loop, % TI_Info.MaxIndex() {

    LV_Add("", TI_Info[A_Index].idx, TI_Info[A_Index].process, TI_Info[A_Index].pid, TI_Info[A_Index].hwnd, TI_Info[A_Index].idcmd, TI_Info[A_Index].tooltip, TI_Info[A_Index].tray)
    LV_ModifyCol() ; Auto-size columns to fit content
    Gui, Show
}

OnSelect:

Gui, Submit, nohide
If (Choice = "Error") {
; Create a new instance of LV_Colors
CLV := New LV_Colors(TILV) ; TILV is the Hwnd
; Set the colors for selected rows
CLV.SelectionColors(0xff0000,0xffffff) ; when clicked changes Red with White Text    AlternateCols
}

else if (Choice = "Clear") {
       LV_Delete()
}

else if (Choice = "Log Results") {
        FormatTime timestamp, A_Now, dddd dd MMM yyyy @ hh:mm:ss tt ; Timestamp
        FileAppend, TimeStamp for set: %timestamp%`n`r, %A_ScriptDir%\TILIB.log
Loop, % test.MaxIndex() {
        LV_GetText(lDex,A_Index,1) ; Get's the Index of everything
        LV_GetText(lName,A_Index,6) ; Get's the Name of everything
        LV_GetText(lLocation,A_Index,7) ; Get's the Location of everything
        FileAppend, %lDex%. %lName% Located within: %lLocation%`n`r, %A_ScriptDir%\TILIB.log
}
 Run, %A_ScriptDir%\TILIB.log
}

Esc:: ExitApp
