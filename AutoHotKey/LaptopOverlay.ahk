SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Persistent
#SingleInstance, force

Gui overlay:new, -Caption +LastFound +ToolWindow +AlwaysOnTop
Gui color, 3355FF ;FFFFFF

Gui add, text, BackgroundTrans, CPU
Gui add, text, yp xp+30 vvCPU w30 BackgroundTrans, --`%

Gui add, text, x+1 ym BackgroundTrans, RAM
Gui add, text, yp xp+30 vvRAM w30 BackgroundTrans, --`%

Gui add, text, x+1 ym BackgroundTrans, POW
Gui add, text, yp xp+30 vvPOW w30 BackgroundTrans, --`%

Gui add, text, x+1 ym BackgroundTrans, LIFE
Gui add, text, yp xp+30 vvLIFE w40 BackgroundTrans, --`%

WinSet, Transparent, 190

SetTimer, Refresh, 850
Gui, show, x1568 y1050
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

; https://autohotkey.com/board/topic/112863-battery-level-triggers-action-or-ends-a-loop/
GetSystemPowerStatus(ByRef _ACLineStatus=0, ByRef _BatteryFlag=0, ByRef _BatteryLifePercent=0
						, ByRef _BatteryLifeTime=0, ByRef _BatteryFullLifeTime=0)
{
	static System_Power_Status
	
	VarSetCapacity(System_Power_Status, 12, 0)
	
	if !DllCall("kernel32.dll\GetSystemPowerStatus", "Ptr", &System_Power_Status)
		return false
	
	_ACLineStatus        := NumGet(System_Power_Status, 0, "UChar")
	_BatteryFlag         := NumGet(System_Power_Status, 1, "UChar")
	_BatteryLifePercent  := NumGet(System_Power_Status, 2, "UChar")
	_BatteryLifeTime     := NumGet(System_Power_Status, 4, "Int")
	_BatteryFullLifeTime := NumGet(System_Power_Status, 8, "Int")
	return true
}


;===================================================================================================
refresh:
	GuiControl, overlay:, vCPU, % CPULoad() `%
	GuiControl, overlay:, vRAM, % GlobalMemoryStatusEx()[2] `%
if !GetSystemPowerStatus(,, LifePct, FullLifeTime)
{
	MsgBox, % "GetSystemPowerStatus failed " A_LastError
	return
}
    GuiControl, overlay:, vPOW, % LifePct `%
if !GetSystemPowerStatus(PowerStatus, PowerFlag, LifePct, LifeTime, FullLifeTime)
{
	MsgBox, % "GetSystemPowerStatus failed " A_LastError
	return
}

SetFormat, float, 02
hours1   := (LifeTime//3600)
minutes1 := (LifeTime - hours1 * 3600)// 60
seconds1 := (LifeTime - hours1 * 3600 - minutes1 * 60)
hours1  +=0.00
minutes1+=0.00
seconds1+=0.00
LifeTime=%hours1%:%minutes1%:%seconds1%

GuiControl, overlay:, vLIFE, % LifeTime
return


 
/*
PowerStatus: AC is On or OFF
PowerFlag:
LifePct: Percentage left of the Battery 
LifeTime:
FullLifeTime:
*/