// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hybrid_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_HybridModel _$$_HybridModelFromJson(Map<String, dynamic> json) =>
    _$_HybridModel(
      category:
          CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
      cost: (json['cost'] as num).toDouble(),
    );

Map<String, dynamic> _$$_HybridModelToJson(_$_HybridModel instance) =>
    <String, dynamic>{
      'category': instance.category,
      'cost': instance.cost,
    };
