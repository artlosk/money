import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money_tracker/models/category_model.dart';

import 'hybrid_model.dart';

part 'hybrid_model.g.dart';

part 'hybrid_model.freezed.dart';

@freezed
class HybridModel with _$HybridModel {

  factory HybridModel({
    required CategoryModel category,
    required double cost,
  }) = _HybridModel;

  const HybridModel._();

  factory HybridModel.fromJson(Map<String, dynamic> json) =>
      _$HybridModelFromJson(json);
}
