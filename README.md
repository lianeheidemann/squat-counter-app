<div align="center" >

<img width="120" src="assets/squat-counter-icon.png">

# Squat Counter App

![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)

A Flutter mobile app that uses the phone's accelerometer to automatically<br>
detect and count squats, tracking repetitions and sets in real time.

<img width="35%" src="https://github.com/user-attachments/assets/0007261c-f7ac-48e4-80b8-3c0322c9f783" alt="Squat Counter App demonstration" />

</div>

## Features

- Automatic squat detection via accelerometer, no manual input required
- Configurable number of repetitions per set and total sets
- Live workout progress tracking

## Tech Stack

- [Flutter](https://flutter.dev) / Dart
- [sensors_plus](https://pub.dev/packages/sensors_plus) for accelerometer data
- Android SDK

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (Dart ^3.11.5)
- Android device or emulator

### Run locally

```bash
flutter pub get
flutter run
```

## Project Structure

```text
lib/
 ├── core/
 │   ├── services/sensor_service.dart
 │   └── theme/app_theme.dart
 │
 ├── features/workout/
 │   ├── controllers/workout_controller.dart
 │   ├── models/workout_config.dart
 │   ├── screens/
 │   │   ├── workout_setup_screen.dart
 │   │   └── workout_session_screen.dart
 │   └── widgets/
 │       ├── number_selector.dart
 │       └── progress_card.dart
 │
 └── main.dart
```

## How It Works

1. The user sets up the workout (reps per set and total sets).
2. The app starts reading the accelerometer.
3. Squat movements are detected from the sensor data.
4. Repetitions and sets are counted and displayed automatically.
5. The workout ends once the configured goal is reached.

## License

Distributed under the [MIT License](LICENSE).
