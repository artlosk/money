// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'category_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) {
  return _CategoryModel.fromJson(json);
}

/// @nodoc
class _$CategoryModelTearOff {
  const _$CategoryModelTearOff();

  _CategoryModel call(
      {required String uid, required String title, required String color}) {
    return _CategoryModel(
      uid: uid,
      title: title,
      color: color,
    );
  }

  CategoryModel fromJson(Map<String, Object?> json) {
    return CategoryModel.fromJson(json);
  }
}

/// @nodoc
const $CategoryModel = _$CategoryModelTearOff();

/// @nodoc
mixin _$CategoryModel {
  String get uid => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get color => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CategoryModelCopyWith<CategoryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryModelCopyWith<$Res> {
  factory $CategoryModelCopyWith(
          CategoryModel value, $Res Function(CategoryModel) then) =
      _$CategoryModelCopyWithImpl<$Res>;
  $Res call({String uid, String title, String color});
}

/// @nodoc
class _$CategoryModelCopyWithImpl<$Res>
    implements $CategoryModelCopyWith<$Res> {
  _$CategoryModelCopyWithImpl(this._value, this._then);

  final CategoryModel _value;
  // ignore: unused_field
  final $Res Function(CategoryModel) _then;

  @override
  $Res call({
    Object? uid = freezed,
    Object? title = freezed,
    Object? color = freezed,
  }) {
    return _then(_value.copyWith(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$CategoryModelCopyWith<$Res>
    implements $CategoryModelCopyWith<$Res> {
  factory _$CategoryModelCopyWith(
          _CategoryModel value, $Res Function(_CategoryModel) then) =
      __$CategoryModelCopyWithImpl<$Res>;
  @override
  $Res call({String uid, String title, String color});
}

/// @nodoc
class __$CategoryModelCopyWithImpl<$Res>
    extends _$CategoryModelCopyWithImpl<$Res>
    implements _$CategoryModelCopyWith<$Res> {
  __$CategoryModelCopyWithImpl(
      _CategoryModel _value, $Res Function(_CategoryModel) _then)
      : super(_value, (v) => _then(v as _CategoryModel));

  @override
  _CategoryModel get _value => super._value as _CategoryModel;

  @override
  $Res call({
    Object? uid = freezed,
    Object? title = freezed,
    Object? color = freezed,
  }) {
    return _then(_CategoryModel(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CategoryModel extends _CategoryModel {
  _$_CategoryModel(
      {required this.uid, required this.title, required this.color})
      : super._();

  factory _$_CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$$_CategoryModelFromJson(json);

  @override
  final String uid;
  @override
  final String title;
  @override
  final String color;

  @override
  String toString() {
    return 'CategoryModel(uid: $uid, title: $title, color: $color)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CategoryModel &&
            const DeepCollectionEquality().equals(other.uid, uid) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.color, color));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(uid),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(color));

  @JsonKey(ignore: true)
  @override
  _$CategoryModelCopyWith<_CategoryModel> get copyWith =>
      __$CategoryModelCopyWithImpl<_CategoryModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CategoryModelToJson(this);
  }
}

abstract class _CategoryModel extends CategoryModel {
  factory _CategoryModel(
      {required String uid,
      required String title,
      required String color}) = _$_CategoryModel;
  _CategoryModel._() : super._();

  factory _CategoryModel.fromJson(Map<String, dynamic> json) =
      _$_CategoryModel.fromJson;

  @override
  String get uid;
  @override
  String get title;
  @override
  String get color;
  @override
  @JsonKey(ignore: true)
  _$CategoryModelCopyWith<_CategoryModel> get copyWith =>
      throw _privateConstructorUsedError;
}
