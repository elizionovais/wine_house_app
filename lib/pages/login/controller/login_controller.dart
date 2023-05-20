import 'package:drink_store/app/models/user_model.dart';
import 'package:drink_store/app/routes/app_routes.dart';
import 'package:drink_store/app/untils/untils_price.dart';
import 'package:drink_store/pages/login/repository/auth_repository.dart';
import 'package:get/get.dart';

import '../result/auth_result.dart';

class LoginController extends GetxController {
  RxBool isLogin = false.obs;

  final authRepository = AuthRepository();
  final UntilPrice untilPrice = UntilPrice();
  UserModel user = UserModel();

  @override
  void onInit() {
    super.onInit();
    validateToken();
  }




  Future<void> validateToken() async {
    String? token = await untilPrice.getLocalData(key: 'token');
    if (token == null) {
      Get.offAllNamed(AppRoutes.login);
      return;
    }
    AuthResult result = await authRepository.validateToken(token);
    result.when(
      success: (user) {
        this.user = user;
        savedToken();
      },
      failure: (message) {
        logout();
      },
    );
  }

  void savedToken() {
    untilPrice.saveLocalData(key: 'token', value: user.token!);
    Get.offAllNamed(AppRoutes.home);
  }


  Future<void> register({required UserModel user}) async {
    isLogin.value = true;
    AuthResult result = await authRepository.register(user: user);
    isLogin.value = false;

    result.when(
      success: (user) {
        this.user = user;
        savedToken();
      },
      failure: (message) {
        untilPrice.showToast(message: message, type: true);
      },
    );
  }

  Future<void> login({required String email, required String password}) async {
    isLogin.value = true;
    AuthResult result = await authRepository.login(email: email, password: password);
    isLogin.value = false;

    result.when(
      success: (user) {
        this.user = user;
        savedToken();
      },
      failure: (message) {
        untilPrice.showToast(message: message, type: true);
      },
    );
  }

  Future<void> logout() async {
    user = UserModel();
    await untilPrice.deleteLocalData(key: 'token');
    Get.offAllNamed(AppRoutes.login);
  }

  Future<void> resetPassword({required String email}) async {
    isLogin.value = true;
    await authRepository.resetPassword(email: email);
    isLogin.value = false;
  }

  Future<void> changePassword(
      {required String currentPassword, required String newPassword}
  )async{
    isLogin.value = true;
    final result = await authRepository.changePassword(token: user.token!, 
    email: user.email!, 
    currentPassword: currentPassword, 
    newPassword: newPassword);
    isLogin.value = false;
    if(result){
      untilPrice.showToast(message: 'Change password success');
      logout();
    }else{
      untilPrice.showToast(message: 'Change password fail', type: true);
    }
  }
}
