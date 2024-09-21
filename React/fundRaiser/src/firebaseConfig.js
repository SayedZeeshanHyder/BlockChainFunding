// firebaseConfig.js
import { initializeApp } from "firebase/app";
import { getFirestore } from "firebase/firestore";

const firebaseConfig = {
  apiKey: "AIzaSyAeDePmDbJor1SlPv8OA6uaKv_-gdJWB9w",
  authDomain: "codefix-d69c7.firebaseapp.com",
  databaseURL: "https://codefix-d69c7-default-rtdb.firebaseio.com",
  projectId: "codefix-d69c7",
  storageBucket: "codefix-d69c7.appspot.com",
  messagingSenderId: "544559436807",
  appId: "1:544559436807:web:c6c1b11258a36fd50e86a2",
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
if (app != null) {
  console.log("Firebase Connected");
}
// Initialize Firestore
const db = getFirestore(app);

export { db };
