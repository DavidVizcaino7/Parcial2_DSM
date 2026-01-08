String? validarCedula(String? value) {
  if (value == null || value.isEmpty) {
    return 'Ingrese la cédula';
  }

  if (!RegExp(r'^\d{10}$').hasMatch(value)) {
    return 'Debe contener exactamente 10 números';
  }

  int provincia = int.parse(value.substring(0, 2));
  int tercerDigito = int.parse(value[2]);

  if (provincia < 1 || provincia > 24) {
    return 'Provincia inválida';
  }

  if (tercerDigito >= 6) {
    return 'Tercer dígito inválido';
  }

  List<int> coeficientes = [2,1,2,1,2,1,2,1,2];
  int suma = 0;

  for (int i = 0; i < 9; i++) {
    int valor = int.parse(value[i]) * coeficientes[i];
    if (valor >= 10) valor -= 9;
    suma += valor;
  }

  int digitoVerificador = int.parse(value[9]);
  int decena = ((suma / 10).ceil()) * 10;
  int resultado = decena - suma;

  if (resultado == 10) resultado = 0;

  if (resultado != digitoVerificador) {
    return 'Cédula inválida';
  }

  return null;
}

String? validarCorreo(String? value) {
  if (value == null || value.isEmpty) {
    return 'Ingrese un correo electrónico';
  }

  final RegExp regexCorreo = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  if (!regexCorreo.hasMatch(value)) {
    return 'Formato de correo inválido (user@domain.com)';
  }

  return null;
}


String? validarPassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Ingrese una contraseña';
  }

  if (value.length < 8) {
    return 'Debe tener mínimo 8 caracteres';
  }

  if (!RegExp(r'[A-Z]').hasMatch(value)) {
    return 'Debe contener al menos una letra mayúscula';
  }

  if (!RegExp(r'[0-9]').hasMatch(value)) {
    return 'Debe contener al menos un número';
  }

  if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
    return 'Debe contener al menos un carácter especial';
  }

  return null;
}
