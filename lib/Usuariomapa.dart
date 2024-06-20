// ignore_for_file: file_names, non_constant_identifier_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_application_1/codigoReserva.dart';
import 'package:flutter_application_1/database.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/menuUsuario.dart';
import 'package:flutter_application_1/sesion.dart';
import 'package:flutter_svg/svg.dart';
import 'package:postgres/postgres.dart';

class UsuarioMapa extends StatefulWidget {
  final String RUT;
  final String nombreUsuario;

  const UsuarioMapa({super.key, required this.RUT, required this.nombreUsuario});
  @override
  _UsuarioMapa createState() => _UsuarioMapa();
}

class _UsuarioMapa extends State<UsuarioMapa> with SingleTickerProviderStateMixin {
  late String RUT = '';
  late Connection _db;
  int tamA = 0, tamB = 0, tamC = 0, tamD = 0, tamE = 0;
  List<String> A = [], B = [], C = [], D = [], E = [];
  int nEst = 0;
  bool cargando = true;

  Future<void> ObtenerTam() async {
    _db = DatabaseHelper().connection;

    final a = await _db.execute("SELECT secc_capacidad FROM SECCION WHERE secc_nombre = 'SECCIÓN A'");
    final b = await _db.execute("SELECT secc_capacidad FROM SECCION WHERE secc_nombre = 'SECCIÓN B'");
    final c = await _db.execute("SELECT secc_capacidad FROM SECCION WHERE secc_nombre = 'SECCIÓN C'");
    final d = await _db.execute("SELECT secc_capacidad FROM SECCION WHERE secc_nombre = 'SECCIÓN D'");
    final e = await _db.execute("SELECT secc_capacidad FROM SECCION WHERE secc_nombre = 'SECCIÓN E'");

    final estacionamientos = await _db.execute('SELECT esta_estado FROM ESTACIONAMIENTO ORDER BY esta_numero ASC');

    int posInicial = 0;

    // Sección A
    for (int i = 0; i < int.parse(a[0][0].toString()); i++) {
      A.add(estacionamientos[posInicial + i][0].toString());
    }
    posInicial += int.parse(a[0][0].toString());
    tamA = int.parse(a[0][0].toString());

    // Sección B
    for (int i = 0; i < int.parse(b[0][0].toString()); i++) {
      B.add(estacionamientos[posInicial + i][0].toString());
    }
    posInicial += int.parse(b[0][0].toString());
    tamB = int.parse(b[0][0].toString());

    // Sección C
    for (int i = 0; i < int.parse(c[0][0].toString()); i++) {
      C.add(estacionamientos[posInicial + i][0].toString());
    }
    posInicial += int.parse(c[0][0].toString());
    tamC = int.parse(c[0][0].toString());

    // Sección D
    for (int i = 0; i < int.parse(d[0][0].toString()); i++) {
      D.add(estacionamientos[posInicial + i][0].toString());
    }
    posInicial += int.parse(d[0][0].toString());
    tamD = int.parse(d[0][0].toString());

    // Sección E
    for (int i = 0; i < int.parse(e[0][0].toString()); i++) {
      E.add(estacionamientos[posInicial + i][0].toString());
    }
    posInicial += int.parse(e[0][0].toString());
    tamE = int.parse(e[0][0].toString());

    setState(() {});
  }

  Future<void> ObtenerTam2() async {
    _db = DatabaseHelper().connection;

    final capacidad = await _db.execute("SELECT secc_capacidad FROM SECCION");

    final estacionamientos = await _db.execute("SELECT esta_estado FROM ESTACIONAMIENTO ORDER BY esta_numero ASC");

    int posInicial = 0;

    // Sección A
    for (int i = 0; i < int.parse(capacidad[0][0].toString()); i++) {
      A.add(estacionamientos[posInicial + i][0].toString());
    }
    posInicial += int.parse(capacidad[0][0].toString());
    tamA = int.parse(capacidad[0][0].toString());

    // Sección B
    for (int i = 0; i < int.parse(capacidad[1][0].toString()); i++) {
      B.add(estacionamientos[posInicial + i][0].toString());
    }
    posInicial += int.parse(capacidad[1][0].toString());
    tamB = int.parse(capacidad[1][0].toString());

    // Sección C
    for (int i = 0; i < int.parse(capacidad[2][0].toString()); i++) {
      C.add(estacionamientos[posInicial + i][0].toString());
    }
    posInicial += int.parse(capacidad[2][0].toString());
    tamC = int.parse(capacidad[2][0].toString());

    // Sección D
    for (int i = 0; i < int.parse(capacidad[3][0].toString()); i++) {
      D.add(estacionamientos[posInicial + i][0].toString());
    }
    posInicial += int.parse(capacidad[3][0].toString());
    tamD = int.parse(capacidad[3][0].toString());

    // Sección E
    for (int i = 0; i < int.parse(capacidad[4][0].toString()); i++) {
      E.add(estacionamientos[posInicial + i][0].toString());
    }
    posInicial += int.parse(capacidad[4][0].toString());
    tamE = int.parse(capacidad[4][0].toString());

    cargando = false;
    setState(() {});
  }

  late String nombreUsuario;
  late TabController ControlladorBarra;
  late List<bool> estaSeleccionado;

  @override
  void initState() {
    RUT = widget.RUT;
    nombreUsuario = widget.nombreUsuario;
    super.initState();
    ControlladorBarra = TabController(length: 5, vsync: this);
    estaSeleccionado = List.generate(104, (index) => false);
    ObtenerTam2();
  }

  @override
  void dispose() {
    ControlladorBarra.dispose();
    super.dispose();
  }

  void _handleTap(int index) {
    setState(() {
      for (int i = 0; i < estaSeleccionado.length; i++) {
        if (i != index) {
          estaSeleccionado[i] = false;
        }
      }
      estaSeleccionado[index] = !estaSeleccionado[index];
    });
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
            builder: (context) => MenuUsuario(RUT: RUT, nombreUsuario: nombreUsuario),
          ),
        );
      },
      child: Scaffold(
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    Expanded(
                      child: Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: Image.asset(
                              'assets/img/Mapa.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          TabBar(
                            controller: ControlladorBarra,
                            indicatorColor: Colors.blue.shade900,
                            labelColor: Colors.blue.shade900,
                            unselectedLabelColor: Colors.grey,
                            tabs: const [
                              Tab(text: 'A'),
                              Tab(text: 'B'),
                              Tab(text: 'C'),
                              Tab(text: 'D'),
                              Tab(text: 'E'),
                            ],
                          ),
                          if (cargando == true)
                            const Expanded(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          else
                            Expanded(
                              child: TabBarView(
                                controller: ControlladorBarra,
                                children: [
                                  GridView.count(
                                    crossAxisCount: 4,
                                    children: zona(tamA, A),
                                  ),
                                  GridView.count(
                                    crossAxisCount: 4,
                                    children: zona(tamB, B),
                                  ),
                                  GridView.count(crossAxisCount: 4, children: zona(tamC, C)),
                                  GridView.count(crossAxisCount: 4, children: zona(tamD, D)),
                                  GridView.count(crossAxisCount: 4, children: zona(tamE, E)),
                                ],
                              ),
                            ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.black),
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Text(
                                    'Disponible',
                                    style: TextStyle(
                                      fontSize: 8,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.black),
                                      color: Colors.yellow,
                                    ),
                                  ),
                                  const Text(
                                    'Reservado',
                                    style: TextStyle(
                                      fontSize: 8,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.black),
                                      color: Colors.red,
                                    ),
                                  ),
                                  const Text(
                                    'Ocupado',
                                    style: TextStyle(
                                      fontSize: 8,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.black),
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const Text(
                                    'No disponible',
                                    style: TextStyle(
                                      fontSize: 8,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.black),
                                      color: Colors.blue,
                                    ),
                                  ),
                                  const Text(
                                    'Seleccionado',
                                    style: TextStyle(
                                      fontSize: 8,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              print(nEst + 1);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => codigoReserva(nEst: (nEst + 1).toString(), RUT: RUT),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            label: const Text(
                              'RESERVAR',
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> zona(int tamSeccion, List<String> seccion) {
    return List.generate(
      tamSeccion,
      (index) {
        String estado = seccion[index];
        bool ocupado = estado == "OCUPADO";
        bool noDisp = estado == "NO DISPONIBLE";
        bool reservado = estado == 'RESERVADO';
        bool seleccionado = estaSeleccionado[index];

        return GestureDetector(
          onTap: () {
            if (!ocupado && !noDisp && !reservado) {
              _handleTap(index);
              nEst = index;
            }
          },
          child: Container(
            width: 20,
            height: 20,
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ocupado
                  ? Colors.red
                  : noDisp
                      ? Colors.grey
                      : reservado
                          ? Colors.yellow
                          : seleccionado
                              ? Colors.lightBlueAccent
                              : Colors.green,
              border: Border.all(color: Colors.black),
            ),
            child: Center(
              child: Text(
                (index + 1).toString(),
                style: TextStyle(
                  color: seleccionado ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
