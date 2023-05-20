import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/components/custom_buttom.dart';
import '../../../../app/components/custom_text_field.dart';
import '../../../../app/untils/validators.dart';
import '../../controller/login_controller.dart';

class ForgotPasswordDialog extends StatelessWidget {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormFieldState>();
  final loginController = Get.find<LoginController>();

  ForgotPasswordDialog({
    required String email,
    Key? key,
  }) : super(key: key) {
    emailController.text = email;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Conteúdo
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Titulo
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Recuperação de senha',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                    bottom: 20,
                  ),
                  child: Text(
                    'Digite seu email para recuperar sua senha',
                    textAlign: TextAlign.center,
                    style: TextStyle(),
                  ),
                ),

                CustomTextField(
                    formKey: formKey,
                    controller: emailController,
                    title: 'E-mail',
                    isPassword: false,
                    prefixIcon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    validator: emailValidator),

                CustomButtom(
                    title: 'Recuperar',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        loginController.resetPassword(email: emailController.text);
                        Get.back(result: true);
                      }
                    })
              ],
            ),
          ),

          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }
}
