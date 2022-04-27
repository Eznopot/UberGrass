const functions = require("firebase-functions");

const admin = require("firebase-admin");
admin.initializeApp(functions.config().admin);

exports.UserLogin = functions.auth.user().onCreate((data) => {
  return admin.firestore().collection("Users").doc(data.uid).set({
    PhoneNumber: data.getPhoneNumber(),
    Status: "User",
  });
});

exports.getCity = functions.https.onCall(async () => {
  const cities = await admin.firestore().collection("City");
  const snapshot = await cities.get();
  if (snapshot.empty) {
    return;
  }

  const map = [];

  snapshot.forEach((doc) => {
    console.log(doc);
    map.set("name", doc.name);
  });
  return map;
});

exports.getUsers = functions.https.onCall(async () => {
  const users = await admin.firestore().collection("Users");

  return users.get().then((querySnapshot) => {
    return querySnapshot;
  });
});

// exports.addUserToGroupe = functions.https.onCall((data, context) => {
//   const original = data.uid;
//   admin.database().ref(`/Users/${original}/role`)
//       .set("Groups/MarseilleSeller");
//   return `Successfully received: ${original}`;
// });

// exports.CreateUser = functions.https.onCall((data, context) => {
//   // const currentUser = admin.auth().currentUser;
//   console.log(data);
//   // firebase.firestore().doc(`/User/`)
// });

// exports.test = functions.https.onRequest((data, response) => {
//   const nb = Math.round(Math.random() * 100);
//   response.send(nb.toString());
// });

// exports.testOnCall = functions.https.onCall((data, response) => {
//   const nb = Math.round(Math.random() * 100);
//   return (`return random number : ${nb.toString()}`);
//   // response.send(nb.toString());
// });
