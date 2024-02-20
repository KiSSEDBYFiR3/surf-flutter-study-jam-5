import 'dart:io';

import 'package:flutter/material.dart';
import 'package:meme_generator/core/consts/app_constants.dart';
import 'package:meme_generator/feature/domain/entity/template.dart';

class TemplateWidget extends StatelessWidget {
  final Decoration decoration;
  final Template template;
  final bool isEditable;

  final TextEditingController? topTextController;
  final TextEditingController? centerTextController;
  final TextEditingController? bottomTextController;

  final FocusNode? topFocusNode;
  final FocusNode? centerFocusNode;
  final FocusNode? bottomFocusNode;

  final Stream<Image>? imageStream;

  const TemplateWidget({
    super.key,
    required this.decoration,
    required this.template,
    required this.isEditable,
    this.bottomTextController,
    this.centerTextController,
    this.topTextController,
    this.bottomFocusNode,
    this.centerFocusNode,
    this.topFocusNode,
    this.imageStream,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (template.topTextFieldValue != null)
                  TextWidget(
                    isEditable: isEditable,
                    text: template.topTextFieldValue,
                    memeTextController: topTextController,
                    focusNode: topFocusNode,
                  ),
                Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: DecoratedBox(
                        decoration: decoration,
                        child: imageStream != null
                            ? StreamBuilder<Image>(
                                stream: imageStream,
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
                              )
                            : _ImageWidget(
                                imageLink: template.imagePath ??
                                    AppConstants.defaultImage,
                              ),
                      ),
                    ),
                    if (template.centerTextFieldValue != null)
                      TextWidget(
                        isEditable: isEditable,
                        text: template.centerTextFieldValue,
                        memeTextController: centerTextController,
                        focusNode: centerFocusNode,
                      ),
                  ],
                ),
                if (template.bottomTextFieldValue != null)
                  TextWidget(
                    isEditable: isEditable,
                    text: template.bottomTextFieldValue,
                    memeTextController: bottomTextController,
                    focusNode: bottomFocusNode,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextWidget extends StatelessWidget {
  final bool isEditable;
  final FocusNode? focusNode;
  final TextEditingController? memeTextController;
  final String? text;
  const TextWidget({
    super.key,
    required this.isEditable,
    this.focusNode,
    this.memeTextController,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    if (isEditable) {
      assert(focusNode != null);
      assert(memeTextController != null);
      return EditableText(
        maxLines: null,
        focusNode: focusNode!,
        controller: memeTextController!,
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
      );
    }

    return Text(
      text ?? '',
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontFamily: 'Impact',
        fontSize: 40,
        color: Colors.white,
      ),
    );
  }
}

class _ImageWidget extends StatelessWidget {
  final String imageLink;
  const _ImageWidget({
    super.key,
    required this.imageLink,
  });

  Future<Image> _getImage() async {
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
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getImage(),
        builder: (context, snapshot) {
          final image = snapshot.data;
          if (image == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Image(image: image.image);
        });
  }
}
