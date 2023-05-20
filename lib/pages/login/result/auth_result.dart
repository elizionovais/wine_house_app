import 'package:drink_store/app/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_result.freezed.dart';

@freezed
abstract class AuthResult with _$AuthResult {
  const factory AuthResult.success(UserModel user) = Success;
  const factory AuthResult.failure(String mensage) = Failure;
}