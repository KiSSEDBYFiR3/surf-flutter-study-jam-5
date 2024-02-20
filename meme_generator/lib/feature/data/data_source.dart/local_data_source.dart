import 'dart:convert';

import 'package:meme_generator/core/consts/app_constants.dart';
import 'package:meme_generator/core/utils/json.dart';
import 'package:meme_generator/feature/data/data_source.dart/i_local_data_source.dart';
import 'package:meme_generator/feature/data/model/template_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class LocalDataSource implements ILocalDataSource {
  /// Использовал [SharedPreferences] потому что было лень тащить Drift)
  final SharedPreferences prefs;

  const LocalDataSource(this.prefs);

  @override
  Future<void> addTemplate(TemplateDto dto) async {
    final templates = await getAllTemplates();

    templates.add(dto);

    final templatesToSave = templates
        .map(
          (e) => e.toJson().toString(),
        )
        .toList();

    await prefs.setStringList(
      AppConstants.templatesKey,
      templatesToSave,
    );
  }

  @override
  Future<void> deleteTemplate(int id) async {
    final templates = await getAllTemplates();

    if (templates.isEmpty) {
      return;
    }

    final templateToDelete =
        templates.indexWhere((element) => element.id == id);

    if (templateToDelete != -1) {
      templates.removeAt(templateToDelete);

      final templatesToUpdate = templates
          .map(
            (e) => e.toJson().toString(),
          )
          .toList();

      await prefs.setStringList(AppConstants.templatesKey, templatesToUpdate);
    }
  }

  @override
  Future<List<TemplateDto>> getAllTemplates() async {
    final stringModel = prefs.getStringList(AppConstants.templatesKey);
    final json = stringModel?.map((e) => jsonDecode(e) as Json).toList();

    return json?.map(TemplateDto.fromJson).toList() ?? [];
  }
}
