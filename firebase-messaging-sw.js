importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-messaging-compat.js");

firebase.initializeApp({
  apiKey: "AIzaSyCoSePApHcF2iif84dv6j15dyDyn4xBof0",
    authDomain: "rstream-15633.firebaseapp.com",
    projectId: "rstream-15633",
    storageBucket: "rstream-15633.appspot.com",
    messagingSenderId: "1027574717774",
    appId: "1:1027574717774:web:b521d5d48799434123921f"
 });
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
  console.log("onBackgroundMessage", m);
});