// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api, camel_case_types, use_build_context_synchronously, file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_1/menuUsuario.dart';
import 'package:postgres/postgres.dart';
import 'package:flutter_application_1/database.dart';
import 'package:flutter_application_1/historialGuardiaResultados.dart';
import 'package:intl/intl.dart';

class UsuarioReservas extends StatefulWidget {
  final String RUT;
  final String nombreUsuario;
  const UsuarioReservas({super.key, required this.RUT, required this.nombreUsuario});
  @override
  _usuarioReservas createState() => _usuarioReservas();
}

class _usuarioReservas extends State<UsuarioReservas> with TickerProviderStateMixin {
  late Connection _db;
  List<List<dynamic>> reservas = [];
  late TabController _tabController;
  final TextEditingController _plateController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _dateController3 = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey3 = GlobalKey<FormState>();
  late String nombreUsuario;
  @override
  void initState() {
    nombreUsuario = widget.nombreUsuario;
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Future<dynamic> buscarHistorialPorPatente(patente, fecha) async {
    try {
      _db = DatabaseHelper().connection;
      final existeVehiculo = await _db.execute("SELECT * FROM VEHICULO WHERE vehi_patente = '${patente.toUpperCase()}'");
      if (existeVehiculo.isEmpty) {
        return 'El vehículo no se encuentra registrado en la base de datos';
      } else {
        var query =
            "SELECT r.rese_usua_rut, r.rese_hora_llegada, r.rese_vehi_patente, r.rese_hora_salida, r.rese_fecha, e.esta_numero, u.usua_nombre, u.usua_apellido_paterno, u.usua_apellido_materno, u.usua_tipo FROM reserva r INNER JOIN estacionamiento e ON r.rese_esta_id = e.esta_id INNER JOIN usuario u ON u.usua_rut = r.rese_usua_rut WHERE rese_vehi_patente = '${patente.toUpperCase()}' AND rese_estado = 'CONFIRMADA' AND rese_usua_rut = '${widget.RUT}' ORDER BY r.rese_fecha DESC, r.rese_hora_llegada DESC";
        if (fecha.isNotEmpty) {
          List<String> partes = fecha.split('/');

          // Reordena las partes de la fecha en el formato deseado
          String nuevaFecha = '${partes[2]}/${partes[1]}/${partes[0]}';
          query =
              "SELECT r.rese_usua_rut, r.rese_hora_llegada, r.rese_vehi_patente, r.rese_hora_salida, r.rese_fecha, e.esta_numero, u.usua_nombre, u.usua_apellido_paterno, u.usua_apellido_materno, u.usua_tipo FROM reserva r INNER JOIN estacionamiento e ON r.rese_esta_id = e.esta_id INNER JOIN usuario u ON u.usua_rut = r.rese_usua_rut WHERE rese_vehi_patente = '${patente.toUpperCase()}' AND rese_estado = 'CONFIRMADA' AND rese_fecha = '$nuevaFecha' AND rese_usua_rut = '${widget.RUT}' ORDER BY r.rese_fecha DESC, r.rese_hora_llegada DESC";
        }

        final result = await _db.execute(query);
        if (result.isEmpty) {
          if (fecha.isNotEmpty) {
            Navigator.of(context, rootNavigator: true).pop('dialog');
            return 'No se encontraron registros asociados a la patente ingresada y la fecha seleccionada';
          } else {
            Navigator.of(context, rootNavigator: true).pop('dialog');
            return 'No se encontraron registros asociados a la patente ingresada';
          }
        } else {
          List<Map<String, dynamic>> reservations = result
              .map((row) => {
                    'rese_usua_rut': row[0],
                    'rese_hora_llegada': row[1],
                    'rese_vehi_patente': row[2],
                    'rese_hora_salida': row[3],
                    'rese_fecha': row[4],
                    'esta_numero': row[5],
                    'usua_nombre': row[6],
                    'usua_apellido_paterno': row[7],
                    'usua_apellido_materno': row[8],
                    'usua_tipo': row[9],
                  })
              .toList();
          print(reservations);
          Navigator.of(context, rootNavigator: true).pop('dialog');
          return reservations;
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> buscarHistorialPorFecha(fecha) async {
    try {
      _db = DatabaseHelper().connection;
      List<String> partes = fecha.split('/');

      // Reordena las partes de la fecha en el formato deseado
      String nuevaFecha = '${partes[2]}/${partes[1]}/${partes[0]}';
      var query =
          "SELECT r.rese_usua_rut, r.rese_hora_llegada, r.rese_vehi_patente, r.rese_hora_salida, r.rese_fecha, e.esta_numero, u.usua_nombre, u.usua_apellido_paterno, u.usua_apellido_materno, u.usua_tipo FROM reserva r INNER JOIN estacionamiento e ON r.rese_esta_id = e.esta_id INNER JOIN usuario u ON u.usua_rut = r.rese_usua_rut WHERE rese_estado = 'CONFIRMADA' AND rese_fecha = '$nuevaFecha' AND rese_usua_rut = '${widget.RUT}' ORDER BY r.rese_fecha DESC, r.rese_hora_llegada DESC";

      final result = await _db.execute(query);

      if (result.isEmpty) {
        Navigator.of(context, rootNavigator: true).pop('dialog');
        return 'No se encontraron registros asociados a la fecha seleccionada';
      } else {
        List<Map<String, dynamic>> reservations = result
            .map((row) => {
                  'rese_usua_rut': row[0],
                  'rese_hora_llegada': row[1],
                  'rese_vehi_patente': row[2],
                  'rese_hora_salida': row[3],
                  'rese_fecha': row[4],
                  'esta_numero': row[5],
                  'usua_nombre': row[6],
                  'usua_apellido_paterno': row[7],
                  'usua_apellido_materno': row[8],
                  'usua_tipo': row[9],
                })
            .toList();
        Navigator.of(context, rootNavigator: true).pop('dialog');
        return reservations;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MenuUsuario(RUT: widget.RUT, nombreUsuario: nombreUsuario)),
      ),
      child: Scaffold(
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
                      const Text(
                        "Buscar por",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      TabBar(
                        controller: _tabController,
                        tabs: const [
                          Tab(text: 'Fecha'),
                          Tab(text: 'Patente'),
                        ],
                      ),
                      SizedBox(
                        height: 600,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            // Aquí va el formulario de búsqueda por fecha
                            buildFechaSearchForm(),
                            // Aquí va el formulario de búsqueda por patente
                            buildPatenteSearchForm(),
                          ],
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

  Widget buildPatenteSearchForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Patente',
                ),
                TextFormField(
                  maxLength: 6,
                  controller: _plateController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    RegExp regex = RegExp(r'^[a-zA-Z]{4}\d{2}$');
                    if (value!.isEmpty || !regex.hasMatch(value)) {
                      return 'Ingrese una patente válida';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Ej: GGXX20',
                    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1.0),
                    ),
                    counterText: '',
                  ),
                  textInputAction: TextInputAction.done,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Fecha (opcional)', textAlign: TextAlign.start),
                TextFormField(
                  controller: _dateController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return null; // Si el valor es nulo o vacío, no hacemos ninguna validación
                    }
                    RegExp regex = RegExp(r'^\d{0,2}\/\d{0,2}\/\d{0,4}$');
                    if (!regex.hasMatch(value)) {
                      return 'Ingrese una fecha válida';
                    } else {
                      DateTime? selectedDate = DateFormat('dd/MM/yyyy').parse(value, true);
                      if (selectedDate.isBefore(DateTime(2024, 1, 1)) || selectedDate.isAfter(DateTime.now())) {
                        return 'Ingrese una fecha entre 01/01/2024 y 09/06/2024';
                      }
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'DD/MM/AAAA',
                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: const OutlineInputBorder(),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1.0),
                    ),
                    counterText: '',
                    suffixIcon: _dateController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                _dateController.clear();
                              });
                            },
                          )
                        : null,
                  ),
                  textInputAction: TextInputAction.done,
                  readOnly: true, // Hace que el campo sea solo de lectura
                  enableInteractiveSelection: false,
                  onTap: () {
                    _seleccionarFecha(_dateController);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 75),
          Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      Colors.blue.shade800,
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) => const AlertDialog(
                          content: SizedBox(
                            height: 250,
                            child: Center(
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: CircularProgressIndicator(
                                  strokeWidth: 7,
                                  semanticsLabel: 'Circular progress indicator',
                                ),
                              ),
                            ),
                          ),
                          elevation: 24,
                        ),
                      );
                      final result = await buscarHistorialPorPatente(_plateController.text, _dateController.text);
                      if (result is String) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Error'),
                              content: Text(result),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HistorialGuardiaresultados(
                              texto: 'patente ${_plateController.text.toUpperCase()}',
                              historial: result,
                            ),
                          ),
                        );
                      }
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        Text(
                          'Buscar',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      Colors.blue.shade800,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.exit_to_app,
                          color: Colors.white,
                        ),
                        Text(
                          'Volver al menu principal',
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
        ],
      ),
    );
  }

  Future<void> _seleccionarFecha(TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      final formattedDate = DateFormat('dd/MM/yyyy').format(picked);
      setState(() {
        controller.text = formattedDate;
      });
    }
  }

  Widget buildFechaSearchForm() {
    return Form(
      key: _formKey3,
      child: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Fecha', textAlign: TextAlign.start),
                TextFormField(
                  controller: _dateController3,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty || value == '') {
                      return 'Ingrese una fecha válida';
                    }
                    RegExp regex = RegExp(r'^\d{0,2}\/\d{0,2}\/\d{0,4}$');
                    if (!regex.hasMatch(value)) {
                      return 'Ingrese una fecha válida';
                    } else {
                      DateTime? selectedDate = DateFormat('dd/MM/yyyy').parse(value, true);
                      if (selectedDate.isBefore(DateTime(2024, 1, 1)) || selectedDate.isAfter(DateTime.now())) {
                        return 'Ingrese una fecha entre 01/01/2024 y 09/06/2024';
                      }
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'DD/MM/AAAA',
                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: const OutlineInputBorder(),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1.0),
                    ),
                    counterText: '',
                    suffixIcon: _dateController3.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                _dateController3.clear();
                              });
                            },
                          )
                        : null,
                  ),
                  textInputAction: TextInputAction.done,
                  readOnly: true, // Hace que el campo sea solo de lectura
                  enableInteractiveSelection: false,
                  onTap: () {
                    _seleccionarFecha(_dateController3);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 75),
          Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Colors.blue.shade800,
                      ),
                    ),
                    onPressed: () async {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) => const AlertDialog(
                          content: SizedBox(
                            height: 250,
                            child: Center(
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: CircularProgressIndicator(
                                  strokeWidth: 7,
                                  semanticsLabel: 'Circular progress indicator',
                                ),
                              ),
                            ),
                          ),
                          elevation: 24,
                        ),
                      );
                      if (_formKey3.currentState?.validate() ?? false) {
                        final result = await buscarHistorialPorFecha(_dateController3.text);
                        if (result is String) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Error'),
                                content: Text(result),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HistorialGuardiaresultados(
                                texto: 'la fecha ${_dateController3.text.toUpperCase()}',
                                historial: result,
                              ),
                            ),
                          );
                        }
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          Text(
                            'Buscar',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      Colors.blue.shade800,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.exit_to_app,
                          color: Colors.white,
                        ),
                        Text(
                          'Volver al menu principal',
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
        ],
      ),
    );
  }
}

bool validarRut(String input) {
  RegExp regex = RegExp(r'^\d{7,8}-[\dkK]$');

  if (regex.hasMatch(input)) {
    List<String> rutSplit = input.split('-');
    String rut = rutSplit[0];
    String digV = rutSplit[1];
    int sum = 0;
    int j = 2;

    if (digV == 'K') {
      digV = 'k';
    }

    for (int i = rut.length - 1; i >= 0; i--) {
      sum += int.parse(rut[i]) * j;
      j++;
      if (j > 7) {
        j = 2;
      }
    }

    int vDiv = sum ~/ 11;
    int vMult = vDiv * 11;
    int vRes = sum - vMult;
    int vFinal = 11 - vRes;

    if (digV == 'k' && vFinal == 10) {
      return true;
    } else if (digV == '0' && vFinal == 11) {
      return true;
    } else if (int.parse(digV) == vFinal) {
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
}
