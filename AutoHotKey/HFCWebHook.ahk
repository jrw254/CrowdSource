/*
AutoHotkey Version:     1.1.33.09
Platform:               Win10
Author:                 JRW254
Script Version:         1.1
Script Function:    Get Hideout.co Facebook Code and send via Web Hook  
*/

#Persistent
#SingleInstance force

SetTimer, Function_Listener, 52000 ; 

OnExit("Exit_Info") ; Create a condition when exiting the app.
/*
   Initialize both the timer and timestamp functions when we start.
*/
Func_Uptime_Log() ; Start timer for the uptime log
Func_Timestamp() ; Create a timestamp for the uptime log

Function_Listener:
FormatTime, OutVar,, tt h:mm:ss ; Reading from left to right we can make sure its the right part of the day
/*
   Numbers associated with names of week days
   A_WDay   1 = Sunday
            2 = Monday
            3 = Tueaday
            4 = Wednesday
            5 = Thursday
            6 = Friday
            7 = Saturday
*/
if ((A_WDay == "2") && (OutVar >= "am 11:05:01") && (OutVar <= "am 11:05:55")) ; Check Monday for code at time and then display
{
   
   Func_HideoutFacebookCode()
   return
}
Else if ((A_WDay == "4") && (OutVar >= "am 11:05:01") && (OutVar <= "am 11:05:55")) ; Check Wednesday for code at time and then display
{
   
   Func_HideoutFacebookCode()
   return
}
Else if ((A_WDay == "6") && (OutVar >= "am 11:05:01") && (OutVar <= "am 11:05:55")) ; Check Friday for code at time and then display
{
   
   Func_HideoutFacebookCode()
   return
}

/*
    Function below downloads a text file to folder. Text file is html code of Hideout.co Facebook Post Page.
    Then it parses that for needed information. Cleans up the information to be readable. 
    Then formated via JSON before sending to Discord server via Web Hook. 
*/

Func_HideoutFacebookCode(){
WebHook_URL:= "" ; Discord web hook url goes here between the quotes

UrlDownloadToFile, https://www.facebook.com/pg/HideoutTV/posts/?ref=page_internal, .\code.txt ; Download a text file of the webpage and store within same directory as script
FileRead, OutVar, .\code.txt ; Read the contents of the file
RegExMatch(OutVar, "Promo code(.+?)<", Code_Data) ; Find Promo Code and Display
RegExMatch(OutVar, "25 free(.+?)<", Limit_Data) ; Find Time Limit and Display
RegExMatch(OutVar, "Code expires(.+?)<", Expire_Data) ; Find Expire Time and Display
; Remve the < from all three variables when displaying info
Code_Data := StrReplace(Code_Data, "<", "") 
Limit_Data := StrReplace(Limit_Data, "<", "")
Expire_Data := StrReplace(Expire_Data, "<", "")

/*
    Below we initialize the json data.
    Dont forget to use \n inside json for newlines and variables wrapped in two % (Non expression mode).

*/
 
All_Data=
(
{
  "content": "AHK Hideout WebHook",
  "embeds": [
    {
      "title": "Hideout Facebook",
      "description": "%Code_Data%\n%Limit_Data%\n%Expire_Data%\n\nPowered by AutoHotKey v1\nCreated by: JRW254",      
      "color": 8280002,
      "thumbnail": {
        "url": "https://hideout.co/assets/img/hide-out-logo.png"
      },
      "image": {
        "url": "https://i.imgur.com/8BKmVpj.png"
      }
    }
  ]
}
) 

WebRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1") ; Creat a COM Object
WebRequest.Open("POST", WebHook_URL, false) ; Listen then Open
WebRequest.SetRequestHeader("Content-Type", "application/json") ; Content will be read in json
WebRequest.Send(All_Data) ; Send all the Data
Return
}


/*
   Must set two Globals for a timestamp and endstamp to work.
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
      MsgBox % "Total Uptime was: "conversion . "`nFor: "A_ScriptName . "`nStarted on: "timestamp . "`nEnded on: "endstamp    ;date_conversion
        LogOutput := "Total Uptime was: "conversion . "`nFor: "A_ScriptName . "`nStarted on: "timestamp . "`nEnded on: "endstamp
        FileAppend, % "Log Entry Created on: "endstamp . "`n`n"LogOutput "`n`n", ./log_testing.log
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
   Global timestamp ; Set to other global can reach the timestamp. 

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
