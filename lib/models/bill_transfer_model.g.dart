// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_transfer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BillTransferModel _$$_BillTransferModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['created_at'],
  );
  return _$_BillTransferModel(
    id: json['id'] as String?,
    uid: json['uid'] as String,
    userUid: json['user_uid'] as String,
    billUidFrom: json['bill_uid_from'] as String,
    billUidTo: json['bill_uid_to'] as String,
    sum: (json['sum'] as num).toDouble(),
    tax: (json['tax'] as num?)?.toDouble(),
    createdAt: _popTimeFromJson(json['created_at'] as Timestamp),
  );
}

Map<String, dynamic> _$$_BillTransferModelToJson(
        _$_BillTransferModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'user_uid': instance.userUid,
      'bill_uid_from': instance.billUidFrom,
      'bill_uid_to': instance.billUidTo,
      'sum': instance.sum,
      'tax': instance.tax,
      'created_at': _pushTimeToJson(instance.createdAt),
    };
