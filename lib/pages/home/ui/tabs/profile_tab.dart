import 'package:drink_store/app/components/custom_buttom.dart';
import 'package:drink_store/app/components/custom_text_field.dart';
import 'package:drink_store/app/untils/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/themes/main_theme.dart';
import '../../../login/controller/login_controller.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Perfil'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              loginController.logout();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          const CircleAvatar(
            radius: 60,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage('assets/images/profile.png'),
          ),
          const SizedBox(height: 16),
          CustomTextField(
            prefixIcon: Icons.person,
            title: 'Name',
            initialValue: loginController.user.name,
            readOnly: true,
          ),
          CustomTextField(
            prefixIcon: Icons.email,
            title: 'Email',
            initialValue: loginController.user.email,
            readOnly: true,
          ),
          CustomTextField(
            prefixIcon: Icons.phone,
            title: 'Phone',
            initialValue: loginController.user.phone,
            readOnly: true,
          ),
          CustomTextField(
            prefixIcon: Icons.file_copy,
            title: 'CPF',
            isPassword: true,
            initialValue: loginController.user.cpf,
            readOnly: true,
          ),
          const SizedBox(height: 16),
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
                  _showDialog();
                },
                child: const Text('Alterar Senha', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          ),
        ],
      ),
    );
  }

  Future<bool?> _showDialog() {
    final newPasswordController = TextEditingController();
    final currentPasswordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Alterar Senha', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                      CustomTextField(
                        controller: currentPasswordController,
                        isPassword: true,
                        title: 'Senha Atual',
                        prefixIcon: Icons.lock,
                        validator: passwordValidator,
                      ),
                      CustomTextField(
                        controller: newPasswordController,
                        isPassword: true,
                        title: 'Nova Senha',
                        prefixIcon: Icons.lock_clock_outlined,
                        validator: passwordValidator,
                      ),
                      CustomTextField(
                        isPassword: true,
                        title: 'Confirmar Senha',
                        prefixIcon: Icons.lock_clock_outlined,
                        validator: (value) {
                          final result = passwordValidator(value);
                          if (result != null) {
                            return result;
                          }

                          if (value != newPasswordController.text) {
                            return 'As senhas não coincidem';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomButtom(
                          title: 'Confirmar',
                          isLoading: loginController.isLogin.value,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              loginController.changePassword(
                                  currentPassword: currentPasswordController.text,
                                  newPassword: newPasswordController.text);
                            }
                          })
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
