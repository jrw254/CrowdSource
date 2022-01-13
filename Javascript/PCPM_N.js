// ==UserScript==
// @name         Prolific Crude Page Monitor
// @namespace    http://tampermonkey.net/
// @version      1.0.N
// @description  New Layout: Page Monitor and Crudely scrape the page that can be displayed via Notifications
// @author       JRW254
// @match        https://app.prolific.co/studies
// @icon         https://www.google.com/s2/favicons?domain=app.prolific.co
// @grant        none
// ==/UserScript==
//
// Below we see if the page has permissions granted so we can get those notifications
console.log(Notification.permission);
   if (Notification.permission === "granted") { // Do nothing if permissions are granted
 //     alert("we have permission");
} else if (Notification.permission !== "denied") {
      Notification.requestPermission().then(permission => { // If permissions are not granted then make a request.
         console.log(permission);
   });
}
//
// Now lets set our interval below:
// PCMP = Prolific Crude Page Monitor for a function name.
setInterval(PCPM, 300000); // 5 minutes
//
function PCPM() { // Function for both sets of notifcations.
//
const listItems = document.querySelectorAll(".list-item"); // Display's the info
//
let surNUM = document.querySelector(".study-list-header .pill").textContent // Get number of available survey's.
const notification = new Notification("Prolific Crude Page Monitor\nAvailable: " + surNUM, { // Create and display the notifications.
    // icon: "yourimageurl.png"
    icon: "https://www.google.com/s2/favicons?domain=app.prolific.co"
})

notification.onclick = function () { // If we click the first notification we will display all survey's in notification area.
for (let i = 0; i < listItems.length; i++) { // Loop through.
let bodyTEXT = listItems[i].textContent; // Store contents of Loop.
const notification = new Notification("PCPM: Crude PANDA\nAvailable: " + surNUM, { // Create and display the notifications.
    body: " Details:\n" + bodyTEXT, // Crudely display info in the body.
    // vibrate: true
    // icon: "yourimageurl.png"
   })
  };
 }
}
//