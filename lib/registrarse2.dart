// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/newRegistro.dart';
import 'package:flutter_application_1/registrarse3.dart';

class Registrarse2 extends StatefulWidget {
  @override
  _Registrarse2State createState() => _Registrarse2State();
}

class _Registrarse2State extends State<Registrarse2> {
  bool contrasena1 = false;
  bool contrasena2 = false;

  TextEditingController contraEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: Align(
        alignment: Alignment.center,
        child: SafeArea(
          child: FractionallySizedBox(
            widthFactor: 0.81,
            heightFactor: 0.95,
            child: Container(
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
                      "ESTACIONAMIENTOS ULAGOS",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: 0.85,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Align(
                                alignment: Alignment.center,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => MyApp()),
                                    );
                                  },
                                  child: const Text(
                                    "Iniciar sesión",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Align(
                                alignment: Alignment.center,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                                    backgroundColor: MaterialStateProperty.all<Color>(
                                      Colors.blue.shade700,
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const Text(
                                    'Registrarse',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
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
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(color: Colors.blue.shade700),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.blue.shade500,
                                shape: BoxShape.circle,
                              ),
                              child: const Text(
                                "2",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const Text(
                              "Crear clave",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          "Contraseña",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
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
                        obscureText: !contrasena1,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                            icon: Icon(contrasena1 ? Icons.visibility_off : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                contrasena1 = !contrasena1;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: const Text("Confirmar Contraseña"),
                      ),
                    ),
                    SizedBox(
                      height: 8,
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
                        controller: contraEditingController,
                        obscureText: !contrasena2,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                            icon: Icon(contrasena2 ? Icons.visibility_off : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                contrasena2 = !contrasena2;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Wrap(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                size: 16,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  "Debe contener al menos 8 caracteres",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Wrap(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                size: 16,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  "Debe contener al menos una letra mayúscula.",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Wrap(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                size: 16,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  "Debe contener al menos una letra minúscula.",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Wrap(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                size: 16,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  "Debe contener al menos un número.",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Wrap(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                size: 16,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  "Las contraseñas coinciden.",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade700),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          llenarPassword(contraEditingController.text);
                          print(getRegistro());
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Registrarse3()),
                          );
                        },
                        icon: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                        label: Text(
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
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Registrarse2(),
  ));
}
