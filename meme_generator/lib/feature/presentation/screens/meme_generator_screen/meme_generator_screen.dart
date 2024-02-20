import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:meme_generator/feature/domain/entity/template.dart';
import 'package:meme_generator/feature/presentation/screens/meme_generator_screen/meme_generator_wm.dart';
import 'package:meme_generator/feature/presentation/widgets/template.dart';
import 'package:screenshot/screenshot.dart';

class MemeGeneratorScreen extends StatelessWidget {
  const MemeGeneratorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MemeGeneratorWidget(memeGeneratorWMFactory);
  }
}

class MemeGeneratorWidget extends ElementaryWidget<IMemeGeneratorWM> {
  const MemeGeneratorWidget(
    super.wmFactory, {
    super.key,
  });

  @override
  Widget build(IMemeGeneratorWM wm) {
    final decoration = BoxDecoration(
      border: Border.all(
        color: Colors.white,
        width: 2,
      ),
    );
    return GestureDetector(
      onTap: wm.unfocus,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 246, 235, 250),
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          actions: [
            IconButton(
              onPressed: wm.saveAndShare,
              icon: const Icon(
                Icons.ios_share_rounded,
                size: 32,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Screenshot(
                controller: wm.screenshotController,
                child: StreamBuilder<Template>(
                    stream: wm.templateController,
                    builder: (context, snapshot) {
                      final template = snapshot.data;
                      if (template == null) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return IntrinsicHeight(
                        child: TemplateWidget(
                          topFocusNode: wm.focusNodeTop,
                          bottomFocusNode: wm.focusNodeBottom,
                          centerFocusNode: wm.focusNodeCenter,
                          centerTextController: wm.memeTextControllerCenter,
                          bottomTextController: wm.memeTextControllerBottom,
                          topTextController: wm.memeTextControllerTop,
                          isEditable: true,
                          template: template,
                          decoration: decoration,
                          imageStream: wm.imageController,
                        ),
                      );
                    }),
              ),
              const SizedBox(
                height: 16,
              ),
              OutlinedButton.icon(
                onPressed: wm.showImageSelectAlertDialod,
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    Colors.deepPurple,
                  ),
                ),
                icon: const Icon(
                  Icons.add_circle_outline_rounded,
                  color: Colors.white,
                ),
                label: const Text(
                  'Заменить изображение',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              OutlinedButton.icon(
                onPressed: wm.goToTemplates,
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    Colors.deepPurple,
                  ),
                ),
                icon: const Icon(
                  Icons.filter_sharp,
                  color: Colors.white,
                ),
                label: const Text(
                  'Выбрать шаблон',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
