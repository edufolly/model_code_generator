import 'dart:collection';

import 'package:folly_fields/util/string_utils.dart';
import 'package:model_code_generator/languages/abstract_language.dart';
import 'package:model_code_generator/models/attribute_model.dart';
import 'package:model_code_generator/models/attribute_type_model.dart';
import 'package:model_code_generator/models/attribute_type_config.dart';
import 'package:model_code_generator/models/entity_model.dart';
import 'package:model_code_generator/models/language_type_model.dart';
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
    AttributeType.Float: 'double',
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
  LanguageType get type => LanguageType.Dart;

  ///
  ///
  ///
  @override
  String typeName(AttributeType attributeType) => typeNames[attributeType]!;

  ///
  ///
  ///
  String langType(AttributeModel attribute) {
    AttributeTypeConfig typeConfig =
        Config().attributeConfig[attribute.type.value]!;

    AttributeTypeConfig internalTypeConfig =
        Config().attributeInternalConfig[attribute.internalType.value]!;

    if (typeConfig.hasInternalType) {
      String s = typeName(attribute.type.value);
      if (internalTypeConfig.hasName) {
        s += '<${attribute.internalName}Model>';
      } else {
        s += '<${typeName(attribute.internalType.value)}>';
      }
      return s;
    }

    if (typeConfig.hasName) {
      return '${attribute.internalName}Model';
    }

    return typeName(attribute.type.value);
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
      if (attribute.type.value == AttributeType.IconData) {
        imports.add('import \'package:flutter/material.dart\';\n');
        imports.add('import \'package:folly_fields/util/icon_helper.dart\';\n');
        break;
      }
    }

    String packagePath = entity.packagePath;

    if (!packagePath.endsWith('/')) packagePath += '/';

    for (AttributeModel attribute in entity.attributes) {
      if (attribute.type.value == AttributeType.Model ||
          attribute.internalType.value == AttributeType.Model) {
        String filename = StringUtils.pascal2Snake(attribute.internalName);
        imports.add('import \'package:$packagePath$filename\_model.dart\';\n');
      }
    }

    code += imports.join();

    String idType = typeNames[entity.idType] ?? 'int';

    code += '\n';
    code += '///\n';
    code += '///\n';
    code += '///\n';
    code += 'class $className extends AbstractModel<$idType> {\n';
    for (AttributeModel attribute in entity.attributes) {
      code += '  ${langType(attribute)}';

      if (!attribute.hasNullAware) code += '?';

      code += ' ${attribute.name}';

      if (attribute.hasNullAware) {
        code += ' = ';
        switch (attribute.type.value) {
          case AttributeType.String:
          case AttributeType.Boolean:
          case AttributeType.Integer:
          case AttributeType.Double:
          case AttributeType.Float:
          case AttributeType.Date:
          case AttributeType.Object:
          case AttributeType.Model:
          case AttributeType.IconData:
            code += attribute.nullAware;
            break;
          case AttributeType.List:
            code += '<${attribute.internalName}Model>[]';
            break;
          case AttributeType.Empty:
            // TODO: Exception.
            break;
          case AttributeType.Unknown:
            // TODO: Exception.
            break;
        }
      }

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
    code += '      :';

    for (AttributeModel attribute in entity.attributes) {
      String name = attribute.name;
      switch (attribute.type.value) {
        case AttributeType.String:
        case AttributeType.Boolean:
        case AttributeType.Integer:
        case AttributeType.Double:
        case AttributeType.Float:
        case AttributeType.Object:
          code += '        $name = map[\'$name\']';
          if (attribute.hasNullAware) code += ' ?? ${attribute.nullAware}';
          break;
        case AttributeType.Date:
          // TODO - Null-aware??
          code += '        $name = map[\'$name\'] != null ';
          code += '&& map[\'$name\'] >= 0\n';
          code += '            ? ';
          code += 'DateTime.fromMillisecondsSinceEpoch(map[\'$name\'])\n';
          code += '            : null';
          break;
        case AttributeType.Model:
          code += '        $name = map[\'$name\'] != null\n';
          code += '            ? ';
          code += '${attribute.internalName}Model.fromJson(map[\'$name\'])\n';
          code += '            : ';
          code += attribute.hasNullAware ? attribute.nullAware : 'null';
          break;
        case AttributeType.List:
          if (attribute.internalType.value == AttributeType.Model) {
            code += '        $name = map[\'$name\'] != null\n';
            code += '            ? (map[\'$name\'] as List<dynamic>)\n';
            code += '                ';
            code += '.map((dynamic map) => ${attribute.internalName}Model';
            code += '.fromJson(map))\n';
            code += '                .toList()\n';
            code += '            : ';
            code += attribute.hasNullAware
                ? '<${attribute.internalName}Model>[]'
                : 'null';
          } else {
            // TODO - Other classes with internal type different of Model.
            code += '// TODO - Implement: $name - ${attribute.internalType}';
          }
          break;
        case AttributeType.IconData:
          // TODO - Null-aware??
          code += '        $name = IconHelper.iconData(map[\'$name\'])';
          break;
        case AttributeType.Empty:
        case AttributeType.Unknown:
          // Do nothing,
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

      if (!attribute.hasNullAware) {
        code += '    if ($name != null) {\n  ';
      }

      code += '    ';

      switch (attribute.type.value) {
        case AttributeType.String:
        case AttributeType.Boolean:
        case AttributeType.Integer:
        case AttributeType.Double:
        case AttributeType.Float:
        case AttributeType.Object:
          code += 'map[\'$name\'] = $name;\n';
          break;
        case AttributeType.Date:
          code += 'map[\'$name\'] = $name.millisecondsSinceEpoch;\n';
          break;
        case AttributeType.Model:
          code += 'map[\'$name\'] = $name';
          if (!attribute.hasNullAware) code += '?';
          code += '.toMap();\n';
          break;
        case AttributeType.List:
          if (attribute.internalType.value == AttributeType.Model) {
            code += 'map[\'$name\'] = ';
            code += '$name.map((${attribute.internalName}Model model) => ';
            code += 'model.toMap()).toList();\n';
          } else {
            // TODO - Other classes with internal type different of Model.
            code += '// TODO - Implement: $name - ${attribute.internalType}';
          }
          break;
        case AttributeType.IconData:
          // TODO - Null-aware??
          code += '      map[\'$name\'] = IconHelper.iconName($name);\n';
          break;
        case AttributeType.Empty:
        case AttributeType.Unknown:
          // Do nothing,
          break;
      }

      if (!attribute.hasNullAware) {
        code += '    }\n';
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
    code += '  String get searchTerm => ${entity.modelSearchTerm};\n';
    code += '\n';

    ///
    ///
    ///
    code += '  ///\n';
    code += '  ///\n';
    code += '  ///\n';
    code += '  @override\n';
    code += '  String toString() => ${entity.modelToString};\n';

    ///
    ///
    ///
    if (entity.moreCode.isNotEmpty) {
      code += '\n';
      code += '  ///\n';
      code += '  ///\n';
      code += '  ///\n';
      code += '  ${entity.moreCode}\n';
    }

    ///
    ///
    ///
    code += '}\n';
    return code;
  }
}
