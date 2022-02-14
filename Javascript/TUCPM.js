// ==UserScript==
// @name         TUCPM
// @namespace
// @version      1.0
// @description  Crude Page Monitor for the TaskUp Website. (TaskUp Crude Page Monitor: TUCPM)
// @             You get two notifications:
// @             1. Qualification's
// @             2. Work
// @             The notifications come back to back. Click each to see the content within notificcations.
// @             Note: You can click one or the other. You can also click both. Each initial notification will appear back to back.
// @                   If you click both in sequence then you'll get all your qual content first then work content next via notifications.
// @                   Open within Notification Center will just dump all notifications instantly, no waiting. (Tested on Win 10)
// @author       JRW254
// @match        https://taskup.ai/workers/projects
// @icon         https://www.google.com/s2/favicons?sz=64&domain=taskup.ai
// @grant        none
// ==/UserScript==

// Give your browser permissions to recieve notifications.
console.log(Notification.permission);
   if (Notification.permission === "granted") {
 //     alert("we have permission");
} else if (Notification.permission !== "denied") {
      Notification.requestPermission().then(permission => {
         console.log(permission);
   });
}

//setInterval(reFra, 5000); // 5 seconds for testing
setInterval(reFra, 1200000); // 20 minutes
setTimeout(qualFunc, 5000);
setTimeout(workFunc, 5000);

function qualFunc() {
let quals = document.querySelectorAll("table")[0].childNodes[3].getElementsByClassName("row")
   const qualNotification = new Notification("TaskUp Crude Page Monitor\n Quals Available: " + quals.length, {
     //  icon: "https://www.google.com/s2/favicons?domain=https://taskup.ai/"
   })

qualNotification.onclick = function () { // If we click the first notification we will display all qual's in notification area.
for (let i = 0; i < quals.length; i++) { // Loop through.
let bodyTEXT = quals[i].textContent; // Store contents of Loop.
const qualBodyNotification = new Notification("TUCPM: Quals Available: " + quals.length, { // Create and display the notifications.
    body: bodyTEXT + bodyTEXT, // Crudely display info in the body.
    // icon: "https://www.google.com/s2/favicons?domain=https://taskup.ai/"
   })
  };
 }
};


function workFunc() {
let work = document.querySelectorAll("table")[1].childNodes[3].getElementsByClassName("row")
   const workNotification = new Notification("TaskUp Crude Page Monitor\n Work Available: " + work.length, {
    //   icon: "https://www.google.com/s2/favicons?domain=https://taskup.ai/"
   })

workNotification.onclick = function () { // If we click the first notification we will display all work in notification area.
for (let i = 0; i < work.length; i++) { // Loop through.
let bodyTEXT = work[i].textContent; // Store contents of Loop.
const workBodyNotification = new Notification("TUCPM: Work Available: " + work.length, { // Create and display the notifications.
    body: bodyTEXT, // Crudely display info in the body.
    // icon: "https://www.google.com/s2/favicons?domain=https://taskup.ai/"
   })
  };
 }
};

function reFra() {
    window.location.reload();
};