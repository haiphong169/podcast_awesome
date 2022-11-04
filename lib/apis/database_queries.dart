import 'package:cloud_firestore/cloud_firestore.dart';

import '../user_info.dart';

final db = FirebaseFirestore.instance;

addNewUser() {
  db.collection('users').doc(userId).set({'subscriptions': []});
}

updateUserSubscription(int podcastId) {
  db.collection('users').doc(userId).update({
    'subscriptions': FieldValue.arrayUnion([podcastId])
  });
}

Future<bool> getSubscriptionState(int podcastId) async {
  var docSnap = await db.collection('users').doc(userId).get();
  final doc = docSnap.data();
  return doc!['subscriptions'].contains(podcastId);
}

unsubscribe(int podcastId) {
  db.collection('users').doc(userId).update({
    'subscriptions': FieldValue.arrayRemove([podcastId])
  });
}

getSubscriptionList() async {
  var docSnap = await db.collection('users').doc(userId).get();
  final doc = docSnap.data();
  return doc!['subscriptions'];
}
