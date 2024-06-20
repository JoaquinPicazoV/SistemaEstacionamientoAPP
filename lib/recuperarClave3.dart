// ignore_for_file: file_names, use_build_context_synchronously, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_application_1/database.dart';
import 'package:postgres/postgres.dart';
import 'package:flutter_application_1/recuperarClave4.dart';

class RecuperarClave3 extends StatefulWidget {
  final String email;
  RecuperarClave3({required this.email, super.key});
  @override
  _RecuperarClave3State createState() => _RecuperarClave3State();
}

class _RecuperarClave3State extends State<RecuperarClave3> {
  bool contrasena1Visible = false;
  bool contrasena2Visible = false;

  // Controladores para los campos de contraseña
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmacionController = TextEditingController();

  // Estados para controlar si los requisitos de contraseña se cumplen
  bool tieneAlMenos8Caracteres = false;
  bool tieneMayuscula = false;
  bool tieneMinuscula = false;
  bool tieneNumero = false;
  bool contrasenasCoinciden = false;
  bool mostrarAdvertencia = false;
  late Connection _db;

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
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Cree su nueva contraseña",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Contraseña"),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: Colors.blue,
                            width: 1,
                          ),
                        ),
                        child: TextField(
                          controller: passwordController,
                          obscureText: !contrasena1Visible,
                          onChanged: onPasswordChanged,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              icon: Icon(contrasena1Visible ? Icons.visibility_off : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  contrasena1Visible = !contrasena1Visible;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Confirmar Contraseña"),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: Colors.blue,
                            width: 1,
                          ),
                        ),
                        child: TextField(
                          controller: confirmacionController,
                          obscureText: !contrasena2Visible,
                          onChanged: onConfirmationChanged,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              icon: Icon(contrasena2Visible ? Icons.visibility_off : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  contrasena2Visible = !contrasena2Visible;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Requisitos de contraseña
                      buildRequirement("Debe contener al menos 8 caracteres", tieneAlMenos8Caracteres),
                      buildRequirement("Debe contener al menos una letra mayúscula.", tieneMayuscula),
                      buildRequirement("Debe contener al menos una letra minúscula.", tieneMinuscula),
                      buildRequirement("Debe contener al menos un número.", tieneNumero),
                      buildRequirement("Las contraseñas coinciden.", contrasenasCoinciden),
                      // Mensaje de advertencia
                      if (mostrarAdvertencia)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          color: Colors.red,
                          child: const Text(
                            "La contraseña no cumple con los requisitos mínimos.",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      // Botón para crear contraseña
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: ElevatedButton.icon(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              contrasenasCoinciden
                                  ? Colors.green
                                  : mostrarAdvertencia
                                      ? Colors.grey
                                      : Colors.blue.shade700,
                            ),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            if (contrasenasCoinciden) {
                              final resultado = await actualizarClaveUsuario(widget.email, passwordController.text);
                              if (resultado) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const RecuperarClave4()),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Ha ocurrido un error al actualizar la clave'),
                                  ),
                                );
                              }
                            } else {
                              // Mostrar mensaje de error o realizar alguna acción adicional
                              setState(() {
                                mostrarAdvertencia = true;
                              });
                            }
                          },
                          icon: const Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                          label: const Text(
                            'Crear contraseña',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
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

  void verificarRequisitos(String password, String confirmacion) {
    // Verificar longitud mínima
    tieneAlMenos8Caracteres = password.length >= 8;

    // Verificar al menos una mayúscula
    tieneMayuscula = password.contains(RegExp(r'[A-Z]'));

    // Verificar al menos una minúscula
    tieneMinuscula = password.contains(RegExp(r'[a-z]'));

    // Verificar al menos un número
    tieneNumero = password.contains(RegExp(r'[0-9]'));

    // Verificar si las contraseñas coinciden
    contrasenasCoinciden = password == confirmacion;

    // Verificar si se cumplen todos los requisitos
    mostrarAdvertencia = !tieneAlMenos8Caracteres || !tieneMayuscula || !tieneMinuscula || !tieneNumero;

    // Actualizar la interfaz de usuario
    setState(() {});
  }

  Widget buildRequirement(String text, bool condition) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Wrap(
        children: [
          Row(
            children: [
              buildIcon(condition),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 14,
                    color: condition ? Colors.green : Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget para mostrar un ícono de verificación o un ícono de advertencia
  Widget buildIcon(bool condition) {
    return Icon(
      condition ? Icons.check_circle : Icons.warning,
      size: 16,
      color: condition ? Colors.green : Colors.grey,
    );
  }

  // Evento de cambio para el campo de contraseña
  void onPasswordChanged(String password) {
    verificarRequisitos(password, confirmacionController.text);
  }

  // Evento de cambio para el campo de confirmación de contraseña
  void onConfirmationChanged(String confirmation) {
    verificarRequisitos(passwordController.text, confirmation);
  }

  @override
  void dispose() {
    // Limpiar controladores al salir de la página
    passwordController.dispose();
    confirmacionController.dispose();
    super.dispose();
  }

  Future<bool> actualizarClaveUsuario(correo, clave) async {
    try {
      _db = DatabaseHelper().connection;

      var query = "SELECT * FROM usuario WHERE usua_correo = '${correo.toLowerCase()}'";

      final resultado = await _db.execute(query);
      if (resultado.affectedRows == 1) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
