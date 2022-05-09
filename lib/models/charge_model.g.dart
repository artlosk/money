// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'charge_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChargeModel _$$_ChargeModelFromJson(Map<String, dynamic> json) =>
    _$_ChargeModel(
      id: json['id'] as int?,
      categoryId: json['categoryId'] as int,
      description: json['description'] as String,
      cost: (json['cost'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$_ChargeModelToJson(_$_ChargeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'categoryId': instance.categoryId,
      'description': instance.description,
      'cost': instance.cost,
      'createdAt': instance.createdAt.toIso8601String(),
    };
