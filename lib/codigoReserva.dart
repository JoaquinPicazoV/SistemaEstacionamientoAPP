// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_string_interpolations, non_constant_identifier_names, use_build_context_synchronously, avoid_print, prefer_const_declarations, camel_case_types, library_private_types_in_public_api, use_super_parameters, file_names, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_application_1/database.dart';
import 'package:flutter_application_1/main.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter_application_1/menuUsuario.dart';
import 'package:postgres/postgres.dart';
import 'package:intl/intl.dart';

class codigoReserva extends StatefulWidget {
  final String RUT;

  const codigoReserva({Key? key, required this.RUT}) : super(key: key);
  @override
  _codigoReserva createState() => _codigoReserva();
}

class _codigoReserva extends State<codigoReserva> {
  @override
  void initState() {
    RUT = widget.RUT; 
    BuscarNombre(RUT);
    super.initState();
    TieneReserva(RUT);
  }

  String txtestacionamiento = '';
  String estacionamiento = '';
  String horarioMaximo = '';
  String txthorarioMaximo = '';
  late Connection _db;
  String nombreUsuario = 'Buscando nombre...';
  Future<void> BuscarNombre(rut) async {
    Connection _db = DatabaseHelper().connection;

    final nombre = await _db.execute(
        "SELECT usua_nombre, usua_apellido_paterno FROM USUARIO WHERE usua_rut='" +
            RUT +
            "'");

    setState(() {
      nombreUsuario = nombre[0][0].toString() + '' + nombre[0][1].toString();
    });
  }

  Future<void> DatosReserva(RUT) async {
    Connection _db = DatabaseHelper().connection;
    final datosReserva = await _db.execute(
        "SELECT rese_esta_id, TO_CHAR(rese_hora_inicio + INTERVAL '30 minutes', 'HH24:MI') AS nueva_hora_ FROM RESERVA WHERE rese_usua_rut='" +
            RUT +
            "' AND rese_estado='EN ESPERA'");

    final nEst = await _db.execute(
        "SELECT esta_numero FROM ESTACIONAMIENTO WHERE esta_id='" +
            datosReserva[0][0].toString() +
            "'");

    setState(() {
      horarioMaximo = datosReserva[0][1].toString();
      estacionamiento = nEst[0][0].toString();
      txtestacionamiento = 'ESTACIONAMIENTO: $estacionamiento';
      txthorarioMaximo = 'HORARIO MÁXIMO DE LLEGADA: $horarioMaximo';
    });
  }

  Future<void> CancelarReserva(RUT) async {
    Connection _db = DatabaseHelper().connection;
    final datos = await _db.execute(
        "SELECT rese_id, rese_esta_id FROM RESERVA WHERE rese_usua_rut='" +
            RUT +
            "' AND rese_estado='EN ESPERA'");

    final estadoEst = await _db.execute(
        "UPDATE ESTACIONAMIENTO SET esta_estado='LIBRE' WHERE esta_id='" +
            datos[0][1].toString() +
            "'");
    final eliminar = await _db.execute(
        "DELETE FROM RESERVA WHERE rese_id='" + datos[0][0].toString() + "'");
  }

  Future<void> Reservar(RUT) async {
    Connection _db = DatabaseHelper().connection;
    DateTime actual = DateTime.now();
    String fechaFormato = DateFormat('MM-dd-yy').format(actual);

    String horaFormato = DateFormat('HH:mm:ss').format(actual);

    final patente = await _db.execute(
        "SELECT regi_vehi_patente FROM REGISTROUSUARIOVEHICULO WHERE regi_usua_rut='" +
            RUT +
            "' AND regi_estado='activo'");
    final nEstacionamiento = await _db.execute(
        "SELECT MAX(esta_numero) FROM ESTACIONAMIENTO WHERE esta_estado='LIBRE'");
    final ID = await _db.execute(
        "SELECT esta_id FROM ESTACIONAMIENTO WHERE esta_numero='" +
            nEstacionamiento[0][0].toString() +
            "'");
    final rutGuardia = '21008896-2';

    print(patente[0][0]);
    print(ID[0][0]);
    print(fechaFormato);
    print(horaFormato);

    final reservar = await _db.execute(
      "INSERT INTO RESERVA(rese_guar_rut, rese_usua_rut, rese_esta_id, rese_vehi_patente, rese_fecha, rese_estado, rese_hora_inicio) VALUES('$rutGuardia', '$RUT', '${ID[0][0]}', '${patente[0][0]}', '$fechaFormato', 'EN ESPERA', '$horaFormato')",
    );

    final estadoEstacionamiento = await _db.execute(
        "UPDATE ESTACIONAMIENTO SET esta_estado='RESERVADO' WHERE esta_id='" +
            ID[0][0].toString() +
            "'");
    print(reservar);
    print(estadoEstacionamiento);
    DatosReserva(RUT);
  }

  Future<void> TieneReserva(RUT) async {
    Connection _db = DatabaseHelper().connection;

    final tiene = await _db.execute(
        "SELECT COUNT(*) FROM RESERVA WHERE rese_usua_rut='" +
            RUT +
            "' AND rese_estado='EN ESPERA'");
    if (tiene[0][0].toString() == '1') {
      final datosReserva = await _db.execute(
          "SELECT rese_esta_id, TO_CHAR(rese_hora_inicio + INTERVAL '30 minutes', 'HH24:MI') AS nueva_hora_ FROM RESERVA WHERE rese_usua_rut='" +
              RUT +
              "' AND rese_estado='EN ESPERA'");

      final nEst = await _db.execute(
          "SELECT esta_numero FROM ESTACIONAMIENTO WHERE esta_id='" +
              datosReserva[0][0].toString() +
              "'");

      setState(() {
        horarioMaximo = datosReserva[0][1].toString();
        estacionamiento = nEst[0][0].toString();
        txtestacionamiento = 'ESTACIONAMIENTO: $estacionamiento';
        txthorarioMaximo = 'HORARIO MÁXIMO DE LLEGADA: $horarioMaximo';
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('AVISO'),
            content: Text(
                'Usted ya tiene una reserva activa. Para realizar otra nueva, primero debe eliminar esta (reserva activa).'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('¡Entendido!'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('CONSULTA'),
            content: Text(
                'No tiene reservas hechas. ¿Desea realizar una reserva ahora?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Reservar(RUT);
                },
                child: Text('Si'),
              ),
            ],
          );
        },
      );
    }
  }

  late String RUT;

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
                mainAxisAlignment: MainAxisAlignment.start,
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
                              '$nombreUsuario',
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'SU CÓDIGO QR ES:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  BarcodeWidget(
                    barcode: Barcode.qrCode(),
                    data: RUT,
                    width: 250,
                    height: 250,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Center(
                      child: Text(
                        'AL INGRESAR PRESENTE QR',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // Textos de estacionamiento y horario máximo de llegada
                  Text(
                    '$txtestacionamiento',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'HORARIO MÁXIMO DE LLEGADA: $horarioMaximo',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      CancelarReserva(RUT);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('AVISO'),
                            content: Text('Reserva cancelada.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => menuUsuario(
                                              RUT: RUT,
                                            )),
                                  );
                                },
                                child: Text('¡Entendido!'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.delete, color: Colors.white),
                    label: Text(
                      'CANCELAR RESERVA',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.home, color: Colors.white),
                    label: Text(
                      'VOLVER AL INICIO',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
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
