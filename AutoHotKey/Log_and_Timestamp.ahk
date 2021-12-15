/*
AutoHotkey Version:     1.1.33.09
Platform:               Win10 19042
Author:                 JRW254
Script Version:         1.0
Script Function:    Log the run time and create start/end timestamps.
*/

#Persistent
#SingleInstance force

/*
   Idea orginated from: 
   https://www.autohotkey.com/boards/viewtopic.php?t=45476 && https://www.autohotkey.com/boards/viewtopic.php?t=45263
*/

OnExit("Exit_Info") ; Create a condition when exiting the app.
/*
   Initialize both the timer and timestamp functions when we start.
*/
Func_Uptime_Log() ; Start timer
Func_Timestamp() ; Create a timestamp
;=============================
/*
   Must set two Globals for a time stamp to work.
   StartTimer rquires only one global. 
   Create a function for the logging of the apps runtime.
*/
Func_Uptime_Log()
{
    Global StartTimer ; Set for scope. 
    Global timestamp ; Set so we can reach the timestamp and display on exit. 
    Global endstamp ; Set so we can reach the endstamp and display on exit. 
/*
   Do math then format for readability when we exit
*/
	If (StartTimer != "") ; If not empty
	{
		FinishTimer := A_TickCount
		TimedDuration := FinishTimer - StartTimer
		StartTimer := ""
         VarSetCapacity(conversion, 256), DllCall("GetDurationFormat", "uint", 2048, "uint", 0, "ptr", 0, "int64", TimedDuration*10000, "wstr", "d' days 'h':'mm':'ss", "wstr", conversion, "int", 256)
      MsgBox % "Total Uptime was: "conversion . "`nFor: "A_ScriptName . "`nStarted on: "timestamp . "`nEnded on: "endstamp    ; Display via MsgBox when we exit.
      Return conversion
	}
	Else
		StartTimer := A_TickCount ; Initialize the timer.
      
}
/*
   Create a function to establish a timestamp. 
*/
Func_Timestamp()
{
   Global timestamp ; Set so other global can reach the timestamp. 

   If(timestamp = "") ; If empty
   {
   FormatTime, timestamp, A_Now, dddd dd MMMM yyyy hh:mm:ss tt ; Take the time and format it then store into a variable.
   return timestamp
   }
}

Func_End_TimeStamp()
{
   Global endstamp

   If(endstamp = "") ; If empty
   {
   FormatTime, endstamp, A_Now, dddd dd MMMM yyyy hh:mm:ss tt ; Take the time and format it then store into a variable.
   return endstamp
   }
}
;=============================
Exit_Info() {
   Func_End_TimeStamp() ; Initialize endstamp
   Func_Uptime_Log() ; End timer
}
;=============================
AppsKey & >:: ExitApp ; Exit out of app
