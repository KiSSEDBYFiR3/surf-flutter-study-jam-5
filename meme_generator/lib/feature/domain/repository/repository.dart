import 'package:meme_generator/feature/domain/entity/template.dart';

abstract interface class IRepository {
  Future<void> addTemplate(Template template);
  Future<void> deleteTemplate(int id);
  Future<List<Template>> getAllTemplates();
}
