import 'dart:async';

enum SessionType {
  focus,
  shortBreak,
  longBreak,
}

class PomodoroService {
  Timer? timer;

  static const int focusDuration = 25 * 60;
  static const int shortBreakDuration = 5 * 60;
  static const int longBreakDuration = 15 * 60;

  int currentTime = focusDuration;

  bool running = false;

  int cycle = 0;

  int completedPomodoros = 0;

  int studiedMinutes = 0;

  SessionType sessionType = SessionType.focus;

  Function()? onUpdate;

  void start() {
    if (running) return;

    running = true;

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (currentTime > 0) {
          currentTime--;

          if (sessionType == SessionType.focus) {
            studiedMinutes =
                ((focusDuration - currentTime) / 60).floor();
          }

          onUpdate?.call();
        } else {
          _nextSession();
        }
      },
    );

    onUpdate?.call();
  }

  void pause() {
    timer?.cancel();
    running = false;
    onUpdate?.call();
  }

  void reset() {
    timer?.cancel();

    running = false;

    currentTime = focusDuration;

    cycle = 0;

    completedPomodoros = 0;

    sessionType = SessionType.focus;

    onUpdate?.call();
  }

  void _nextSession() {
    timer?.cancel();

    if (sessionType == SessionType.focus) {
      completedPomodoros++;

      cycle++;

      if (cycle >= 4) {
        sessionType = SessionType.longBreak;
        currentTime = longBreakDuration;
      } else {
        sessionType = SessionType.shortBreak;
        currentTime = shortBreakDuration;
      }
    } else {
      if (sessionType == SessionType.longBreak) {
        cycle = 0;
      }

      sessionType = SessionType.focus;
      currentTime = focusDuration;
    }

    running = false;

    onUpdate?.call();
  }

  double get progress {
    int total;

    switch (sessionType) {
      case SessionType.focus:
        total = focusDuration;
        break;

      case SessionType.shortBreak:
        total = shortBreakDuration;
        break;

      case SessionType.longBreak:
        total = longBreakDuration;
        break;
    }

    return 1 - (currentTime / total);
  }

  String get formattedTime {
    final min = currentTime ~/ 60;
    final sec = currentTime % 60;

    return '${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}';
  }

  String get sessionLabel {
    switch (sessionType) {
      case SessionType.focus:
        return "🎯 Foco";

      case SessionType.shortBreak:
        return "☕ Descanso";

      case SessionType.longBreak:
        return "🌴 Descanso Longo";
    }
  }

  String get cycleLabel {
    return "$cycle/4 do ciclo";
  }
}