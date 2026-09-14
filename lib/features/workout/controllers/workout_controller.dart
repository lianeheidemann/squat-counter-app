import '../models/workout_config.dart';

/// Controla estado do treino
class WorkoutController {
  WorkoutConfig config = WorkoutConfig(repsPerSet: 10, totalSets: 3);

  int currentRep = 0;
  int currentSet = 1;

  bool workoutFinished = false;

  /// Incrementa repetição
  void incrementRep() {
    // Não continua se treino acabou
    if (workoutFinished) return;

    currentRep++;

    // Completou série
    if (currentRep >= config.repsPerSet) {
      // Última série
      if (currentSet >= config.totalSets) {
        workoutFinished = true;
      } else {
        currentSet++;
        currentRep = 0;
      }
    }
  }

  /// Atualiza treino
  void updateWorkout({required int reps, required int sets}) {
    config = WorkoutConfig(repsPerSet: reps, totalSets: sets);
  }

  /// Reinicia treino
  void resetWorkout() {
    currentRep = 0;
    currentSet = 1;

    workoutFinished = false;
  }
}
