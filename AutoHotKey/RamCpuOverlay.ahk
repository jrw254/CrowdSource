SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Persistent
#SingleInstance, force

Gui overlay:new, -Caption +LastFound +ToolWindow +AlwaysOnTop
Gui color, 3355FF ;FFFFFF

Gui add, text, BackgroundTrans, CPU
Gui add, text, yp xp+30 vvCPU w50 BackgroundTrans, --`%

Gui add, text, x+1 ym BackgroundTrans, RAM
Gui add, text, yp xp+30 vvRAM w50 BackgroundTrans, --`%
WinSet, Transparent, 190

SetTimer, Refresh, 850
Gui, show, x1215 y740 ; <----- change position of overlay here 
OnMessage(0x201, "WM_LBUTTONDOWN")
return

WM_LBUTTONDOWN() {
	PostMessage, 0xA1, 2
}

CPULoad() {
	Static PIT, PKT, PUT
	IfEqual, PIT,, Return 0, DllCall( "GetSystemTimes", "Int64P",PIT, "Int64P",PKT, "Int64P",PUT )

	DllCall( "GetSystemTimes", "Int64P",CIT, "Int64P",CKT, "Int64P",CUT )
	IdleTime := PIT - CIT,    KernelTime := PKT - CKT,    UserTime := PUT - CUT
	SystemTime := KernelTime + UserTime 

	Return ( ( SystemTime - IdleTime ) * 100 ) // SystemTime,    PIT := CIT,    PKT := CKT,    PUT := CUT 
}

GlobalMemoryStatusEx()
{
    static MEMORYSTATUSEX, init := VarSetCapacity(MEMORYSTATUSEX, 64, 0) && NumPut(64, MEMORYSTATUSEX, "UInt")
    if !(DllCall("kernel32.dll\GlobalMemoryStatusEx", "Ptr", &MEMORYSTATUSEX))
		return DllCall("kernel32.dll\GetLastError")
    return [NumGet(MEMORYSTATUSEX,  0, "UInt"), NumGet(MEMORYSTATUSEX,  4, "UInt"), NumGet(MEMORYSTATUSEX,  8, "UInt64"), NumGet(MEMORYSTATUSEX, 16, "UInt64"), NumGet(MEMORYSTATUSEX, 24, "UInt64"), NumGet(MEMORYSTATUSEX, 32, "UInt64"), NumGet(MEMORYSTATUSEX, 40, "UInt64"), NumGet(MEMORYSTATUSEX, 48, "UInt64"), NumGet(MEMORYSTATUSEX, 56, "UInt64")]
}

refresh:
	GuiControl, overlay:, vCPU, % CPULoad() `%
	GuiControl, overlay:, vRAM, % GlobalMemoryStatusEx()[2] `%
return
