// ignore_for_file: use_build_context_synchronously, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_1/confirmacionRealizada.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:permission_handler/permission_handler.dart';

class ConfirmarReserva extends StatelessWidget {
  final controladorRUT = TextEditingController();
  final controladorDV = TextEditingController();

  ConfirmarReserva({super.key});

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
              builder: (context) => ConfirmacionRealizada(RUT: RUT.toString()),
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
                        const SizedBox(height: 30),
                        const Text(
                          'Ingrese el RUT que le otorgará el cliente para confirmar su llegada al estacionamiento de la Universidad de Los Lagos Campus Chinquihue',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 30),
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
                                  decoration: const InputDecoration(
                                    hintText: 'RUT sin DV',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.blue),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.blue),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
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
                                  decoration: const InputDecoration(
                                    hintText: 'DV',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.blue),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.blue),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton.icon(
                          onPressed: () {
                            String rut = controladorRUT.text;
                            String dv = controladorDV.text;
                            rut = '$rut-$dv';
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ConfirmacionRealizada(RUT: rut),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                          label: const Text(
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
                        const SizedBox(height: 50),
                        ElevatedButton.icon(
                          onPressed: () {
                            _scanQR();
                          },
                          icon: const Icon(
                            Icons.qr_code,
                            color: Colors.white,
                          ),
                          label: const Text(
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
                      icon: const Icon(Icons.arrow_back),
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
