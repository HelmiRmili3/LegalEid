import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  //final String? name;
  //final String? phone;
  final String? email;
  //final String? address;
  //final String? image;
  final int? caseNumber;
  final int? consultationsNumber;
  final int? sessionsNumber;
  final double? totalAmounts;
  final double? totalPayments;
  UserModel({
    this.id,
    // this.name,
    // this.phone,
    this.email,
    //this.address,
    //this.image,
    this.caseNumber,
    this.consultationsNumber,
    this.sessionsNumber,
    this.totalAmounts,
    this.totalPayments,
  });
  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
      id: snapshot['id'],
      email: snapshot['email'],
      caseNumber: snapshot['caseNumber'],
      consultationsNumber: snapshot['consultationsNumber'],
      sessionsNumber: snapshot['sessionsNumber'],
      totalAmounts: snapshot['totalAmounts'],
      totalPayments: snapshot['totalPayments'],
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'caseNumber': caseNumber,
        'consultationsNumber': consultationsNumber,
        'sessionsNumber': sessionsNumber,
        'totalAmounts': totalAmounts,
        'totalPayments': totalPayments,
      };
}
