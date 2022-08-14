// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refill_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RefillModel _$$_RefillModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['created_at'],
  );
  return _$_RefillModel(
    id: json['id'] as String?,
    uid: json['uid'] as String,
    billId: json['bill_id'] as String,
    billUid: json['bill_uid'] as String,
    billTitle: json['bill_title'] as String,
    userUid: json['user_uid'] as String,
    cost: (json['cost'] as num).toDouble(),
    createdAt: _popTimeFromJson(json['created_at'] as Timestamp),
  );
}

Map<String, dynamic> _$$_RefillModelToJson(_$_RefillModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'bill_id': instance.billId,
      'bill_uid': instance.billUid,
      'bill_title': instance.billTitle,
      'user_uid': instance.userUid,
      'cost': instance.cost,
      'created_at': _pushTimeToJson(instance.createdAt),
    };
