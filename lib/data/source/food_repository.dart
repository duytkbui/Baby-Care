import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_babycare/data/model/food_model.dart';
import 'package:uuid/uuid.dart';

class FoodRepository {
  final FirebaseFirestore firebaseFirestore;

  FoodRepository({FirebaseFirestore firebaseFirestore})
      : this.firebaseFirestore =
      firebaseFirestore ?? FirebaseFirestore.instance;

  Stream<List<FoodModel>> createFood(List<FoodModel> listFoodModel) {
    for (var i = 0; i < listFoodModel.length; i++) {
      DocumentReference documentReferencer =
      firebaseFirestore.collection('food').doc(Uuid().v4());
      String temp = listFoodModel[i].type.toString();
      documentReferencer
          .set(listFoodModel[i].toJson())
          .whenComplete(() => print("$temp food added to the database"))
          .catchError((e) => print(e));
    }
    return firebaseFirestore.collection('food').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => FoodModel.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<FoodModel>> fetchFood(String idBaby) {
    return firebaseFirestore
        .collection('food')
        .where('idBaby', isEqualTo: idBaby)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => FoodModel.fromSnapshot(doc)).toList();
    });
  }
}