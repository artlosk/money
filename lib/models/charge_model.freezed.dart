// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'charge_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChargeModel _$ChargeModelFromJson(Map<String, dynamic> json) {
  return _ChargeModel.fromJson(json);
}

/// @nodoc
class _$ChargeModelTearOff {
  const _$ChargeModelTearOff();

  _ChargeModel call(
      {required String uid,
      @JsonKey(name: 'category_uid')
          required String categoryUid,
      @JsonKey(name: 'user_uid')
          required String userUid,
      required String description,
      required double cost,
      @JsonKey(required: true, name: 'created_at', toJson: _pushTimeToJson, fromJson: _popTimeFromJson)
          dynamic createdAt}) {
    return _ChargeModel(
      uid: uid,
      categoryUid: categoryUid,
      userUid: userUid,
      description: description,
      cost: cost,
      createdAt: createdAt,
    );
  }

  ChargeModel fromJson(Map<String, Object?> json) {
    return ChargeModel.fromJson(json);
  }
}

/// @nodoc
const $ChargeModel = _$ChargeModelTearOff();

/// @nodoc
mixin _$ChargeModel {
  String get uid => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_uid')
  String get categoryUid => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_uid')
  String get userUid => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  double get cost => throw _privateConstructorUsedError;
  @JsonKey(
      required: true,
      name: 'created_at',
      toJson: _pushTimeToJson,
      fromJson: _popTimeFromJson)
  dynamic get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChargeModelCopyWith<ChargeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChargeModelCopyWith<$Res> {
  factory $ChargeModelCopyWith(
          ChargeModel value, $Res Function(ChargeModel) then) =
      _$ChargeModelCopyWithImpl<$Res>;
  $Res call(
      {String uid,
      @JsonKey(name: 'category_uid')
          String categoryUid,
      @JsonKey(name: 'user_uid')
          String userUid,
      String description,
      double cost,
      @JsonKey(required: true, name: 'created_at', toJson: _pushTimeToJson, fromJson: _popTimeFromJson)
          dynamic createdAt});
}

/// @nodoc
class _$ChargeModelCopyWithImpl<$Res> implements $ChargeModelCopyWith<$Res> {
  _$ChargeModelCopyWithImpl(this._value, this._then);

  final ChargeModel _value;
  // ignore: unused_field
  final $Res Function(ChargeModel) _then;

  @override
  $Res call({
    Object? uid = freezed,
    Object? categoryUid = freezed,
    Object? userUid = freezed,
    Object? description = freezed,
    Object? cost = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      categoryUid: categoryUid == freezed
          ? _value.categoryUid
          : categoryUid // ignore: cast_nullable_to_non_nullable
              as String,
      userUid: userUid == freezed
          ? _value.userUid
          : userUid // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      cost: cost == freezed
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
abstract class _$ChargeModelCopyWith<$Res>
    implements $ChargeModelCopyWith<$Res> {
  factory _$ChargeModelCopyWith(
          _ChargeModel value, $Res Function(_ChargeModel) then) =
      __$ChargeModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String uid,
      @JsonKey(name: 'category_uid')
          String categoryUid,
      @JsonKey(name: 'user_uid')
          String userUid,
      String description,
      double cost,
      @JsonKey(required: true, name: 'created_at', toJson: _pushTimeToJson, fromJson: _popTimeFromJson)
          dynamic createdAt});
}

/// @nodoc
class __$ChargeModelCopyWithImpl<$Res> extends _$ChargeModelCopyWithImpl<$Res>
    implements _$ChargeModelCopyWith<$Res> {
  __$ChargeModelCopyWithImpl(
      _ChargeModel _value, $Res Function(_ChargeModel) _then)
      : super(_value, (v) => _then(v as _ChargeModel));

  @override
  _ChargeModel get _value => super._value as _ChargeModel;

  @override
  $Res call({
    Object? uid = freezed,
    Object? categoryUid = freezed,
    Object? userUid = freezed,
    Object? description = freezed,
    Object? cost = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_ChargeModel(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      categoryUid: categoryUid == freezed
          ? _value.categoryUid
          : categoryUid // ignore: cast_nullable_to_non_nullable
              as String,
      userUid: userUid == freezed
          ? _value.userUid
          : userUid // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      cost: cost == freezed
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: createdAt == freezed ? _value.createdAt : createdAt,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ChargeModel extends _ChargeModel {
  _$_ChargeModel(
      {required this.uid,
      @JsonKey(name: 'category_uid')
          required this.categoryUid,
      @JsonKey(name: 'user_uid')
          required this.userUid,
      required this.description,
      required this.cost,
      @JsonKey(required: true, name: 'created_at', toJson: _pushTimeToJson, fromJson: _popTimeFromJson)
          this.createdAt})
      : super._();

  factory _$_ChargeModel.fromJson(Map<String, dynamic> json) =>
      _$$_ChargeModelFromJson(json);

  @override
  final String uid;
  @override
  @JsonKey(name: 'category_uid')
  final String categoryUid;
  @override
  @JsonKey(name: 'user_uid')
  final String userUid;
  @override
  final String description;
  @override
  final double cost;
  @override
  @JsonKey(
      required: true,
      name: 'created_at',
      toJson: _pushTimeToJson,
      fromJson: _popTimeFromJson)
  final dynamic createdAt;

  @override
  String toString() {
    return 'ChargeModel(uid: $uid, categoryUid: $categoryUid, userUid: $userUid, description: $description, cost: $cost, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ChargeModel &&
            const DeepCollectionEquality().equals(other.uid, uid) &&
            const DeepCollectionEquality()
                .equals(other.categoryUid, categoryUid) &&
            const DeepCollectionEquality().equals(other.userUid, userUid) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.cost, cost) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(uid),
      const DeepCollectionEquality().hash(categoryUid),
      const DeepCollectionEquality().hash(userUid),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(cost),
      const DeepCollectionEquality().hash(createdAt));

  @JsonKey(ignore: true)
  @override
  _$ChargeModelCopyWith<_ChargeModel> get copyWith =>
      __$ChargeModelCopyWithImpl<_ChargeModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChargeModelToJson(this);
  }
}

abstract class _ChargeModel extends ChargeModel {
  factory _ChargeModel(
      {required String uid,
      @JsonKey(name: 'category_uid')
          required String categoryUid,
      @JsonKey(name: 'user_uid')
          required String userUid,
      required String description,
      required double cost,
      @JsonKey(required: true, name: 'created_at', toJson: _pushTimeToJson, fromJson: _popTimeFromJson)
          dynamic createdAt}) = _$_ChargeModel;
  _ChargeModel._() : super._();

  factory _ChargeModel.fromJson(Map<String, dynamic> json) =
      _$_ChargeModel.fromJson;

  @override
  String get uid;
  @override
  @JsonKey(name: 'category_uid')
  String get categoryUid;
  @override
  @JsonKey(name: 'user_uid')
  String get userUid;
  @override
  String get description;
  @override
  double get cost;
  @override
  @JsonKey(
      required: true,
      name: 'created_at',
      toJson: _pushTimeToJson,
      fromJson: _popTimeFromJson)
  dynamic get createdAt;
  @override
  @JsonKey(ignore: true)
  _$ChargeModelCopyWith<_ChargeModel> get copyWith =>
      throw _privateConstructorUsedError;
}
