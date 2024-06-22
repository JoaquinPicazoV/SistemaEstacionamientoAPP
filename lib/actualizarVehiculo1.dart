// ignore_for_file: file_names, library_private_types_in_public_api, non_constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_application_1/actualizar_vehiculo2.dart';
import 'package:flutter_application_1/anadir_vehiculo.dart';
import 'package:flutter_application_1/database.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/menuUsuario.dart';
import 'package:flutter_application_1/sesion.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:postgres/postgres.dart';

class ActualizarVehiculo extends StatefulWidget {
  final String RUT;
  final String nombreUsuario;

  const ActualizarVehiculo({super.key, required this.RUT, required this.nombreUsuario});
  @override
  _ActualizarVehiculoState createState() => _ActualizarVehiculoState();
}

class _ActualizarVehiculoState extends State<ActualizarVehiculo> {
  List<Map<String, dynamic>> _vehicles = [];
  bool _isLoading = true;
  late String RUT = 'BUSCANDO';
  late String nombreUsuario;
  @override
  void initState() {
    RUT = widget.RUT;
    nombreUsuario = widget.nombreUsuario;
    _connectToDatabase();
    super.initState();
  }

  Future<void> _connectToDatabase() async {
    Connection _db = DatabaseHelper().connection;

    final results = await _db.execute(
        "SELECT v.vehi_patente, v.vehi_marca, v.vehi_modelo, v.vehi_anio FROM vehiculo v JOIN registrousuariovehiculo ruv ON v.vehi_patente = ruv.regi_vehi_patente WHERE ruv.regi_usua_rut = '$RUT'");
    setState(() {
      _vehicles = [];
      for (List<dynamic> row in results) {
        Map<String, dynamic> vehicleMap = {
          'vehi_patente': row[0],
          'vehi_marca': row[1],
          'vehi_modelo': row[2],
          'vehi_anio': row[3],
        };
        _vehicles.add(vehicleMap);
      }
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MenuUsuario(RUT: RUT, nombreUsuario: nombreUsuario),
        ),
      ),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                      const SizedBox(height: 30),
                      const Text(
                        "DATOS VEHÍCULO",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),
                      FractionallySizedBox(
                        widthFactor: 0.97,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _isLoading
                              ? [
                                  const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ]
                              : _vehicles.map((vehicle) => _buildVehicleContainer(vehicle)).toList(),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AnadirVehiculo(RUT: RUT, nombreUsuario: widget.nombreUsuario),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'Añadir',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade700,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                        width: 20,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MenuUsuario(RUT: RUT, nombreUsuario: widget.nombreUsuario),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.home,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'VOLVER AL MENÚ',
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
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVehicleContainer(Map<String, dynamic> vehicleData) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green, width: 2), // Ajusta el ancho del borde aquí
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDataRow("Patente:", vehicleData["vehi_patente"]),
          _buildDataRow("Marca:", vehicleData["vehi_marca"]),
          _buildDataRow("Modelo:", vehicleData["vehi_modelo"]),
          _buildDataRow("Año:", vehicleData["vehi_anio"].toString()),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildButton("Editar", Icons.edit, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ActualizarVehiculo2(rut: RUT, nombreUsuario: nombreUsuario, patente: vehicleData["vehi_patente"]),
                  ),
                );
              }, Colors.blue), // Color verde para el botón "Editar"
              _buildButton("Eliminar", Icons.delete, () {
                // Aquí va la lógica para eliminar el vehículo
              }, Colors.red), // Color rojo para el botón "Eliminar"
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton("Usar", Icons.verified, () {
                // Aquí va la lógica para usar el vehículo
              }, Colors.green), // Color azul para el botón "Usar"
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, IconData icon, Function() onPressed, Color color) {
    return Container(
      width: 140, // Ancho fijo para los botones
      decoration: BoxDecoration(
        color: color, // Color de fondo del contenedor
        borderRadius: BorderRadius.circular(10), // Radio del borde del contenedor
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: Colors.white, // Color blanco para el icono
        ),
        label: Text(
          text,
          style: const TextStyle(color: Colors.white), // Color blanco para el texto del botón
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent, // Establece el color transparente para el botón
          shadowColor: Colors.transparent,
        ),
      ),
    );
  }

  Widget _buildDataRow(String title, String? data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          data ?? '',
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
