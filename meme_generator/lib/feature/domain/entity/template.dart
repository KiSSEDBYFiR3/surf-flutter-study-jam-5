import 'package:freezed_annotation/freezed_annotation.dart';

part 'template.freezed.dart';

@freezed
class Template with _$Template {
  factory Template({
    required int id,
    String? imagePath,
    String? topTextFieldValue,
    String? bottomTextFieldValue,
    String? centerTextFieldValue,
  }) = _Template;
}
