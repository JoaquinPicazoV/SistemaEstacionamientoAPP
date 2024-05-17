// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/codigoReserva.dart';
import 'package:flutter_application_1/main.dart';

class menuUsuario extends StatelessWidget {
  // Variable para la disponibilidad de estacionamientos
  int estacionamientosDisponibles = 4;

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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 60,
                              height: 60,
                              child: Image.asset('assets/img/LogoSolo.png'),
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
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyApp()),
                                );
                              },
                              icon: Icon(
                                Icons.exit_to_app,
                                color: Colors.red,
                              ),
                              label: Text(
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
                  SizedBox(height: 20),
                  Image.asset(
                    'assets/img/CCHPM.jpg',
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  // Alerta roja y disponibilidad de estacionamientos
                  Column(
                    children: [
                      // Alerta roja
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: Colors.red,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'ATENCIÓN',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        "¡$estacionamientosDisponibles ESTACIONAMIENTOS DISPONIBLES!",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      Column(
                        children: [
                          FractionallySizedBox(
                            widthFactor: 0.96,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => codigoReserva()),
                                );
                              },
                              icon: Icon(Icons.car_crash_outlined,
                                  color: Colors.white),
                              label: Text(
                                'RESERVAR ESTACIONAMIENTO',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.blue.shade700),
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
                              onPressed: () {},
                              icon: Icon(Icons.history, color: Colors.white),
                              label: Text(
                                'MIS RESERVAS',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.blue.shade700),
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
                              onPressed: () {},
                              icon:
                                  Icon(Icons.location_on, color: Colors.white),
                              label: Text(
                                'MAPA DE ESTACIONAMIENTO',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.blue.shade700),
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
                              onPressed: () {},
                              icon: Icon(Icons.directions_car,
                                  color: Colors.white),
                              label: Text(
                                'ACTUALIZAR DATOS DE VEHÍCULO',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.blue.shade700),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
