// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'charge_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChargeModel _$$_ChargeModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['created_at'],
  );
  return _$_ChargeModel(
    id: json['id'] as String?,
    uid: json['uid'] as String,
    billUid: json['bill_uid'] as String?,
    billTitle: json['bill_title'] as String?,
    categoryUid: json['category_uid'] as String,
    userUid: json['user_uid'] as String,
    description: json['description'] as String,
    cost: (json['cost'] as num).toDouble(),
    createdAt: _popTimeFromJson(json['created_at'] as Timestamp),
  );
}

Map<String, dynamic> _$$_ChargeModelToJson(_$_ChargeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'bill_uid': instance.billUid,
      'bill_title': instance.billTitle,
      'category_uid': instance.categoryUid,
      'user_uid': instance.userUid,
      'description': instance.description,
      'cost': instance.cost,
      'created_at': _pushTimeToJson(instance.createdAt),
    };
