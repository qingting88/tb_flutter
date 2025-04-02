# TreasureBox Flutter App

TreasureBox is an elegant Flutter application that provides a modern user authentication flow.

## Features

- User registration
- Email verification
- Password setup
- Registration completion flow

## Project Structure

The project follows a clean layered architecture, adhering to Flutter best practices:

```
lib/
  core/              # Core components
    constants/       # Application constants
    theme/           # Theme configuration
    utils/           # Utility functions
    widgets/         # Common widgets
  features/          # Feature modules
    auth/            # Authentication feature
      data/          # Data layer
      domain/        # Domain layer
      presentation/  # Presentation layer
  l10n/              # Internationalization
  main.dart          # Application entry point
```

## Tech Stack

- Flutter 3.x
- Provider (State management)
- Go Router (Navigation)
- Material 3 design

## Running the Project

1. Make sure Flutter SDK is installed
2. Clone the project
3. Run `flutter pub get` to install dependencies
4. Run `flutter run` to start the application
