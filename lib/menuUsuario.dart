// ignore_for_file: prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, non_constant_identifier_names, prefer_interpolation_to_compose_strings, camel_case_types, library_private_types_in_public_api, use_super_parameters, file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_1/actualizarVehiculo1.dart';
import 'package:flutter_application_1/codigoReserva.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/testSeesion.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:postgres/postgres.dart';

class menuUsuario extends StatefulWidget {
  final String RUT;

  const menuUsuario({Key? key, required this.RUT}) : super(key: key);
  @override
  _menuUsuarioState createState() => _menuUsuarioState();
}

class _menuUsuarioState extends State<menuUsuario> {
  late String RUT = 'BUSCANDO';
  @override
  void initState() {
    BuscarNombre(RUT);
    RUT = widget.RUT;
    super.initState();
  }

  int estacionamientosDisponibles = 0;
  late Connection _db;
  String texto = 'Consultando disponibilidad...';
  String nombreUsuario = 'Buscando nombre...';

  Future<void> BuscarNombre(rut) async {
    _db = await Connection.open(
      Endpoint(
        host: 'ep-sparkling-dream-a5pwwhsb.us-east-2.aws.neon.tech',
        database: 'estacionamientosUlagos',
        username: 'estacionamientosUlagos_owner',
        password: 'D7HQdX0nweTx',
      ),
      settings: const ConnectionSettings(sslMode: SslMode.require),
    );

    final nombre = await _db.execute("SELECT usua_nombre, usua_apellido_paterno FROM USUARIO WHERE usua_rut='" + RUT + "'");

    setState(() {
      nombreUsuario = nombre[0][0].toString() + '' + nombre[0][1].toString();
    });
  }

  Future<void> ConsultarDisponibilidad() async {
    _db = await Connection.open(
      Endpoint(
        host: 'ep-sparkling-dream-a5pwwhsb.us-east-2.aws.neon.tech',
        database: 'estacionamientosUlagos',
        username: 'estacionamientosUlagos_owner',
        password: 'D7HQdX0nweTx',
      ),
      settings: const ConnectionSettings(sslMode: SslMode.require),
    );

    final results = await _db.execute("SELECT COUNT(*) FROM estacionamiento WHERE esta_estado = 'LIBRE'");
    setState(() {
      estacionamientosDisponibles = int.parse(results[0][0].toString());
      texto = '¡$estacionamientosDisponibles estacionamientos disponibles!';
    });
  }

  @override
  Widget build(BuildContext context) {
    ConsultarDisponibilidad();

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
                                    MaterialPageRoute(builder: (context) => codigoReserva(RUT: RUT)),
                                  );
                                },
                                icon: const Icon(Icons.car_crash_outlined, color: Colors.white),
                                label: const Text(
                                  'RESERVAR ESTACIONAMIENTO',
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
                            const SizedBox(height: 20),
                            FractionallySizedBox(
                              widthFactor: 0.96,
                              child: ElevatedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.history, color: Colors.white),
                                label: const Text(
                                  'MIS RESERVAS',
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
                                onPressed: () {},
                                icon: const Icon(Icons.location_on, color: Colors.white),
                                label: const Text(
                                  'MAPA DE ESTACIONAMIENTO',
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
                                      builder: (context) => actualizarVehiculo(),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.directions_car, color: Colors.white),
                                label: const Text(
                                  'ACTUALIZAR DATOS DE VEHÍCULO',
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
    );
  }
}
