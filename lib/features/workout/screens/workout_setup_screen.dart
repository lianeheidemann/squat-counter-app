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
        title: const Text('Squat Counter'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(Icons.fitness_center_rounded, color: colors.primary),
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight - 36,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Configure seu treino',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Defina sua meta e deixe o celular contar cada agachamento.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 28),
                  NumberSelector(
                    title: 'Repetições',
                    subtitle: 'por série',
                    icon: Icons.repeat_rounded,
                    value: reps,
                    onIncrease: () => setState(() => reps++),
                    onDecrease: reps > 1 ? () => setState(() => reps--) : null,
                  ),
                  const SizedBox(height: 14),
                  NumberSelector(
                    title: 'Séries',
                    subtitle: 'no treino',
                    icon: Icons.layers_rounded,
                    value: sets,
                    onIncrease: () => setState(() => sets++),
                    onDecrease: sets > 1 ? () => setState(() => sets--) : null,
                  ),
                  const SizedBox(height: 18),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: colors.primaryContainer.withValues(alpha: 0.55),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.flag_rounded, color: colors.primary),
                        const SizedBox(width: 12),
                        const Expanded(child: Text('Meta total do treino')),
                        Text(
                          '$totalReps agachamentos',
                          style: const TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  ElevatedButton.icon(
                    onPressed: _startWorkout,
                    icon: const Icon(Icons.play_arrow_rounded),
                    label: const Text('Começar treino'),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Mantenha o celular firme junto ao corpo durante o exercício.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall
                        ?.copyWith(color: colors.onSurfaceVariant),
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
