// ignore_for_file: library_private_types_in_public_api, camel_case_types, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_1/database.dart';
import 'package:flutter_application_1/main.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter_application_1/menuUsuario.dart';
import 'package:flutter_application_1/sesion.dart';
import 'package:flutter_application_1/usuarioMapa.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:postgres/postgres.dart';
import 'package:intl/intl.dart';

class CodigoReserva extends StatefulWidget {
  final String RUT, nEst, nombreUsuario;

  const CodigoReserva({super.key, required this.nEst, required this.RUT, required this.nombreUsuario});
  @override
  _codigoReserva createState() => _codigoReserva();
}

class _codigoReserva extends State<CodigoReserva> {
  late String nEst, nombreUsuario, RUT;
  bool cargando = true, cancelar = false, noPatente = false;
  @override
  void initState() {
    RUT = widget.RUT;
    nEst = widget.nEst;
    nombreUsuario = widget.nombreUsuario;
    super.initState();
    reservar(RUT);
  }

  String txtestacionamiento = '';
  String estacionamiento = '';
  String horarioMaximo = '';
  String txthorarioMaximo = '';

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

  Future<void> reservar(String RUT) async {
    Connection _db = DatabaseHelper().connection;
    DateTime actual = DateTime.now();
    String fechaFormato = DateFormat('MM-dd-yy').format(actual);
    String horaFormato = DateFormat('HH:mm:ss').format(actual);

    final no =
        await _db.execute("SELECT COUNT(*) FROM reserva WHERE rese_fecha = DATE '$fechaFormato' AND rese_hora_inicio + INTERVAL '30 minutes' > TIME '$horaFormato'AND rese_usua_rut = '$RUT' LIMIT 1");
    if (int.parse(no[0][0].toString()) >= 1) {
      setState(() {
        cancelar = true;
        cargando = false;
      });
    } else {
      cancelar = false;
      final patente = await _db.execute("SELECT regi_vehi_patente FROM REGISTROUSUARIOVEHICULO WHERE regi_usua_rut='$RUT' AND regi_estado='activo'");
      final nEstacionamiento = nEst;
      final ID = await _db.execute("SELECT esta_id FROM ESTACIONAMIENTO WHERE esta_numero='$nEstacionamiento'");
      final rutGuardia = '21008896-2';

      try {
        print(patente[0][0]);
      } catch (e) {
        setState(() {
          cargando = false;
          noPatente = true;
          return;
        });
      }
      print(ID[0][0]);
      print(fechaFormato);
      print(horaFormato);

      print('rut guardia:$rutGuardia, RUT: $RUT, ID:$ID, patente:$patente, fecha formato:$fechaFormato, hora formato:$horaFormato');

      await _db.execute(
        "INSERT INTO RESERVA(rese_guar_rut, rese_usua_rut, rese_esta_id, rese_vehi_patente, rese_fecha, rese_estado, rese_hora_inicio,rese_is_usua) VALUES('$rutGuardia', '$RUT', '${ID[0][0]}', '${patente[0][0]}', '$fechaFormato', 'EN ESPERA', '$horaFormato','t')",
      );
      print('{ID[0][0].toString()}:${ID[0][0].toString()}');
      await _db.execute("UPDATE ESTACIONAMIENTO SET esta_estado='RESERVADO' WHERE esta_id='${ID[0][0]}'");
      datosReserva(RUT);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        dispose();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UsuarioMapa(RUT: RUT, nombreUsuario: nombreUsuario),
          ),
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
                      if (!cargando && !cancelar)
                        Column(
                          children: [
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
                          ],
                        ),
                      if (!cargando && cancelar)
                        const Text(
                          'Ya tiene una reserva',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      if (!cargando && noPatente)
                        const Text(
                          'No tiene vehiculos activos',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),

                      if (cargando) const CircularProgressIndicator(),

                      const SizedBox(height: 20),
                      if (!cargando && !cancelar && !noPatente)
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
                                        Navigator.of(context).pop();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MenuUsuario(
                                              RUT: RUT,
                                              nombreUsuario: nombreUsuario,
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MenuUsuario(RUT: RUT, nombreUsuario: nombreUsuario),
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
        ),
      ),
    );
  }
}
