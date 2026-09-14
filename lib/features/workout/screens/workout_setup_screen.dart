import 'package:flutter/material.dart';

import '../controllers/workout_controller.dart';
import '../widgets/number_selector.dart';
import 'workout_session_screen.dart';

class WorkoutSetupScreen extends StatefulWidget {
  const WorkoutSetupScreen({super.key});

  @override
  State<WorkoutSetupScreen> createState() => _WorkoutSetupScreenState();
}

class _WorkoutSetupScreenState extends State<WorkoutSetupScreen> {
  final WorkoutController controller = WorkoutController();
  int reps = 10;
  int sets = 3;

  int get totalReps => reps * sets;

  void _startWorkout() {
    controller.updateWorkout(reps: reps, sets: sets);
    controller.resetWorkout();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => WorkoutSessionScreen(controller: controller),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 68,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Icon(Icons.fitness_center_rounded, color: colors.primary, size: 27),
        ),
        title: const Text('Squat Counter'),
        actions: [
          IconButton(
            tooltip: 'Settings',
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Settings will be available soon.')),
            ),
            icon: const Icon(Icons.settings_outlined, size: 21),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(18, 8, 18, 22),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight - 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'STRONGER EVERY DAY',
                    style: TextStyle(
                      color: colors.onSurfaceVariant,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2.4,
                    ),
                  ),
                  const SizedBox(height: 9),
                  Text(
                    'Configure your\nworkout',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Set your goal and let your phone count every squat.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 22),
                  NumberSelector(
                    title: 'Repetitions',
                    subtitle: 'per set',
                    icon: Icons.repeat_rounded,
                    value: reps,
                    onIncrease: () => setState(() => reps++),
                    onDecrease: reps > 1 ? () => setState(() => reps--) : null,
                  ),
                  const SizedBox(height: 10),
                  NumberSelector(
                    title: 'Sets',
                    subtitle: 'in this workout',
                    icon: Icons.layers_rounded,
                    value: sets,
                    onIncrease: () => setState(() => sets++),
                    onDecrease: sets > 1 ? () => setState(() => sets--) : null,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                    decoration: BoxDecoration(
                      color: colors.surface,
                      border: Border.all(color: colors.outline),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: colors.primary.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(Icons.flag_rounded, color: colors.primary, size: 21),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Total workout goal',
                            style: TextStyle(color: colors.onSurfaceVariant, fontSize: 13),
                          ),
                        ),
                        Text(
                          '$totalReps squats',
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  ElevatedButton.icon(
                    onPressed: _startWorkout,
                    icon: const Icon(Icons.play_arrow_rounded, size: 21),
                    label: const Text('Start workout'),
                  ),
                  const SizedBox(height: 13),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.lock_outline_rounded, size: 14, color: colors.onSurfaceVariant),
                      const SizedBox(width: 7),
                      Flexible(
                        child: Text(
                          'Keep your phone secure and close to your body.',
                          style: TextStyle(color: colors.onSurfaceVariant, fontSize: 11),
                        ),
                      ),
                    ],
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
