// ignore_for_file: library_private_types_in_public_api, camel_case_types, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_1/database.dart';
import 'package:flutter_application_1/main.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter_application_1/menuUsuario.dart';
import 'package:flutter_application_1/sesion.dart';
import 'package:postgres/postgres.dart';
import 'package:intl/intl.dart';

class CodigoReserva extends StatefulWidget {
  final String RUT;
  final String nEst;

  const CodigoReserva({super.key, required this.nEst, required this.RUT});
  @override
  _codigoReserva createState() => _codigoReserva();
}

class _codigoReserva extends State<CodigoReserva> {
  late String nEst = '';
  bool cargando = true;
  @override
  void initState() {
    RUT = widget.RUT;
    nEst = widget.nEst;
    buscarNombre(RUT);
    super.initState();
    reservar(RUT);
  }

  String txtestacionamiento = '';
  String estacionamiento = '';
  String horarioMaximo = '';
  String txthorarioMaximo = '';
  String nombreUsuario = 'Buscando nombre...';
  Future<void> buscarNombre(rut) async {
    Connection _db = DatabaseHelper().connection;

    final nombre = await _db.execute("SELECT usua_nombre, usua_apellido_paterno FROM USUARIO WHERE usua_rut='$RUT'");

    setState(() {
      nombreUsuario = '${nombre[0][0]} ${nombre[0][1]}';
    });
  }

  Future<void> datosReserva(RUT) async {
    Connection _db = DatabaseHelper().connection;
    final datosReserva =
        await _db.execute("SELECT rese_esta_id, TO_CHAR(rese_hora_inicio + INTERVAL '30 minutes', 'HH24:MI') AS nueva_hora_ FROM RESERVA WHERE rese_usua_rut='$RUT' AND rese_estado='EN ESPERA'");

    setState(() {
      horarioMaximo = datosReserva[0][1].toString();
      estacionamiento = nEst;
      txtestacionamiento = 'ESTACIONAMIENTO: $estacionamiento';
      txthorarioMaximo = 'HORARIO MÁXIMO DE LLEGADA: $horarioMaximo';
      cargando = false;
    });
  }

  Future<void> cancelarReserva(RUT) async {
    Connection _db = DatabaseHelper().connection;
    final datos = await _db.execute("SELECT rese_id, rese_esta_id FROM RESERVA WHERE rese_usua_rut='$RUT' AND rese_estado='EN ESPERA'");
    final estadoEst = await _db.execute("UPDATE ESTACIONAMIENTO SET esta_estado='LIBRE' WHERE esta_numero='$nEst'");
    final eliminar = await _db.execute("DELETE FROM RESERVA WHERE rese_id='${datos[0][0]}'");
  }

  Future<void> reservar(RUT) async {
    Connection _db = DatabaseHelper().connection;
    DateTime actual = DateTime.now();
    String fechaFormato = DateFormat('MM-dd-yy').format(actual);

    String horaFormato = DateFormat('HH:mm:ss').format(actual);

    final patente = await _db.execute("SELECT regi_vehi_patente FROM REGISTROUSUARIOVEHICULO WHERE regi_usua_rut='$RUT' AND regi_estado='activo'");
    final nEstacionamiento = nEst;
    final ID = await _db.execute("SELECT esta_id FROM ESTACIONAMIENTO WHERE esta_numero='$nEstacionamiento'");
    final rutGuardia = '21008896-2';

    print(patente[0][0]);
    print(ID[0][0]);
    print(fechaFormato);
    print(horaFormato);

    print('rut guardia:$rutGuardia, RUT: $RUT, ID:$ID, patente:$patente, fecha formato:$fechaFormato, hora formato:$horaFormato');

    final reservar = await _db.execute(
      "INSERT INTO RESERVA(rese_guar_rut, rese_usua_rut, rese_esta_id, rese_vehi_patente, rese_fecha, rese_estado, rese_hora_inicio) VALUES('$rutGuardia', '$RUT', '${ID[0][0]}', '${patente[0][0]}', '$fechaFormato', 'EN ESPERA', '$horaFormato')",
    );
    print('{ID[0][0].toString()}:${ID[0][0].toString()}');
    final estadoEstacionamiento = await _db.execute("UPDATE ESTACIONAMIENTO SET esta_estado='RESERVADO' WHERE esta_id='${ID[0][0]}'");

    print(reservar);
    print(estadoEstacionamiento);
    datosReserva(RUT);
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
                              nombreUsuario,
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
                                  MaterialPageRoute(builder: (context) => const MyApp()),
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
                  const Padding(
                    padding: EdgeInsets.all(8.0),
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
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
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
                  if (!cargando)
                    Text(
                      txtestacionamiento,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  Text(
                    txthorarioMaximo,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (cargando) const CircularProgressIndicator(),

                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      cancelarReserva(RUT);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('AVISO'),
                            content: const Text('Reserva cancelada.'),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  String? authNombreFuture = getSessionNombre().toString();
                                  String authNombre = authNombreFuture.toString();
                                  Navigator.of(context).pop();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MenuUsuario(
                                        RUT: RUT,
                                        nombreUsuario: authNombre,
                                      ),
                                    ),
                                  );
                                },
                                child: const Text('¡Entendido!'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.delete, color: Colors.white),
                    label: const Text(
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
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      String authNombre = getSessionNombre().toString();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MenuUsuario(RUT: RUT, nombreUsuario: authNombre),
                        ),
                      );
                    },
                    icon: const Icon(Icons.home, color: Colors.white),
                    label: const Text(
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
