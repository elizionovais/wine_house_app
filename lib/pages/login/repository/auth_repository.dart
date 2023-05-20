import 'package:drink_store/app/consts/endpoints.dart';
import 'package:drink_store/app/models/user_model.dart';
import 'package:drink_store/app/untils/http_manager.dart';
import 'package:drink_store/pages/login/repository/auth_errors.dart';
import 'package:drink_store/pages/login/result/auth_result.dart';

class AuthRepository {
  HttpManager httpManager = HttpManager();

  Future<AuthResult> validateToken(String token) async {
    final response = await httpManager.request(
      url: EndPoint.validateToken,
      method: HttpRequests.post,
      headers: {
        "X-Parse-Session-Token": token,
      },
    );

    if (response['result'] != null) {
      final user = UserModel.fromJson(response['result']);
      return AuthResult.success(user);
    } else {
      return AuthResult.failure(authErrorsString(response['error']));
    }
  }

  Future<AuthResult> login({required String email, required String password}) async {
    final response = await httpManager.request(
      url: EndPoint.login,
      method: HttpRequests.post,
      body: {
        "email": email,
        "password": password,
      },
    );

    if (response['result'] != null) {
      final user = UserModel.fromJson(response['result']);
      return AuthResult.success(user);
    } else {
      return AuthResult.failure(authErrorsString(response['error']));
    }
  }

  Future<AuthResult> register({
    required UserModel user,
  }) async {
    final response = await httpManager.request(
      url: EndPoint.register,
      method: HttpRequests.post,
      body: user.toJson(),
    );

    if (response['result'] != null) {
      final user = UserModel.fromJson(response['result']);
      return AuthResult.success(user);
    } else {
      return AuthResult.failure(authErrorsString(response['error']));
    }
  }

  Future<void> resetPassword({required String email}) async {
    await httpManager.request(
      url: EndPoint.resetPassword,
      method: HttpRequests.post,
      body: {
        "email": email,
      },
    );
  }

  Future<bool> changePassword({
    required String token,
    required String email,
    required String currentPassword,
    required String newPassword,
  }) async {
    final response = await httpManager.request(
      url: EndPoint.changePassword,
      method: HttpRequests.post,
      headers: {
        "X-Parse-Session-Token": token,
      },
      body: {
        'email': email,
        'currentPassword': currentPassword,
        'newPassword': newPassword,
      },
    );

    return response['error'] == null;
  }
}
