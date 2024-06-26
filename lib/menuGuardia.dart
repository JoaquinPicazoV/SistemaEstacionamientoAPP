// ignore_for_file: library_private_types_in_public_api, file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_application_1/adminGuardia1.dart';
import 'package:flutter_application_1/confirmarReserva1.dart';
import 'package:flutter_application_1/historialGuardia.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/sesion.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:postgres/postgres.dart';
import 'package:flutter_application_1/database.dart';

class MenuGuardia extends StatefulWidget {
  final String RUT, nombreUsuario;

  const MenuGuardia({super.key, required this.RUT, required this.nombreUsuario});
  @override
  _MenuGuardiaState createState() => _MenuGuardiaState();
}

class _MenuGuardiaState extends State<MenuGuardia> {
  late String RUT, nombreUsuario;

  @override
  void initState() {
    RUT = widget.RUT;
    nombreUsuario = widget.nombreUsuario;
    consultarDisponibilidad();
    super.initState();
  }

  int estacionamientosDisponibles = 0;
  late Connection _db;
  String texto = 'Consultando disponibilidad...';

  Future<void> consultarDisponibilidad() async {
    _db = DatabaseHelper().connection;

    final results = await _db.execute("SELECT COUNT(*) FROM estacionamiento WHERE esta_estado = 'LIBRE'");
    setState(() {
      estacionamientosDisponibles = int.parse(results[0][0].toString());
      texto = '¡$estacionamientosDisponibles estacionamientos disponibles!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Confirmación'),
              content: const Text('¿Quiere salir?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    clearSession();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyApp(),
                      ),
                    );
                  },
                  child: const Text('Si'),
                ),
              ],
            );
          },
        );
      },
      child: Scaffold(
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
                    children: [
                      FractionallySizedBox(
                        widthFactor: 0.85,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
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
                                    nombreUsuario,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.blue.shade900,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextButton.icon(
                                    style: TextButton.styleFrom(padding: EdgeInsets.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap, alignment: Alignment.centerRight),
                                    onPressed: () {
                                      clearSession();
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
                      const SizedBox(
                        height: 20,
                      ),
                      Image.asset(
                        'assets/img/CCHPM.jpg',
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      // Alerta roja y disponibilidad de estacionamientos
                      Column(
                        children: [
                          // Alerta roja
                          const Row(
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
                          const SizedBox(height: 10),
                          Text(
                            texto,
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      FractionallySizedBox(
                        widthFactor: 0.85,
                        child: Column(
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
                                            builder: (context) => AdminGuardia1(rut: widget.RUT, nombreUsuario: widget.nombreUsuario),
                                          ));
                                    },
                                    icon: const Icon(Icons.car_crash_outlined, color: Colors.white),
                                    label: const Text(
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
                                const SizedBox(
                                  height: 20,
                                ),
                                FractionallySizedBox(
                                  widthFactor: 0.96,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const HistorialGuardia(),
                                          ));
                                    },
                                    icon: const Icon(Icons.history, color: Colors.white),
                                    label: const Text(
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
                                const SizedBox(
                                  height: 20,
                                ),
                                FractionallySizedBox(
                                  widthFactor: 0.96,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ConfirmarReserva(nombreUsuario: nombreUsuario,),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.check, color: Colors.white),
                                    label: const Text(
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
