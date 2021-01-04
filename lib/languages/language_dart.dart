import 'package:model_code_generator/languages/abstract_language.dart';
import 'package:model_code_generator/models/attribute_type.dart';
import 'package:model_code_generator/models/entity_model.dart';
import 'package:model_code_generator/languages/language_type.dart';

///
///
///
class LanguageDart extends AbstractLanguage {
  static const Map<AttributeType, String> typeNames = <AttributeType, String>{
    AttributeType.String: 'String',
    AttributeType.Boolean: 'bool',
    AttributeType.Integer: 'int',
    AttributeType.Double: 'double',
    AttributeType.Model: null,
    AttributeType.List: 'List',
  };

  ///
  ///
  ///
  @override
  LanguageType get type => LanguageType.Dart;

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
    code += 'Dart - Não implementado.';
    return code;

    /*
    String className = '${model.name}Model';

    String code = '';
    code += 'import \'package:folly_fields/crud/abstract_model.dart\';\n';
    code += '\n';
    code += '///\n';
    code += '///\n';
    code += '///\n';
    code += 'class $className extends AbstractModel {\n';
    for (AttributeModel attribute in model.attributes) {
      code += '  ${attribute.getTextType()} ${attribute.name}';
      if (attribute.hasNullAware) code += ' = ${attribute.nullAware}';
      code += ';\n';
    }
    code += '\n';

    ///
    ///
    ///
    code += '  ///\n';
    code += '  ///\n';
    code += '  ///\n';
    code += '  $className();\n';
    code += '\n';

    ///
    ///
    ///
    code += '  ///\n';
    code += '  ///\n';
    code += '  ///\n';
    code += '  $className.fromJson(Map<String, dynamic> map)\n';
    code += '      :\n';

    for (AttributeModel attribute in model.attributes) {
      String name = attribute.name;
      switch (attribute.type.type) {
        case AttributeType.String:
          code += '        $name = map[\'$name\']';
          break;
        case AttributeType.Boolean:
          code += '        $name = map[\'$name\']';
          break;
        case AttributeType.Integer:
          code += '        $name = map[\'$name\']';
          break;
        case AttributeType.Double:
          code += '        $name = map[\'$name\']';
          break;
        case AttributeType.Model:
          code += '        AttributeType.Model - ??????????\n';
          break;
        case AttributeType.List:
          code += '        AttributeType.List - ??????????\n';
          break;
      }

      if (attribute.hasNullAware) code += ' ?? ${attribute.nullAware}';

      code += ',\n';
    }
    code += '        super.fromJson(map);\n';
    code += '\n';

    ///
    ///
    ///
    code += '  ///\n';
    code += '  ///\n';
    code += '  ///\n';
    code += '  @override\n';
    code += '  $className fromJson(Map<String, dynamic> map) =>\n';
    code += '      $className.fromJson(map);\n';
    code += '\n';

    ///
    ///
    ///
    code += '  ///\n';
    code += '  ///\n';
    code += '  ///\n';
    code += '  @override\n';
    code += '  Map<String, dynamic> toMap() {\n';
    code += '    Map<String, dynamic> map = super.toMap();\n';
    for (AttributeModel attribute in model.attributes) {
      String name = attribute.name;
      code += '    ';
      if (!attribute.hasNullAware) {
        code += 'if ($name != null) ';
      }

      switch (attribute.type.type) {
        case AttributeType.String:
          code += 'map[\'$name\'] = $name';
          break;
        case AttributeType.Boolean:
          code += 'map[\'$name\'] = $name';
          break;
        case AttributeType.Integer:
          code += 'map[\'$name\'] = $name';
          break;
        case AttributeType.Double:
          code += 'map[\'$name\'] = $name';
          break;
        case AttributeType.Model:
          code += '    AttributeType.Model - ??????????\n';
          break;
        case AttributeType.List:
          code += '    AttributeType.List - ??????????\n';
          break;
      }

      if (attribute.hasNullAware) code += ' ?? ${attribute.nullAware}';

      code += ';\n';
    }
    code += '    return map;\n';
    code += '  }\n';
    code += '\n';

    ///
    ///
    ///
    code += '  ///\n';
    code += '  ///\n';
    code += '  ///\n';
    code += '  @override\n';
    code += '  // TODO: implement searchTerm\n';
    code += '  String get searchTerm => throw UnimplementedError();\n';
    code += '}\n';

    _codeController.text = code;

 */
  }
}
