import 'package:flutter/material.dart';
import 'package:gemini_test/features/home/presentation/screens/home_screen.dart';
import 'package:gemini_test/features/repositories/presentation/screens/repository_list_screen.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub Repositories',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
      routes: {
        '/repository_list': (context) => const RepositoryListScreen(technology: ''),
      },
    );
  }
}