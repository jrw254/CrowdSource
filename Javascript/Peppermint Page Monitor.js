// ==UserScript==
// @name         Peppermint Page Monitor
// @namespace    
// @version      1.0
// @description  Appen page monitor for the project: Peppermint
// @author       JRW254
// @match        https://connect.appen.com/qrp/core/vendors/task/view/1159
// @icon         data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==
// @grant        none
// ==/UserScript==

// Allows us to set prmissions for toast notifications. Will display a pop up if they need to be granted, nothing if already granted. 
console.log(Notification.permission);
   if (Notification.permission === "granted") {
 //     alert("we have permission");
} else if (Notification.permission !== "denied") {
      Notification.requestPermission().then(permission => {
         console.log(permission);
   });
}

function appenNotification() {
    let taskDESC = document.querySelector(".task_table").querySelectorAll(".expand-description").length; // Grabs it via the Task Description tag
    const notification = new Notification("Appen Peppermint's Page Monitor\n Work Available: " + taskDESC, {
        icon: "https://www.google.com/s2/favicons?domain=https://connect.appen.com/"
    })
 }

 function reFresh() { // Reloads the page
    window.location.reload();
}

setTimeout(appenNotification, 15000); // 15 seconds after load sends notification
setInterval(reFresh, 1200000); // 20 minutes to reload page
