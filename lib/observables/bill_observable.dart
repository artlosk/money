import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_tracker/models/bill_model.dart';
import 'package:money_tracker/models/category_model.dart';
import 'package:uuid/uuid.dart';

import '../components/dialogs/dialog_month_picker.dart';
import '../models/bill_transfer_model.dart';
import '../models/refill_model.dart';

part 'bill_observable.g.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

enum StoreState {loading, loaded}

class BillState = BillStateBase with _$BillState;

abstract class BillStateBase with Store {
  static const COLLECTION_CHARGES = 'charges';
  static const COLLECTION_USER_CATEGORIES = 'user_categories';
  static const COLLECTION_USER_CHARGES = 'user_charges';
  static const COLLECTION_USER_BILLS = 'user_bills';
  static const COLLECTION_USER_REFILLS = 'user_refills';
  static const COLLECTION_USER_TRANSFER = 'user_transfer';

  static const MESSAGE_ERROR_COLECTION_NOT_FOUND =
      'Коллекция не найдена или разорвана связь с сервером';

  BillStateBase({
    required this.userId,
  });

  final String userId;

  @observable
  DateTime currentDate = DateTime.now();

  @observable
  ObservableList<BillModel> bills = ObservableList<BillModel>();

  @observable
  bool billLoaded = false;

  @observable
  ObservableList<RefillModel> refills = ObservableList<RefillModel>();

  @observable
  bool refillLoaded = false;

  @observable
  ObservableList<BillTransferModel> transfers = ObservableList<BillTransferModel>();

  @observable
  bool transferLoaded = false;

  @observable
  double totalSum = 0.0;

  @observable
  double totalSumInMonth = 0.0;

  @action
  Future checkExistBill({required String title}) async {
    return await _firestore
        .collection(COLLECTION_CHARGES)
        .doc(userId)
        .collection(COLLECTION_USER_BILLS)
        .where('title', whereIn: [title])
        .withConverter<BillModel>(
          fromFirestore: (snapshot, _) => BillModel.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toJson(),
        )
        .get()
        .then((value) async {
          if (value.size > 0) {
            return true;
          }
          return false;
        });
  }

  @action
  Future createBill({required BillModel model}) async {
    await _firestore
        .collection(COLLECTION_CHARGES)
        .doc(userId)
        .collection(COLLECTION_USER_BILLS)
        .add(model.toJson())
        .then((value) async {
          value.update({'id' : value.id}).then((value) => getListBill());
    });
  }

  @action
  Future updateBill({required BillModel model}) async {
    await _firestore
        .collection(COLLECTION_CHARGES)
        .doc(userId)
        .collection(COLLECTION_USER_BILLS)
        .doc(model.id).update(model.toJson()).then((value) async {
      await getListBill();
    });
  }

  // @action
  // Future deleteBill({required String? billUid}) async {
  //   await _firestore
  //       .collection(COLLECTION_CHARGES)
  //       .doc(userId)
  //       .collection(COLLECTION_USER_BILLS)
  //       .where('uid', isEqualTo: billUid)
  //       .get()
  //       .then((value) => value.docs.forEach((element) async {
  //             element.reference.delete();
  //             await _firestore
  //                 .collection(COLLECTION_CHARGES)
  //                 .doc(userId)
  //                 .collection(COLLECTION_USER_CHARGES)
  //                 .where('category_uid', isEqualTo: billUid)
  //                 .get()
  //                 .then((value1) => value1.docs.forEach((element1) {
  //                       element1.reference.delete();
  //                     }));
  //           }));
  // }

  @action
  Future getListBill() async {
    billLoaded = false;
    await _firestore
        .collection(COLLECTION_CHARGES)
        .doc(userId)
        .collection(COLLECTION_USER_BILLS)
        .orderBy('id')
        .withConverter<BillModel>(
      fromFirestore: (snapshot, _) => BillModel.fromJson(snapshot.data()!),
      toFirestore: (user, _) => user.toJson(),
    ).get().then((value) {
      bills.clear();
      value.docs.map((e) async {
        var id = e.id;
        var data = e.data();
        bills.add(BillModel(
            id: id,
            uid: data.uid,
            userUid: data.userUid,
            title: data.title,
            type: data.type,
            totalSum: data.totalSum,
        ));
      }).toList();
    });
    billLoaded = true;
  }

  @action
  Future listAllRefill({required DateTime currentDate}) async {
    refillLoaded = false;
    final DateTime datetimeFrom =
    DateTime(currentDate.year, currentDate.month, 01, 00, 00, 00);
    final DateTime datetimeTo = DateTime(
        currentDate.year,
        currentDate.month,
        DateUtils.getDaysInMonth(currentDate.year, currentDate.month),
        23,
        59,
        59);

    await _firestore
        .collection(COLLECTION_CHARGES)
        .doc(userId)
        .collection(COLLECTION_USER_REFILLS)
        .where('user_uid', isEqualTo: userId)
        .where('created_at', isGreaterThanOrEqualTo: Timestamp.fromDate(datetimeFrom))
        .where('created_at', isLessThanOrEqualTo: Timestamp.fromDate(datetimeTo))
        .orderBy('created_at', descending: true)
        .withConverter<RefillModel>(fromFirestore: (snapshot, _) => RefillModel.fromJson(snapshot.data()!), toFirestore: (user, _) => user.toJson(),)
        .get().then((value) {
          refills.clear();
      value.docs.map((event) {
        var id = event.id;
        var data = event.data();
        refills.add(RefillModel(
            id: id,
            uid: data.uid,
            userUid: data.userUid,
            billId: data.billId,
            billTitle: data.billTitle,
            billUid: data.billUid,
            cost: data.cost,
            createdAt: data.createdAt,
        ));
      }).toList();
    });
    refillLoaded = true;
  }

  @action
  Future listRefillByUid(
      {required DateTime currentDate, required BillModel bill}) async {
    refillLoaded = false;
    final DateTime datetimeFrom =
    DateTime(currentDate.year, currentDate.month, 01, 00, 00, 00);
    final DateTime datetimeTo = DateTime(
        currentDate.year,
        currentDate.month,
        DateUtils.getDaysInMonth(currentDate.year, currentDate.month),
        23,
        59,
        59);

    await _firestore
        .collection(COLLECTION_CHARGES)
        .doc(userId)
        .collection(COLLECTION_USER_REFILLS)
        .where('user_uid', isEqualTo: userId)
        .where('created_at', isGreaterThanOrEqualTo: Timestamp.fromDate(datetimeFrom))
        .where('created_at', isLessThanOrEqualTo: Timestamp.fromDate(datetimeTo))
    .where('bill_uid', isEqualTo: bill.uid)
        .orderBy('created_at', descending: true)
        .withConverter<RefillModel>(fromFirestore: (snapshot, _) => RefillModel.fromJson(snapshot.data()!), toFirestore: (user, _) => user.toJson(),)
        .get().then((value) {
      refills.clear();
      value.docs.map((event) {
        var id = event.id;
        var data = event.data();
        refills.add(RefillModel(
          id: id,
          uid: data.uid,
          userUid: data.userUid,
          billId: data.billId,
          billTitle: data.billTitle,
          billUid: data.billUid,
          cost: data.cost,
          createdAt: data.createdAt,
        ));
      }).toList();
    });
    refillLoaded = true;
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

  @action
  Future refillAmountCreate({required RefillModel refillModel, required BillModel? bill}) async {
    // billLoaded = false;
    refillLoaded = false;
    await _firestore
        .collection(COLLECTION_CHARGES)
        .doc(userId)
        .collection(COLLECTION_USER_REFILLS)
        .add(refillModel.toJson())
    .then((value) async {
      value.update({'id' : value.id}).then((value) async {
          await _firestore
              .collection(COLLECTION_CHARGES)
              .doc(userId)
              .collection(COLLECTION_USER_BILLS)
              .doc(refillModel.billId)
              .update({"totalSum": FieldValue.increment(refillModel.cost)}).whenComplete(() async {
                if (bill != null) {
                  await getTotalSumByBill(billUid: refillModel.billUid);
                  await getTotalSumMonthByBill(billUid: refillModel.billUid);
                }
          });
      });
      // await getListBill().whenComplete(() async {
      //   if (bill != null) {
      //     await listRefillByUid(currentDate: currentDate, bill: bill);
      //   } else {
      //     await listAllRefill(currentDate: currentDate);
      //   }
      // });
      if (bill != null) {
        await listRefillByUid(currentDate: currentDate, bill: bill);
      } else {
        await listAllRefill(currentDate: currentDate);
      }
    });
  }

  @action
  Future refillAmountUpdate({required RefillModel refillModel, required double oldCost, required BillModel? bill}) async {
    refillLoaded = false;
    await _firestore
        .collection(COLLECTION_CHARGES)
        .doc(userId)
        .collection(COLLECTION_USER_REFILLS)
        .where('uid', whereIn: [refillModel.uid])
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
            .collection(COLLECTION_USER_REFILLS)
            .doc(e.id)
            .update(refillModel.toJson());
      }).toList();
    }).whenComplete(() async {
      await _firestore
          .collection(COLLECTION_CHARGES)
          .doc(userId)
          .collection(COLLECTION_USER_BILLS)
          .where('uid', whereIn: [refillModel.billUid])
          .withConverter<BillModel>(
        fromFirestore: (snapshot, _) => BillModel.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      )
          .get()
          .then((value) async {
        value.docs.map((e) async {


          double totalSum = e.data().totalSum - oldCost + refillModel.cost;
          await _firestore
              .collection(COLLECTION_CHARGES)
              .doc(userId)
              .collection(COLLECTION_USER_BILLS)
              .doc(e.id)
              .update({"totalSum": totalSum}).whenComplete(() async {
                if (bill != null) {
                  await listRefillByUid(currentDate: currentDate, bill: bill);
                } else {
                  await listAllRefill(currentDate: currentDate);
                }
          await getTotalSumMonthByBill(billUid: e.data().uid);
          await getTotalSumByBill(billUid: e.data().uid);
          });
        }).toList();
      });
    });
  }

  @action
  Future refillAmountDelete({required RefillModel? refillModel, required String? refillDocId, BillModel? bill}) async {
    refillLoaded = false;
      await _firestore
          .collection(COLLECTION_CHARGES)
          .doc(userId)
          .collection(COLLECTION_USER_REFILLS)
          .doc(refillDocId)
          .delete().whenComplete(() async {
        await _firestore
            .collection(COLLECTION_CHARGES)
            .doc(userId)
            .collection(COLLECTION_USER_BILLS)
            .where('uid', whereIn: [refillModel?.billUid])
            .withConverter<BillModel>(
          fromFirestore: (snapshot, _) => BillModel.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toJson(),
        )
            .get()
            .then((value) async {
          value.docs.map((e) async {

            double totalSum = e.data().totalSum - refillModel!.cost;
            await _firestore
                .collection(COLLECTION_CHARGES)
                .doc(userId)
                .collection(COLLECTION_USER_BILLS)
                .doc(e.id)
                .update({"totalSum": totalSum}).whenComplete(() async {
              // await getListBill();
            });
            if (bill != null) {
              await listRefillByUid(currentDate: currentDate, bill: bill);
            } else {
              await listAllRefill(currentDate: currentDate);
            }
            if (bill != null) {
              await getTotalSumMonthByBill(billUid: e
                  .data()
                  .uid);
              await getTotalSumByBill(billUid: e
                  .data()
                  .uid);
            }
          }).toList();
        });
      });
  }

  getTotalSumByBill({required String billUid}) async {
    await _firestore.collection(COLLECTION_CHARGES).doc(userId)
        .collection(COLLECTION_USER_REFILLS)
        .where('bill_uid', isEqualTo: billUid).withConverter<RefillModel>(
      fromFirestore: (snapshot, _) => RefillModel.fromJson(snapshot.data()!),
      toFirestore: (user, _) => user.toJson(),
    ).get().then((value) {
      totalSum = 0;
      value.docs.map((e) => totalSum += e.data().cost).toList();
    });
  }

  getTotalSumMonthByBill({required String billUid}) async {
    final DateTime datetimeFrom =
    DateTime(currentDate.year, currentDate.month, 01, 00, 00, 00);
    final DateTime datetimeTo = DateTime(
        currentDate.year,
        currentDate.month,
        DateUtils.getDaysInMonth(currentDate.year, currentDate.month),
        23,
        59,
        59);

    await _firestore.collection(COLLECTION_CHARGES).doc(userId)
        .collection(COLLECTION_USER_REFILLS)
        .where('bill_uid', isEqualTo: billUid)
        .where('created_at', isGreaterThanOrEqualTo: Timestamp.fromDate(datetimeFrom))
        .where('created_at', isLessThanOrEqualTo: Timestamp.fromDate(datetimeTo))
        .withConverter<RefillModel>(
      fromFirestore: (snapshot, _) => RefillModel.fromJson(snapshot.data()!),
      toFirestore: (user, _) => user.toJson(),
    ).get().then((value) {
      totalSumInMonth = 0;
      value.docs.map((e) => totalSumInMonth += e.data().cost).toList();
    });
  }

  transfer({required BillModel billFrom, required BillModel billTo, required double sum, required double tax}) async {
    BillTransferModel transferModel = BillTransferModel(
      uid: const Uuid().v1(),
      userUid: billFrom.userUid,
      billUidFrom: billFrom.uid,
      billUidTo: billTo.uid,
      sum: sum,
      tax: tax,
      createdAt: DateTime.now(),
    );
    await _firestore.collection(COLLECTION_CHARGES)
        .doc(userId)
        .collection(COLLECTION_USER_TRANSFER)
        .add(transferModel.toJson())
        .then((value) async {
      value.update({'id': value.id}).then((value) async {
        await _firestore.collection(COLLECTION_CHARGES).doc(userId).collection(
            COLLECTION_USER_BILLS).doc(billFrom.id).update(
            {'totalSum': FieldValue.increment(-(sum + tax))});
        await _firestore.collection(COLLECTION_CHARGES).doc(userId).collection(
            COLLECTION_USER_BILLS).doc(billTo.id).update(
            {'totalSum': FieldValue.increment(sum + tax)});
        await getListBill();
      });
    });
  }

  Future getTransferList({required DateTime currentDate}) async {
    transferLoaded = false;
    final DateTime datetimeFrom =
    DateTime(currentDate.year, currentDate.month, 01, 00, 00, 00);
    final DateTime datetimeTo = DateTime(
        currentDate.year,
        currentDate.month,
        DateUtils.getDaysInMonth(currentDate.year, currentDate.month),
        23,
        59,
        59);

    await _firestore
        .collection(COLLECTION_CHARGES)
        .doc(userId)
        .collection(COLLECTION_USER_TRANSFER)
        .where('created_at', isGreaterThanOrEqualTo: Timestamp.fromDate(datetimeFrom))
        .where('created_at', isLessThanOrEqualTo: Timestamp.fromDate(datetimeTo))
        .orderBy('created_at', descending: true)
        .withConverter<BillTransferModel>(
      fromFirestore: (snapshot, _) => BillTransferModel.fromJson(snapshot.data()!),
      toFirestore: (user, _) => user.toJson(),
    ).get().then((value) {
      transfers.clear();
      value.docs.map((e) {
        var data = e.data();
        transfers.add(BillTransferModel(
            id: data.id,
            uid: data.uid,
            userUid: data.userUid,
            billUidFrom: data.billUidFrom,
            billUidTo: data.billUidTo,
            sum: data.sum,
            tax: data.tax,
            createdAt: data.createdAt,
        ));
      }).toList();
    });
    transferLoaded = true;
  }
}
