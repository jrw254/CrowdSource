// ==UserScript==
// @name         Swag Buddy Beta Testing
// @namespace    http://tampermonkey.net/
// @version      2.0
// @description  Added buttons that don't seem to work, but we have keypresses!
// @author       JRW254/Sabedth
// @match
// @match        https://ab.swagbucks.com/promo/*
// @grant        none
// ==/UserScript==

/*
I haven't found all cases or even edge cases. This works sorta.
It's on the semi passive side right now.
Z Key: Starts the 30 second timer in a loop. 
X Key: Stops all timers but the Z Key one.
C Key: Stops the Start Timer(Z Key one).
Still on the fence about the timer lengths. 
This does not work on certain pages with a count of six because those pages require a refresh.
Will do the InboxDollars side later after his is fleshed.
Still have close windows errors and AYSW messages to solve.
Longest current run without interrupt: 3 hours. (More testing needed)
Again: Ultra Beta Semi-Passive RPA tool for Swag Videos.
*/




let refreshStopInterval;
let refreshInterval;
window.addEventListener("onkeypress", keyDown, true);
window.addEventListener("keydown", keyDown);
window.addEventListener("click", start30, false);
window.addEventListener("click", start2, false);
window.addEventListener("click", start3, false);
window.addEventListener("click", start5, false);
window.addEventListener("click", start10, false);
window.addEventListener("click", start20, false);
window.addEventListener("click", stop, false);

// HotKey's[...]

function keyDown() {
var e = window.event;
switch (e.keyCode) {
    // Key z
    case 90:
        setTimeout(startBtn , 5000);
        start30();
        break;
    // Key x
    case 88:
        stop();
        stop1();
        alert("All Hands STOP!!");
        break;
    // Key c
    case 67:
        stop1();
        break;
    // Key v
    case 65:
        document.getElementById("discoverMore").click(); // discoverMore
        break;
// Number Key's 1-5[...]

    // Key 1
    case 49:
        start2();
        break;
    // Key 2
    case 50:
        start3();
        break;
    // Key 3
    case 51:
        start5();
        break;
    // Key 4
    case 52:
        start10();
        break;
    // Key 5
    case 53:
        start20();
        break;
}
}

// Main Functions[...]
function startBtn() {
    "use strict";
let stbtn = document.getElementById("startEarning");
let gogo = stbtn;
stbtn.click();
}


function discBtn() {
    "use strict";
let disbtn = document.getElementById("discoverMore");
let gogo1 = disbtn;
disbtn.click();
}



//setIntervals[...]

function start30() { // 30 second timer & startBtn
    stop1();
    refreshStopInterval = setInterval(function() {
    startBtn();
    },30000);
}

function start2() { // 2.5 minute timer & discoverMore
    stop();
    refreshInterval = setInterval(function() {
    discBtn();
    },5000);
}

function start3() { // 3 minute timer & discoverMore
    stop();
    refreshInterval = setInterval(function() {
    discBtn();
    },180000);
}

function start5() { // 5 minute timer & discoverMore
    stop();
    refreshInterval = setInterval(function() {
    discBtn();
    },320000);
}

function start10() { // 10 minute timer & discoverMore
    stop();
    refreshInterval = setInterval(function() {
    discBtn();
    },10*60*1000);
}

function start20() { // 20 minute timer & discoverMore
    stop();
    refreshInterval = setInterval(function() {
    discBtn();
    },20*60*1000);
}

/* Stop Function[...] */
function stop() {
if (refreshInterval != null) {
clearInterval(refreshInterval);
refreshInterval = null;
}
}

function stop1() {
if (refreshStopInterval != null) {
clearInterval(refreshStopInterval);
refreshStopInterval = null;
}
}

/* Injected HTML Buttons[...] */
var h = document.getElementById("main-content");
  h.insertAdjacentHTML("beforeend", "<button style=color:red; background-color:powderblue; border-color:black; onclick=start30();><a>Start Timer</a></button>");
  h.insertAdjacentHTML("beforeend", "       ");
  h.insertAdjacentHTML("beforeend", "<button style=background-color:powderblue; border-color:black; onclick=start2();><a>2.5 min</a></button>");
  h.insertAdjacentHTML("beforeend", "       ");
  h.insertAdjacentHTML("beforeend", "<button style=background-color:powderblue; border-color:black; onclick=start3();><a>3 min</a></button>");
  h.insertAdjacentHTML("beforeend", "       ");
  h.insertAdjacentHTML("beforeend", "<button style=background-color:powderblue; border-color:black; onclick=start5();><a>5 min</a></button>");
  h.insertAdjacentHTML("beforeend", "       ");
  h.insertAdjacentHTML("beforeend", "<button style=background-color:powderblue; border-color:black; onclick=start10();><a>10 min</a></button>");
  h.insertAdjacentHTML("beforeend", "       ");
  h.insertAdjacentHTML("beforeend", "<button style= background-color:powderblue; border-color:black; onclick=start20();><a>20 min</a></button>");
  h.insertAdjacentHTML("beforeend", "       ");
  h.insertAdjacentHTML("beforeend", "<button style=background-color:tomato; border-color:black; onclick=stop();><a>Stop Timer</a></button>");
  h.insertAdjacentHTML("beforeend", "       ");






