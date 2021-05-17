// ==UserScript==
// @name         AVID Helper
// @namespace    http://tampermonkey.net/
// @version      1.0
// @description  Make AVID's better with a no mouse solution
// @author       JRW254/Sabedth
// @match        https://apps.avidannotations.com/*
// @icon         https://www.google.com/s2/favicons?domain=undefined.
// @grant        none
// ==/UserScript==

// allBtn[0] = Instructions, allBtn[1] = Yes, allBtn[2] = No, allBtn[3] = Sumbit allBtn[4] = Submit again
let allBtn = document.getElementsByClassName("btn-primary")
    for(let i = 0, len = allBtn.length; i < len; i++) {
}
// Main[...]
window.focus();
  document.addEventListener("keydown", function(e) {
     if (e.keyCode === 90) { // Key = z
         e.preventDefault();
  document.querySelector('.close').click(); // Close the first pop up
         allBtn[1].click(); // Clicks the Yes button
     }
    if (e.keyCode === 88) { // Key = x
        e.preventDefault();
        allBtn[3].click(); // First Submit Button
    }
    else if (e.keyCode === 67) { // Key = c
        e.preventDefault();
        allBtn[4].click(); // Second Submit Button
      }
});
