# Gemini Test

A Flutter project that demonstrates a clean architecture approach for fetching and displaying GitHub repositories.

## Getting Started

This project is a starting point for a Flutter application.

To get started, clone the repository and run the following commands:

```bash
flutter pub get
flutter run
```

## Project Structure

The project follows a feature-based structure, with a clear separation of concerns between layers.

```
lib/
├── core/
│   ├── error/
│   ├── network/
│   └── usecases/
├── features/
│   ├── home/
│   │   └── presentation/
│   └── repositories/
│       ├── data/
│       ├── domain/
│       └── presentation/
├── injection_container.dart
└── main.dart
```

- **`core`**: Contains shared functionalities like error handling, network utilities, and base use cases.
- **`features`**: Each feature of the application is divided into `data`, `domain`, and `presentation` layers.
  - **`data`**: Handles data retrieval from local or remote sources.
  - **`domain`**: Contains the business logic and entities.
  - **`presentation`**: Manages the UI and state using Flutter BLoC.
- **`injection_container.dart`**: Initializes and injects dependencies using `get_it`.
- **`main.dart`**: The entry point of the application.

## Dependencies

This project uses the following dependencies:

- **`flutter_bloc`**: For state management.
- **`equatable`**: To compare objects.
- **`dartz`**: For functional programming (Either type).
- **`dio`**: For making HTTP requests.
- **`get_it`**: For dependency injection.
- **`internet_connection_checker`**: To check for internet connectivity.
- **`shared_preferences`**: For local storage.
- **`connectivity_plus`**: To monitor network status.
- **`url_launcher`**: To launch URLs.

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.