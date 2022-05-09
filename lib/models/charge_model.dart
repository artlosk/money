import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:money_tracker/models/category_model.dart';

part 'charge_model.g.dart';

part 'charge_model.freezed.dart';

@freezed
class ChargeModel with _$ChargeModel {
  factory ChargeModel({
    required int? id,
    required int categoryId,
    required String description,
    required double cost,
    required DateTime createdAt,
  }) = _ChargeModel;

  const ChargeModel._();

  factory ChargeModel.fromJson(Map<String, dynamic> json) =>
      _$ChargeModelFromJson(json);
}