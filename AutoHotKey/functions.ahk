/*
    Random Functions Stored Here
    
*/

; =========================================================================================================================
; =========================================================================================================================
; =========================================================================================================================

/*
    Date:                   June-1-2022
    AutoHotkey Version:     1.1.34.00
    Platform:               Win10 19042
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
    WinMove, % TitleOf,, (A_ScreenWidth/2)-(Width/2), (A_ScreenHeight/2)-(Height/2) ; center window
        WinActivate, % TitleOf
    } 
    else if (MB = 1) 
    {
    IniRead, Xpar, centerwindows.ini, Coords, X_Var 
    IniRead, Ypar, centerwindows.ini, Coords, Y_Var
        WinMove, % TitleOf,, Xpar, Ypar ; Moves it back
    }
 Return
    }
