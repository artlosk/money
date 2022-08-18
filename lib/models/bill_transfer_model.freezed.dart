// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'bill_transfer_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BillTransferModel _$BillTransferModelFromJson(Map<String, dynamic> json) {
  return _BillTransferModel.fromJson(json);
}

/// @nodoc
mixin _$BillTransferModel {
  String? get id => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_uid')
  String get userUid => throw _privateConstructorUsedError;
  @JsonKey(name: 'bill_uid_from')
  String get billUidFrom => throw _privateConstructorUsedError;
  @JsonKey(name: 'bill_uid_to')
  String get billUidTo => throw _privateConstructorUsedError;
  double get sum => throw _privateConstructorUsedError;
  double? get tax => throw _privateConstructorUsedError;
  @JsonKey(
      required: true,
      name: 'created_at',
      toJson: _pushTimeToJson,
      fromJson: _popTimeFromJson)
  dynamic get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BillTransferModelCopyWith<BillTransferModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BillTransferModelCopyWith<$Res> {
  factory $BillTransferModelCopyWith(
          BillTransferModel value, $Res Function(BillTransferModel) then) =
      _$BillTransferModelCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      String uid,
      @JsonKey(name: 'user_uid')
          String userUid,
      @JsonKey(name: 'bill_uid_from')
          String billUidFrom,
      @JsonKey(name: 'bill_uid_to')
          String billUidTo,
      double sum,
      double? tax,
      @JsonKey(required: true, name: 'created_at', toJson: _pushTimeToJson, fromJson: _popTimeFromJson)
          dynamic createdAt});
}

/// @nodoc
class _$BillTransferModelCopyWithImpl<$Res>
    implements $BillTransferModelCopyWith<$Res> {
  _$BillTransferModelCopyWithImpl(this._value, this._then);

  final BillTransferModel _value;
  // ignore: unused_field
  final $Res Function(BillTransferModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? uid = freezed,
    Object? userUid = freezed,
    Object? billUidFrom = freezed,
    Object? billUidTo = freezed,
    Object? sum = freezed,
    Object? tax = freezed,
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
      userUid: userUid == freezed
          ? _value.userUid
          : userUid // ignore: cast_nullable_to_non_nullable
              as String,
      billUidFrom: billUidFrom == freezed
          ? _value.billUidFrom
          : billUidFrom // ignore: cast_nullable_to_non_nullable
              as String,
      billUidTo: billUidTo == freezed
          ? _value.billUidTo
          : billUidTo // ignore: cast_nullable_to_non_nullable
              as String,
      sum: sum == freezed
          ? _value.sum
          : sum // ignore: cast_nullable_to_non_nullable
              as double,
      tax: tax == freezed
          ? _value.tax
          : tax // ignore: cast_nullable_to_non_nullable
              as double?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
abstract class _$$_BillTransferModelCopyWith<$Res>
    implements $BillTransferModelCopyWith<$Res> {
  factory _$$_BillTransferModelCopyWith(_$_BillTransferModel value,
          $Res Function(_$_BillTransferModel) then) =
      __$$_BillTransferModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      String uid,
      @JsonKey(name: 'user_uid')
          String userUid,
      @JsonKey(name: 'bill_uid_from')
          String billUidFrom,
      @JsonKey(name: 'bill_uid_to')
          String billUidTo,
      double sum,
      double? tax,
      @JsonKey(required: true, name: 'created_at', toJson: _pushTimeToJson, fromJson: _popTimeFromJson)
          dynamic createdAt});
}

/// @nodoc
class __$$_BillTransferModelCopyWithImpl<$Res>
    extends _$BillTransferModelCopyWithImpl<$Res>
    implements _$$_BillTransferModelCopyWith<$Res> {
  __$$_BillTransferModelCopyWithImpl(
      _$_BillTransferModel _value, $Res Function(_$_BillTransferModel) _then)
      : super(_value, (v) => _then(v as _$_BillTransferModel));

  @override
  _$_BillTransferModel get _value => super._value as _$_BillTransferModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? uid = freezed,
    Object? userUid = freezed,
    Object? billUidFrom = freezed,
    Object? billUidTo = freezed,
    Object? sum = freezed,
    Object? tax = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$_BillTransferModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      userUid: userUid == freezed
          ? _value.userUid
          : userUid // ignore: cast_nullable_to_non_nullable
              as String,
      billUidFrom: billUidFrom == freezed
          ? _value.billUidFrom
          : billUidFrom // ignore: cast_nullable_to_non_nullable
              as String,
      billUidTo: billUidTo == freezed
          ? _value.billUidTo
          : billUidTo // ignore: cast_nullable_to_non_nullable
              as String,
      sum: sum == freezed
          ? _value.sum
          : sum // ignore: cast_nullable_to_non_nullable
              as double,
      tax: tax == freezed
          ? _value.tax
          : tax // ignore: cast_nullable_to_non_nullable
              as double?,
      createdAt: createdAt == freezed ? _value.createdAt : createdAt,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BillTransferModel extends _BillTransferModel {
  _$_BillTransferModel(
      {this.id,
      required this.uid,
      @JsonKey(name: 'user_uid')
          required this.userUid,
      @JsonKey(name: 'bill_uid_from')
          required this.billUidFrom,
      @JsonKey(name: 'bill_uid_to')
          required this.billUidTo,
      required this.sum,
      required this.tax,
      @JsonKey(required: true, name: 'created_at', toJson: _pushTimeToJson, fromJson: _popTimeFromJson)
          this.createdAt})
      : super._();

  factory _$_BillTransferModel.fromJson(Map<String, dynamic> json) =>
      _$$_BillTransferModelFromJson(json);

  @override
  final String? id;
  @override
  final String uid;
  @override
  @JsonKey(name: 'user_uid')
  final String userUid;
  @override
  @JsonKey(name: 'bill_uid_from')
  final String billUidFrom;
  @override
  @JsonKey(name: 'bill_uid_to')
  final String billUidTo;
  @override
  final double sum;
  @override
  final double? tax;
  @override
  @JsonKey(
      required: true,
      name: 'created_at',
      toJson: _pushTimeToJson,
      fromJson: _popTimeFromJson)
  final dynamic createdAt;

  @override
  String toString() {
    return 'BillTransferModel(id: $id, uid: $uid, userUid: $userUid, billUidFrom: $billUidFrom, billUidTo: $billUidTo, sum: $sum, tax: $tax, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BillTransferModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.uid, uid) &&
            const DeepCollectionEquality().equals(other.userUid, userUid) &&
            const DeepCollectionEquality()
                .equals(other.billUidFrom, billUidFrom) &&
            const DeepCollectionEquality().equals(other.billUidTo, billUidTo) &&
            const DeepCollectionEquality().equals(other.sum, sum) &&
            const DeepCollectionEquality().equals(other.tax, tax) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(uid),
      const DeepCollectionEquality().hash(userUid),
      const DeepCollectionEquality().hash(billUidFrom),
      const DeepCollectionEquality().hash(billUidTo),
      const DeepCollectionEquality().hash(sum),
      const DeepCollectionEquality().hash(tax),
      const DeepCollectionEquality().hash(createdAt));

  @JsonKey(ignore: true)
  @override
  _$$_BillTransferModelCopyWith<_$_BillTransferModel> get copyWith =>
      __$$_BillTransferModelCopyWithImpl<_$_BillTransferModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BillTransferModelToJson(
      this,
    );
  }
}

abstract class _BillTransferModel extends BillTransferModel {
  factory _BillTransferModel(
      {final String? id,
      required final String uid,
      @JsonKey(name: 'user_uid')
          required final String userUid,
      @JsonKey(name: 'bill_uid_from')
          required final String billUidFrom,
      @JsonKey(name: 'bill_uid_to')
          required final String billUidTo,
      required final double sum,
      required final double? tax,
      @JsonKey(required: true, name: 'created_at', toJson: _pushTimeToJson, fromJson: _popTimeFromJson)
          final dynamic createdAt}) = _$_BillTransferModel;
  _BillTransferModel._() : super._();

  factory _BillTransferModel.fromJson(Map<String, dynamic> json) =
      _$_BillTransferModel.fromJson;

  @override
  String? get id;
  @override
  String get uid;
  @override
  @JsonKey(name: 'user_uid')
  String get userUid;
  @override
  @JsonKey(name: 'bill_uid_from')
  String get billUidFrom;
  @override
  @JsonKey(name: 'bill_uid_to')
  String get billUidTo;
  @override
  double get sum;
  @override
  double? get tax;
  @override
  @JsonKey(
      required: true,
      name: 'created_at',
      toJson: _pushTimeToJson,
      fromJson: _popTimeFromJson)
  dynamic get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$_BillTransferModelCopyWith<_$_BillTransferModel> get copyWith =>
      throw _privateConstructorUsedError;
}
