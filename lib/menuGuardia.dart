// ignore_for_file: file_names, prefer_const_constructors, camel_case_types, non_constant_identifier_names, use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_application_1/confirmarReserva1.dart';
import 'package:flutter_application_1/historialGuardia.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/testSeesion.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:postgres/postgres.dart';
import 'package:flutter_application_1/database.dart';

class menuGuardia extends StatefulWidget {
  final String RUT;

  const menuGuardia({Key? key, required this.RUT}) : super(key: key);
  @override
  _menuGuardiaState createState() => _menuGuardiaState();
}

class _menuGuardiaState extends State<menuGuardia> {
  late String RUT = RUT;
  @override
  void initState() {
    RUT = widget.RUT;
    BuscarNombre();
    ConsultarDisponibilidad();
    super.initState();
  }

  int estacionamientosDisponibles = 0;
  late Connection _db;
  String texto = 'Consultando disponibilidad...';
  String nombreUsuario = 'Buscando nombre...';

  Future<void> BuscarNombre() async {
    _db = DatabaseHelper().connection;
    
    final nombre = await _db.execute("SELECT guar_nombre, guar_apellido_paterno, guar_apellido_materno FROM guardia WHERE guar_rut='$RUT'");
    
    setState(() {
      nombreUsuario = '${nombre[0][0]} ${nombre[0][1]} ${nombre[0][2]}';
    });
  }

  Future<void> ConsultarDisponibilidad() async {
    _db = DatabaseHelper().connection;

    final results = await _db.execute("SELECT COUNT(*) FROM estacionamiento WHERE esta_estado = 'LIBRE'");
    setState(() {
      estacionamientosDisponibles = int.parse(results[0][0].toString());
      texto = '¡$estacionamientosDisponibles estacionamientos disponibles!';
    });
  }

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
                        "$texto",
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
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
                                builder: (context) => confirmarReserva(),
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
          ),
        ),
      ),
    );
  }
}
