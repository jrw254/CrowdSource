/*
AutoHotkey Version:     1.1.33.09
Platform:               Win10 19042
Author:                 JRW254
Script Version:         1.0
Script Function:    Create a basic front end folder for anything you want to display with templates. 
*/

#Persistent
#SingleInstance force

/*
    Display an Input Box so we can define our file path for folder.
*/
InputBox, filePath, frontend-O-matic AHK v 1, Enter the full path of the first folder. `nAll files and storage folder will be created within.,,, 150
if ErrorLevel
    MsgBox, CANCEL was pressed.
else
    MsgBox, You entered "%filePath%"
/*
    Let us create the new folder we need.
*/
FileCreateDir, %filePath%
/*
    Lets create or append the files within the folder. 
*/
FileAppend, ; Index.html
(
<html>
  <head>
    <title>Mock FrontEnd Anything</title>

    <!-- Normalize HTML5 Reset -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/4.1.1/normalize.min.css">

    <!-- styles.css Link -->
    <link rel="stylesheet" href="css/styles.css">

    <!-- Responsive Shit -->
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=0">
  </head>

  <body>

    <!-- global.js Link -->
    <script src=""></script>

    <p> Sup This is a Index Template </p>
  </body>
</html>
), %filePath%\index.html
;======================================================
FileAppend, ; Style.css
(
This is a blank CSS Template
), %filePath%\style.css
;======================================================
FileAppend, ; Global.js
(
// This is a blank Javascript Template
), %filePath%\global.js
;======================================================
/*
    Now let's create a single storage folder for whatever.
*/
FileCreateDir, %filePath%\Storage
/*
    End of process
*/
