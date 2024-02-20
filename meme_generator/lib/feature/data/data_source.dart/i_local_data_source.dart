import 'package:meme_generator/feature/data/model/template_dto.dart';

abstract interface class ILocalDataSource {
  Future<void> addTemplate(TemplateDto dto);
  Future<void> deleteTemplate(int id);
  Future<List<TemplateDto>> getAllTemplates();
}
