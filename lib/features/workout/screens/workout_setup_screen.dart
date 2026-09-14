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
        leadingWidth: 54,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Icon(Icons.fitness_center_rounded, color: colors.primary, size: 22),
        ),
        title: const Text('Squat Counter'),
        actions: [
          IconButton(
            tooltip: 'Settings',
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Settings will be available soon.')),
            ),
            icon: const Icon(Icons.settings_outlined),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight - 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 224,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1E20),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: colors.outline),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 16,
                          top: 28,
                          right: 160,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'STRONGER EVERY DAY',
                                style: TextStyle(
                                  color: colors.onSurfaceVariant,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 2.0,
                                ),
                              ),
                              const SizedBox(height: 11),
                              Text(
                                'Configure your\nworkout',
                                style: Theme.of(context).textTheme.headlineMedium,
                              ),
                              const SizedBox(height: 9),
                              Text(
                                'Set your goal. Your phone counts every squat.',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: -6,
                          bottom: -8,
                          width: 190,
                          height: 232,
                          child: Image.asset(
                            'assets/woman-squatting.png',
                            fit: BoxFit.contain,
                            alignment: Alignment.bottomRight,
                            filterQuality: FilterQuality.high,
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          height: 38,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.transparent, const Color(0xFF1A1E20).withValues(alpha: 0.92)],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  NumberSelector(
                    title: 'Repetitions',
                    subtitle: 'per set',
                    icon: Icons.repeat_rounded,
                    value: reps,
                    onIncrease: () => setState(() => reps++),
                    onDecrease: reps > 1 ? () => setState(() => reps--) : null,
                  ),
                  const SizedBox(height: 9),
                  NumberSelector(
                    title: 'Sets',
                    subtitle: 'in this workout',
                    icon: Icons.layers_rounded,
                    value: sets,
                    onIncrease: () => setState(() => sets++),
                    onDecrease: sets > 1 ? () => setState(() => sets--) : null,
                  ),
                  const SizedBox(height: 9),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
                    decoration: BoxDecoration(
                      color: colors.surface,
                      border: Border.all(color: colors.outline),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: colors.primary.withValues(alpha: 0.10),
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: Icon(Icons.flag_outlined, color: colors.primary, size: 19),
                        ),
                        const SizedBox(width: 11),
                        Expanded(
                          child: Text(
                            'Total workout goal',
                            style: TextStyle(color: colors.onSurfaceVariant, fontSize: 12),
                          ),
                        ),
                        Text(
                          '$totalReps squats',
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton.icon(
                    onPressed: _startWorkout,
                    icon: const Icon(Icons.play_arrow_rounded, size: 19),
                    label: const Text('Start workout'),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.lock_outline_rounded, size: 13, color: colors.onSurfaceVariant),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          'Keep your phone secure and close to your body.',
                          style: TextStyle(color: colors.onSurfaceVariant, fontSize: 10),
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
