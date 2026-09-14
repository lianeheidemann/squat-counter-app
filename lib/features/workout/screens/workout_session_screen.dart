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
        icon: const Icon(Icons.emoji_events_rounded, size: 42),
        title: const Text('Workout complete!'),
        content: const Text(
          'Great job! You completed every planned set.',
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          FilledButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              resetTraining();
            },
            child: const Text('Train again'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final controller = widget.controller;
    final statusColor = colors.primary;

    return Scaffold(
      appBar: AppBar(title: const Text('Workout in progress')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 13,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.08),
                  border: Border.all(
                    color: statusColor.withValues(alpha: 0.35),
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Icon(
                      trainingStarted
                          ? Icons.sensors_rounded
                          : Icons.pause_circle_outline_rounded,
                      color: statusColor,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        trainingStarted
                            ? 'Automatic counting is active'
                            : 'Ready to start',
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
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
                  const SizedBox(width: 12),
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
              const SizedBox(height: 18),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.phone_android_rounded,
                            color: colors.primary,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Phone movement',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Real-time accelerometer readings',
                        style: Theme.of(context).textTheme.bodySmall
                            ?.copyWith(color: colors.onSurfaceVariant),
                      ),
                      const SizedBox(height: 18),
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
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: trainingStarted ? null : startTraining,
                icon: Icon(
                  trainingStarted
                      ? Icons.sensors_rounded
                      : Icons.play_arrow_rounded,
                ),
                label: Text(
                  trainingStarted ? 'Sensors active' : 'Start counting',
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: resetTraining,
                icon: const Icon(Icons.refresh_rounded),
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
  Widget build(BuildContext context) => Expanded(
    child: Column(
      children: [
        Text(
          axis,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value.toStringAsFixed(2),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
      ],
    ),
  );
}
