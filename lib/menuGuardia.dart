// ignore_for_file: file_names, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_application_1/confirmarReserva1.dart';
import 'package:flutter_application_1/historialGuardia.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_svg/flutter_svg.dart';

class menuGuardia extends StatelessWidget {
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
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FractionallySizedBox(
                      widthFactor: 0.85,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 50,
                                height: 50,
                                child: SvgPicture.asset('assets/img/logo.87d5c665 1.svg', semanticsLabel: 'Logo Ulagos'),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Nombre_Usuario',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue.shade900,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextButton.icon(
                                style: TextButton.styleFrom(padding: EdgeInsets.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap, alignment: Alignment.centerRight),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const MyApp(),
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.exit_to_app,
                                  color: Colors.red,
                                ),
                                label: const Text(
                                  'Cerrar Sesión',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Image.asset(
                    'assets/img/CCHPM.jpg',
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: [
                      FractionallySizedBox(
                        widthFactor: 0.96,
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.car_crash_outlined, color: Colors.white),
                          label: Text(
                            'ADMINISTRAR ESTACIONAMIENTO',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.blue.shade700),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      FractionallySizedBox(
                        widthFactor: 0.96,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                            MaterialPageRoute(
                              builder: (context) => historialGuardia(),
                            ));
                          },
                          icon: Icon(Icons.history, color: Colors.white),
                          label: Text(
                            'HISTORIAL DE RESERVAS',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.blue.shade700),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      FractionallySizedBox(
                        widthFactor: 0.96,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => confirmarReserva()),
                            );
                          },
                          icon: Icon(Icons.check, color: Colors.white),
                          label: Text(
                            'CONFIRMAR RESERVA',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.blue.shade700),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
