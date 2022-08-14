// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'refill_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RefillModel _$RefillModelFromJson(Map<String, dynamic> json) {
  return _RefillModel.fromJson(json);
}

/// @nodoc
mixin _$RefillModel {
  String? get id => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  @JsonKey(name: 'bill_id')
  String get billId => throw _privateConstructorUsedError;
  @JsonKey(name: 'bill_uid')
  String get billUid => throw _privateConstructorUsedError;
  @JsonKey(name: 'bill_title')
  String get billTitle => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_uid')
  String get userUid => throw _privateConstructorUsedError;
  double get cost => throw _privateConstructorUsedError;
  @JsonKey(
      required: true,
      name: 'created_at',
      toJson: _pushTimeToJson,
      fromJson: _popTimeFromJson)
  dynamic get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RefillModelCopyWith<RefillModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RefillModelCopyWith<$Res> {
  factory $RefillModelCopyWith(
          RefillModel value, $Res Function(RefillModel) then) =
      _$RefillModelCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      String uid,
      @JsonKey(name: 'bill_id')
          String billId,
      @JsonKey(name: 'bill_uid')
          String billUid,
      @JsonKey(name: 'bill_title')
          String billTitle,
      @JsonKey(name: 'user_uid')
          String userUid,
      double cost,
      @JsonKey(required: true, name: 'created_at', toJson: _pushTimeToJson, fromJson: _popTimeFromJson)
          dynamic createdAt});
}

/// @nodoc
class _$RefillModelCopyWithImpl<$Res> implements $RefillModelCopyWith<$Res> {
  _$RefillModelCopyWithImpl(this._value, this._then);

  final RefillModel _value;
  // ignore: unused_field
  final $Res Function(RefillModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? uid = freezed,
    Object? billId = freezed,
    Object? billUid = freezed,
    Object? billTitle = freezed,
    Object? userUid = freezed,
    Object? cost = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      billId: billId == freezed
          ? _value.billId
          : billId // ignore: cast_nullable_to_non_nullable
              as String,
      billUid: billUid == freezed
          ? _value.billUid
          : billUid // ignore: cast_nullable_to_non_nullable
              as String,
      billTitle: billTitle == freezed
          ? _value.billTitle
          : billTitle // ignore: cast_nullable_to_non_nullable
              as String,
      userUid: userUid == freezed
          ? _value.userUid
          : userUid // ignore: cast_nullable_to_non_nullable
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
abstract class _$$_RefillModelCopyWith<$Res>
    implements $RefillModelCopyWith<$Res> {
  factory _$$_RefillModelCopyWith(
          _$_RefillModel value, $Res Function(_$_RefillModel) then) =
      __$$_RefillModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      String uid,
      @JsonKey(name: 'bill_id')
          String billId,
      @JsonKey(name: 'bill_uid')
          String billUid,
      @JsonKey(name: 'bill_title')
          String billTitle,
      @JsonKey(name: 'user_uid')
          String userUid,
      double cost,
      @JsonKey(required: true, name: 'created_at', toJson: _pushTimeToJson, fromJson: _popTimeFromJson)
          dynamic createdAt});
}

/// @nodoc
class __$$_RefillModelCopyWithImpl<$Res> extends _$RefillModelCopyWithImpl<$Res>
    implements _$$_RefillModelCopyWith<$Res> {
  __$$_RefillModelCopyWithImpl(
      _$_RefillModel _value, $Res Function(_$_RefillModel) _then)
      : super(_value, (v) => _then(v as _$_RefillModel));

  @override
  _$_RefillModel get _value => super._value as _$_RefillModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? uid = freezed,
    Object? billId = freezed,
    Object? billUid = freezed,
    Object? billTitle = freezed,
    Object? userUid = freezed,
    Object? cost = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$_RefillModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      billId: billId == freezed
          ? _value.billId
          : billId // ignore: cast_nullable_to_non_nullable
              as String,
      billUid: billUid == freezed
          ? _value.billUid
          : billUid // ignore: cast_nullable_to_non_nullable
              as String,
      billTitle: billTitle == freezed
          ? _value.billTitle
          : billTitle // ignore: cast_nullable_to_non_nullable
              as String,
      userUid: userUid == freezed
          ? _value.userUid
          : userUid // ignore: cast_nullable_to_non_nullable
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
class _$_RefillModel extends _RefillModel {
  _$_RefillModel(
      {this.id,
      required this.uid,
      @JsonKey(name: 'bill_id')
          required this.billId,
      @JsonKey(name: 'bill_uid')
          required this.billUid,
      @JsonKey(name: 'bill_title')
          required this.billTitle,
      @JsonKey(name: 'user_uid')
          required this.userUid,
      required this.cost,
      @JsonKey(required: true, name: 'created_at', toJson: _pushTimeToJson, fromJson: _popTimeFromJson)
          this.createdAt})
      : super._();

  factory _$_RefillModel.fromJson(Map<String, dynamic> json) =>
      _$$_RefillModelFromJson(json);

  @override
  final String? id;
  @override
  final String uid;
  @override
  @JsonKey(name: 'bill_id')
  final String billId;
  @override
  @JsonKey(name: 'bill_uid')
  final String billUid;
  @override
  @JsonKey(name: 'bill_title')
  final String billTitle;
  @override
  @JsonKey(name: 'user_uid')
  final String userUid;
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
    return 'RefillModel(id: $id, uid: $uid, billId: $billId, billUid: $billUid, billTitle: $billTitle, userUid: $userUid, cost: $cost, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RefillModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.uid, uid) &&
            const DeepCollectionEquality().equals(other.billId, billId) &&
            const DeepCollectionEquality().equals(other.billUid, billUid) &&
            const DeepCollectionEquality().equals(other.billTitle, billTitle) &&
            const DeepCollectionEquality().equals(other.userUid, userUid) &&
            const DeepCollectionEquality().equals(other.cost, cost) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(uid),
      const DeepCollectionEquality().hash(billId),
      const DeepCollectionEquality().hash(billUid),
      const DeepCollectionEquality().hash(billTitle),
      const DeepCollectionEquality().hash(userUid),
      const DeepCollectionEquality().hash(cost),
      const DeepCollectionEquality().hash(createdAt));

  @JsonKey(ignore: true)
  @override
  _$$_RefillModelCopyWith<_$_RefillModel> get copyWith =>
      __$$_RefillModelCopyWithImpl<_$_RefillModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RefillModelToJson(
      this,
    );
  }
}

abstract class _RefillModel extends RefillModel {
  factory _RefillModel(
      {final String? id,
      required final String uid,
      @JsonKey(name: 'bill_id')
          required final String billId,
      @JsonKey(name: 'bill_uid')
          required final String billUid,
      @JsonKey(name: 'bill_title')
          required final String billTitle,
      @JsonKey(name: 'user_uid')
          required final String userUid,
      required final double cost,
      @JsonKey(required: true, name: 'created_at', toJson: _pushTimeToJson, fromJson: _popTimeFromJson)
          final dynamic createdAt}) = _$_RefillModel;
  _RefillModel._() : super._();

  factory _RefillModel.fromJson(Map<String, dynamic> json) =
      _$_RefillModel.fromJson;

  @override
  String? get id;
  @override
  String get uid;
  @override
  @JsonKey(name: 'bill_id')
  String get billId;
  @override
  @JsonKey(name: 'bill_uid')
  String get billUid;
  @override
  @JsonKey(name: 'bill_title')
  String get billTitle;
  @override
  @JsonKey(name: 'user_uid')
  String get userUid;
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
  _$$_RefillModelCopyWith<_$_RefillModel> get copyWith =>
      throw _privateConstructorUsedError;
}
