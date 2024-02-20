import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meme_generator/core/consts/app_constants.dart';
import 'package:meme_generator/core/di/dependencies.dart';
import 'package:meme_generator/feature/domain/entity/template.dart';
import 'package:meme_generator/feature/presentation/screens/meme_create_template_screen/meme_create_template_model.dart';
import 'package:meme_generator/feature/presentation/screens/meme_create_template_screen/meme_create_template_screen.dart';
import 'package:meme_generator/feature/presentation/widgets/image_selector.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/subjects.dart';

abstract interface class IMemeCreateTemplateWM
    extends WidgetModel<MemeCreateTemplateWidget, IMemeCreateTemplateModel> {
  IMemeCreateTemplateWM(super.model);

  BehaviorSubject<bool> get topTextVisibleController;
  BehaviorSubject<bool> get centerTextVisibleController;
  BehaviorSubject<bool> get bottomTextVisibleController;

  TextEditingController get memeTextControllerCenter;
  TextEditingController get memeTextControllerTop;
  TextEditingController get memeTextControllerBottom;

  FocusNode get focusNodeTop;
  FocusNode get focusNodeBottom;
  FocusNode get focusNodeCenter;

  void onTopCheckboxChanged(bool value);
  void onCenterCheckboxChanged(bool value);
  void onBottomCheckboxChanged(bool value);

  Future<void> showImageSelectAlertDialod();

  BehaviorSubject<Template> get constructedTemplateController;

  void goBack();
  Future<void> save();
}

IMemeCreateTemplateWM memeCreateTemplateWMFactory(BuildContext context) {
  final model = context.read<Dependencies>().memeCreateTemplateModel;
  return MemeCreateTemplateWM(model);
}

final class MemeCreateTemplateWM
    extends WidgetModel<MemeCreateTemplateWidget, IMemeCreateTemplateModel>
    implements IMemeCreateTemplateWM {
  MemeCreateTemplateWM(super.model);

  Template? get constructedTemplate =>
      _constructedTemplateController.valueOrNull;

  final TextEditingController textFieldController = TextEditingController();

  @override
  void goBack() {
    Navigator.of(context).pop(false);
  }

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    _constructedTemplateController.add(
      Template(
        id: model.nextIndex,
      ),
    );

    memeTextControllerBottom.addListener(_bottomTextControllerListner);
    memeTextControllerTop.addListener(_topTextControllerListner);
    memeTextControllerCenter.addListener(_centerTextControllerListner);
  }

  @override
  Future<void> save() async {
    final navigator = Navigator.of(context);
    final template = constructedTemplate;
    if (template != null) {
      await model.addTemplate(template);
    }
    navigator.pop(true);
  }

  void _bottomTextControllerListner() {
    final template = constructedTemplate?.copyWith(
      bottomTextFieldValue: memeTextControllerBottom.text,
    );

    if (template != null) {
      _constructedTemplateController.add(template);
    }
  }

  void _topTextControllerListner() {
    final template = constructedTemplate?.copyWith(
      topTextFieldValue: memeTextControllerTop.text,
    );

    if (template != null) {
      _constructedTemplateController.add(template);
    }
  }

  void _centerTextControllerListner() {
    final template = constructedTemplate?.copyWith(
      centerTextFieldValue: memeTextControllerCenter.text,
    );

    if (template != null) {
      _constructedTemplateController.add(template);
    }
  }

  @override
  void dispose() {
    _bottomTextVisibleController.close();
    _topTextVisibleController.close();
    _centerTextVisibleController.close();

    focusNodeBottom.dispose();
    focusNodeCenter.dispose();
    focusNodeTop.dispose();

    memeTextControllerBottom.dispose();
    memeTextControllerCenter.dispose();
    memeTextControllerTop.dispose();
    textFieldController.dispose();

    memeTextControllerBottom.removeListener(_bottomTextControllerListner);
    memeTextControllerTop.removeListener(_topTextControllerListner);
    memeTextControllerCenter.removeListener(_centerTextControllerListner);

    super.dispose();
  }

  void _showImageSelectorBottomSheet() async {
    Navigator.of(context).pop();

    final result = await showModalBottomSheet<bool?>(
      constraints: const BoxConstraints(maxHeight: 200),
      context: context,
      builder: (context) => ImageSelectorTextField(
        controller: textFieldController,
        onTap: Navigator.of(context).pop,
      ),
    );

    if (result == true) {
      final template =
          constructedTemplate?.copyWith(imagePath: textFieldController.text);

      if (template != null) {
        _constructedTemplateController.add(template);
      }
    }
  }

  Future<void> _pickLocalImage() async {
    Navigator.of(context).pop();

    final file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );

    final path = file?.path;

    if (path != null) {
      final template = constructedTemplate?.copyWith(imagePath: path);

      if (template != null) {
        _constructedTemplateController.add(template);
      }
    }
  }

  @override
  Future<void> showImageSelectAlertDialod() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          title: const Center(
            child: Text('Выберите способ'),
          ),
          actions: [
            TextButton(
              onPressed: _showImageSelectorBottomSheet,
              child: const Center(
                child: Text('По ссылке'),
              ),
            ),
            TextButton(
              onPressed: _pickLocalImage,
              child: const Center(
                child: Text('С устройства'),
              ),
            )
          ],
        );
      },
    );
  }

  @override
  BehaviorSubject<bool> get bottomTextVisibleController =>
      _bottomTextVisibleController;

  final BehaviorSubject<bool> _bottomTextVisibleController = BehaviorSubject();

  @override
  BehaviorSubject<bool> get centerTextVisibleController =>
      _centerTextVisibleController;

  final BehaviorSubject<bool> _centerTextVisibleController = BehaviorSubject();

  @override
  final FocusNode focusNodeBottom = FocusNode();

  @override
  final FocusNode focusNodeCenter = FocusNode();

  @override
  final FocusNode focusNodeTop = FocusNode();

  @override
  final TextEditingController memeTextControllerBottom =
      TextEditingController();

  @override
  final TextEditingController memeTextControllerCenter =
      TextEditingController();

  @override
  final TextEditingController memeTextControllerTop = TextEditingController();

  @override
  BehaviorSubject<bool> get topTextVisibleController =>
      _topTextVisibleController;

  final BehaviorSubject<bool> _topTextVisibleController = BehaviorSubject();

  @override
  void onBottomCheckboxChanged(bool value) {
    _bottomTextVisibleController.add(value);
    final template = constructedTemplate?.copyWith(
      bottomTextFieldValue: value ? AppConstants.defaultText : null,
    );
    memeTextControllerBottom.text = value ? AppConstants.defaultText : '';

    if (template != null) {
      _constructedTemplateController.add(template);
    }
  }

  @override
  void onCenterCheckboxChanged(bool value) {
    _centerTextVisibleController.add(value);
    final template = constructedTemplate?.copyWith(
      centerTextFieldValue: value ? AppConstants.defaultText : null,
    );
    memeTextControllerCenter.text = value ? AppConstants.defaultText : '';

    if (template != null) {
      _constructedTemplateController.add(template);
    }
  }

  @override
  void onTopCheckboxChanged(bool value) {
    _topTextVisibleController.add(value);

    final template = constructedTemplate?.copyWith(
      topTextFieldValue: value ? AppConstants.defaultText : null,
    );
    memeTextControllerTop.text = value ? AppConstants.defaultText : '';

    if (template != null) {
      _constructedTemplateController.add(template);
    }
  }

  @override
  BehaviorSubject<Template> get constructedTemplateController =>
      _constructedTemplateController;

  final BehaviorSubject<Template> _constructedTemplateController =
      BehaviorSubject();
}
