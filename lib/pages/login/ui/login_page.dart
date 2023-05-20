import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:drink_store/app/untils/untils_price.dart';
import 'package:drink_store/app/untils/validators.dart';
import 'package:drink_store/pages/login/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/components/custom_buttom.dart';
import '../../../app/components/custom_text_field.dart';
import '../../../app/themes/main_theme.dart';
import 'components/forgot_password_dialog.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  UntilPrice untilPrice = UntilPrice();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: size.height,
              child: Column(
                children: [
                  Image.asset('assets/images/winelogo1.png', height: 200, width: 200),
                  SizedBox(
                    height: 100,
                    child: TextLiquidFill(
                      waveDuration: const Duration(seconds: 6),
                      loadUntil: 0.7,
                      text: 'YourWineHouse',
                      waveColor: Colors.redAccent,
                      boxBackgroundColor: Colors.white,
                      boxHeight: 80,
                      textStyle: const TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomTextField(
                            controller: emailController,
                            title: 'E-mail',
                            isPassword: false,
                            prefixIcon: Icons.email,
                            keyboardType: TextInputType.emailAddress,
                            validator: emailValidator),
                        CustomTextField(
                            controller: passwordController,
                            title: 'Password',
                            isPassword: true,
                            prefixIcon: Icons.lock,
                            validator: passwordValidator),
                        Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () async {
                                  final bool? result = await showDialog(
                                      context: context,
                                      builder: (_) => ForgotPasswordDialog(email: emailController.text));
                                  if (result ?? false) {
                                    untilPrice.showToast(message: 'E-mail de reperção enviado com sucesso!');
                                  }
                                },
                                child: const Text('Esqueceu a senha?'))),
                        GetX<LoginController>(builder: (controller) {
                          return CustomButtom(
                              title: 'Entrar',
                              isLoading: controller.isLogin.value,
                              onPressed: () async {
                                FocusScope.of(context).unfocus();
                                if (formKey.currentState!.validate()) {
                                  String email = emailController.text;
                                  String password = passwordController.text;
                                  await controller.login(email: email, password: password);
                                }
                              });
                        }),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Divider(
                                color: Colors.grey,
                                thickness: 2,
                              )),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Text('Ou'),
                              ),
                              Expanded(
                                  child: Divider(
                                thickness: 2,
                                color: Colors.grey,
                              )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 60,
                          child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(16)),
                                ),
                                side: BorderSide(width: 2, color: ColorTheme.primary),
                              ),
                              onPressed: () {
                                Get.toNamed('/register');
                              },
                              child: const Text('Criar uma conta',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
