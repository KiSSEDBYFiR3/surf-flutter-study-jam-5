import 'package:flutter/material.dart';
import 'package:meme_generator/core/di/dependencies.dart';
import 'package:meme_generator/core/di/dependencies_provider.dart';
import 'package:meme_generator/feature/data/data_source.dart/i_local_data_source.dart';
import 'package:meme_generator/feature/data/data_source.dart/local_data_source.dart';
import 'package:meme_generator/feature/data/repository/repository.dart';
import 'package:meme_generator/feature/domain/repository/repository.dart';
import 'package:meme_generator/feature/presentation/screens/meme_create_template_screen/meme_create_template_model.dart';
import 'package:meme_generator/feature/presentation/screens/meme_generator_screen/meme_generator_model.dart';
import 'package:meme_generator/feature/presentation/screens/meme_template_screen/meme_template_model.dart';
import 'package:meme_generator/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IDiContainer {
  Future<Widget> configureDependencies();
}

class DiContainer implements IDiContainer {
  @override
  Future<Widget> configureDependencies() async {
    final prefs = await SharedPreferences.getInstance();
    final dataSource = _dataSourceFactory(prefs);

    final dependencies = Dependencies(
      memeGeneratorModel: _memeGeneratorModelFactory(),
      memeTemplateModel: _memeTemplateModelFactory(dataSource),
      memeCreateTemplateModel: _memeCreateTemplateModelFactory(dataSource),
    );
    return DependenciesProvider(
      dependencies: dependencies,
      child: const App(),
    );
  }

  IMemeCreateTemplateModel _memeCreateTemplateModelFactory(
          ILocalDataSource dataSource) =>
      MemeCreateTemplateModel(repository: _repositoryFactory(dataSource));

  IMemeGeneratorModel _memeGeneratorModelFactory() => MemeGeneratorModel();
  IMemeTemplateModel _memeTemplateModelFactory(ILocalDataSource dataSource) =>
      MemeTemplateModel(repository: _repositoryFactory(dataSource));

  IRepository _repositoryFactory(ILocalDataSource dataSource) =>
      Repository(dataSource);

  ILocalDataSource _dataSourceFactory(SharedPreferences prefs) =>
      LocalDataSource(prefs);
}
