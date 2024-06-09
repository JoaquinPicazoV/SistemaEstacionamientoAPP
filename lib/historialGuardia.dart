// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, file_names, use_key_in_widget_constructors, camel_case_types, library_private_types_in_public_api, avoid_print, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_application_1/database.dart';
import 'package:postgres/postgres.dart';

class historialGuardia extends StatefulWidget {
  @override
  _HistorialGuardiaState createState() => _HistorialGuardiaState();
}

class _HistorialGuardiaState extends State<historialGuardia> {
  late Connection _db;
  List<List<dynamic>> reservas = [];

  @override
  void initState() {
    super.initState();
    buscarHistorial();
  }

  Future<void> buscarHistorial() async {
    print('buscando');
    Connection _db = DatabaseHelper().connection;

    final size = await _db.execute("SELECT COUNT(*) FROM RESERVA");
    final tam = size[0][0] as int;

    final datosReserva = await _db.execute("SELECT rese_usua_rut, rese_vehi_patente, rese_esta_id, TO_CHAR(rese_fecha, 'DD-MM-YY') AS rese_fecha, rese_estado FROM RESERVA");

    setState(() {
      reservas.clear();
      for (var i = 0; i < tam; i++) {
        reservas.add([
          datosReserva[i][0].toString(),
          datosReserva[i][1].toString(),
          datosReserva[i][2].toString().replaceFirst("CHI", "").trim(),
          datosReserva[i][3].toString(),
          datosReserva[i][4].toString(),
        ]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: Align(
        child: SafeArea(
          child: FractionallySizedBox(
            widthFactor: 0.95,
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
                      "HISTORIAL RESERVAS",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: buscarHistorial,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade800,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: Icon(Icons.refresh, color: Colors.white),
                      label: Text(
                        'Actualizar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: 0.95,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: Text(
                                        'RUT',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Flexible(
                                      flex: 2,
                                      fit: FlexFit.tight,
                                      child: Text(
                                        'Patente',
                                        textAlign: TextAlign.center,
                                        softWrap: true,
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: Text(
                                        'nº Est',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: Text(
                                        'Fecha',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: Text(
                                        'Estado',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              for (var reserva in reservas)
                                Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        fit: FlexFit.tight,
                                        child: Text(
                                          reserva[0].toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Flexible(
                                        flex: 2,
                                        fit: FlexFit.tight,
                                        child: Text(
                                          reserva[1].toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        fit: FlexFit.tight,
                                        child: Text(
                                          reserva[2].toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        fit: FlexFit.tight,
                                        child: Text(
                                          reserva[3].toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        fit: FlexFit.tight,
                                        child: Text(
                                          reserva[4].toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                            Colors.blue.shade800,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.exit_to_app,
                              color: Colors.white,
                            ),
                            Text(
                              'Atras',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
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
