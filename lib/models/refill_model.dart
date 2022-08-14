import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:money_tracker/models/category_model.dart';

part 'refill_model.g.dart';

part 'refill_model.freezed.dart';

@freezed
class RefillModel with _$RefillModel {
  factory RefillModel({
    String? id,
    required String uid,
    @JsonKey(name: 'bill_id') required String billId,
    @JsonKey(name: 'bill_uid') required String billUid,
    @JsonKey(name: 'bill_title') required String billTitle,
    @JsonKey(name: 'user_uid') required String userUid,
    required double cost,
    @JsonKey(required: true, name: 'created_at', toJson: _pushTimeToJson, fromJson: _popTimeFromJson) createdAt
  }) = _RefillModel;

  const RefillModel._();

  factory RefillModel.fromJson(Map<String, dynamic> json) =>
      _$RefillModelFromJson(json);
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