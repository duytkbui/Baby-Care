import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_babycare/data/model/baby_model.dart';

class BabyRepository {
  final FirebaseFirestore firebaseFirestore;

  BabyRepository({FirebaseFirestore firebaseFirestore})
      : this.firebaseFirestore =
            firebaseFirestore ?? FirebaseFirestore.instance;

  Stream<List<BabyModel>> getAllBaby() {
    return firebaseFirestore.collection('baby').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => BabyModel.fromSnapshot(doc)).toList();
    });
  }
}
