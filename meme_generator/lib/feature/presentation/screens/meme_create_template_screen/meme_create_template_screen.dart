import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:meme_generator/feature/domain/entity/template.dart';
import 'package:meme_generator/feature/presentation/screens/meme_create_template_screen/meme_create_template_wm.dart';
import 'package:meme_generator/feature/presentation/widgets/template.dart';

class MemeCreateTemplateScreen extends StatelessWidget {
  const MemeCreateTemplateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MemeCreateTemplateWidget(memeCreateTemplateWMFactory);
  }
}

class MemeCreateTemplateWidget extends ElementaryWidget<IMemeCreateTemplateWM> {
  const MemeCreateTemplateWidget(super.wmFactory, {super.key});

  @override
  Widget build(IMemeCreateTemplateWM wm) {
    final decoration = BoxDecoration(
      border: Border.all(
        color: Colors.white,
        width: 2,
      ),
    );
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 235, 250),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 28,
            color: Colors.white,
          ),
          onPressed: wm.goBack,
        ),
        actions: [
          TextButton(
            onPressed: wm.save,
            child: const Text(
              'Сохранить',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0, top: 12),
                      child: Text(
                        'Позиция текста',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    StreamBuilder<bool>(
                      stream: wm.topTextVisibleController,
                      builder: (context, snapshot) {
                        return _CheckBox(
                          checkBoxValue: snapshot.data ?? false,
                          onChanged: (value) =>
                              wm.onTopCheckboxChanged(value ?? false),
                          text: 'Сверху',
                        );
                      },
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    StreamBuilder<bool>(
                      stream: wm.centerTextVisibleController,
                      builder: (context, snapshot) {
                        return _CheckBox(
                          checkBoxValue: snapshot.data ?? false,
                          onChanged: (value) =>
                              wm.onCenterCheckboxChanged(value ?? false),
                          text: 'Центр',
                        );
                      },
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    StreamBuilder<bool>(
                      stream: wm.bottomTextVisibleController,
                      builder: (context, snapshot) {
                        return _CheckBox(
                          checkBoxValue: snapshot.data ?? false,
                          onChanged: (value) =>
                              wm.onBottomCheckboxChanged(value ?? false),
                          text: 'Снизу',
                        );
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.image),
                    onPressed: wm.showImageSelectAlertDialod,
                    label: const Center(
                      child: Text(
                        'Изображение',
                        style: TextStyle(fontSize: 17),
                        maxLines: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          StreamBuilder<Template>(
              stream: wm.constructedTemplateController,
              builder: (context, snapshot) {
                final template = snapshot.data;

                if (template == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return TemplateWidget(
                  decoration: decoration,
                  template: template,
                  isEditable: true,
                  topFocusNode: wm.focusNodeTop,
                  bottomFocusNode: wm.focusNodeBottom,
                  centerFocusNode: wm.focusNodeCenter,
                  topTextController: wm.memeTextControllerTop,
                  centerTextController: wm.memeTextControllerCenter,
                  bottomTextController: wm.memeTextControllerBottom,
                );
              }),
        ],
      ),
    );
  }
}

class _CheckBox extends StatelessWidget {
  final bool checkBoxValue;
  final Function(bool?) onChanged;
  final String text;
  const _CheckBox({
    super.key,
    required this.checkBoxValue,
    required this.onChanged,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: checkBoxValue,
          onChanged: onChanged,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
