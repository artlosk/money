import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_tracker/models/category_model.dart';
import 'package:money_tracker/models/hybrid_model.dart';
import 'package:rxdart/rxdart.dart';

import '../components/dialogs/dialog_month_picker.dart';
import '../models/charge_model.dart';

part 'charges_observable.g.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class ChargesState = ChargesStateBase with _$ChargesState;

abstract class ChargesStateBase with Store {
  static const COLLECTION_CHARGES = 'charges';
  static const COLLECTION_USER_CATEGORIES = 'user_categories';
  static const COLLECTION_USER_CHARGES = 'user_charges';
  static const COLLECTION_USER_BILLS = 'user_bills';

  static const MESSAGE_ERROR_COLECTION_NOT_FOUND =
      'Коллекция не найдена или разорвана связь с сервером';

  ChargesStateBase({
    required this.userId,
  });

  final String userId;

  @observable
  DateTime currentDate = DateTime.now();

  @action
  Future checkExistCategory({required String title}) async {
    return await _firestore
        .collection(COLLECTION_CHARGES)
        .doc(userId)
        .collection(COLLECTION_USER_CATEGORIES)
        .where('title', whereIn: [title])
        .withConverter<CategoryModel>(
          fromFirestore: (snapshot, _) => CategoryModel.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toJson(),
        ).get().then((value) async {
          if (value.size > 0) {
            return true;
          }
          return false;
        });
  }

  @action
  Future createCategory({required CategoryModel model}) async {
    await _firestore
        .collection(COLLECTION_CHARGES)
        .doc(userId)
        .collection(COLLECTION_USER_CATEGORIES)
        .add(model.toJson()).then((value) {
          value.update({'id' : value.id});
    });
  }

  @action
  Future updateCategory({required CategoryModel model}) async {
    await _firestore
        .collection(COLLECTION_CHARGES)
        .doc(userId)
        .collection(COLLECTION_USER_CATEGORIES)
        .where('uid', whereIn: [model.uid])
        .withConverter<CategoryModel>(
          fromFirestore: (snapshot, _) =>
              CategoryModel.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toJson(),
        )
        .get()
        .then((value) async {
          value.docs.map((e) async {
            await _firestore
                .collection(COLLECTION_CHARGES)
                .doc(userId)
                .collection(COLLECTION_USER_CATEGORIES)
                .doc(e.id)
                .update(model.toJson());
          }).toList();
        });
  }

  @action
  Future deleteCategory({required String? categoryUid}) async {
    await _firestore
        .collection(COLLECTION_CHARGES)
        .doc(userId)
        .collection(COLLECTION_USER_CATEGORIES)
        .where('uid', isEqualTo: categoryUid)
        .get()
        .then((value) => value.docs.forEach((element) async {
              element.reference.delete();
              await _firestore
                  .collection(COLLECTION_CHARGES)
                  .doc(userId)
                  .collection(COLLECTION_USER_CHARGES)
                  .where('category_uid', isEqualTo: categoryUid)
                  .get()
                  .then((value1) => value1.docs.forEach((element1) {
                        element1.reference.delete();
                      }));
            }));
  }

  @action
  Future createCharge({required ChargeModel model}) async {
    await _firestore
        .collection(COLLECTION_CHARGES)
        .doc(userId)
        .collection(COLLECTION_USER_CHARGES)
        .add(model.toJson()).then((value) async {
          value.update({'id': value.id}).whenComplete(() async {
      final bill = await _firestore
          .collection(COLLECTION_CHARGES)
          .doc(userId)
          .collection(COLLECTION_USER_BILLS)
          .where('uid', isEqualTo: model.billUid).limit(1).get().then((QuerySnapshot snapshot) => snapshot.docs[0].reference);
      await bill.update({'totalSum': FieldValue.increment(-model.cost)});
    });
    });
  }

  @action
  Future updateCharge(
      {required String? chargeDocId, required ChargeModel model, required double oldCost, required String? oldBillUid}) async {
    await _firestore
        .collection(COLLECTION_CHARGES)
        .doc(userId)
        .collection(COLLECTION_USER_CHARGES)
        .doc(chargeDocId)
        .withConverter<ChargeModel>(
      fromFirestore: (snapshot, _) =>
          ChargeModel.fromJson(snapshot.data()!),
      toFirestore: (user, _) => user.toJson(),
    ).update(model.toJson()).whenComplete(() async {
      if (model.billUid != oldBillUid) {
        final oldBillQuery = await _firestore
            .collection(COLLECTION_CHARGES)
            .doc(userId)
            .collection(COLLECTION_USER_BILLS)
            .where('uid', isEqualTo: oldBillUid)
            .limit(1)
            .get()
            .then((QuerySnapshot snapshot) => snapshot.docs[0].reference);
        await oldBillQuery.update({'totalSum': FieldValue.increment(oldCost)});

        final newBillQuery = await _firestore
            .collection(COLLECTION_CHARGES)
            .doc(userId)
            .collection(COLLECTION_USER_BILLS)
            .where('uid', isEqualTo: model.billUid)
            .limit(1)
            .get()
            .then((QuerySnapshot snapshot) => snapshot.docs[0].reference);
        await newBillQuery.update({'totalSum': FieldValue.increment(-model.cost)});
      } else {
        final billQuery = await _firestore
            .collection(COLLECTION_CHARGES)
            .doc(userId)
            .collection(COLLECTION_USER_BILLS)
            .where('uid', isEqualTo: model.billUid)
            .limit(1)
            .get()
            .then((QuerySnapshot snapshot) => snapshot.docs[0].reference);
            await billQuery.update({'totalSum': FieldValue.increment(oldCost - model.cost)});
      }
    });
  }

  @action
  Future deleteCharge({required String? chargeDocId, required double? chargeCost, required String? chargeBillUid}) async {
    await _firestore
        .collection(COLLECTION_CHARGES)
        .doc(userId)
        .collection(COLLECTION_USER_CHARGES)
        .doc(chargeDocId)
        .delete().whenComplete(() async {

          chargeCost ??= 0;
        final billQuery = await _firestore
            .collection(COLLECTION_CHARGES)
            .doc(userId)
            .collection(COLLECTION_USER_BILLS)
            .where('uid', isEqualTo: chargeBillUid)
            .limit(1)
            .get()
            .then((QuerySnapshot snapshot) => snapshot.docs[0].reference);
        await billQuery.update({'totalSum': FieldValue.increment(chargeCost!)});
    });
  }

  @action
  Stream<List<HybridModel>> getCatWithTotal({required DateTime currentDate}) {
    final DateTime datetimeFrom =
        DateTime(currentDate.year, currentDate.month, 01, 00, 00, 00);
    final DateTime datetimeTo = DateTime(
        currentDate.year,
        currentDate.month,
        DateUtils.getDaysInMonth(currentDate.year, currentDate.month),
        23,
        59,
        59);

    Stream<List<CategoryModel>> query1 = _firestore
        .collection(COLLECTION_CHARGES)
        .doc(userId)
        .collection(COLLECTION_USER_CATEGORIES)
        .withConverter<CategoryModel>(
          fromFirestore: (snapshot, _) =>
              CategoryModel.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toJson(),
        )
        .snapshots()
        .map((event) => event.docs.map((e) => e.data()).toList());

    Stream<List<ChargeModel>> query2 = _firestore
        .collection(COLLECTION_CHARGES)
        .doc(userId)
        .collection(COLLECTION_USER_CHARGES)
        .where('created_at', isGreaterThanOrEqualTo: datetimeFrom)
        .where('created_at', isLessThanOrEqualTo: datetimeTo)
        .withConverter<ChargeModel>(
          fromFirestore: (snapshot, _) =>
              ChargeModel.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toJson(),
        )
        .snapshots()
        .map((event) => event.docs.map((e) => e.data()).toList());

    return Rx.combineLatest2(query1, query2,
        (List<CategoryModel> categories, List<ChargeModel> charges) {
      return categories.map((category) {
        double total = 0;
        charges.map((charge) {
          if (charge.categoryUid == category.uid) {
            total += charge.cost;
          }
        }).toList();
        return HybridModel(category: category, cost: total);
      }).toList();
    }).delay(const Duration(milliseconds: 200));
  }

  @action
  Stream<List<QueryDocumentSnapshot<ChargeModel>>> listChargeByCategory(
      {required String categoryUid, required DateTime currentDate}) {
    final DateTime datetimeFrom =
        DateTime(currentDate.year, currentDate.month, 01, 00, 00, 00);
    final DateTime datetimeTo = DateTime(
        currentDate.year,
        currentDate.month,
        DateUtils.getDaysInMonth(currentDate.year, currentDate.month),
        23,
        59,
        59);

    return _firestore
        .collection(COLLECTION_CHARGES)
        .doc(userId)
        .collection(COLLECTION_USER_CHARGES)
        .where('user_uid', isEqualTo: userId)
        .where('category_uid', isEqualTo: categoryUid)
        .where('created_at', isGreaterThanOrEqualTo: Timestamp.fromDate(datetimeFrom))
        .where('created_at', isLessThanOrEqualTo: Timestamp.fromDate(datetimeTo))
        .orderBy('created_at', descending: true)
        .withConverter<ChargeModel>(
          fromFirestore: (snapshot, _) =>
              ChargeModel.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toJson(),
        )
        .snapshots()
        .map((event) => event.docs).delay(const Duration(milliseconds: 200));
  }

  @action
  Future deleteAllData() async {
    await _firestore
        .collection(COLLECTION_CHARGES)
        .doc(userId)
        .collection(COLLECTION_USER_CATEGORIES)
        .get()
        .then(
          (value) => value.docs.forEach(
            (element) async {
              element.reference.delete();
            },
          ),
        );

    await _firestore
        .collection(COLLECTION_CHARGES)
        .doc(userId)
        .collection(COLLECTION_USER_CHARGES)
        .get()
        .then(
          (value) => value.docs.forEach(
            (element) async {
          element.reference.delete();
        },
      ),
    );
  }

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
    return currentDate;
  }
}
