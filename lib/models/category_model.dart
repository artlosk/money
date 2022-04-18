import 'package:freezed_annotation/freezed_annotation.dart';

import 'charge_model.dart';

part 'category_model.g.dart';

part 'category_model.freezed.dart';

@freezed
class CategoryModel with _$CategoryModel {

  factory CategoryModel({
    required String uid,
    required String title,
    required String color,
  }) = _CategoryModel;

  const CategoryModel._();

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
}
