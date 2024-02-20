import 'package:meme_generator/feature/presentation/screens/meme_create_template_screen/meme_create_template_model.dart';
import 'package:meme_generator/feature/presentation/screens/meme_generator_screen/meme_generator_model.dart';
import 'package:meme_generator/feature/presentation/screens/meme_template_screen/meme_template_model.dart';

final class Dependencies {
  final IMemeGeneratorModel memeGeneratorModel;
  final IMemeTemplateModel memeTemplateModel;
  final IMemeCreateTemplateModel memeCreateTemplateModel;

  const Dependencies({
    required this.memeGeneratorModel,
    required this.memeTemplateModel,
    required this.memeCreateTemplateModel,
  });
}
