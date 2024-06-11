import 'package:flutter/material.dart';

class HistorialGuardiaresultados extends StatefulWidget {
  final String texto;
  final dynamic historial;
  final ScrollController controller = ScrollController();

  HistorialGuardiaresultados({
    required this.texto,
    required this.historial,
  });

  @override
  _HistorialGuardiaresultadosState createState() =>
      _HistorialGuardiaresultadosState();
}

class _HistorialGuardiaresultadosState
    extends State<HistorialGuardiaresultados> {
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
              child: ListView(
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
                  const Center(
                    child: Text(
                      "HISTORIAL RESERVAS",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Resultados para ${widget.texto}",
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      controller: widget.controller,
                      shrinkWrap: true,
                      itemCount: widget.historial.length,
                      itemBuilder: (BuildContext context, int index) {
                        final reserva = widget.historial[index];
                        return Container(
                          margin: const EdgeInsets.only(
                              bottom: 20), // Agrega espacio entre cada elemento
                          child: Reservas(
                              //Se le pasan todos estos datos a la clase MiWidget
                              patente: reserva['rese_vehi_patente'],
                              rutUsuario: reserva['rese_usua_rut'],
                              nombreUsuario: reserva['usua_nombre'],
                              apellidoPatUsuario:
                                  reserva['usua_apellido_paterno'],
                              apellidoMatUsuario:
                                  reserva['usua_apellido_materno'],
                              numeroEstacionamiento: reserva['esta_numero'],
                              fechaReserva: reserva['rese_fecha'],
                              horaLlegada:
                                  reserva['rese_hora_llegada'].toString(),
                              horaSalida:
                                  reserva['rese_hora_salida'].toString(),
                              tipo: reserva['usua_tipo']),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String getDayOfWeek(int day) {
  switch (day) {
    case 1:
      return 'Lun';
    case 2:
      return 'Mar';
    case 3:
      return 'Mié';
    case 4:
      return 'Jue';
    case 5:
      return 'Vie';
    case 6:
      return 'Sáb';
    case 7:
      return 'Dom';
    default:
      return '';
  }
}

//Funcion que obtiene el nombre del mes

String getMonthName(int month) {
  switch (month) {
    case 1:
      return 'Enero';
    case 2:
      return 'Febrero';
    case 3:
      return 'Marzo';
    case 4:
      return 'Abril';
    case 5:
      return 'Mayo';
    case 6:
      return 'Junio';
    case 7:
      return 'Julio';
    case 8:
      return 'Agosto';
    case 9:
      return 'Septiembre';
    case 10:
      return 'Octubre';
    case 11:
      return 'Noviembre';
    case 12:
      return 'Diciembre';
    default:
      return 'Mes no válido';
  }
}

class Reservas extends StatelessWidget {
  final String patente;
  final String rutUsuario;
  final String nombreUsuario;
  final String apellidoPatUsuario;
  final String apellidoMatUsuario;
  final String numeroEstacionamiento;
  final DateTime fechaReserva;
  final String horaLlegada;
  final String horaSalida;
  final String tipo;

  const Reservas({
    super.key,
    required this.patente,
    required this.rutUsuario,
    required this.nombreUsuario,
    required this.apellidoPatUsuario,
    required this.apellidoMatUsuario,
    required this.numeroEstacionamiento,
    required this.fechaReserva,
    required this.tipo,
    required this.horaLlegada,
    required this.horaSalida,
  });

  @override
  Widget build(BuildContext context) {
    String horaLlegadaFormateada =
        horaLlegada != 'null' ? horaLlegada.substring(5, 13) : horaLlegada;
    String horaSalidaFormateada =
        horaSalida != 'null' ? horaSalida.substring(5, 13) : horaSalida;
    int numeroDia = fechaReserva.day;
    int anio = fechaReserva.year;
    int numeroDiaDeLaSemana = fechaReserva.weekday;
    int numeroMes = fechaReserva.month;
    final nombreDia = [
      "Lunes",
      "Martes",
      "Miércoles",
      "Jueves",
      "Viernes",
      "Sábado",
      "Domingo"
    ];
    final nombreMes = [
      "Enero",
      "Febrero",
      "Marzo",
      "Abril",
      "Mayo",
      "Junio",
      "Julio",
      "Agosto",
      "Septiembre",
      "Octubre",
      "Noviembre",
      "Diciembre"
    ];
    return Builder(builder: (BuildContext context) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 3.0),
        child: SizedBox(
          width: 400,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: const BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
            child: Column(
              children: [
                Container(
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 8,
                      ),
                      const Icon(
                        Icons.calendar_month_sharp,
                        color: Colors.white,
                        size: 30,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        //Muestra las fechas de las citas
                        '${nombreDia[numeroDiaDeLaSemana - 1]} ${numeroDia.toString().padLeft(2, '0')} de ${nombreMes[numeroMes - 1]} del ${anio.toString()}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0), // Espacio vertical entre las filas
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Patente',
                              ),
                            ),
                            Expanded(
                              child: Text(patente),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'RUT',
                              ),
                            ),
                            Expanded(
                              child: Text(rutUsuario),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Nombre',
                              ),
                            ),
                            Expanded(
                              child: Text(nombreUsuario),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Apellidos',
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '$apellidoPatUsuario $apellidoMatUsuario',
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Hora llegada',
                              ),
                            ),
                            Expanded(
                              child: Text(horaLlegadaFormateada),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Hora salida',
                              ),
                            ),
                            Expanded(
                              child: Text(horaSalidaFormateada),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'N° Estacionamiento',
                              ),
                            ),
                            Expanded(
                              child: Text(numeroEstacionamiento),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Tipo',
                              ),
                            ),
                            Expanded(
                              child: Text(tipo),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
