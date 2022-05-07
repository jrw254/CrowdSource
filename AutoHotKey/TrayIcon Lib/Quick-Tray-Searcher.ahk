/*
AutoHotkey Version:     1.1.34.00
Platform:               Win10 19042
Author:                 JRW254
Script Version:         1.0
Script Function:    A searching tool for a couple of things. 
*/
#Include ./TrayIcon-Lib.ahk
/*
    Create Menu's Below

    Icon locations: %A_Windir%\System32\<insert below here>
        mmcndmgr.dll
        ieframe.dll
        comres.dll
*/
Menu, Tray, NoStandard ; Deelets Old Menu's
Menu, Tray, Icon, OTS-Icon.ico
Menu, Tray, Add ; Creates a seperatr once
Menu, Tray, Add, Look Up AHK Stuff, ahkSearcher
Menu, Tray, Icon, Look Up AHK Stuff, %A_Windir%\System32\comres.dll, 1 
spacer() ; creates a seperatr twice
Menu, Tray, Add, Another one bites the dust, dedMS
spacer()
Menu, Tray, Add, Find .ico files, iconSearcher
Menu, Tray, Add, Find .png files, pngSearcher
Menu, Tray, Add, Find .jpg files, jpgSearcher
Menu, Tray, Add, Find .gif files, gifSearcher
Menu, Tray, Icon, Find .ico files, %A_Windir%\System32\ieframe.dll, 18
Menu, Tray, Icon, Find .png files, %A_Windir%\System32\ieframe.dll, 18
Menu, Tray, Icon, Find .jpg files, %A_Windir%\System32\ieframe.dll, 18
Menu, Tray, Icon, Find .gif files, %A_Windir%\System32\ieframe.dll, 18
spacer()
Menu, Tray, Add, ISBN Lookup, ISBN
Menu, Tray, Add, PDF Lookup, PDF
Menu, Tray, Icon, ISBN Lookup, %A_Windir%\System32\moricons.dll, 91
Menu, Tray, Icon, PDF Lookup, %A_Windir%\System32\moricons.dll, 91
spacer()
Menu, Tray, Add, Startup Folder, startFold
Menu, Tray, Add, Version 2 Folder, vtwoFold
Menu, Tray, Add, Downloads Folder, dwnFold
Menu, Tray, Icon, Startup Folder, %A_Windir%\System32\mmcndmgr.dll, 50
Menu, Tray, Icon, Version 2 Folder, %A_Windir%\System32\mmcndmgr.dll, 23
Menu, Tray, Icon, Downloads Folder, %A_Windir%\System32\mmcndmgr.dll, 97
spacer()
Menu, Tray, Add, Quick-Tray-Searcher.ahk, emptyPlace
Menu, Tray, Add, AHK v 1.1.34.0 @ JRW254 - 2022, emptyPlace
/*
    Hotkey's
*/
^mButton:: TrayIcon_Button("AutoHotKeyU64.exe", "R", 0) ; AutoHotKey.exe | AutoHotKeyU64.exe | Zero indexed
/*
    Exit App
*/
Esc:: ExitApp
/*
    Look up thing on AHK
    See what Microsoft has killed. 
*/
ahkSearcher:
InputBox ahkSearcher, AHK Web Searcher, Have a browser open to search the internet for your query,, 500, 100, 15, 15
Run https://www.google.com/search?q=%ahkSearcher%+autohotkey
return

dedMS: ; https://killedbymicrosoft.info/
Run https://killedbymicrosoft.info/
Return
/*
    Folders
*/
startFold:
Run % A_Startup
Return

vtwoFold:
Run C:\Code\AHK_v2_Alpha
Return

dwnFold:
Run %userprofile%\Downloads
Return
/*
    Image Searching
*/
iconSearcher:
InputBox iconSearcher, Look up Icons on Google, Via web browser,, 500, 100, 15, 15
Run https://www.google.com/search?q=%iconSearcher%&tbm=isch&tbs=ift:ico&hl
Return

pngSearcher:
InputBox pngSearcher, Look up PNG's on Google, Via web browser,, 500, 100, 15, 15
Run https://www.google.com/search?q=%pngSearcher%&tbm=isch&tbs=ift:png&hl
Return

jpgSearcher:
InputBox jpgSearcher, Look up JPG's on Google, Via web browser,, 500, 100, 15, 15
Run https://www.google.com/search?q=%jpgSearcher%&tbm=isch&tbs=ift:jpg&hl
Return

gifSearcher:
InputBox gifSearcher, Look up GIF's on Google, Via web browser,, 500, 100, 15, 15
Run https://www.google.com/search?q=%gifSearcher%&tbm=isch&tbs=ift:gif&hl
Return
/*
    Book and Document Searching
*/
ISBN:
InputBox ISBN, Look up ISBN numbers on Google, Via web browser,, 500, 100, 15, 15
Run https://isbnsearch.org/search?s=%ISBN%
Return ; https://isbnsearch.org/search?s= 978-1-61620-578-2

PDF:
InputBox PDF, Look up PDF's on Google, Via web browser,, 500, 100, 15, 15
Run https://www.google.com/search?q=filetype`%3Apdf %PDF%
Return 
/*
    So we can have menu's of just words.
*/
emptyPlace:
Return
/*
    Function to create two spacings. 
*/
spacer() { ; Functionally create spacers for better readability above.
    Menu, Tray, Add
    Menu, Tray, Add
}
