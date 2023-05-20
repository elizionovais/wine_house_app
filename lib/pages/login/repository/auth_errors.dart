String authErrorsString(String? code) {
  switch (code) {
    case 'INVALID_CREDENTIALS':
      return 'Email e/ou senha inválidos';
    case 'Invalid session token':
      return 'Sessão inválida';
    case 'INVALID_FULLNAME':
      return 'Nome inválido';
    case 'INVALID_PHONE' :
      return 'Telefone inválido';
    case 'INVALID_CPF':
      return 'CPF inválido';
    default:
      return 'Erro desconhecido';
  }
}