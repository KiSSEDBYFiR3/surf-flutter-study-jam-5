import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meme_generator/core/consts/app_constants.dart';
import 'package:meme_generator/core/di/dependencies.dart';
import 'package:meme_generator/feature/presentation/screens/meme_generator_model.dart';
import 'package:meme_generator/feature/presentation/screens/meme_generator_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/subjects.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

abstract interface class IMemeGeneratorWM
    extends WidgetModel<MemeGeneratorWidget, IMemeGeneratorModel> {
  TextEditingController get memeTextController;
  TextEditingController get textFieldController;

  ScreenshotController get screenshotController;

  BehaviorSubject<Image> get imageController;

  FocusNode get focusNode;

  IMemeGeneratorWM(super.model);

  void unfocus();

  void showImageSelectAlertDialod();
  void saveAndShare();
}

final class MemeGeneratorWM
    extends WidgetModel<MemeGeneratorWidget, IMemeGeneratorModel>
    implements IMemeGeneratorWM {
  MemeGeneratorWM(super.model);

  @override
  final TextEditingController memeTextController = TextEditingController();

  @override
  final FocusNode focusNode = FocusNode();

  @override
  final ScreenshotController screenshotController = ScreenshotController();

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    memeTextController.text = AppConstants.defaultText;
    _imageController.add(
      Image.network(
        AppConstants.defaultImage,
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  void saveAndShare() async {
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
    memeTextController.dispose();
    textFieldController.dispose();
    focusNode.dispose();
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
      builder: (context) => _ImageSelectorTextField(
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
  void showImageSelectAlertDialod() async {
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
}

IMemeGeneratorWM memeGeneratorWMFactory(BuildContext context) {
  final model = context.read<Dependencies>().memeGeneratorModel;
  return MemeGeneratorWM(model);
}

class _ImageSelectorTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(bool?) onTap;
  const _ImageSelectorTextField({
    super.key,
    required this.onTap,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: TextField(
            decoration: const InputDecoration(
              filled: true,
              fillColor: Color.fromARGB(255, 250, 222, 222),
              focusColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
            ),
            controller: controller,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: OutlinedButton(
            onPressed: () => onTap(true),
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.deepPurple),
            ),
            child: const Center(
              child: Text(
                'Выбрать',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
