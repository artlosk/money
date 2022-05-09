import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.g.dart';

part 'user_model.freezed.dart';

@freezed
class UserModel with _$UserModel {

  factory UserModel({
    required int id,
    required String login,
    required String? image
  }) = _UserModel;

  const UserModel._();

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
