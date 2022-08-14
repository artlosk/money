// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'bill_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BillModel _$BillModelFromJson(Map<String, dynamic> json) {
  return _BillModel.fromJson(json);
}

/// @nodoc
mixin _$BillModel {
  String? get id => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_uid')
  String get userUid => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  double get totalSum => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BillModelCopyWith<BillModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BillModelCopyWith<$Res> {
  factory $BillModelCopyWith(BillModel value, $Res Function(BillModel) then) =
      _$BillModelCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      String uid,
      @JsonKey(name: 'user_uid') String userUid,
      String title,
      String type,
      double totalSum});
}

/// @nodoc
class _$BillModelCopyWithImpl<$Res> implements $BillModelCopyWith<$Res> {
  _$BillModelCopyWithImpl(this._value, this._then);

  final BillModel _value;
  // ignore: unused_field
  final $Res Function(BillModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? uid = freezed,
    Object? userUid = freezed,
    Object? title = freezed,
    Object? type = freezed,
    Object? totalSum = freezed,
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
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      totalSum: totalSum == freezed
          ? _value.totalSum
          : totalSum // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
abstract class _$$_BillModelCopyWith<$Res> implements $BillModelCopyWith<$Res> {
  factory _$$_BillModelCopyWith(
          _$_BillModel value, $Res Function(_$_BillModel) then) =
      __$$_BillModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      String uid,
      @JsonKey(name: 'user_uid') String userUid,
      String title,
      String type,
      double totalSum});
}

/// @nodoc
class __$$_BillModelCopyWithImpl<$Res> extends _$BillModelCopyWithImpl<$Res>
    implements _$$_BillModelCopyWith<$Res> {
  __$$_BillModelCopyWithImpl(
      _$_BillModel _value, $Res Function(_$_BillModel) _then)
      : super(_value, (v) => _then(v as _$_BillModel));

  @override
  _$_BillModel get _value => super._value as _$_BillModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? uid = freezed,
    Object? userUid = freezed,
    Object? title = freezed,
    Object? type = freezed,
    Object? totalSum = freezed,
  }) {
    return _then(_$_BillModel(
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
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      totalSum: totalSum == freezed
          ? _value.totalSum
          : totalSum // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BillModel extends _BillModel {
  _$_BillModel(
      {this.id,
      required this.uid,
      @JsonKey(name: 'user_uid') required this.userUid,
      required this.title,
      required this.type,
      required this.totalSum})
      : super._();

  factory _$_BillModel.fromJson(Map<String, dynamic> json) =>
      _$$_BillModelFromJson(json);

  @override
  final String? id;
  @override
  final String uid;
  @override
  @JsonKey(name: 'user_uid')
  final String userUid;
  @override
  final String title;
  @override
  final String type;
  @override
  final double totalSum;

  @override
  String toString() {
    return 'BillModel(id: $id, uid: $uid, userUid: $userUid, title: $title, type: $type, totalSum: $totalSum)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BillModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.uid, uid) &&
            const DeepCollectionEquality().equals(other.userUid, userUid) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other.totalSum, totalSum));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(uid),
      const DeepCollectionEquality().hash(userUid),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(totalSum));

  @JsonKey(ignore: true)
  @override
  _$$_BillModelCopyWith<_$_BillModel> get copyWith =>
      __$$_BillModelCopyWithImpl<_$_BillModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BillModelToJson(
      this,
    );
  }
}

abstract class _BillModel extends BillModel {
  factory _BillModel(
      {final String? id,
      required final String uid,
      @JsonKey(name: 'user_uid') required final String userUid,
      required final String title,
      required final String type,
      required final double totalSum}) = _$_BillModel;
  _BillModel._() : super._();

  factory _BillModel.fromJson(Map<String, dynamic> json) =
      _$_BillModel.fromJson;

  @override
  String? get id;
  @override
  String get uid;
  @override
  @JsonKey(name: 'user_uid')
  String get userUid;
  @override
  String get title;
  @override
  String get type;
  @override
  double get totalSum;
  @override
  @JsonKey(ignore: true)
  _$$_BillModelCopyWith<_$_BillModel> get copyWith =>
      throw _privateConstructorUsedError;
}
