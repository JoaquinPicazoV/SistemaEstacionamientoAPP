// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, non_constant_identifier_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/menuGuardia.dart';

class confirmacionRealizada extends StatelessWidget {
  final String? rut;
  confirmacionRealizada({required this.rut});

  String nombre = "Sebastián Nicolás Leiva Almonacid";
  late String? RUT;
  String rol = 'Estudiante';
  String nEstacionamiento = '52';

  @override
  Widget build(BuildContext context) {
    RUT = rut;

    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: Center(
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FractionallySizedBox(
                      widthFactor: 0.6,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 30),
                        child: Image.asset(
                          "assets/img/LogoSolo.png",
                          fit: BoxFit.fitHeight,
                          height: 80,
                          width: 80,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.blue.shade700,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 150,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'CONFIRMACIÓN REALIZADA',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Text(
                          'NOMBRE:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            '$nombre',
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'RUT:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          '$RUT',
                          overflow: TextOverflow.visible,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'ROL:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          '$rol',
                          overflow: TextOverflow.visible,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'ESTACIONAMIENTO:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          '$nEstacionamiento',
                          overflow: TextOverflow.visible,
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => menuGuardia(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                      label: Text(
                        'VOLVER AL MENÚ PRINCIPAL',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
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
