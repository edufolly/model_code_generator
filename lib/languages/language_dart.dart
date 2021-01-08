import 'dart:collection';

import 'package:folly_fields/util/string_utils.dart';
import 'package:model_code_generator/languages/abstract_language.dart';
import 'package:model_code_generator/models/attribute_model.dart';
import 'package:model_code_generator/models/attribute_type.dart';
import 'package:model_code_generator/models/attribute_type_config.dart';
import 'package:model_code_generator/models/entity_model.dart';
import 'package:model_code_generator/languages/language_type.dart';
import 'package:model_code_generator/util/config.dart';

///
///
///
class LanguageDart extends AbstractLanguage {
  static const Map<AttributeType, String> typeNames = <AttributeType, String>{
    AttributeType.String: 'String',
    AttributeType.Boolean: 'bool',
    AttributeType.Integer: 'int',
    AttributeType.Double: 'double',
    AttributeType.Object: 'dynamic',
    AttributeType.Model: null,
    AttributeType.List: 'List',
    AttributeType.IconData: 'IconData',
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
  String typeName(AttributeType attributeType) => typeNames[attributeType];

  ///
  ///
  ///
  String langType(AttributeModel attribute) {
    AttributeTypeConfig typeConfig = Config().attributeConfig[attribute.type];

    AttributeTypeConfig internalTypeConfig = attribute.internalType == null
        ? null
        : Config().attributeInternalConfig[attribute.internalType];

    if (typeConfig.hasInternalType) {
      String s = typeName(attribute.type);
      if (internalTypeConfig.hasName) {
        s += '<${attribute.internalName}Model>';
      } else {
        s += '<${typeName(attribute.internalType)}>';
      }
      return s;
    }

    if (typeConfig.hasName) {
      return '${attribute.internalName}Model';
    }

    return typeName(attribute.type);
  }

  SplayTreeSet<String> imports = SplayTreeSet<String>();

  ///
  ///
  ///
  @override
  String getModelClass(EntityModel entity) {
    String className = '${entity.name}Model';

    String code = '';

    imports.clear();

    imports.add('import \'package:folly_fields/crud/abstract_model.dart\';\n');

    ///
    ///
    ///
    for (AttributeModel attribute in entity.attributes) {
      if (attribute.type == AttributeType.IconData) {
        imports.add('import \'package:flutter/material.dart\';\n');
        imports.add('import \'package:folly_fields/util/icon_helper.dart\';\n');
        break;
      }
    }

    String packagePath = entity.packagePath;

    if (!packagePath.endsWith('/')) packagePath += '/';

    for (AttributeModel attribute in entity.attributes) {
      if (attribute.type == AttributeType.Model ||
          attribute.internalType == AttributeType.Model) {
        String filename = StringUtils.pascal2Snake(attribute.internalName);
        imports.add('import \'package:$packagePath$filename\_model.dart\';\n');
      }
    }

    code += imports.join();

    code += '\n';
    code += '///\n';
    code += '///\n';
    code += '///\n';
    code += 'class $className extends AbstractModel {\n';
    for (AttributeModel attribute in entity.attributes) {
      code += '  ${langType(attribute)} ${attribute.name}';
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

    for (AttributeModel attribute in entity.attributes) {
      String name = attribute.name;
      switch (attribute.type) {
        case AttributeType.String:
        case AttributeType.Boolean:
        case AttributeType.Integer:
        case AttributeType.Double:
        case AttributeType.Object:
          code += '        $name = map[\'$name\']';
          if (attribute.hasNullAware) code += ' ?? ${attribute.nullAware}';
          break;
        case AttributeType.Model:
          code += '        $name = map[\'$name\'] != null\n';
          code += '            ? ';
          code += '${attribute.internalName}Model.fromJson(map[\'$name\'])\n';
          code += '            : ';
          code += attribute.hasNullAware ? attribute.nullAware : 'null';
          break;
        case AttributeType.List:
          // TODO - Null-aware??
          if (attribute.internalType == AttributeType.Model) {
            code += '        $name = map[\'$name\'] != null\n';
            code += '            ? (map[\'$name\'] as List<dynamic>)\n';
            code += '                ';
            code += '.map((dynamic map) => ${attribute.internalName}Model';
            code += '.fromJson(map))\n';
            code += '                .toList()\n';
            code += '            : null';
          } else {
            // TODO - Comportamento para classes que não sejam model.
            code += '// TODO - Implement: $name - ${attribute.internalType}';
          }
          break;
        case AttributeType.IconData:
          // TODO - Null-aware??
          code += '        $name = IconHelper.iconData(map[\'$name\'])';
          break;
      }

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
    code += '  $className fromMulti(Map<String, dynamic> map) =>\n';
    code += '      $className.fromJson(AbstractModel.fromMultiMap(map));\n';
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
    for (AttributeModel attribute in entity.attributes) {
      String name = attribute.name;
      code += '    ';

      switch (attribute.type) {
        case AttributeType.String:
        case AttributeType.Boolean:
        case AttributeType.Integer:
        case AttributeType.Double:
        case AttributeType.Object:
          if (!attribute.hasNullAware) {
            code += 'if ($name != null) ';
          }
          code += 'map[\'$name\'] = $name';
          if (attribute.hasNullAware) code += ' ?? ${attribute.nullAware}';
          code += ';\n';
          break;
        case AttributeType.Model:
          if (!attribute.hasNullAware) {
            code += 'if ($name != null) ';
          }

          code += 'map[\'$name\'] = ';
          code += attribute.hasNullAware
              ? '($name ?? ${attribute.nullAware})'
              : name;
          code += '.toMap();\n';
          break;
        case AttributeType.List:
          // TODO - Null-aware??
          if (attribute.internalType == AttributeType.Model) {
            code += 'if ($name != null) {\n';
            code += '      map[\'$name\'] = ';
            code += '$name.map((${attribute.internalName}Model model) => ';
            code += 'model.toMap()).toList();\n';
            code += '    }\n';
          } else {
            // TODO - Comportamento para classes que não sejam model.
            code += '// TODO - Implement: $name - ${attribute.internalType}';
          }
          break;
        case AttributeType.IconData:
          code += 'if ($name != null) {\n';
          code += '      map[\'$name\'] = IconHelper.iconName($name);\n';
          code += '    }\n';
          break;
      }
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
    code += '  String get searchTerm => ${entity.searchterm};\n';
    code += '\n';

    ///
    ///
    ///
    code += '  ///\n';
    code += '  ///\n';
    code += '  ///\n';
    code += '  @override\n';
    code += '  String toString() => ${entity.tostring};\n';

    ///
    ///
    ///
    code += '}\n';
    return code;
  }
}
