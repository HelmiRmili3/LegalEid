import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart';

class FirestorHelper {
  //create and set data for new user
  static Future create(UserModel user) async {
    final dataCollection = FirebaseFirestore.instance.collection('users');
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final docRef = dataCollection.doc(uid);
    final newUser = UserModel(
      id: user.id,
      email: user.email,
      caseNumber: user.caseNumber,
      consultationsNumber: user.consultationsNumber,
      sessionsNumber: user.sessionsNumber,
      totalAmounts: user.totalAmounts,
      totalPayments: user.totalPayments,
    ).toJson();
    try {
      await docRef.set(newUser);
    } catch (e) {
      //print('some error has occurd $e');
    }
  }
}
