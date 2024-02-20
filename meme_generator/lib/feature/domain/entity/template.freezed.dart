// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'template.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Template {
  int get id => throw _privateConstructorUsedError;
  String? get imagePath => throw _privateConstructorUsedError;
  String? get topTextFieldValue => throw _privateConstructorUsedError;
  String? get bottomTextFieldValue => throw _privateConstructorUsedError;
  String? get centerTextFieldValue => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TemplateCopyWith<Template> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TemplateCopyWith<$Res> {
  factory $TemplateCopyWith(Template value, $Res Function(Template) then) =
      _$TemplateCopyWithImpl<$Res, Template>;
  @useResult
  $Res call(
      {int id,
      String? imagePath,
      String? topTextFieldValue,
      String? bottomTextFieldValue,
      String? centerTextFieldValue});
}

/// @nodoc
class _$TemplateCopyWithImpl<$Res, $Val extends Template>
    implements $TemplateCopyWith<$Res> {
  _$TemplateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? imagePath = freezed,
    Object? topTextFieldValue = freezed,
    Object? bottomTextFieldValue = freezed,
    Object? centerTextFieldValue = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      imagePath: freezed == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String?,
      topTextFieldValue: freezed == topTextFieldValue
          ? _value.topTextFieldValue
          : topTextFieldValue // ignore: cast_nullable_to_non_nullable
              as String?,
      bottomTextFieldValue: freezed == bottomTextFieldValue
          ? _value.bottomTextFieldValue
          : bottomTextFieldValue // ignore: cast_nullable_to_non_nullable
              as String?,
      centerTextFieldValue: freezed == centerTextFieldValue
          ? _value.centerTextFieldValue
          : centerTextFieldValue // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TemplateImplCopyWith<$Res>
    implements $TemplateCopyWith<$Res> {
  factory _$$TemplateImplCopyWith(
          _$TemplateImpl value, $Res Function(_$TemplateImpl) then) =
      __$$TemplateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String? imagePath,
      String? topTextFieldValue,
      String? bottomTextFieldValue,
      String? centerTextFieldValue});
}

/// @nodoc
class __$$TemplateImplCopyWithImpl<$Res>
    extends _$TemplateCopyWithImpl<$Res, _$TemplateImpl>
    implements _$$TemplateImplCopyWith<$Res> {
  __$$TemplateImplCopyWithImpl(
      _$TemplateImpl _value, $Res Function(_$TemplateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? imagePath = freezed,
    Object? topTextFieldValue = freezed,
    Object? bottomTextFieldValue = freezed,
    Object? centerTextFieldValue = freezed,
  }) {
    return _then(_$TemplateImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      imagePath: freezed == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String?,
      topTextFieldValue: freezed == topTextFieldValue
          ? _value.topTextFieldValue
          : topTextFieldValue // ignore: cast_nullable_to_non_nullable
              as String?,
      bottomTextFieldValue: freezed == bottomTextFieldValue
          ? _value.bottomTextFieldValue
          : bottomTextFieldValue // ignore: cast_nullable_to_non_nullable
              as String?,
      centerTextFieldValue: freezed == centerTextFieldValue
          ? _value.centerTextFieldValue
          : centerTextFieldValue // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$TemplateImpl implements _Template {
  _$TemplateImpl(
      {required this.id,
      this.imagePath,
      this.topTextFieldValue,
      this.bottomTextFieldValue,
      this.centerTextFieldValue});

  @override
  final int id;
  @override
  final String? imagePath;
  @override
  final String? topTextFieldValue;
  @override
  final String? bottomTextFieldValue;
  @override
  final String? centerTextFieldValue;

  @override
  String toString() {
    return 'Template(id: $id, imagePath: $imagePath, topTextFieldValue: $topTextFieldValue, bottomTextFieldValue: $bottomTextFieldValue, centerTextFieldValue: $centerTextFieldValue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TemplateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.imagePath, imagePath) ||
                other.imagePath == imagePath) &&
            (identical(other.topTextFieldValue, topTextFieldValue) ||
                other.topTextFieldValue == topTextFieldValue) &&
            (identical(other.bottomTextFieldValue, bottomTextFieldValue) ||
                other.bottomTextFieldValue == bottomTextFieldValue) &&
            (identical(other.centerTextFieldValue, centerTextFieldValue) ||
                other.centerTextFieldValue == centerTextFieldValue));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, imagePath, topTextFieldValue,
      bottomTextFieldValue, centerTextFieldValue);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TemplateImplCopyWith<_$TemplateImpl> get copyWith =>
      __$$TemplateImplCopyWithImpl<_$TemplateImpl>(this, _$identity);
}

abstract class _Template implements Template {
  factory _Template(
      {required final int id,
      final String? imagePath,
      final String? topTextFieldValue,
      final String? bottomTextFieldValue,
      final String? centerTextFieldValue}) = _$TemplateImpl;

  @override
  int get id;
  @override
  String? get imagePath;
  @override
  String? get topTextFieldValue;
  @override
  String? get bottomTextFieldValue;
  @override
  String? get centerTextFieldValue;
  @override
  @JsonKey(ignore: true)
  _$$TemplateImplCopyWith<_$TemplateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
