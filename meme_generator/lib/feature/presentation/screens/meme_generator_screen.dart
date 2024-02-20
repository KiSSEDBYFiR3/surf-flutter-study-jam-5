import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:meme_generator/feature/presentation/screens/meme_generator_wm.dart';
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
        backgroundColor: Colors.grey,
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
                child: ColoredBox(
                  color: Colors.black,
                  child: DecoratedBox(
                    decoration: decoration,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 20,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: double.infinity,
                            height: 200,
                            child: DecoratedBox(
                              decoration: decoration,
                              child: StreamBuilder<Image>(
                                stream: wm.imageController,
                                builder: (context, snapshot) {
                                  final image = snapshot.data;

                                  if (image == null) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: image,
                                  );
                                },
                              ),
                            ),
                          ),
                          EditableText(
                            maxLines: null,
                            focusNode: wm.focusNode,
                            controller: wm.memeTextController,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: 'Impact',
                              fontSize: 40,
                              color: Colors.white,
                            ),
                            cursorColor: Colors.white,
                            cursorWidth: 4,
                            cursorHeight: 36,
                            backgroundCursorColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
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
            ],
          ),
        ),
      ),
    );
  }
}
