const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp(functions.config().firebase);

exports.addUserToGroupe = functions.https.onCall((data, context) => {
  const original = data.uid;
  admin.database().ref(`/Users/${original}/role`)
      .set("Groups/MarseilleSeller");
  return `Successfully received: ${original}`;
});
