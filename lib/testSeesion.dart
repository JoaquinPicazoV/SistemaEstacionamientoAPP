// ignore_for_file: file_names

import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveSession(correo, nombre) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('auth_correo', correo);
  await prefs.setString('auth_nombre', nombre);
  await prefs.setBool('auth_exist', true);
}

Future<String?> getSessionCorreo() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('auth_correo');
}

Future<String?> getSessionNombre() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('auth_nombre');
}

Future<void> clearSession() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('auth_correo');
  await prefs.setBool('auth_exist', true);
}

Future<bool> getExistSession() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('auth_exist') ?? false;
}
