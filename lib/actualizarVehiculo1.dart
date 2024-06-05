import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class actualizarVehiculo extends StatefulWidget {
  @override
  _ActualizarVehiculoState createState() => _ActualizarVehiculoState();
}

class _ActualizarVehiculoState extends State<actualizarVehiculo> {
  
  List<Map<String, dynamic>> _vehicles = [];
  late Connection _db;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _connectToDatabase();

  }

  Future<void> _connectToDatabase() async {
    _db = await Connection.open(
      Endpoint(
        host: 'ep-sparkling-dream-a5pwwhsb.us-east-2.aws.neon.tech',
        database: 'estacionamientosUlagos',
        username: 'estacionamientosUlagos_owner',
        password: 'D7HQdX0nweTx',
      ),
      settings: const ConnectionSettings(sslMode: SslMode.require),
    );

    String rut = '21008896-2';

    final results = await _db.execute(
        "SELECT v.vehi_patente, v.vehi_marca, v.vehi_modelo, v.vehi_anio FROM vehiculo v JOIN registrousuariovehiculo ruv ON v.vehi_patente = ruv.regi_vehi_patente WHERE ruv.regi_usua_rut = '$rut'");

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
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: Align(
        alignment: Alignment.center,
        child: SafeArea(
          child: FractionallySizedBox(
            widthFactor: 0.81,
            heightFactor: 0.95,
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),
                      Row(
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
                                'Nombre_Usuario',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue.shade900,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextButton.icon(
                                onPressed: () {
                                  // Aquí va tu lógica para cerrar sesión
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
                      SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          "DATOS VEHÍCULO",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _isLoading
                            ? [Center(child: CircularProgressIndicator())]
                            : _vehicles
                                .map((vehicle) => _buildVehicleContainer(vehicle))
                                .toList(),
                      ),
                      SizedBox(height: 200),
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
    margin: EdgeInsets.symmetric(vertical: 10),
    padding: EdgeInsets.all(10),
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
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildButton("Editar", Icons.edit, () {
              // Aquí va la lógica para editar el vehículo
            }, Colors.blue), // Color verde para el botón "Editar"
            _buildButton("Eliminar", Icons.delete, () {
              // Aquí va la lógica para eliminar el vehículo
            }, Colors.red), // Color rojo para el botón "Eliminar"
          ],
        ),
        SizedBox(height: 10),
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
        style: TextStyle(color: Colors.white), // Color blanco para el texto del botón
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
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 6),
        Text(
          data ?? '',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
