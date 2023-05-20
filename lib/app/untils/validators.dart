import 'package:get/get.dart';

String? emailValidator(String? p0) {
  if (p0 == null || p0.isEmpty) {
    return 'Digite um e-mail';
  } else if (!p0.isEmail) {
    return 'Digite um e-mail válido';
  }
  return null;
}

String? passwordValidator(String? p0) {
  if (p0 == null || p0.isEmpty) {
    return 'Digite uma senha';
  } else if (p0.length < 6) {
    return 'A senha deve ter no mínimo 6 caracteres';
  }
  return null;
}

String? nameValidator(String? p0) {
  if (p0 == null || p0.isEmpty) {
    return 'Digite um nome';
  } else if (p0.length < 3) {
    return 'O nome deve ter no mínimo 3 caracteres';
  }
  return null;
}

String? cpfValidator(String? p0) {
  if (p0 == null || p0.isEmpty) {
    return 'Digite um CPF';
  } else if (!p0.isCpf) {
    return 'Digite um CPF válido';
  }
  return null;
}

String? phoneValidator(String? p0) {
  if (p0 == null || p0.isEmpty) {
    return 'Digite um telefone';
  } else if (!p0.isPhoneNumber || p0.length < 14) {
    return 'Digite um telefone válido';
  }
  return null;
}