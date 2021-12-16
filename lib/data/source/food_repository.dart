import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_babycare/constants/app_constants.dart';
import 'package:flutter_babycare/data/model/food_model.dart';
import 'package:flutter_babycare/data/model/ni_model.dart';
import 'package:flutter_babycare/data/source/ni_repository.dart';
import 'package:flutter_babycare/utils/converter.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class FoodRepository {
  final FirebaseFirestore firebaseFirestore;
  final NIRepository niRepository;

  FoodRepository(
      {FirebaseFirestore firebaseFirestore, NIRepository niRepository})
      : this.firebaseFirestore =
            firebaseFirestore ?? FirebaseFirestore.instance,
        this.niRepository = niRepository ?? new NIRepository();

  Future<String> createFood(List<FoodModel> listFoodModel) async {
    for (var i = 0; i < listFoodModel.length; i++) {
      String idFood = Uuid().v4();
      listFoodModel[i].setId(idFood);
      DocumentReference documentReferencer =
          firebaseFirestore.collection('food').doc(idFood);
      String temp = listFoodModel[i].type.toString();
      await documentReferencer
          .set(listFoodModel[i].toJson())
          .whenComplete(() => print("$temp food added to the database"))
          .catchError((e) => print(e));

      List<NIModel> listNi = Converter.foodToNI(listFoodModel[i]);

      for (var j = 0; j < listNi.length; j++) {
        await niRepository.createNi(listNi[j], listFoodModel[0].idBaby);
      }
    }
    return listFoodModel[0].idBaby;
  }

  Future<String> updateFood(List<FoodModel> listFoodModel) async {
    List<FoodModel> listFoodRecent =
        await fetchFood(listFoodModel[0].idBaby, 0);
    bool isOverDay = false;
    double temp = 10000;
    int maxCountUpdate;
    await firebaseFirestore
        .collection('food')
        .where('idBaby', isEqualTo: listFoodModel[0].idBaby)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        double date = Converter.dateToDayDouble(
            DateFormat('dd/MM/yyyy').format(doc.data()['updateDate'].toDate()));
        if (temp >= date) {
          temp = date;
          maxCountUpdate = doc.data()['countUpdate'];
        }
      });
    });

    await firebaseFirestore
        .collection('food')
        .where('idBaby', isEqualTo: listFoodModel[0].idBaby)
        .where('countUpdate', isEqualTo: maxCountUpdate)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc.data()['type'] ==
            Converter.FoodTypeToUnitString(FoodType.Egg)) {
          if (Converter.checkOverDay(doc.data()['updateDate'].toDay())) {
            isOverDay = true;
          }
        }
      });
    });

    for (var i = 0; i < listFoodModel.length; i++) {
      if (isOverDay) {
        listFoodModel[i].setCountUpdate(maxCountUpdate + 1);
        String idFood = Uuid().v4();
        listFoodModel[i].setId(idFood);
        DocumentReference documentReferencer =
            firebaseFirestore.collection('food').doc(idFood);
        String temp = listFoodModel[i].type.toString();
        await documentReferencer
            .set(listFoodModel[i].toJson())
            .whenComplete(() => print("$temp food added to the database"))
            .catchError((e) => print(e));

        List<NIModel> listNi = Converter.foodToNI(listFoodModel[i]);

        for (var j = 0; j < listNi.length; j++) {
          await niRepository.createNi(listNi[j], listFoodModel[0].idBaby);
        }
      } else {
        for (var j = 0; j < listFoodRecent.length; j++) {
          if (listFoodRecent[j].type == listFoodModel[i].type) {
            listFoodModel[i].setId(listFoodRecent[j].id);
            DocumentReference documentReferencer =
                firebaseFirestore.collection('food').doc(listFoodRecent[j].id);
            documentReferencer
                .update(listFoodModel[i].toJson())
                .whenComplete(() => print("Food updated in the database"))
                .catchError((e) => print(e));
          }
        }
      }
    }
    return listFoodModel[0].idBaby;
  }

  Future<List<FoodModel>> fetchFood(String idBaby, int dayAgo) async {
    // dayAgo = 0 là hôm nay, =1 là 1 ngày trước, =2 là 2 ngày trước
    List<FoodModel> listFood = [];
    int maxCountUpdate;
    double temp = 10000;
    await firebaseFirestore
        .collection('food')
        .where('idBaby', isEqualTo: idBaby)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        double date = Converter.dateToDayDouble(
            DateFormat('dd/MM/yyyy').format(doc.data()['updateDate'].toDate()));
        if (temp >= date) {
          temp = date;
          maxCountUpdate = doc.data()['countUpdate'];
        }
      });
    });
    await firebaseFirestore
        .collection('food')
        .where('idBaby', isEqualTo: idBaby)
        .where('countUpdate', isEqualTo: maxCountUpdate - dayAgo)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        listFood.add(FoodModel.fromSnapshot(doc));
      });
    });
    return listFood;
  }
}
