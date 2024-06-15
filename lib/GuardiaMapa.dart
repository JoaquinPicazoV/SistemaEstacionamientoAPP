// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_application_1/ReservarGuardia.dart';
import 'package:flutter_application_1/database.dart';
import 'package:flutter_application_1/menuGuardia.dart';
import 'package:postgres/postgres.dart';

class GuardiaMapa extends StatefulWidget {
  @override
  _GuardiaMapaState createState() => _GuardiaMapaState();
}

class _GuardiaMapaState extends State<GuardiaMapa>
    with SingleTickerProviderStateMixin {
  late Connection _db;
  int tamA = 0;
  int tamB = 0;
  int tamC = 0;
  int tamD = 0;
  int tamE = 0;
  List<String> A = [];
  List<String> B = [];
  List<String> C = [];
  List<String> D = [];
  List<String> E = [];
  int nEst = 0;

  Future<void> ObtenerTam() async {
    _db = DatabaseHelper().connection;

    final a = await _db.execute(
        "SELECT secc_capacidad FROM SECCION WHERE secc_nombre = 'SECCIÓN A'");
    final b = await _db.execute(
        "SELECT secc_capacidad FROM SECCION WHERE secc_nombre = 'SECCIÓN B'");
    final c = await _db.execute(
        "SELECT secc_capacidad FROM SECCION WHERE secc_nombre = 'SECCIÓN C'");
    final d = await _db.execute(
        "SELECT secc_capacidad FROM SECCION WHERE secc_nombre = 'SECCIÓN D'");
    final e = await _db.execute(
        "SELECT secc_capacidad FROM SECCION WHERE secc_nombre = 'SECCIÓN E'");

    final estacionamientos = await _db.execute(
        'SELECT esta_estado FROM ESTACIONAMIENTO ORDER BY esta_numero ASC');

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

  String nombreUsuario = 'Buscando...';
  late TabController ControlladorBarra;
  late List<bool> estaSeleccionado;

  @override
  void initState() {
    super.initState();
    ControlladorBarra = TabController(length: 5, vsync: this);
    estaSeleccionado = List.generate(104, (index) => false);
    ObtenerTam();
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                              width: 50,
                              height: 50,
                              child: Image.asset(
                                'assets/img/LogoSolo.png',
                                fit: BoxFit.contain,
                              ),
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
                              onPressed: () {},
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
                          tabs: [
                            Tab(text: 'A'),
                            Tab(text: 'B'),
                            Tab(text: 'C'),
                            Tab(text: 'D'),
                            Tab(text: 'E'),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: ControlladorBarra,
                            children: [
                              GridView.count(
                                crossAxisCount: 4,
                                children: List.generate(
                                  tamA,
                                  (index) {
                                    String estado = A[index];
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
                                        margin: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: ocupado
                                              ? Colors.red
                                              : noDisp
                                                  ? Colors.grey
                                                  : reservado
                                                      ? Colors.yellow
                                                      : seleccionado
                                                          ? Colors
                                                              .lightBlueAccent
                                                          : Colors.green,
                                          border:
                                              Border.all(color: Colors.black),
                                        ),
                                        child: Center(
                                          child: Text(
                                            (index + 1).toString(),
                                            style: TextStyle(
                                              color: seleccionado
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              GridView.count(
                                crossAxisCount: 4,
                                children: List.generate(
                                  tamB,
                                  (index) {
                                    String estado = B[index];
                                    bool ocupado = estado == "OCUPADO";
                                    bool noDisp = estado == "NO DISPONIBLE";
                                    bool reservado = estado == 'RESERVADO';

                                    bool seleccionado =
                                        estaSeleccionado[tamA + index];

                                    return GestureDetector(
                                      onTap: () {
                                        if (!ocupado && !noDisp && !reservado) {
                                          _handleTap(tamA + index);
                                          nEst = tamA + index;
                                        }
                                      },
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                    
                                        margin: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: ocupado
                                              ? Colors.red
                                              : noDisp
                                                  ? Colors.grey
                                                  : reservado
                                                      ? Colors.yellow
                                                      : seleccionado
                                                          ? Colors
                                                              .lightBlueAccent
                                                          : Colors.green,
                                          border:
                                              Border.all(color: Colors.black),
                                        ),
                                        child: Center(
                                          child: Text(
                                            (tamA + index + 1).toString(),
                                            style: TextStyle(
                                              color: seleccionado
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              GridView.count(
                                crossAxisCount: 4,
                                children: List.generate(
                                  tamC,
                                  (index) {
                                    String estado = C[index];
                                    bool ocupado = estado == "OCUPADO";
                                    bool noDisp = estado == "NO DISPONIBLE";
                                    bool reservado = estado == 'RESERVADO';

                                    bool seleccionado =
                                        estaSeleccionado[tamA + tamB + index];

                                    return GestureDetector(
                                      onTap: () {
                                        if (!ocupado && !noDisp && !reservado) {
                                          _handleTap(tamA + tamB + index);
                                          nEst = tamA + tamB + index;
                                        }
                                      },
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        margin: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: ocupado
                                              ? Colors.red
                                              : noDisp
                                                  ? Colors.grey
                                                  : reservado
                                                      ? Colors.yellow
                                                      : seleccionado
                                                          ? Colors
                                                              .lightBlueAccent
                                                          : Colors.green,
                                          border:
                                              Border.all(color: Colors.black),
                                        ),
                                        child: Center(
                                          child: Text(
                                            (tamA + tamB + index + 1)
                                                .toString(),
                                            style: TextStyle(
                                              color: seleccionado
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              GridView.count(
                                crossAxisCount: 4,
                                children: List.generate(
                                  tamD,
                                  (index) {
                                    String estado = D[index];
                                    bool ocupado = estado == "OCUPADO";
                                    bool noDisp = estado == "NO DISPONIBLE";
                                    bool reservado = estado == 'RESERVADO';

                                    bool seleccionado = estaSeleccionado[
                                        tamA + tamB + tamC + index];

                                    return GestureDetector(
                                      onTap: () {
                                        if (!ocupado && !noDisp && !reservado) {
                                          _handleTap(
                                              tamA + tamB + tamC + index);
                                          nEst = tamA + tamB + tamC + index;
                                        }
                                      },
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        margin: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: ocupado
                                              ? Colors.red
                                              : noDisp
                                                  ? Colors.grey
                                                  : reservado
                                                      ? Colors.yellow
                                                      : seleccionado
                                                          ? Colors
                                                              .lightBlueAccent
                                                          : Colors.green,
                                          border:
                                              Border.all(color: Colors.black),
                                        ),
                                        child: Center(
                                          child: Text(
                                            (tamA + tamB + tamC + index + 1)
                                                .toString(),
                                            style: TextStyle(
                                              color: seleccionado
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              GridView.count(
                                crossAxisCount: 4,
                                children: List.generate(
                                  tamE,
                                  (index) {
                                    String estado = E[index];
                                    bool ocupado = estado == "OCUPADO";
                                    bool noDisp = estado == "NO DISPONIBLE";
                                    bool reservado = estado == 'RESERVADO';

                                    bool seleccionado = estaSeleccionado[
                                        tamA + tamB + tamC + tamD + index];

                                    return GestureDetector(
                                      onTap: () {
                                        if (!ocupado && !noDisp && !reservado) {
                                          _handleTap(tamA +
                                              tamB +
                                              tamC +
                                              tamD +
                                              index);
                                          nEst =
                                              tamA + tamB + tamC + tamD + index;
                                        }
                                      },
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        margin: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: ocupado
                                              ? Colors.red
                                              : noDisp
                                                  ? Colors.grey
                                                  : reservado
                                                      ? Colors.yellow
                                                      : seleccionado
                                                          ? Colors
                                                              .lightBlueAccent
                                                          : Colors.green,
                                          border:
                                              Border.all(color: Colors.black),
                                        ),
                                        child: Center(
                                          child: Text(
                                            (tamA +
                                                    tamB +
                                                    tamC +
                                                    tamD +
                                                    index +
                                                    1)
                                                .toString(),
                                            style: TextStyle(
                                              color: seleccionado
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
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
                                Text(
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
                                Text(
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
                                Text(
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
                                Text(
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
                                Text(
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
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            print(nEst + 1);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReservarGuardia(
                                    nEsta: (nEst + 1).toString()),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          label: Text(
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
                        SizedBox(height: 20,),
                        ElevatedButton.icon(
                          onPressed: () {
                     
                            
                          },
                          icon: Icon(
                            Icons.home,
                            color: Colors.white,
                          ),
                          label: Text(
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
    );
  }
}