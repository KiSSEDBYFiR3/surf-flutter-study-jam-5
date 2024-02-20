// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'template_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TemplateDto _$TemplateDtoFromJson(Map<String, dynamic> json) => TemplateDto(
      id: json['id'] as int,
      bottomTextFieldValue: json['bottomTextFieldValue'] as String?,
      centerTextFieldValue: json['centerTextFieldValue'] as String?,
      topTextFieldValue: json['topTextFieldValue'] as String?,
      imagePath: json['imagePath'] as String?,
    );

Map<String, dynamic> _$TemplateDtoToJson(TemplateDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imagePath': instance.imagePath,
      'topTextFieldValue': instance.topTextFieldValue,
      'bottomTextFieldValue': instance.bottomTextFieldValue,
      'centerTextFieldValue': instance.centerTextFieldValue,
    };
