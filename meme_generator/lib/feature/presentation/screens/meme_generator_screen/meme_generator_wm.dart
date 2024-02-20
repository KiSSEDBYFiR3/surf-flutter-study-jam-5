import 'dart:io';

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meme_generator/core/consts/app_constants.dart';
import 'package:meme_generator/core/di/dependencies.dart';
import 'package:meme_generator/feature/domain/entity/template.dart';
import 'package:meme_generator/feature/presentation/screens/meme_generator_screen/meme_generator_model.dart';
import 'package:meme_generator/feature/presentation/screens/meme_generator_screen/meme_generator_screen.dart';
import 'package:meme_generator/feature/presentation/screens/meme_template_screen/meme_template_screen.dart';
import 'package:meme_generator/feature/presentation/widgets/image_selector.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/subjects.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

abstract interface class IMemeGeneratorWM
    extends WidgetModel<MemeGeneratorWidget, IMemeGeneratorModel> {
  TextEditingController get memeTextControllerCenter;
  TextEditingController get memeTextControllerTop;
  TextEditingController get memeTextControllerBottom;

  TextEditingController get textFieldController;

  ScreenshotController get screenshotController;

  BehaviorSubject<Image> get imageController;

  BehaviorSubject<Template> get templateController;

  FocusNode get focusNodeTop;
  FocusNode get focusNodeBottom;
  FocusNode get focusNodeCenter;

  IMemeGeneratorWM(super.model);

  void unfocus();

  Future<void> showImageSelectAlertDialod();
  Future<void> saveAndShare();

  Future<void> goToTemplates();
}

final class MemeGeneratorWM
    extends WidgetModel<MemeGeneratorWidget, IMemeGeneratorModel>
    implements IMemeGeneratorWM {
  MemeGeneratorWM(super.model);

  @override
  final TextEditingController memeTextControllerCenter =
      TextEditingController();
  @override
  final TextEditingController memeTextControllerTop = TextEditingController();

  @override
  final TextEditingController memeTextControllerBottom =
      TextEditingController();

  @override
  final FocusNode focusNodeTop = FocusNode();
  @override
  final FocusNode focusNodeBottom = FocusNode();
  @override
  final FocusNode focusNodeCenter = FocusNode();

  @override
  final ScreenshotController screenshotController = ScreenshotController();

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    memeTextControllerBottom.text = AppConstants.defaultText;

    _imageController.add(
      Image.network(
        AppConstants.defaultImage,
        fit: BoxFit.cover,
      ),
    );
    _templateController.add(
      Template(
        id: 0,
        imagePath: AppConstants.defaultImage,
        bottomTextFieldValue: AppConstants.defaultText,
      ),
    );
  }

  @override
  Future<void> saveAndShare() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = await screenshotController.captureAndSave(directory.path);
    if (path != null) {
      await Share.shareXFiles(
        [
          XFile(path),
        ],
      );
    }
  }

  @override
  void dispose() {
    _imageController.close();
    _templateController.close();

    memeTextControllerTop.dispose();
    memeTextControllerCenter.dispose();
    memeTextControllerBottom.dispose();

    textFieldController.dispose();

    focusNodeTop.dispose();
    focusNodeBottom.dispose();
    focusNodeCenter.dispose();
    super.dispose();
  }

  @override
  final TextEditingController textFieldController = TextEditingController();

  @override
  BehaviorSubject<Image> get imageController => _imageController;

  final BehaviorSubject<Image> _imageController = BehaviorSubject();

  @override
  void unfocus() => FocusScope.of(context).unfocus();

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
      _imageController.add(
        Image.network(textFieldController.text),
      );
    }
  }

  Future<void> _pickLocalImage() async {
    Navigator.of(context).pop();

    final file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );

    final bytes = await file?.readAsBytes();

    if (bytes != null) {
      _imageController.add(
        Image.memory(bytes),
      );
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
  Future<void> goToTemplates() async {
    final template = await Navigator.of(context).push<Template>(
      MaterialPageRoute(
        builder: (context) => const MemeTemplateScreen(),
      ),
    );
    if (template != null) {
      _templateController.add(template);
      memeTextControllerBottom.text = template.bottomTextFieldValue ?? '';
      memeTextControllerCenter.text = template.centerTextFieldValue ?? '';
      memeTextControllerTop.text = template.topTextFieldValue ?? '';
      final image = await _getImage(template.imagePath);
      if (image != null) {
        _imageController.add(image);
      }
    }
  }

  Future<Image?> _getImage(String? imageLink) async {
    if (imageLink == null) {
      return _imageController.valueOrNull;
    }
    if (imageLink.contains('http')) {
      final image = Image.network(
        imageLink,
        fit: BoxFit.cover,
      );
      return image;
    }
    final bytes = await File(
      imageLink,
    ).readAsBytes();

    final image = Image.memory(bytes);
    return image;
  }

  @override
  BehaviorSubject<Template> get templateController => _templateController;
  final BehaviorSubject<Template> _templateController = BehaviorSubject();
}

IMemeGeneratorWM memeGeneratorWMFactory(BuildContext context) {
  final model = context.read<Dependencies>().memeGeneratorModel;
  return MemeGeneratorWM(model);
}
