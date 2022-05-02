/*
AutoHotkey Version:     1.1.33.09
Platform:               Win10 19042
Author:                 JRW254
Script Version:         1.0
Script Function:    Hide and Show windows on the fly
*/

#Persistent
#SingleInstance force
SetTitleMatchMode, 2

; https://www.autohotkey.com/boards/viewtopic.php?t=30769
^.::
target_window := [""] ; place names of windows seperated by comma
;target_window := ["Brave"]
xp=0
    for k, v in target_window {
        If WinExist(target_window[k]) {
        WinActivate, % target_window[k]
            xp+=1
        }
    }
     if(xp=0) {
        MsgBox No Windows Within Range
    }
        return

^,::
target_window := [""] ; place names of windows seperated by comma
xp=0
    for k, v in target_window {
        If WinExist(target_window[k]) {
            WinMinimize, % target_window[k]
            xp-=1
        }
    }
    if(xp=0) {
        MsgBox They All Fall Down
    }
    return
