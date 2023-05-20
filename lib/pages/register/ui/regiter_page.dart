import 'package:drink_store/app/components/custom_buttom.dart';
import 'package:drink_store/app/components/custom_text_field.dart';
import 'package:drink_store/app/untils/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../login/controller/login_controller.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final cpfformater = MaskTextInputFormatter(mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});
  final phoneformater = MaskTextInputFormatter(mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});
  final _formKey = GlobalKey<FormState>();
  final loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.47,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Text(
                        'New User',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      )
                    ],
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45),
                        topRight: Radius.circular(45),
                      ),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextField(
                            title: 'Email',
                            prefixIcon: Icons.email,
                            keyboardType: TextInputType.emailAddress,
                            validator: emailValidator,
                            onSaved: (p0) {
                              loginController.user.email = p0!;
                            },
                          ),
                          CustomTextField(
                            title: 'Senha',
                            prefixIcon: Icons.email,
                            isPassword: true,
                            validator: passwordValidator,
                            onSaved: (p0) {
                              loginController.user.password = p0!;
                            },
                          ),
                          CustomTextField(
                            title: 'Nome',
                            prefixIcon: Icons.person,
                            validator: nameValidator,
                            onSaved: (p0) {
                              loginController.user.name = p0!;
                            },
                          ),
                          CustomTextField(
                            title: 'Celular',
                            prefixIcon: Icons.phone,
                            inputFormatters: [phoneformater],
                            keyboardType: TextInputType.phone,
                            validator: phoneValidator,
                            onSaved: (p0) {
                              loginController.user.phone = p0!;
                            },
                          ),
                          CustomTextField(
                            title: 'CPF',
                            prefixIcon: Icons.file_copy,
                            inputFormatters: [cpfformater],
                            keyboardType: TextInputType.number,
                            validator: cpfValidator,
                            onSaved: (p0) {
                              loginController.user.cpf = p0!;
                            },
                          ),
                          const SizedBox(height: 20),
                          Obx(() {
                            return CustomButtom(
                                title: 'Cadastrar',
                                isLoading: loginController.isLogin.value,
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    loginController.register(user: loginController.user);
                                  }
                                });
                          })
                        ],
                      ),
                    )),
              ],
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: SafeArea(
                child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ))),
          )
        ],
      ),
    );
  }
}
