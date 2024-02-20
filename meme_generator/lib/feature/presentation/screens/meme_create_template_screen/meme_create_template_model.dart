import 'package:elementary/elementary.dart';
import 'package:meme_generator/feature/domain/entity/template.dart';
import 'package:meme_generator/feature/domain/repository/repository.dart';

abstract interface class IMemeCreateTemplateModel extends ElementaryModel {
  int get nextIndex;

  Future<void> addTemplate(Template template);
}

final class MemeCreateTemplateModel extends ElementaryModel
    implements IMemeCreateTemplateModel {
  final IRepository repository;
  List<Template> templates = [];

  MemeCreateTemplateModel({required this.repository});

  @override
  void init() async {
    templates = await repository.getAllTemplates();

    super.init();
  }

  @override
  int get nextIndex => templates.length;

  @override
  Future<void> addTemplate(Template template) async =>
      await repository.addTemplate(template);
}
