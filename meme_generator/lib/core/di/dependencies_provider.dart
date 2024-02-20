import 'package:flutter/material.dart';
import 'package:meme_generator/core/di/dependencies.dart';
import 'package:provider/provider.dart';

class DependenciesProvider extends StatelessWidget {
  const DependenciesProvider({
    super.key,
    required this.child,
    required this.dependencies,
  });

  final Widget child;
  final Dependencies dependencies;

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => dependencies,
      child: child,
    );
  }
}
