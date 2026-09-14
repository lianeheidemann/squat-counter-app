import '../models/workout_config.dart';

/// Manages workout configuration and progress.
class WorkoutController {
  WorkoutConfig config = WorkoutConfig(repsPerSet: 10, totalSets: 3);

  int currentRep = 0;
  int currentSet = 1;

  bool workoutFinished = false;

  /// Increments the repetition count.
  void incrementRep() {
    // Ignore sensor events after the workout is complete.
    if (workoutFinished) return;

    currentRep++;

    // Advance when the current set is complete.
    if (currentRep >= config.repsPerSet) {
      // Finish after the final set.
      if (currentSet >= config.totalSets) {
        workoutFinished = true;
      } else {
        currentSet++;
        currentRep = 0;
      }
    }
  }

  /// Updates the workout configuration.
  void updateWorkout({required int reps, required int sets}) {
    config = WorkoutConfig(repsPerSet: reps, totalSets: sets);
  }

  /// Resets workout progress.
  void resetWorkout() {
    currentRep = 0;
    currentSet = 1;

    workoutFinished = false;
  }
}
