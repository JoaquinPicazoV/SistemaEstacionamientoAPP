import 'package:flutter/material.dart';
import 'package:flutter_application_1/database.dart';
import 'package:flutter_application_1/recuperarClave2.dart';
import 'package:postgres/postgres.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'dart:math';

class RecuperarClave extends StatefulWidget {
  @override
  _RecuperarClaveState createState() => _RecuperarClaveState();
}

class _RecuperarClaveState extends State<RecuperarClave> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  late Connection _db;
  RegExp get _emailRegex => RegExp(r'^\S+@\S+$');

  Future<bool> buscarCorreo(String correo) async {
    _db = DatabaseHelper().connection;
    final existe = await _db.execute(
        "SELECT COUNT(*) FROM USUARIO WHERE usua_correo='${correo.toLowerCase()}'");

    if (existe[0][0] == 1) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: Align(
        alignment: Alignment.center,
        child: SafeArea(
          child: FractionallySizedBox(
              widthFactor: 0.95,
              child: Container(
                padding: const EdgeInsets.only(top: 40, bottom: 40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      FractionallySizedBox(
                        widthFactor: 0.6,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 30),
                          child: Image.asset(
                            "assets/img/ULAGOS.png",
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      const Text(
                        "RECUPERAR CONTRASEÑA",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.85,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          child: const Text(
                            "Ingrese su correo electrónico",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.85,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              SizedBox(
                                child: TextFormField(
                                  style: const TextStyle(fontSize: 12),
                                  controller: _emailController,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Ingrese un correo';
                                    } else if (!_emailRegex.hasMatch(value)) {
                                      return 'Ingrese un correo válido';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Correo electrónico',
                                    suffixIcon: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        border: Border.all(
                                          color: Colors.blue,
                                        ),
                                      ),
                                      child: const IconButton(
                                          icon: Icon(Icons.email,
                                              color: Colors.black),
                                          onPressed: null),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 1.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.85,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              if (_formKey.currentState?.validate() ?? false) {
                                final existe =
                                    await buscarCorreo(_emailController.text);
                                if (existe) {
                                  String codigo = generarCodigo();
                                  bool enviado = await sendEmail(
                                      _emailController.text, codigo);
                                  if (enviado) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RecuperarClave2(
                                              codigo: codigo,
                                              email: _emailController.text
                                                  .toLowerCase())),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text('No se pudo enviar el correo'),
                                      ),
                                    );
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'El correo ingresado no está registrado'),
                                    ),
                                  );
                                }
                              }
                            },
                            icon: const Icon(Icons.send, color: Colors.white),
                            label: const Text(
                              'Enviar código',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade700,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.85,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Volver al login",
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}

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
    ..html = "<h1>Codigo de verificación: ${codigo}</h1>";

  try {
    final sendReport = await send(message, smtpServer);
    print('Mensaje enviado: ' + sendReport.toString());
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
