/*
AutoHotkey Version:     1.1.33.09
Platform:               Win10 19042
Author:                 JRW254
Script Version:         1.0
Script Function:    Check WinNT for Group and see who is and is not an admin. 
*/

#Persistent
#SingleInstance force


; https://www.autohotkey.com/boards/viewtopic.php?f=76&t=4524&start=20
objGroup := ComObjGet("WinNT://./Administrators")
    for objUser in objGroup.Members
;
if (objUser.Name = !A_UserName) {
    MsgBox % objUser.Name " is NOT a local admin" 
;
}
else if (objUser.Name = A_UserName) {
    MsgBox % objUser.Name " is a local admin" 
}
