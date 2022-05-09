import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:money_tracker/models/category_model.dart';
import 'package:money_tracker/models/hybrid_model.dart';

import '../components/dialogs/dialog_month_picker.dart';
import '../models/charge_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';

part 'charges_observable.g.dart';

IOSOptions _getIOSOptions() => const IOSOptions(
      accessibility: IOSAccessibility.first_unlock,
    );

AndroidOptions _getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );

const _storage = FlutterSecureStorage();
final Dio _dio = Dio();

class ChargesState = ChargesStateBase with _$ChargesState;

abstract class ChargesStateBase with Store {

  ChargesStateBase({
    required this.userId,
  });

  final int userId;

  @observable
  bool isLoading = false;

  @observable
  ObservableList<HybridModel> categories = ObservableList<HybridModel>();

  @observable
  ObservableList<ChargeModel> charges = ObservableList<ChargeModel>();

  @observable
  DateTime currentDate = DateTime.now();

  Future getToken() async {
    String token = await _storage.read(
            key: 'token',
            iOptions: _getIOSOptions(),
            aOptions: _getAndroidOptions()) ??
        '';
    return token;
  }

  // @action
  // Future checkExistCategory({required String title}) async {
  //   return await _firestore
  //       .collection(COLLECTION_CHARGES)
  //       .doc(userId)
  //       .collection(COLLECTION_USER_CATEGORIES)
  //       .where('title', whereIn: [title])
  //       .withConverter<CategoryModel>(
  //         fromFirestore: (snapshot, _) => CategoryModel.fromJson(snapshot.data()!),
  //         toFirestore: (user, _) => user.toJson(),
  //       ).get().then((value) async {
  //         if (value.size > 0) {
  //           return true;
  //         }
  //         return false;
  //       });
  // }
  @action
  Future checkExistCategory({required String title}) async {
    // String token = await _storage.read(key: 'token',
    //     iOptions: _getIOSOptions(),
    //     aOptions: _getAndroidOptions()) ?? '';
    return getToken().then((token) async {
      try {
        final response = await _dio.get(
            'http://10.0.2.2:80/mt/default/check-exist-category',
            options: Options(headers: {"Authorization": "Bearer " + token}),
            queryParameters: {"title": title});
        return response.data;
      } on DioError catch (e) {
        //isSignIn = false;
        print(e);
      }
    });
  }

  //
  // @action
  // Future createCategory({required CategoryModel model}) async {
  //   await _firestore
  //       .collection(COLLECTION_CHARGES)
  //       .doc(userId)
  //       .collection(COLLECTION_USER_CATEGORIES)
  //       .add(model.toJson());
  // }
  @action
  Future createCategory({required CategoryModel model}) async {
    String token = await _storage.read(
            key: 'token',
            iOptions: _getIOSOptions(),
            aOptions: _getAndroidOptions()) ??
        '';
    try {
      final response = await _dio.post('http://10.0.2.2:80/mt/default/create',
          options: Options(headers: {"Authorization": "Bearer " + token}),
          data: {"title": model.title, "color": model.color});
      if (response.statusCode == 200) {
        categories.clear();
        getCategories();
      }
      return response.data;
    } on DioError catch (e) {
      //isSignIn = false;
      print(e);
    }
    // await _firestore
    //     .collection(COLLECTION_CHARGES)
    //     .doc(userId)
    //     .collection(COLLECTION_USER_CATEGORIES)
    //     .add(model.toJson());
  }

  @action
  Future getCategories() async {
    isLoading = true;
    String token = await _storage.read(
            key: 'token',
            iOptions: _getIOSOptions(),
            aOptions: _getAndroidOptions()) ??
        '';
    // while(true) {
    try {
      final response = await _dio.get('http://10.0.2.2:80/mt/default/list',
          options: Options(
              headers: {"Authorization": "Bearer " + token},
              contentType: Headers.jsonContentType),
          queryParameters: {"month": currentDate});
      if (response.statusCode == 200) {
        response.data.map((json) {
          categories.add(
            HybridModel(
              category: CategoryModel(
                id: int.tryParse(json['id']),
                title: json['title'],
                color: json['color'],
              ),
              cost: double.parse(json['cost']),
            ),
          );
        }).toString();
        isLoading = false;
        return categories;
      }
    } on DioError catch (e) {
      isLoading = false;
      //isSignIn = false;
      print(e);
    }
    // }
  }

//
// @action
// Future updateCategory({required CategoryModel model}) async {
//   await _firestore
//       .collection(COLLECTION_CHARGES)
//       .doc(userId)
//       .collection(COLLECTION_USER_CATEGORIES)
//       .where('uid', whereIn: [model.id])
//       .withConverter<CategoryModel>(
//         fromFirestore: (snapshot, _) =>
//             CategoryModel.fromJson(snapshot.data()!),
//         toFirestore: (user, _) => user.toJson(),
//       )
//       .get()
//       .then((value) async {
//         value.docs.map((e) async {
//           await _firestore
//               .collection(COLLECTION_CHARGES)
//               .doc(userId)
//               .collection(COLLECTION_USER_CATEGORIES)
//               .doc(e.id)
//               .update(model.toJson());
//         }).toList();
//       });
// }
  @action
  Future updateCategory({required CategoryModel model}) async {
    String token = await _storage.read(
            key: 'token',
            iOptions: _getIOSOptions(),
            aOptions: _getAndroidOptions()) ??
        '';
    try {
      final response = await _dio.put('http://10.0.2.2:80/mt/default/update',
          queryParameters: {"id": model.id},
          options: Options(headers: {"Authorization": "Bearer " + token}),
          data: {"title": model.title, "color": model.color});
      if (response.statusCode == 200) {
        categories.clear();
        getCategories();
      }
      return response.data;
    } on DioError catch (e) {
      //isSignIn = false;
      print(e);
    }
  }

//
// @action
// Future deleteCategory({required String? categoryUid}) async {
//   await _firestore
//       .collection(COLLECTION_CHARGES)
//       .doc(userId)
//       .collection(COLLECTION_USER_CATEGORIES)
//       .where('uid', isEqualTo: categoryUid)
//       .get()
//       .then((value) => value.docs.forEach((element) async {
//             element.reference.delete();
//             await _firestore
//                 .collection(COLLECTION_CHARGES)
//                 .doc(userId)
//                 .collection(COLLECTION_USER_CHARGES)
//                 .where('category_uid', isEqualTo: categoryUid)
//                 .get()
//                 .then((value1) => value1.docs.forEach((element1) {
//                       element1.reference.delete();
//                     }));
//           }));
// }

  @action
  Future deleteCategory({required int? categoryId}) async {
    String token = await _storage.read(
            key: 'token',
            iOptions: _getIOSOptions(),
            aOptions: _getAndroidOptions()) ??
        '';
    try {
      final response = await _dio.delete(
        'http://10.0.2.2:80/mt/default/delete',
        queryParameters: {"id": categoryId},
        options: Options(headers: {"Authorization": "Bearer " + token}),
      );
      if (response.statusCode == 200) {
        categories.clear();
        getCategories();
      }
      return response.data;
    } on DioError catch (e) {
      //isSignIn = false;
      print(e);
    }
  }

//
// @action
// Future createCharge({required ChargeModel model}) async {
//   await _firestore
//       .collection(COLLECTION_CHARGES)
//       .doc(userId)
//       .collection(COLLECTION_USER_CHARGES)
//       .add(model.toJson());
// }
  Future createCharge({required ChargeModel model}) async {
    return getToken().then((token) async {
      try {
        final response = await _dio.post('http://10.0.2.2:80/mt/charge/create',
            options: Options(headers: {"Authorization": "Bearer " + token}),
            data: {
              "categoryId": model.categoryId,
              "description": model.description,
              "cost": model.cost,
              "createdAt": model.createdAt.toString()
            });
        if (response.statusCode == 200) {
          categories.clear();
          getCategories();
          return response.data;
        }
        return response.data;
      } on DioError catch (e) {
        //isSignIn = false;
        print(e);
      }
    });
  }

//
// @action
// Future updateCharge(
//     {required String? chargeDocId, required ChargeModel model}) async {
//   await _firestore
//       .collection(COLLECTION_CHARGES)
//       .doc(userId)
//       .collection(COLLECTION_USER_CHARGES)
//       .doc(chargeDocId)
//       .update(model.toJson());
// }
//

  @action
  Future updateCharge({required ChargeModel model}) async {
    return getToken().then((token) async {
      try {
        final response = await _dio.put('http://10.0.2.2:80/mt/charge/update',
            queryParameters: {"id": model.id},
            options: Options(headers: {"Authorization": "Bearer " + token}),
            data: {
              "categoryId": model.categoryId,
              "description": model.description,
              "cost": model.cost,
              "createdAt": model.createdAt.toString()
            });
        if (response.statusCode == 200) {
          charges.clear();
          listChargesByCategory(categoryId: model.categoryId, currentDate: currentDate);
          return response.data;
        }
        return response.data;
      } on DioError catch (e) {
        //isSignIn = false;
        print(e);
      }
    });
  }

// @action
// Future deleteCharge({required String? chargeDocId}) async {
//   await _firestore
//       .collection(COLLECTION_CHARGES)
//       .doc(userId)
//       .collection(COLLECTION_USER_CHARGES)
//       .doc(chargeDocId)
//       .delete();
// }

  @action
  Future deleteCharge({required ChargeModel? chargeModel}) async {
    return getToken().then((token) async {
      try {
        final response = await _dio.delete(
          'http://10.0.2.2:80/mt/charge/delete',
          queryParameters: {"id": chargeModel?.id},
          options: Options(headers: {"Authorization": "Bearer " + token}),
        );
        if (response.statusCode == 200) {
          categories.clear();
          getCategories();

          charges.clear();
          if (chargeModel != null) {
            listChargesByCategory(
                categoryId: chargeModel.categoryId,
                currentDate: chargeModel.createdAt);
          }
          return response.data;
        }
        return response.data;
      } on DioError catch (e) {
        print(e);
      }
    });
  }

//
// @action
// Stream<List<HybridModel>> getCatWithTotal({required DateTime currentDate}) {
//   final DateTime datetimeFrom =
//       DateTime(currentDate.year, currentDate.month, 01, 00, 00, 00);
//   final DateTime datetimeTo = DateTime(
//       currentDate.year,
//       currentDate.month,
//       DateUtils.getDaysInMonth(currentDate.year, currentDate.month),
//       23,
//       59,
//       59);
//
//   Stream<List<CategoryModel>> query1 = _firestore
//       .collection(COLLECTION_CHARGES)
//       .doc(userId)
//       .collection(COLLECTION_USER_CATEGORIES)
//       .withConverter<CategoryModel>(
//         fromFirestore: (snapshot, _) =>
//             CategoryModel.fromJson(snapshot.data()!),
//         toFirestore: (user, _) => user.toJson(),
//       )
//       .snapshots()
//       .map((event) => event.docs.map((e) => e.data()).toList());
//
//   Stream<List<ChargeModel>> query2 = _firestore
//       .collection(COLLECTION_CHARGES)
//       .doc(userId)
//       .collection(COLLECTION_USER_CHARGES)
//       .where('created_at', isGreaterThanOrEqualTo: datetimeFrom)
//       .where('created_at', isLessThanOrEqualTo: datetimeTo)
//       .withConverter<ChargeModel>(
//         fromFirestore: (snapshot, _) =>
//             ChargeModel.fromJson(snapshot.data()!),
//         toFirestore: (user, _) => user.toJson(),
//       )
//       .snapshots()
//       .map((event) => event.docs.map((e) => e.data()).toList());
//
//   return Rx.combineLatest2(query1, query2,
//       (List<CategoryModel> categories, List<ChargeModel> charges) {
//     return categories.map((category) {
//       double total = 0;
//       charges.map((charge) {
//         if (charge.categoryId == category.id) {
//           total += charge.cost;
//         }
//       }).toList();
//       return HybridModel(category: category, cost: total);
//     }).toList();
//   }).delay(const Duration(milliseconds: 200));
// }
//
// @action
// Stream<List<QueryDocumentSnapshot<ChargeModel>>> listChargeByCategory(
//     {required String categoryUid, required DateTime currentDate}) {
//   final DateTime datetimeFrom =
//       DateTime(currentDate.year, currentDate.month, 01, 00, 00, 00);
//   final DateTime datetimeTo = DateTime(
//       currentDate.year,
//       currentDate.month,
//       DateUtils.getDaysInMonth(currentDate.year, currentDate.month),
//       23,
//       59,
//       59);
//
//   return _firestore
//       .collection(COLLECTION_CHARGES)
//       .doc(userId)
//       .collection(COLLECTION_USER_CHARGES)
//       .where('user_uid', isEqualTo: userId)
//       .where('category_uid', isEqualTo: categoryUid)
//       .where('created_at', isGreaterThanOrEqualTo: Timestamp.fromDate(datetimeFrom))
//       .where('created_at', isLessThanOrEqualTo: Timestamp.fromDate(datetimeTo))
//       .orderBy('created_at', descending: true)
//       .withConverter<ChargeModel>(
//         fromFirestore: (snapshot, _) =>
//             ChargeModel.fromJson(snapshot.data()!),
//         toFirestore: (user, _) => user.toJson(),
//       )
//       .snapshots()
//       .map((event) => event.docs).delay(const Duration(milliseconds: 200));
// }
//
  Future listChargesByCategory(
      {required categoryId, required DateTime currentDate}) async {
    return getToken().then((token) async {
      try {
        final response = await _dio.delete(
          'http://10.0.2.2:80/mt/charge/list',
          queryParameters: {"categoryId": categoryId, "date": currentDate},
          options: Options(headers: {"Authorization": "Bearer " + token}),
        );
        if (response.statusCode == 200) {
          charges.clear();
          response.data
              .map((json) => charges.add(ChargeModel.fromJson(json)))
              .toList();
          return charges;
        }
        return response.data;
      } on DioError catch (e) {
        print(e);
      }
    });
  }

// @action
// Future deleteAllData() async {
//   await _firestore
//       .collection(COLLECTION_CHARGES)
//       .doc(userId)
//       .collection(COLLECTION_USER_CATEGORIES)
//       .get()
//       .then(
//         (value) => value.docs.forEach(
//           (element) async {
//             element.reference.delete();
//           },
//         ),
//       );

  Future deleteAllData() async {
    return getToken().then((token) async {
      try {
        final response = await _dio.delete(
          'http://10.0.2.2:80/mt/default/delete-all',
          options: Options(headers: {"Authorization": "Bearer " + token}),
        );
        if (response.statusCode == 200) {
          categories.clear();
          getCategories();
        }
        return response.data;
      } on DioError catch (e) {
        //isSignIn = false;
        print(e);
      }
    });
  }

//
//   await _firestore
//       .collection(COLLECTION_CHARGES)
//       .doc(userId)
//       .collection(COLLECTION_USER_CHARGES)
//       .get()
//       .then(
//         (value) => value.docs.forEach(
//           (element) async {
//         element.reference.delete();
//       },
//     ),
//   );
// }
//
  @action
  Future<DateTime> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await dialogMonthPicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime.now(),
        round: 16.0);
    if (pickedDate != null && pickedDate != currentDate) {
      currentDate = pickedDate;
    }
    categories.clear();
    getCategories();
    return currentDate;
  }
}
