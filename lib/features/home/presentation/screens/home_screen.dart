import 'package:flutter/material.dart';
import 'package:gemini_test/features/repositories/presentation/screens/repository_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub Repositories'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade200, Colors.blue.shade800],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTechnologyButton(context, {'Android':'language:kotlin'}, Icons.android),
              const SizedBox(height: 20),
              _buildTechnologyButton(context, {'IOS':'language:swift'}, Icons.apple),
              const SizedBox(height: 20),
              _buildTechnologyButton(context, {'Flutter':'language:dart'}, Icons.code),
              const SizedBox(height: 20),
              _buildTechnologyButton(context, {'React Native':'topic:react-native'}, Icons.code),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTechnologyButton(BuildContext context, Map technology, IconData icon) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RepositoryListScreen(technology: technology.values.toString()),
          ),
        );
      },
      icon: Icon(icon, size: 40),
      label: Text(technology.keys.first, style: const TextStyle(fontSize: 20)),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}