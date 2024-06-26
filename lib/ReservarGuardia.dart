// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';

class ReservarGuardia extends StatefulWidget {
  final String nEsta;

  const ReservarGuardia({super.key, required this.nEsta});
  @override
  _ReservarGuardia createState() => _ReservarGuardia();
}

class _ReservarGuardia extends State<ReservarGuardia> {
  late String nEsta = '';
  @override
  void initState() {
    nEsta = widget.nEsta;
    super.initState();
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
                    CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.blue.shade700,
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 100,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "¡RESERVA EXITOSA!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Estacionamiento reservado: $nEsta",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MyApp()),
                        );
                      },
                      icon: const Icon(Icons.home, color: Colors.white),
                      label: const Text(
                        "VOLVER AL INICIO",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue.shade700),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
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
