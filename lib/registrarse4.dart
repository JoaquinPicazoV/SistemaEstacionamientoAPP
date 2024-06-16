// ignore_for_file: prefer_const_constructors, avoid_print, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';

class registrarse4 extends StatelessWidget {
  const registrarse4({super.key});

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
                                      MaterialPageRoute(
                                          builder: (context) => MyApp()),
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
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.blue.shade700),
                                  ),
                                  onPressed: (){
                                  },
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
                              child: CircleAvatar(
                                backgroundColor: Colors.blue.shade500,
                                child: Icon(
                                  Icons.check,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const Text(
                              "Confirmar cuenta",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.blue.shade700,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 100,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "¡SE HA REGISTRADO EXITOSAMENTE!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyApp()),
                        );
                      },
                      icon: Icon(Icons.home, color: Colors.white),
                      label: Text(
                        "VOLVER AL INICIO",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue.shade700),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
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
