import 'package:flutter/material.dart';
import 'package:meme_generator/core/di/di_container.dart';
import 'package:meme_generator/feature/presentation/screens/meme_generator_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = DiContainer();

  final app = await container.configureDependencies();
  runApp(app);
}

/// App,s main widget.
class App extends StatelessWidget {
  /// Constructor for [MyApp].
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const MemeGeneratorScreen(),
    );
  }
}
