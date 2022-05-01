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

// const firebase = require("firebase-app");
const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp(functions.config().admin);
const db = admin.firestore();
const distance = require("google-distance");
distance.apiKey = "AIzaSyDQRHR9qa-aMU6etJT8kp0VX8I1QvnodLA";

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

// async function deleteDoc(_data) {
//   _data.forEach(async (doc) => {
//     await doc.delete();
//   });
// }

/* Collections Functions */

exports.GetAllCollection = functions.https.onCall(async () => {
  const map = [];
  const collections = await db.listCollections();
  collections.forEach((collection) => {
    map.push({id: collection.id});
  });
  return map;
});

/* Doc Functions */

exports.GetDocFromCall = functions.https.onCall(async (data) => {
  const _Doc = await db.collection(data.callName).doc(data.docName).get();

  return _Doc.data();
});

exports.SetDocFromCall = functions.https.onCall(async (data) => {
  return await db.collection(data.callName).doc(data.docName).set(data.set);
});

exports.GetAllDocOfCollection = functions.https.onCall(async (data) => {
  const map = [];
  const _Doc = await db.collection(data.docName).get();

  _Doc.forEach((Doc) => {
    map.push({id: Doc.id});
  });
  return map;
});

/* User Functions */

exports.UserLogin = functions.auth.user().onCreate(async (usr) => {
  db.collection("Users").doc(usr.uid).set({
    Status: "Incomplete",
  });
  return true;
});

let debugI = 0;

async function debug(_name, _data) {
  db.collection("debug").doc(JSON.stringify(
      new Date().getDate().toString())).update({
    [`${debugI}`]: JSON.stringify({name: _name, data: _data}),
  });
  debugI++;
}

exports.UserDelete = functions.auth.user().onDelete(async (data) => {
  debug("data.uid", data.uid);
  const _user = db.collection("Users").doc(data.uid);
  debug("_user", _user);
  const user = await _user.get();
  debug("user", user);

  const _Articles = await db.collection("Articles")
      .where("CreateBy", "==", data.uid).get();
  debug("_Articles", _Articles);
  _Articles.forEach((doc) => {
    doc.ref.delete();
  });

  await db.collection("Groups").doc(user.data().Groups).update({
    [`Who.${user.data().Roles.Type}`]: admin.firestore.FieldValue.
        arrayRemove(data.uid),
  });

  await _user.delete();
  return true;
});

exports.getUsers = functions.https.onCall(async () => {
  return await getTable("Users");
});

exports.setUsers = functions.https.onCall(async (data, context) => {
  const _Roles = await mappingType("Type", "Roles", "==", data.rolesType);
  const _Rights = await mappingType("Type", "Rights", "==", _Roles.data.Type);
  const _Pages = await mappingType("Who", "Pages", "==", _Roles.data.Type);
  const _Groups = await mappingType("Name", "Groups", "==", data.city);

  await db.collection("Groups").doc(_Groups.uid).update({
    [`Who.${_Roles.data.Type}`]: admin.firestore.FieldValue
        .arrayUnion(context.auth.uid),
  });

  let address = "";
  if (data.rolesType == "Seller") {
    address = data.address;
  }

  return await db.collection("Users").doc(context.auth.uid).set({
    Groups: _Groups.uid,
    Pages: _Pages.uid,
    Roles: _Roles.uid,
    Rights: _Rights.uid,
    Status: "Complete",
    Name: data.name,
    Email: data.email,
    Address: address,
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

exports.getCities = functions.https.onCall(async () => {
  const _Cities = await getTable("Groups");

  return _Cities.map((arr) => {
    return {
      Name: arr.Name,
    };
  });
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
  await db.collection("Articles").add(Article);
  return true;
});

exports.modifyArticles = functions.https.onCall(async (data, context) => {
  if (!getMyRight(context, "Write", "Articles")) {
    return "No Right to modify articles";
  }
  db.collection("Articles").doc(data.id).update({
    Name: data.name,
    Price: data.price,
    Quantity: data.quantity,
    Weight: data.weight,
  });
  return true;
});

exports.getArticlesInGroup = functions.https.onCall(async (data, context) => {
  if (!getMyRight(context, "Read", "Articles")) {
    return;
  }

  const docUser = db.collection("Users").doc(context.auth.uid);
  const usr = await docUser.get();
  const _Groups = db.collection("Groups").doc(usr.data().Groups);
  const group = await _Groups.get();
  const _idSeller = await group.data().Who.Seller;

  const mapA = await db.collection("Articles")
      .where("CreateBy", "in", _idSeller).get();

  return await selectInArray(
      await createMappingDataId(mapA),
      data.start,
      data.end);
});

exports.getArticles = functions.https.onCall(async (data, context) => {
  if (!getMyRight(context, "Read", "Articles")) {
    return;
  }
  const docArticles = db.collection("Articles")
      .where("CreateBy", "==", context.auth.uid);
  const Articles = await docArticles.get();
  return await selectInArray(
      await createMappingDataId(Articles),
      data.start,
      data.end);
});

exports.buyArticles = functions.https.onCall(async (data, context) => {
  if (!getMyRight(context, "Write", "Ordered")) {
    return;
  }

  const art = await db.collection("Articles").doc(data.id).get();
  const Ordered = {
    Articles: data.id,
    Buyer: context.auth.uid,
    Quantity: data.quantity,
    Seller: art.data().CreateBy,
    Address: data.address,
    Time: new Date().getDate().toString(),
  };

  await db.collection("Ordered").add(Ordered);
  return true;
});

/* Order Functions */

exports.getOrderInGroup = functions.https.onCall(async (data, context) => {
  if (!getMyRight(context, "Read", "Ordered")) {
    return;
  }

  const docUser = db.collection("Users").doc(context.auth.uid);
  const usr = await docUser.get();
  const _Groups = db.collection("Groups").doc(usr.data().Groups);
  const group = await _Groups.get();
  const _idSeller = await group.data().Who.Seller;
  const mapA = await db.collection("Ordered")
      .where("Seller", "in", _idSeller).get();

  let mapSeller = [];
  mapA.forEach((m) => {
    const Seller = db.collection("Users").doc(m.data().Seller).get();
    mapSeller.push({
      Seller: Seller,
      Quantity: m.data().quantity,
      Address_Buyer: m.data().Address,
    });
  });
  mapSeller = await Promise.all(mapSeller);
  // mapSeller.forEach((m) => {
  //   m.Seller = m.Seller.data().Address;
  // });
  return mapSeller;
  // let mapSeller = [];
  // mapA.forEach((m) => {
  //   const Sellers = db.collection("Users").doc(m.data().Seller).get();
  //   mapSeller.push(Sellers);
  // });
  // mapSeller = await Promise.all(mapSeller);

  // let map = [];
  // for (let index = 0; index < mapA.length; index++) {
  //   const m = mapA[index];
  //   const Sellers = mapSeller[index].data();
  //   const _distance = distance.get({
  //     origin: Sellers.data().Address,
  //     destination: m.data().Address,
  //   }, (err, data) => {
  //     return (data);
  //   });

  //   map.push({
  //     Address_Seller: Sellers.data().Address,
  //     Quantity: m.data().Quantity,
  //     Address_Buyer: m.data().Address,
  //     distanceTime: _distance,
  //   });
  // }
  // map = await Promise.all(map);
  // return (map);
  // return (map);
  // return await selectInArray(
  //     await createMappingDataId(mapA),
  //     data.start,
  //     data.end);
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

  const docRights = db.collection("Rights").doc(await usr.data().Rights);
  const rights = await docRights.get();

  return (await rights.data()[rw][obj]);
}

/* Ordered Functions */

exports.getOrdered = functions.https.onCall(async (data, context) => {

});
