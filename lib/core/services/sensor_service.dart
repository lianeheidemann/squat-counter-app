import 'dart:async';

import 'package:sensors_plus/sensors_plus.dart';

/// Serviço responsável pelos sensores
class SensorService {
  StreamSubscription? _accelerometerSubscription;

  bool canCount = true;

  /// Inicia leitura
  void startListening({
    required Function onSquatDetected,

    required Function(double x, double y, double z) onSensorChanged,
  }) {
    _accelerometerSubscription = accelerometerEventStream().listen((event) {
      final x = event.x;
      final y = event.y;
      final z = event.z;

      // Atualiza interface
      onSensorChanged(x, y, z);

      /*
      Detecta movimento forte em qualquer eixo
      */

      final movementDetected = x.abs() > 12 || y.abs() > 12 || z.abs() > 12;

      if (movementDetected && canCount) {
        canCount = false;

        onSquatDetected();

        // Cooldown
        Future.delayed(const Duration(milliseconds: 1500), () {
          canCount = true;
        });
      }
    });
  }

  /// Para sensores
  void stopListening() {
    _accelerometerSubscription?.cancel();
  }
}
