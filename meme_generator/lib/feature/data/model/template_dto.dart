import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meme_generator/core/utils/json.dart';

part 'template_dto.g.dart';

@JsonSerializable(
  createToJson: true,
  createFactory: true,
)
class TemplateDto {
  final int id;
  final String? imagePath;
  final String? topTextFieldValue;
  final String? bottomTextFieldValue;
  final String? centerTextFieldValue;

  const TemplateDto({
    required this.id,
    this.bottomTextFieldValue,
    this.centerTextFieldValue,
    this.topTextFieldValue,
    this.imagePath,
  });

  Json toJson() => _$TemplateDtoToJson(this);

  factory TemplateDto.fromJson(Json json) => _$TemplateDtoFromJson(json);
}
