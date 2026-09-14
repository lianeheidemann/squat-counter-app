import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/workout/screens/workout_setup_screen.dart';

void main() {
  runApp(const SquatCounterApp());
}

/// Widget principal do aplicativo
class SquatCounterApp extends StatelessWidget {
  const SquatCounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Squat Counter',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const WorkoutSetupScreen(),
    );
  }
}
