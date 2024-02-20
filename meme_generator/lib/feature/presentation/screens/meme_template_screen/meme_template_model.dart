import 'package:elementary/elementary.dart';
import 'package:meme_generator/feature/domain/entity/template.dart';
import 'package:meme_generator/feature/domain/repository/repository.dart';

abstract class IMemeTemplateModel extends ElementaryModel {
  Future<void> addTemplate(Template template);
  Future<void> deleteTemplate(int id);
  Future<List<Template>> getAllTemplates();
}

final class MemeTemplateModel extends ElementaryModel
    implements IMemeTemplateModel {
  final IRepository repository;

  MemeTemplateModel({
    required this.repository,
  });

  @override
  Future<void> addTemplate(Template template) async =>
      repository.addTemplate(template);

  @override
  Future<void> deleteTemplate(int id) async =>
      await repository.deleteTemplate(id);

  @override
  Future<List<Template>> getAllTemplates() async =>
      await repository.getAllTemplates();
}
