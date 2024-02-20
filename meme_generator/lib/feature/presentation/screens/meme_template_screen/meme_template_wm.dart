import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:meme_generator/core/di/dependencies.dart';
import 'package:meme_generator/feature/domain/entity/template.dart';
import 'package:meme_generator/feature/presentation/screens/meme_create_template_screen/meme_create_template_screen.dart';
import 'package:meme_generator/feature/presentation/screens/meme_template_screen/meme_template_model.dart';
import 'package:meme_generator/feature/presentation/screens/meme_template_screen/meme_template_screen.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/subjects.dart';

abstract interface class IMemeTemplateWM
    extends WidgetModel<MemeTemplateWidget, IMemeTemplateModel> {
  IMemeTemplateWM(super.model);

  BehaviorSubject<List<Template>> get templatesController;

  void selectTemplate(Template template);
  void goBack();
  void goToCreateTemplate();
}

final class MemeTemplateWM
    extends WidgetModel<MemeTemplateWidget, IMemeTemplateModel>
    implements IMemeTemplateWM {
  MemeTemplateWM(super.model);

  @override
  BehaviorSubject<List<Template>> get templatesController =>
      _templatesController;

  final BehaviorSubject<List<Template>> _templatesController =
      BehaviorSubject();

  @override
  void initWidgetModel() async {
    super.initWidgetModel();
    final templates = await model.getAllTemplates();
    _templatesController.add(templates);
  }

  @override
  void dispose() {
    _templatesController.close();
    super.dispose();
  }

  @override
  void selectTemplate(Template template) {
    Navigator.of(context).pop(template);
  }

  @override
  void goBack() {
    Navigator.of(context).pop();
  }

  @override
  void goToCreateTemplate() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const MemeCreateTemplateScreen(),
      ),
    );

    if (result == true) {
      final templates = await model.getAllTemplates();
      _templatesController.add(templates);
    }
  }
}

IMemeTemplateWM memeTemplateWMFactory(BuildContext context) {
  final model = context.read<Dependencies>().memeTemplateModel;
  return MemeTemplateWM(model);
}
