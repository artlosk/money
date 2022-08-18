import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:money_tracker/models/category_model.dart';

part 'bill_transfer_model.g.dart';

part 'bill_transfer_model.freezed.dart';

@freezed
class BillTransferModel with _$BillTransferModel {
  factory BillTransferModel({
    String? id,
    required String uid,
    @JsonKey(name: 'user_uid') required String userUid,
    @JsonKey(name: 'bill_uid_from') required String billUidFrom,
    @JsonKey(name: 'bill_uid_to') required String billUidTo,
    required double sum,
    required double? tax,
    @JsonKey(required: true, name: 'created_at', toJson: _pushTimeToJson, fromJson: _popTimeFromJson) createdAt
  }) = _BillTransferModel;

  const BillTransferModel._();

  factory BillTransferModel.fromJson(Map<String, dynamic> json) =>
      _$BillTransferModelFromJson(json);
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
