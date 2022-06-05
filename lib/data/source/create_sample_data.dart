import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_babycare/data/model/product/product_model.dart';
import 'package:flutter_babycare/data/model/product/rating_model.dart';
import 'package:flutter_babycare/data/source/baby/food_repository.dart';
import 'package:flutter_babycare/data/source/recommender/product_repository.dart';
import 'package:flutter_babycare/data/source/recommender/rating_repository.dart';
import 'package:uuid/uuid.dart';

import '../../constants/app_constants.dart';
import '../model/baby/food_model.dart';
import '../model/baby/ni_model.dart';
import '../../utils/converter.dart';

import 'baby/ni_repository.dart';

class CreateSampleData {
  CreateSampleData();

  static Future<String> create() async {
    //List<FoodModel> foodList4 = [];
    String idBaby = "d4f1d35b-ae49-4a6e-a269-1793812239b7";
    // List<int> foodValues4 = [];
    // foodValues4.add(500); //porridge
    // foodValues4.add(600); //milk
    // foodValues4.add(0); //meat
    // foodValues4.add(0); //fish
    // foodValues4.add(1); //egg
    // foodValues4.add(100); //green_vegets
    // foodValues4.add(50); //red_vegets
    // foodValues4.add(60); //citrus_fruit
    // for (var i = 0; i < FoodType.values.length; i++) {
    //   foodList4.add(FoodModel(
    //     idBaby: idBaby,
    //     type: FoodType.values[i],
    //     value: foodValues4[i].toDouble(),
    //     updateDate: DateTime(2021, 12, 25),
    //   ));
    // }

    // List<FoodModel> foodList3 = [];
    // List<int> foodValues3 = [];
    // foodValues3.add(200); //porridge
    // foodValues3.add(300); //milk
    // foodValues3.add(500); //meat
    // foodValues3.add(0); //fish
    // foodValues3.add(0); //egg
    // foodValues3.add(100); //green_vegets
    // foodValues3.add(0); //red_vegets
    // foodValues3.add(100); //citrus_fruit
    // for (var i = 0; i < FoodType.values.length; i++) {
    //   foodList3.add(FoodModel(
    //     idBaby: idBaby,
    //     type: FoodType.values[i],
    //     value: foodValues3[i].toDouble(),
    //     updateDate: DateTime(2021, 12, 26),
    //   ));
    // }

    // List<FoodModel> foodList2 = [];
    // List<int> foodValues2 = [];
    // foodValues2.add(500); //porridge
    // foodValues2.add(600); //milk
    // foodValues2.add(0); //meat
    // foodValues2.add(0); //fish
    // foodValues2.add(0); //egg
    // foodValues2.add(100); //green_vegets
    // foodValues2.add(0); //red_vegets
    // foodValues2.add(0); //citrus_fruit
    // for (var i = 0; i < FoodType.values.length; i++) {
    //   foodList2.add(FoodModel(
    //     idBaby: idBaby,
    //     type: FoodType.values[i],
    //     value: foodValues2[i].toDouble(),
    //     updateDate: DateTime(2021, 12, 27),
    //   ));
    // }

    List<FoodModel> foodList1 = [];
    List<int> foodValues1 = [];
    foodValues1.add(0); //porridge
    foodValues1.add(600); //milk
    foodValues1.add(50); //meat
    foodValues1.add(50); //fish
    foodValues1.add(2); //egg
    foodValues1.add(0); //green_vegets
    foodValues1.add(200); //red_vegets
    foodValues1.add(100); //citrus_fruit
    for (var i = 0; i < FoodType.values.length; i++) {
      foodList1.add(FoodModel(
        idBaby: idBaby,
        type: FoodType.values[i],
        value: foodValues1[i].toDouble(),
        updateDate: DateTime(2022, 4, 13),
      ));
    }

    List<FoodModel> foodList0 = [];
    List<int> foodValues0 = [];
    foodValues0.add(500); //porridge
    foodValues0.add(600); //milk
    foodValues0.add(0); //meat
    foodValues0.add(0); //fish
    foodValues0.add(0); //egg
    foodValues0.add(0); //green_vegets
    foodValues0.add(0); //red_vegets
    foodValues0.add(0); //citrus_fruit
    for (var i = 0; i < FoodType.values.length; i++) {
      foodList0.add(FoodModel(
        idBaby: idBaby,
        type: FoodType.values[i],
        value: foodValues0[i].toDouble(),
        updateDate: DateTime(2022, 4, 15),
      ));
    }

    await FoodRepository.createFood(foodList0);
    await FoodRepository.createFood(foodList1);

    return "done";
  }

  static Future<String> createProduct() async {
    List<ProductModel> list = [];
    list.add(ProductModel(
        url:
            "https://shopee.vn/-M%C3%A3-LIFE020650K-gi%E1%BA%A3m-10-%C4%91%C6%A1n-200K-Xe-l%E1%BA%AFc-cao-c%E1%BA%A5p-b%C3%A1nh-cao-su-c%C3%B3-%C4%91%C3%A8n-v%C3%A0-nh%E1%BA%A1c-BBT-GLOBAL-SW004-i.120503687.9848017045?sp_atk=2775e348-16f5-4d8e-91b3-391661f61af6&xptdk=2775e348-16f5-4d8e-91b3-391661f61af6",
        primaryImage:
            "https://cf.shopee.vn/file/69062c2ac07868180ee14bdc720480f3",
        basePrice: 600000,
        name: "Xe lắc cao cấp bánh cao su có đèn và nhạc BBT GLOBAL SW004",
        salePercent: 20,
        tagName: "children's car",
        ratePoint: 0,
        rateCount: 0,
        totalBought: 10,
        shopLocation: "Ha Noi",
        type: "Xe lac"));
    list.add(ProductModel(
        url:
            "https://shopee.vn/-Nh%E1%BB%B1a-Ch%E1%BB%A3-L%E1%BB%9Bn-Xe-%C4%90%E1%BA%A1p-Tr%E1%BA%BB-Em-12-inch-K104-Cho-B%C3%A9-T%E1%BB%AB-2-%C4%91%E1%BA%BFn-3-Tu%E1%BB%95i-i.69119994.4531500192?sp_atk=d4507b2e-9d1c-49da-83ee-e47d86fc03bd&xptdk=d4507b2e-9d1c-49da-83ee-e47d86fc03bd",
        primaryImage:
            "https://cf.shopee.vn/file/c462af6d4f2a1f54f362f76354b39bad",
        basePrice: 830000,
        name: "Xe Đạp Trẻ Em 12 inch K104 Cho Bé Từ 2 đến 3 Tuổi",
        salePercent: 40,
        tagName: "children's car",
        ratePoint: 0,
        rateCount: 0,
        totalBought: 5,
        shopLocation: "TPHCM",
        type: "xe dap"));
    list.add(ProductModel(
        url: "links",
        primaryImage:
            "https://cf.shopee.vn/file/58cde3a70fb78c49ae3d4551aea99694",
        basePrice: 600000,
        name: "Xe chòi chân trẻ em 4 bánh cao cấp Luddy 1003",
        salePercent: 10,
        tagName: "children's car",
        ratePoint: 0,
        rateCount: 0,
        totalBought: 2,
        shopLocation: "Ha Noi",
        type: "Xe chòi"));

    for (var i = 0; i < list.length; i++) {
      await ProductRepository.createProduct(list[i]);
    }

    return "done";
  }

  static Future<String> createRating() async {
    var listModel = [
      RatingModel(
          content: "good",
          idProduct: "09d67479-a724-4f61-8446-9bd40975af19",
          ratePoint: 5,
          userId: "4GxRYoBYNDXo0nBt6VfUTJc5VXG3"),
      RatingModel(
          content: "good",
          idProduct: "09d67479-a724-4f61-8446-9bd40975af19",
          ratePoint: 5,
          userId: "4GxRYoBYNDXo0nBt6VfUTJc5VXG3"),
      RatingModel(
          content: "good",
          idProduct: "09d67479-a724-4f61-8446-9bd40975af19",
          ratePoint: 5,
          userId: "4GxRYoBYNDXo0nBt6VfUTJc5VXG3"),
      RatingModel(
          content: "good",
          idProduct: "09d67479-a724-4f61-8446-9bd40975af19",
          ratePoint: 5,
          userId: "4GxRYoBYNDXo0nBt6VfUTJc5VXG3"),
      RatingModel(
          content: "good",
          idProduct: "09d67479-a724-4f61-8446-9bd40975af19",
          ratePoint: 5,
          userId: "4GxRYoBYNDXo0nBt6VfUTJc5VXG3"),
      RatingModel(
          content: "good",
          idProduct: "09d67479-a724-4f61-8446-9bd40975af19",
          ratePoint: 5,
          userId: "4GxRYoBYNDXo0nBt6VfUTJc5VXG3"),
      RatingModel(
          content: "good",
          idProduct: "09d67479-a724-4f61-8446-9bd40975af19",
          ratePoint: 5,
          userId: "4GxRYoBYNDXo0nBt6VfUTJc5VXG3"),
      RatingModel(
          content: "good",
          idProduct: "09d67479-a724-4f61-8446-9bd40975af19",
          ratePoint: 5,
          userId: "4GxRYoBYNDXo0nBt6VfUTJc5VXG3"),
      RatingModel(
          content: "good",
          idProduct: "09d67479-a724-4f61-8446-9bd40975af19",
          ratePoint: 5,
          userId: "4GxRYoBYNDXo0nBt6VfUTJc5VXG3"),
      RatingModel(
          content: "good",
          idProduct: "09d67479-a724-4f61-8446-9bd40975af19",
          ratePoint: 5,
          userId: "4GxRYoBYNDXo0nBt6VfUTJc5VXG3"),
      RatingModel(
          content: "good",
          idProduct: "09d67479-a724-4f61-8446-9bd40975af19",
          ratePoint: 5,
          userId: "4GxRYoBYNDXo0nBt6VfUTJc5VXG3"),
      RatingModel(
          content: "good",
          idProduct: "09d67479-a724-4f61-8446-9bd40975af19",
          ratePoint: 5,
          userId: "4GxRYoBYNDXo0nBt6VfUTJc5VXG3"),
      RatingModel(
          content: "good",
          idProduct: "09d67479-a724-4f61-8446-9bd40975af19",
          ratePoint: 5,
          userId: "4GxRYoBYNDXo0nBt6VfUTJc5VXG3"),
      RatingModel(
          content: "good",
          idProduct: "09d67479-a724-4f61-8446-9bd40975af19",
          ratePoint: 5,
          userId: "4GxRYoBYNDXo0nBt6VfUTJc5VXG3"),
      RatingModel(
          content: "good",
          idProduct: "09d67479-a724-4f61-8446-9bd40975af19",
          ratePoint: 5,
          userId: "4GxRYoBYNDXo0nBt6VfUTJc5VXG3"),
    ];

    List<RatingModel> list = [];
    list.addAll(listModel);
    for (var i = 0; i < list.length; i++) {
      await RatingRepository.createRating(list[i]);
    }

    return "done";
  }
}
