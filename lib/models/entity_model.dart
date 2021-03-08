import 'package:folly_fields/crud/abstract_model.dart';
import 'package:model_code_generator/models/attribute_model.dart';
import 'package:model_code_generator/languages/language_type.dart';

///
///
///
class EntityModel extends AbstractModel {
  String name = '';
  LanguageType languageType = LanguageType.Unknown;
  String packagePath = '';
  List<AttributeModel> attributes = <AttributeModel>[];
  String modelSearchTerm = '';
  String modelToString = '';

  ///
  ///
  ///
  EntityModel();

  ///
  ///
  ///
  EntityModel.fromJson(Map<String, dynamic> map)
      : name = map['name'] ?? '',
        languageType = LanguageTypeHelper.parse(map['languageType']),
        packagePath = map['packagePath'] ?? '',
        attributes = map['attributes'] != null
            ? (map['attributes'] as List<dynamic>)
                .map((dynamic attribute) => AttributeModel.fromJson(attribute))
                .toList()
            : <AttributeModel>[],
        modelSearchTerm = map['searchTerm'] ?? '',
        modelToString = map['toString'] ?? '',
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
    map['name'] = name;
    map['languageType'] = LanguageTypeHelper.string(languageType);
    map['packagePath'] = packagePath;
    map['attributes'] = attributes
        .map((AttributeModel attribute) => attribute.toMap())
        .toList();
    map['searchTerm'] = modelSearchTerm;
    map['toString'] = modelToString;
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
