import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_application_1/main.dart';

class registrarse3 extends StatelessWidget {
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
                    Column(
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
                          "ESTACIONAMIENTOS ULAGOS",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.85,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => MyApp()),
                                        );
                                        print('Iniciar');
                                      },
                                      child: const Text(
                                        "Iniciar sesión",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                                        backgroundColor: MaterialStatePropertyAll(
                                          Colors.blue.shade700,
                                        ),
                                      ),
                                      onPressed: () {
                                        print('Registrarse');
                                      },
                                      child: const Text(
                                        'Registrarse',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                //CAJA COMPLETAR DATOS
                              ],
                            ),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.85,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            margin: const EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(color: Colors.blue.shade700),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //CIRCULO
                                Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade500,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Text(
                                    "3",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const Text(
                                  "Confirmar cuenta",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Text(
                          '¡ENVIAMOS UN MAIL DE CONFIRMACIÓN A SU CORREO ELECTRÓNICO!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.85,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 50),
                            height: 40,
                            child: Pinput(
                              length: 6,
                              defaultPinTheme: PinTheme(
                                textStyle: const TextStyle(fontSize: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              onCompleted: (pin) {
                                print(pin);
                              },
                            ),
                          ),
                        ),
                        const Text(
                          'Tiempo restante',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        TimerCountdown(
                          format: CountDownTimerFormat.minutesSeconds,
                          timeTextStyle: const TextStyle(fontSize: 20),
                          enableDescriptions: false,
                          endTime: DateTime.now().add(
                            const Duration(
                              minutes: 5,
                            ),
                          ),
                          onEnd: () {
                            print('Este es el timer terminando');
                          },
                        ),
                        const Icon(
                          Icons.mail_outline_rounded,
                          size: 36,
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          padding: const MaterialStatePropertyAll(
                            EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 10,
                            ),
                          ),
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          backgroundColor: MaterialStatePropertyAll(Colors.blue.shade700),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Confirmar',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
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
