import 'package:folly_fields/crud/abstract_model.dart';
import 'package:model_code_generator/models/attribute_model.dart';
import 'package:model_code_generator/languages/language_type.dart';

///
///
///
class EntityModel extends AbstractModel {
  String name;
  LanguageType languageType;
  List<AttributeModel> attributes;

  ///
  ///
  ///
  EntityModel();

  ///
  ///
  ///
  EntityModel.fromJson(Map<String, dynamic> map)
      : name = map['name'],
        languageType = LanguageTypeHelper.parse(map['languageType']),
        attributes = map['attributes'] == null
            ? null
            : (map['attributes'] as List<dynamic>)
                .map((dynamic attribute) => AttributeModel.fromJson(attribute))
                .toList(),
        super.fromJson(map);

  ///
  ///
  ///
  @override
  EntityModel fromJson(Map<String, dynamic> map) => EntityModel.fromJson(map);

  ///
  ///
  ///
  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    if (name != null) map['name'] = name;

    if (languageType != null) {
      map['languageType'] = LanguageTypeHelper.string(languageType);
    }

    if (attributes != null) {
      map['attributes'] = attributes
          .map((AttributeModel attribute) => attribute.toMap())
          .toList();
    }

    return map;
  }

  ///
  ///
  ///
  @override
  String get searchTerm => name;
}
