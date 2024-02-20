import 'package:meme_generator/feature/data/data_source.dart/i_local_data_source.dart';
import 'package:meme_generator/feature/domain/entity/template.dart';
import 'package:meme_generator/feature/domain/mappers/template_mapper.dart';
import 'package:meme_generator/feature/domain/repository/repository.dart';

final class Repository implements IRepository {
  final ILocalDataSource dataSource;

  const Repository(this.dataSource);

  @override
  Future<void> addTemplate(Template template) async =>
      await dataSource.addTemplate(TemplateMapper.mapTemplateToDto(template));

  @override
  Future<void> deleteTemplate(int id) async =>
      await dataSource.deleteTemplate(id);

  @override
  Future<List<Template>> getAllTemplates() async {
    final dtos = await dataSource.getAllTemplates();

    final templates = dtos.map(TemplateMapper.mapDtoToTemplate).toList();

    return templates;
  }
}
