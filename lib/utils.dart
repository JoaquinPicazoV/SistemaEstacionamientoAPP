// ignore_for_file: deprecated_member_use

import 'dart:math';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

Future<bool> sendEmail(String recipientEmail, String codigo) async {
  String username = 'estacionamientosulagos@gmail.com';
  String password = 'yotv rves zpzg lpkq';

  // Configurar el servidor SMTP
  final smtpServer = gmail(username, password);

  // Crear el mensaje
  final message = Message()
    ..from = Address(username, username)
    ..recipients.add(recipientEmail)
    ..subject = 'Codigo de verificación'
    ..text = 'Codigo de verificación: $codigo'
    ..html = "<h1>Codigo de verificación: $codigo</h1>";

  try {
    final sendReport = await send(message, smtpServer);
    print('Mensaje enviado: ${sendReport.toString()}');
    return true;
  } on MailerException catch (e) {
    print('Mensaje no enviado. ${e.toString()}');
    for (var p in e.problems) {
      print('Problema: ${p.code}: ${p.msg}');
    }
    return false;
  }
}

String generarCodigo() {
  Random nRandom = Random();
  String codigo = '';
  for (int i = 0; i < 6; i++) {
    codigo += nRandom.nextInt(10).toString();
  }
  print(codigo);
  return codigo;
}
