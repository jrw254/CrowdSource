/*
    Random Functions Stored Here
    
*/

; =========================================================================================================================
; =========================================================================================================================
; =========================================================================================================================

/*
    Date:                   June-1-2022
    AutoHotkey Version:     1.1.34.00
    Platform:               Win10 1904
    Author:                 JRW254
    Function Version:       1.0
    Function Description:   Center then move back windows.
    Examples:
        F1::CenterWindow("File Explorer", 0) ; No Move Back
        F2::CenterWindow("File Explorer", 1) ; Move Back
        F3::CenterWindow("New Tab - Brave", 0) ; No Move Back
        F4::CenterWindow("New Tab - Brave", 1) ; Move Back
*/

CenterWindow(TitleOf, MB) {
    If (MB = 0) 
    {
     WinGetPos, X, Y, Width, Height, % TitleOf
        IniWrite, %TitleOf%, centerwindows.ini, Coords, WinTitle
        IniWrite, %X%, centerwindows.ini, Coords, X_Var
        IniWrite, %Y%, centerwindows.ini, Coords, Y_Var
        IniWrite, %Width%, centerwindows.ini, Coords, Width_Var
        IniWrite, %Height%, centerwindows.ini, Coords, Height_Var
    WinMove, % TitleOf,, (A_ScreenWidth/2)-(Width/2), (A_ScreenHeight/2)-(Height/2) ; center window
        WinActivate, % TitleOf
    } 
    else if (MB = 1) 
    {
    IniRead, Xpar, centerwindows.ini, Coords, X_Var 
    IniRead, Ypar, centerwindows.ini, Coords, Y_Var
    IniRead, Wpar, centerwindows.ini, Coords, Width_Var
    IniRead, Hpar, centerwindows.ini, Coords, Height_Var
        WinMove, % TitleOf,, Xpar, Ypar, Wpar, Hpar ; Moves it back
    }
 Return
 }
 
; =========================================================================================================================
; =========================================================================================================================
; =========================================================================================================================

/*
    Date:                   June-5-2022
    AutoHotkey Version:     1.1.34.00
    Platform:               Win10 19044
    Author:                 JRW254
    Function Version:       1.0
    Function Description:   Snap to the four quads on a mobile device.
    Examples:
        F1:: mobile_snap("File Explorer", -1042, 0, 528, 373, "TLC")
        F2:: mobile_snap("File Explorer", -520, 0, 528, 373, "TRC")
        F3:: mobile_snap("File Explorer", -1032, 365, 528, 373, "BLC")
        F4:: mobile_snap("File Explorer", -520, 365, 528, 373, "BRC")
*/

mobile_snap(Window, X, Y, W, H, Opt) { 
    WinGetTitle, Title, % Window
    Switch Opt
    {
        case "TLC": WinMove, % Title,, X, Y, W, H
        case "TRC": WinMove, % Title,, X, Y, W, H
        case "BLC": WinMove, % Title,, X, Y, W, H
        case "BRC": WinMove, % Title,, X, Y, W, H
    }
Return
}

; =========================================================================================================================
; =========================================================================================================================
; =========================================================================================================================
    
