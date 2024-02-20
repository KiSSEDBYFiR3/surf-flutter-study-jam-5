import 'package:meme_generator/feature/data/model/template_dto.dart';
import 'package:meme_generator/feature/domain/entity/template.dart';

abstract class TemplateMapper {
  static Template mapDtoToTemplate(TemplateDto dto) {
    return Template(
      id: dto.id,
      imagePath: dto.imagePath,
      topTextFieldValue: dto.topTextFieldValue,
      bottomTextFieldValue: dto.topTextFieldValue,
      centerTextFieldValue: dto.centerTextFieldValue,
    );
  }

  static TemplateDto mapTemplateToDto(Template template) {
    return TemplateDto(
      id: template.id,
      imagePath: template.imagePath,
      topTextFieldValue: template.topTextFieldValue,
      bottomTextFieldValue: template.topTextFieldValue,
      centerTextFieldValue: template.centerTextFieldValue,
    );
  }
}
