import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:money_tracker/models/category_model.dart';

part 'charge_model.g.dart';

part 'charge_model.freezed.dart';

@freezed
class ChargeModel with _$ChargeModel {
  factory ChargeModel({
    String? id,
    required String uid,
    @JsonKey(name: 'bill_uid') required String? billUid,
    @JsonKey(name: 'bill_title') required String? billTitle,
    @JsonKey(name: 'category_uid') required String categoryUid,
    @JsonKey(name: 'user_uid') required String userUid,
    required String description,
    required double cost,
    @JsonKey(required: true, name: 'created_at', toJson: _pushTimeToJson, fromJson: _popTimeFromJson) createdAt
  }) = _ChargeModel;

  const ChargeModel._();

  factory ChargeModel.fromJson(Map<String, dynamic> json) =>
      _$ChargeModelFromJson(json);
}

Timestamp _pushTimeToJson(DateTime date) => Timestamp.fromDate(date);
DateTime _popTimeFromJson(Timestamp date) => date.toDate();

class DocumentSerializerNullable
    implements JsonConverter<DocumentReference?, DocumentReference?> {
  const DocumentSerializerNullable();

  @override
  DocumentReference? fromJson(DocumentReference? docRef) => docRef;

  @override
  DocumentReference? toJson(DocumentReference? docRef) => docRef;
}