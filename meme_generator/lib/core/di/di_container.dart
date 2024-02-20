import 'package:flutter/material.dart';
import 'package:meme_generator/core/di/dependencies.dart';
import 'package:meme_generator/core/di/dependencies_provider.dart';
import 'package:meme_generator/main.dart';
import 'package:meme_generator/feature/presentation/screens/meme_generator_model.dart';

abstract class IDiContainer {
  Future<Widget> configureDependencies();
}

class DiContainer implements IDiContainer {
  @override
  Future<Widget> configureDependencies() async {
    return DependenciesProvider(
      dependencies: _dependencies,
      child: const App(),
    );
  }

  late final _dependencies =
      Dependencies(memeGeneratorModel: _memeGeneratorModelFactory());

  IMemeGeneratorModel _memeGeneratorModelFactory() => MemeGeneratorModel();
}
