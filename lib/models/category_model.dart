import 'package:freezed_annotation/freezed_annotation.dart';

import 'charge_model.dart';

part 'category_model.g.dart';

part 'category_model.freezed.dart';

@freezed
class CategoryModel with _$CategoryModel {

  factory CategoryModel({
    //@JsonKey(name: "id", fromJson: CategoryModel._stringToInt, toJson: CategoryModel._stringFromInt) required int? id,
    required int? id,
    required String title,
    required String color,
  }) = _CategoryModel;

  const CategoryModel._();

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  static int? _stringToInt(String? number) => number == null ? null : int.tryParse(number);
  static String? _stringFromInt(int? number) => number?.toString();
}
