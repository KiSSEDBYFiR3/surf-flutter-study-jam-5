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
          (e) => jsonEncode(e),
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
            (e) => jsonEncode(e),
          )
          .toList();

      await prefs.setStringList(AppConstants.templatesKey, templatesToUpdate);
    }
  }

  @override
  Future<List<TemplateDto>> getAllTemplates() async {
    if (await checkIfFirstRun()) {
      final templates = _generateDefaultTemplates();

      final stringModels =
          templates.map((e) => jsonEncode(e.toJson())).toList();
      await prefs.setStringList(AppConstants.templatesKey, stringModels);

      return templates;
    }

    final stringModel = prefs.getStringList(AppConstants.templatesKey);
    final json = stringModel?.map((e) => jsonDecode(e) as Json).toList();

    return json?.map(TemplateDto.fromJson).toList() ?? [];
  }

  Future<bool> checkIfFirstRun() async {
    final isFirstRun = prefs.getBool(AppConstants.firstRun);
    if (isFirstRun == null) {
      prefs.setBool(AppConstants.firstRun, false);
      return true;
    }
    return isFirstRun;
  }

  /// Дэфолтные шаблоны для первого запуска приложения, так как из сети ничего не получаем
  List<TemplateDto> _generateDefaultTemplates() {
    return const [
      TemplateDto(
        id: 1,
        imagePath: AppConstants.defaultImage,
        topTextFieldValue: AppConstants.defaultText,
      ),
      TemplateDto(
        id: 2,
        imagePath: AppConstants.defaultImage,
        bottomTextFieldValue: AppConstants.defaultText,
      ),
      TemplateDto(
        id: 3,
        imagePath: AppConstants.defaultImage,
        centerTextFieldValue: AppConstants.defaultText,
      ),
      TemplateDto(
        id: 4,
        imagePath: AppConstants.defaultImage,
        topTextFieldValue: AppConstants.defaultText,
        bottomTextFieldValue: AppConstants.defaultText,
      ),
    ];
  }
}
