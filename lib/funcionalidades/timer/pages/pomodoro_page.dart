import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../services/pomodoro_service.dart';

class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({super.key});

  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  final PomodoroService pomodoro = PomodoroService();

  String? materia;

  int pomodoros = 0;

  @override
  void initState() {
    super.initState();

    pomodoro.onUpdate = () {
      setState(() {});

      if (pomodoro.currentTime == 0) {
        pomodoros++;
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.brown,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: '',
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Sessão de Estudo",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Técnica Pomodoro",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 25),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  hint: const Text("Escolha uma matéria"),
                  value: materia,
                  items: const [
                    DropdownMenuItem(
                      value: "Engenharia de Software",
                      child: Text("Engenharia de Software"),
                    ),
                    DropdownMenuItem(
                      value: "Banco de Dados",
                      child: Text("Banco de Dados"),
                    ),
                    DropdownMenuItem(
                      value: "Programação para dispositivos moveis",
                      child: Text("Programação para dispositivos moveis"),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      materia = value;
                    });
                  },
                ),
              ),

              const SizedBox(height: 25),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xff7C4DFF),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "🎯 Foco",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text("0/4 do ciclo"),
                      ],
                    ),

                    const SizedBox(height: 30),

                    CircularPercentIndicator(
                      radius: 110,
                      lineWidth: 8,
                      percent: pomodoro.progress,
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Colors.orange,
                      backgroundColor: Colors.grey.shade300,
                      center: Text(
                        pomodoro.formattedTime,
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                          ),
                          onPressed: () {
                            setState(() {
                              if (pomodoro.running) {
                                pomodoro.pause();
                              } else {
                                pomodoro.start();
                              }
                            });
                          },
                          icon: Icon(
                            pomodoro.running
                                ? Icons.pause
                                : Icons.play_arrow,
                          ),
                          label: Text(
                            pomodoro.running ? "Pausar" : "Iniciar",
                          ),
                                                  ),
                        const SizedBox(width: 10),
                        OutlinedButton(
                          onPressed: pomodoro.reset,
                          child: const Icon(Icons.refresh),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: cardInfo(
                      "🍅",
                      pomodoros.toString(),
                      "Pomodoros",
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: cardInfo(
                      "⏰",
                      ((25 * 60 - pomodoro.currentTime) ~/ 60).toString(),
                      "Minutos",
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xfffff4eb),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: const Color(0xffffc49a),
                  ),
                ),
                child: const Text(
                  "Como funciona: Estude por 25 minutos, depois descanse 5 minutos. A cada 4 pomodoros, faça uma pausa de 15 minutos.",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardInfo(
    String emoji,
    String valor,
    String titulo,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Text(
            "$emoji $valor",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(titulo),
        ],
      ),
    );
  }
}