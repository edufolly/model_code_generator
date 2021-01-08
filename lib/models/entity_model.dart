import 'package:folly_fields/crud/abstract_model.dart';
import 'package:model_code_generator/models/attribute_model.dart';
import 'package:model_code_generator/languages/language_type.dart';

///
///
///
class EntityModel extends AbstractModel {
  String name;
  LanguageType languageType;
  String packagePath;
  List<AttributeModel> attributes;
  String searchterm;
  String tostring;

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
        packagePath = map['packagePath'],
        attributes = map['attributes'] == null
            ? null
            : (map['attributes'] as List<dynamic>)
                .map((dynamic attribute) => AttributeModel.fromJson(attribute))
                .toList(),
        searchterm = map['searchTerm'],
        tostring = map['toString'],
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
  EntityModel fromMulti(Map<String, dynamic> map) =>
      EntityModel.fromJson(AbstractModel.fromMultiMap(map));

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

    if (packagePath != null) map['packagePath'] = packagePath;

    if (attributes != null) {
      map['attributes'] = attributes
          .map((AttributeModel attribute) => attribute.toMap())
          .toList();
    }

    if (searchterm != null) map['searchTerm'] = searchterm;

    if (tostring != null) map['toString'] = tostring;

    return map;
  }

  ///
  ///
  ///
  @override
  String get searchTerm => name;

  ///
  ///
  ///
  @override
  String toString() => name;
}
