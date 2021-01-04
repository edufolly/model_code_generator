import 'package:model_code_generator/languages/abstract_language.dart';
import 'package:model_code_generator/models/attribute_type.dart';
import 'package:model_code_generator/models/entity_model.dart';
import 'package:model_code_generator/languages/language_type.dart';

///
///
///
class LanguageJava extends AbstractLanguage {
  static const Map<AttributeType, String> typeNames = <AttributeType, String>{
    AttributeType.String: 'String',
    AttributeType.Boolean: 'boolean',
    AttributeType.Integer: 'int',
    AttributeType.Double: 'double',
    AttributeType.Model: null,
    AttributeType.List: 'List',
  };

  ///
  ///
  ///
  @override
  LanguageType get type => LanguageType.Java;

  ///
  ///
  ///
  @override
  String getTypeName(AttributeType attributeType) => typeNames[attributeType];

  ///
  ///
  ///
  @override
  String getModelClass(EntityModel entity) {
    String code = '';
    code += 'Java - Não implementado.';
    return code;
  }
}
