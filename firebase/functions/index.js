/* Utilities Functions */

async function mappingType(type, _collection, where, toFound) {
  function mapping(all) {
    const map = [];
    all.forEach((one) => {
      map.push({data: one.data(), uid: one.id});
    });
    if (map.length == 0) {
      return {data: "Error", uid: "Error"};
    }
    return map;
  }
  const ot = await db.collection(_collection)
      .where(type, where, toFound).get();
  return mapping(ot)[0];
}

async function selectInArray(arr, start, end) {
  const out = [];
  let i = 0;
  arr.forEach((j) => {
    if (i >= start && i <= end) {
      out.push(j);
    }
    i++;
  });
  return out;
}

/* require and setUp FireBase Env */

const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp(functions.config().admin);
const db = admin.firestore();

/* Utilities FireBase Functions */

async function getTable(tableName) {
  const Tables = await db.collection(tableName);
  const snapshot = await Tables.get();
  const map = [];

  if (snapshot.empty) {
    return;
  }

  snapshot.forEach((doc) => {
    map.push(doc.data());
  });

  return map;
}

// async function createMappingData(data) {
//   const map = [];
//   data.forEach((elem) => {
//     map.push(elem.data());
//   });
//   return map;
// }

async function createMappingDataId(data) {
  const map = [];
  data.forEach((elem) => {
    map.push({
      data: elem.data(),
      id: elem.id,
    });
  });
  return map;
}

/* User Functions */

exports.UserLogin = functions.auth.user().onCreate(async (usr) => {
  return db.collection("Users").doc(usr.uid).set({
    // PhoneNumber: usr.phone,
    Status: "Incomplete",
  }).catch((err) => {
    console.log(err);
    return;
  });
});

exports.getUsers = functions.https.onCall(async () => {
  return await getTable("Users");
});

exports.setUsers = functions.https.onCall(async (data, context) => {
  const _Roles = await mappingType("Type", "Roles", "==", data.rolesType);
  const _Rights = await mappingType("Type", "Rights", "==", _Roles.data.Type);
  const _Pages = await mappingType("Who", "Pages", "==", _Roles.data.Type);
  const _Cities = await mappingType("Name", "Cities", "==", data.city);
  const nGroups = await db.collection("Groups")
      .where("Who", "array-contains", _Roles.data.Type).get();
  const _Groups = [];
  nGroups.forEach((G) => {
    _Groups.push(G.id);
  });
  db.collection("Cities").doc(_Cities.uid).update({
    Number: {
      Buyer: _Cities.data.Number.Buyer +
          (_Roles.data.Type == "Buyer" ? 1 : 0),
      Delivery: _Cities.data.Number.Delivery +
          (_Roles.data.Type == "Delivery" ? 1 : 0),
      Seller: _Cities.data.Number.Seller +
          (_Roles.data.Type == "Seller" ? 1 : 0),
    },
  });
  return db.collection("Users").doc(context.auth.uid).set({
    Groups: _Groups,
    Pages: _Pages.uid,
    Roles: _Roles.uid,
    City: _Cities.uid,
    Rights: _Rights.uid,
    Status: "Complete",
    Name: data.name,
    Email: data.email,
  });
});

/* "My" Functions */

exports.getMe = functions.https.onCall(async (data, context) => {
  const doc = db.collection("Users").doc(context.auth.uid);
  const usr = await doc.get();
  return usr.data();
});

exports.getMyPage = functions.https.onCall(async (data, context) => {
  const docUser = db.collection("Users").doc(context.auth.uid);
  const usr = await docUser.get();

  const docPages = db.collection("Pages").doc(usr.data().Pages);
  const pages = await docPages.get();

  return pages.data().Pages[data.pageName];
});

/* Cities Functions */

exports.getCity = functions.https.onCall(async () => {
  return await getTable("Cities");
});

/* Articles Functions */

exports.createArticles = functions.https.onCall(async (data, context) => {
  if (!getMyRight(context, "Write", "Articles")) {
    return;
  }
  const Article = {
    CreateBy: context.auth.uid,
    Name: data.name,
    Price: data.price,
    Quantity: data.quantity,
    Weight: data.weight,
  };
  return db.collection("Articles").add(Article);
});

exports.modifyArticles = functions.https.onCall(async (data, context) => {
  if (!getMyRight(context, "Write", "Articles")) {
    return;
  }
  return db.collection("Articles").doc(data.id).update({
    Name: data.name,
    Price: data.price,
    Quantity: data.quantity,
    Weight: data.weight,
  });
});

exports.getArticles = functions.https.onCall(async (data, context) => {
  if (!getMyRight(context, "Read", "Articles")) {
    return;
  }
  const docArticles = db.collection("Articles")
      .where("CreateBy", "==", context.auth.uid);
  const Articles = await docArticles.get();
  return selectInArray(
      await createMappingDataId(Articles),
      data.start,
      data.end);
});

/* Roles Functions */

exports.getRoles = functions.https.onCall(async () => {
  const Roles = await db.collection("Roles")
      .where("Display", "==", true).get();
  const map = [];

  Roles.forEach((doc) => {
    map.push(doc.data());
  });

  return map;
});

/* Rights Functions */

async function getMyRight(context, rw, obj) {
  const docUser = db.collection("Users").doc(context.auth.uid);
  const usr = await docUser.get();

  const docRights = db.collection("Rights").doc(usr.data().Rights);
  const rights = await docRights.get();

  return (rights.data()[rw][obj]);
}
