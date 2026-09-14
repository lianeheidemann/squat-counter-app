import 'package:flutter/material.dart';

import '../../../../core/services/sensor_service.dart';
import '../controllers/workout_controller.dart';
import '../widgets/progress_card.dart';

class WorkoutSessionScreen extends StatefulWidget {
  final WorkoutController controller;
  const WorkoutSessionScreen({super.key, required this.controller});

  @override
  State<WorkoutSessionScreen> createState() => _WorkoutSessionScreenState();
}

class _WorkoutSessionScreenState extends State<WorkoutSessionScreen> {
  final SensorService sensorService = SensorService();
  bool trainingStarted = false;
  double x = 0;
  double y = 0;
  double z = 0;

  @override
  void dispose() {
    sensorService.stopListening();
    super.dispose();
  }

  void startTraining() {
    sensorService.startListening(
      onSquatDetected: () {
        if (!mounted) return;
        setState(() {
          widget.controller.incrementRep();
          if (widget.controller.workoutFinished) {
            sensorService.stopListening();
            trainingStarted = false;
            Future.delayed(const Duration(milliseconds: 300), () {
              if (mounted) showFinishedDialog();
            });
          }
        });
      },
      onSensorChanged: (sensorX, sensorY, sensorZ) {
        if (!mounted) return;
        setState(() {
          x = sensorX;
          y = sensorY;
          z = sensorZ;
        });
      },
    );
    setState(() => trainingStarted = true);
  }

  void resetTraining() {
    sensorService.stopListening();
    widget.controller.resetWorkout();
    setState(() {
      trainingStarted = false;
      x = 0;
      y = 0;
      z = 0;
    });
  }

  void showFinishedDialog() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(Icons.emoji_events_rounded, color: Color(0xFFFFC857), size: 46),
        title: const Text('Workout complete!', textAlign: TextAlign.center),
        content: const Text(
          'Great job! You completed every planned set.\n\n“Small steps create big changes.”',
          textAlign: TextAlign.center,
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                resetTraining();
              },
              child: const Text('Train again'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final controller = widget.controller;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Squat Counter'),
        actions: [
          IconButton(
            tooltip: 'More options',
            onPressed: () {},
            icon: const Icon(Icons.more_horiz_rounded),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 8, 18, 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                decoration: BoxDecoration(
                  color: colors.primary.withValues(alpha: 0.06),
                  border: Border.all(color: colors.primary.withValues(alpha: 0.38)),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: colors.primary),
                        color: colors.primary.withValues(alpha: 0.1),
                      ),
                      child: Icon(
                        trainingStarted ? Icons.pause_rounded : Icons.play_arrow_rounded,
                        color: colors.primary,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            trainingStarted ? 'Workout in progress' : 'Ready to start',
                            style: TextStyle(color: colors.primary, fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            trainingStarted ? "Keep going! You've got this." : 'Secure your phone before starting.',
                            style: TextStyle(color: colors.onSurfaceVariant, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: ProgressCard(
                      title: 'Current set',
                      current: controller.currentSet,
                      total: controller.config.totalSets,
                      icon: Icons.layers_rounded,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ProgressCard(
                      title: 'Repetitions',
                      current: controller.currentRep,
                      total: controller.config.repsPerSet,
                      icon: Icons.repeat_rounded,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.phone_android_rounded, color: colors.primary, size: 20),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: Text('Phone movement', style: TextStyle(fontWeight: FontWeight.w700)),
                          ),
                          Text('LIVE', style: TextStyle(color: colors.primary, fontSize: 10, fontWeight: FontWeight.w800)),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          _SensorValue(axis: 'X', value: x),
                          _SensorValue(axis: 'Y', value: y),
                          _SensorValue(axis: 'Z', value: z),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: trainingStarted ? null : startTraining,
                icon: Icon(trainingStarted ? Icons.sensors_rounded : Icons.play_arrow_rounded),
                label: Text(trainingStarted ? 'Automatic counting active' : 'Start counting'),
              ),
              const SizedBox(height: 10),
              OutlinedButton.icon(
                onPressed: resetTraining,
                icon: const Icon(Icons.refresh_rounded, size: 19),
                label: const Text('Reset workout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SensorValue extends StatelessWidget {
  final String axis;
  final double value;
  const _SensorValue({required this.axis, required this.value});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: colors.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(axis, style: TextStyle(color: colors.onSurfaceVariant, fontSize: 11)),
            const SizedBox(height: 4),
            Text(value.toStringAsFixed(2), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
          ],
        ),
      ),
    );
  }
}
