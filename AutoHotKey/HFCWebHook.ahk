/*
AutoHotkey Version:     1.1.33.09
Platform:               Win10
Author:                 JRW254
Script Version:         1.0
Script Function:    Get Hideout.co Facebook Code and send via Web Hook
                    Note: Place Discord Web Hook URL ar Line 54 within quotes.
*/

#Persistent
#SingleInstance force

SetTimer, Function_Listener, 52000 ; might send duplicate within time

Function_Listener:
FormatTime, OutVar,, h:mm:ss tt ; Format time to be more readable 
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
if ((A_WDay == "2") && (OutVar >= "11:05:01 am") && (OutVar <= "11:05:55 am")) ; Check Monday for code at time and then display
;if ((A_WDay == "3") && (OutVar >= "11:06:01 pm") && (OutVar <= "11:06:55 pm")) ; Tester
{
   
   Func_HideoutFacebookCode()
   return
}
Else if ((A_WDay == "4") && (OutVar >= "11:01:01 am") && (OutVar <= "11:01:55 am")) ; Check Wednesday for code at time and then display
{
   
   Func_HideoutFacebookCode()
   return
}
Else if ((A_WDay == "6") && (OutVar >= "11:01:01 am") && (OutVar <= "11:01:55 am")) ; Check Friday for code at time and then display
{
   
   Func_HideoutFacebookCode()
   return
}

/*
    Function below downloads an text file to folder. Text file is html code of Hideout.co Facebook Post Page.
    Then it parses that for needed information. Clans up the information to be readable. 
    Then formated via JSON before sending to Discord server via Web Hook. 
*/

Func_HideoutFacebookCode(){
WebHook_URL:= "" ; Discord web hook url goes here

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
        "url": "https://i.imgur.com/8BKmVpj.png"
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
