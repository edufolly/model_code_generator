import 'package:folly_fields/folly_fields.dart';
import 'package:model_code_generator/languages/abstract_language.dart';
import 'package:model_code_generator/languages/language_dart.dart';
import 'package:model_code_generator/languages/language_java.dart';
import 'package:model_code_generator/models/attribute_model.dart';
import 'package:model_code_generator/models/language_type_model.dart';
import 'package:model_code_generator/models/attribute_type_model.dart';
import 'package:model_code_generator/models/attribute_type_config.dart';

///
///
///
class Config extends AbstractConfig {
  static final Config _singleton = Config._internal();

  ///
  ///
  ///
  Config._internal();

  ///
  ///
  ///
  factory Config() {
    return _singleton;
  }

  ///
  ///
  ///
  Map<AttributeType, String> get attributeTypeItems =>
      _internalItems(attributeConfig);

  ///
  ///
  ///
  Map<AttributeType, String> get attributeInternalTypeItems =>
      _internalItems(attributeInternalConfig);

  ///
  ///
  ///
  Map<AttributeType, String> _internalItems(
          Map<AttributeType, AttributeTypeConfig> map) =>
      map.map((AttributeType key, AttributeTypeConfig value) =>
          MapEntry<AttributeType, String>(key, value.name));

  ///
  ///
  ///
  Map<AttributeType, AttributeTypeConfig> get attributeInternalConfig =>
      Map<AttributeType, AttributeTypeConfig>.of(attributeConfig)
        ..removeWhere((AttributeType key, AttributeTypeConfig value) =>
            value.hasInternalType);

  ///
  ///
  ///
  Map<AttributeType, AttributeTypeConfig> attributeConfig =
      <AttributeType, AttributeTypeConfig>{
    AttributeType.String: AttributeTypeConfig(
      name: 'String',
      hasInternalType: false,
      hasName: false,
    ),
    AttributeType.Boolean: AttributeTypeConfig(
      name: 'Boolean',
      hasInternalType: false,
      hasName: false,
    ),
    AttributeType.Integer: AttributeTypeConfig(
      name: 'Integer',
      hasInternalType: false,
      hasName: false,
    ),
    AttributeType.Double: AttributeTypeConfig(
      name: 'Double',
      hasInternalType: false,
      hasName: false,
    ),
    AttributeType.Float: AttributeTypeConfig(
      name: 'Float',
      hasInternalType: false,
      hasName: false,
    ),
    AttributeType.Date: AttributeTypeConfig(
      name: 'Date',
      hasInternalType: false,
      hasName: false,
    ),
    AttributeType.Object: AttributeTypeConfig(
      name: 'Object',
      hasInternalType: false,
      hasName: false,
    ),
    AttributeType.Model: AttributeTypeConfig(
      name: 'Model',
      hasInternalType: false,
      hasName: true,
    ),
    AttributeType.List: AttributeTypeConfig(
      name: 'List',
      hasInternalType: true,
      hasName: false,
    ),
    AttributeType.IconData: AttributeTypeConfig(
      name: 'IconData',
      hasInternalType: false,
      hasName: false,
    ),
    AttributeType.Empty: AttributeTypeConfig(
      name: '[Empty]',
      hasInternalType: false,
      hasName: false,
    ),
    AttributeType.Unknown: AttributeTypeConfig(
      name: '[Unknown]',
      hasInternalType: false,
      hasName: false,
    ),
  };

  ///
  ///
  ///
  Map<LanguageType, AbstractLanguage> languages =
      <LanguageType, AbstractLanguage>{
    LanguageType.Dart: LanguageDart(),
    LanguageType.Java: LanguageJava(),
  };

  ///
  ///
  ///
  String textType(AttributeModel attribute) {
    AttributeTypeConfig typeConfig = attributeConfig[attribute.type.value]!;

    AttributeTypeConfig internalTypeConfig =
        attributeInternalConfig[attribute.internalType.value]!;

    if (typeConfig.hasInternalType) {
      String s = typeConfig.name;
      if (internalTypeConfig.hasName) {
        s += '<${attribute.internalName}>';
      } else {
        s += '<${internalTypeConfig.name}>';
      }
      return s;
    }

    if (typeConfig.hasName) {
      return attribute.internalName;
    }

    return typeConfig.name;
  }
}
