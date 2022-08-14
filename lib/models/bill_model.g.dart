// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BillModel _$$_BillModelFromJson(Map<String, dynamic> json) => _$_BillModel(
      id: json['id'] as String?,
      uid: json['uid'] as String,
      userUid: json['user_uid'] as String,
      title: json['title'] as String,
      type: json['type'] as String,
      totalSum: (json['totalSum'] as num).toDouble(),
    );

Map<String, dynamic> _$$_BillModelToJson(_$_BillModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'user_uid': instance.userUid,
      'title': instance.title,
      'type': instance.type,
      'totalSum': instance.totalSum,
    };
