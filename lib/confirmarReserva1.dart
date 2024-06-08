// ignore_for_file: use_build_context_synchronously, no_leading_underscores_for_local_identifiers, prefer_const_constructors, prefer_interpolation_to_compose_strings, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_application_1/confirmacionRealizada.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:permission_handler/permission_handler.dart';

class confirmarReserva extends StatelessWidget {
  final controladorRUT = TextEditingController();
  final controladorDV = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? RUT;
    Future<void> _scanQR() async {
      var status = await Permission.camera.request();
      if (status.isGranted) {
        RUT = await scanner.scan();
        if (RUT != null) {
          RUT = RUT.toString();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => confirmacionRealizada(RUT: RUT.toString()),
            ),
          );
        }
      }
    }

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
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
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
                        const Text(
                          "CONFIRMAR RESERVA",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 30),
                        const Text(
                          'Ingrese el RUT que le otorgará el cliente para confirmar su llegada al estacionamiento de la Universidad de Los Lagos Campus Chinquihue',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 200,
                                height: 50,
                                child: TextField(
                                  controller: controladorRUT,
                                  decoration: InputDecoration(
                                    hintText: 'RUT sin DV',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "-",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 80,
                                height: 50,
                                child: TextField(
                                  controller: controladorDV,
                                  decoration: InputDecoration(
                                    hintText: 'DV',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        ElevatedButton.icon(
                          onPressed: () {
                            String? rut = controladorRUT.text;
                            String? dv = controladorDV.text;
                            rut = rut + '-' + dv;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    confirmacionRealizada(RUT: RUT.toString()),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                          label: Text(
                            'CONFIRMAR',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade700,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: 50),
                        ElevatedButton.icon(
                          onPressed: () {
                            _scanQR();
                          },
                          icon: Icon(
                            Icons.qr_code,
                            color: Colors.white,
                          ),
                          label: Text(
                            '¿USA QR? HAZ CLICK AQUÍ',
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
                  Positioned(
                    left: 10,
                    top: 10,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      color: Colors.blue.shade900,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
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
