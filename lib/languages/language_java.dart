import 'package:model_code_generator/languages/abstract_language.dart';
import 'package:model_code_generator/models/attribute_type_model.dart';
import 'package:model_code_generator/models/entity_model.dart';
import 'package:model_code_generator/models/language_type_model.dart';

///
///
///
class LanguageJava extends AbstractLanguage {
  static const Map<AttributeType, String> typeNames = <AttributeType, String>{
    AttributeType.String: 'String',
    AttributeType.Boolean: 'boolean',
    AttributeType.Integer: 'int',
    AttributeType.Double: 'double',
    AttributeType.Float: 'float',
    AttributeType.Date: 'DateTime',
    AttributeType.Object: 'dynamic',
    AttributeType.Model: '',
    AttributeType.List: 'List',
    AttributeType.IconData: 'IconData',
    AttributeType.Unknown: '[Unknown]',
    AttributeType.Empty: '',
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
  String typeName(AttributeType attributeType) => typeNames[attributeType]!;

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
