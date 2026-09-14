import 'dart:async';

import 'package:sensors_plus/sensors_plus.dart';

/// Handles accelerometer readings and squat detection.
class SensorService {
  StreamSubscription? _accelerometerSubscription;

  bool canCount = true;

  /// Starts listening to accelerometer events.
  void startListening({
    required Function onSquatDetected,

    required Function(double x, double y, double z) onSensorChanged,
  }) {
    _accelerometerSubscription = accelerometerEventStream().listen((event) {
      final x = event.x;
      final y = event.y;
      final z = event.z;

      // Sends the latest sensor values to the interface.
      onSensorChanged(x, y, z);

      /*
      Detects strong movement on any axis.
      */

      final movementDetected = x.abs() > 12 || y.abs() > 12 || z.abs() > 12;

      if (movementDetected && canCount) {
        canCount = false;

        onSquatDetected();

        // Prevents a single movement from being counted more than once.
        Future.delayed(const Duration(milliseconds: 1500), () {
          canCount = true;
        });
      }
    });
  }

  /// Stops listening to accelerometer events.
  void stopListening() {
    _accelerometerSubscription?.cancel();
  }
}
