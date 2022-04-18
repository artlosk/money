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
    uid: json['uid'] as String,
    categoryUid: json['category_uid'] as String,
    userUid: json['user_uid'] as String,
    description: json['description'] as String,
    cost: (json['cost'] as num).toDouble(),
    createdAt: _popTimeFromJson(json['created_at'] as Timestamp),
  );
}

Map<String, dynamic> _$$_ChargeModelToJson(_$_ChargeModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'category_uid': instance.categoryUid,
      'user_uid': instance.userUid,
      'description': instance.description,
      'cost': instance.cost,
      'created_at': _pushTimeToJson(instance.createdAt),
    };
