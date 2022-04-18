// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'hybrid_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

HybridModel _$HybridModelFromJson(Map<String, dynamic> json) {
  return _HybridModel.fromJson(json);
}

/// @nodoc
class _$HybridModelTearOff {
  const _$HybridModelTearOff();

  _HybridModel call({required CategoryModel category, required double cost}) {
    return _HybridModel(
      category: category,
      cost: cost,
    );
  }

  HybridModel fromJson(Map<String, Object?> json) {
    return HybridModel.fromJson(json);
  }
}

/// @nodoc
const $HybridModel = _$HybridModelTearOff();

/// @nodoc
mixin _$HybridModel {
  CategoryModel get category => throw _privateConstructorUsedError;
  double get cost => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HybridModelCopyWith<HybridModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HybridModelCopyWith<$Res> {
  factory $HybridModelCopyWith(
          HybridModel value, $Res Function(HybridModel) then) =
      _$HybridModelCopyWithImpl<$Res>;
  $Res call({CategoryModel category, double cost});

  $CategoryModelCopyWith<$Res> get category;
}

/// @nodoc
class _$HybridModelCopyWithImpl<$Res> implements $HybridModelCopyWith<$Res> {
  _$HybridModelCopyWithImpl(this._value, this._then);

  final HybridModel _value;
  // ignore: unused_field
  final $Res Function(HybridModel) _then;

  @override
  $Res call({
    Object? category = freezed,
    Object? cost = freezed,
  }) {
    return _then(_value.copyWith(
      category: category == freezed
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CategoryModel,
      cost: cost == freezed
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }

  @override
  $CategoryModelCopyWith<$Res> get category {
    return $CategoryModelCopyWith<$Res>(_value.category, (value) {
      return _then(_value.copyWith(category: value));
    });
  }
}

/// @nodoc
abstract class _$HybridModelCopyWith<$Res>
    implements $HybridModelCopyWith<$Res> {
  factory _$HybridModelCopyWith(
          _HybridModel value, $Res Function(_HybridModel) then) =
      __$HybridModelCopyWithImpl<$Res>;
  @override
  $Res call({CategoryModel category, double cost});

  @override
  $CategoryModelCopyWith<$Res> get category;
}

/// @nodoc
class __$HybridModelCopyWithImpl<$Res> extends _$HybridModelCopyWithImpl<$Res>
    implements _$HybridModelCopyWith<$Res> {
  __$HybridModelCopyWithImpl(
      _HybridModel _value, $Res Function(_HybridModel) _then)
      : super(_value, (v) => _then(v as _HybridModel));

  @override
  _HybridModel get _value => super._value as _HybridModel;

  @override
  $Res call({
    Object? category = freezed,
    Object? cost = freezed,
  }) {
    return _then(_HybridModel(
      category: category == freezed
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CategoryModel,
      cost: cost == freezed
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_HybridModel extends _HybridModel {
  _$_HybridModel({required this.category, required this.cost}) : super._();

  factory _$_HybridModel.fromJson(Map<String, dynamic> json) =>
      _$$_HybridModelFromJson(json);

  @override
  final CategoryModel category;
  @override
  final double cost;

  @override
  String toString() {
    return 'HybridModel(category: $category, cost: $cost)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HybridModel &&
            const DeepCollectionEquality().equals(other.category, category) &&
            const DeepCollectionEquality().equals(other.cost, cost));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(category),
      const DeepCollectionEquality().hash(cost));

  @JsonKey(ignore: true)
  @override
  _$HybridModelCopyWith<_HybridModel> get copyWith =>
      __$HybridModelCopyWithImpl<_HybridModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_HybridModelToJson(this);
  }
}

abstract class _HybridModel extends HybridModel {
  factory _HybridModel(
      {required CategoryModel category, required double cost}) = _$_HybridModel;
  _HybridModel._() : super._();

  factory _HybridModel.fromJson(Map<String, dynamic> json) =
      _$_HybridModel.fromJson;

  @override
  CategoryModel get category;
  @override
  double get cost;
  @override
  @JsonKey(ignore: true)
  _$HybridModelCopyWith<_HybridModel> get copyWith =>
      throw _privateConstructorUsedError;
}
