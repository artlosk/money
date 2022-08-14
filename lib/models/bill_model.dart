import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:money_tracker/models/category_model.dart';

part 'bill_model.g.dart';

part 'bill_model.freezed.dart';

@freezed
class BillModel with _$BillModel {
  factory BillModel({
    String? id,
    required String uid,
    @JsonKey(name: 'user_uid') required String userUid,
    required String title,
    required String type,
    required double totalSum,
  }) = _BillModel;

  const BillModel._();

  factory BillModel.fromJson(Map<String, dynamic> json) =>
      _$BillModelFromJson(json);
}
