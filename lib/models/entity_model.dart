import 'package:folly_fields/crud/abstract_model.dart';
import 'package:model_code_generator/models/attribute_model.dart';
import 'package:model_code_generator/models/attribute_type_model.dart';
import 'package:model_code_generator/models/language_type_model.dart';

///
///
///
class EntityModel extends AbstractModel<int> {
  String name = '';
  LanguageTypeModel languageType = LanguageTypeModel(value: LanguageType.Dart);
  String packagePath = '';
  AttributeTypeModel idType = AttributeTypeModel(value: AttributeType.Integer);
  List<AttributeModel> attributes = <AttributeModel>[];
  String modelSearchTerm = '';
  String modelToString = '';
  String moreCode = '';

  ///
  ///
  ///
  EntityModel();

  ///
  ///
  ///
  EntityModel.fromJson(Map<String, dynamic> map)
      : name = map['name'] ?? '',
        languageType = map['languageType'] != null
            ? LanguageTypeModel.fromJson(map['languageType'])
            : LanguageTypeModel(value: LanguageType.Dart),
        packagePath = map['packagePath'] ?? '',
        idType = map['idType'] != null
            ? AttributeTypeModel.fromJson(map['idType'])
            : AttributeTypeModel(value: AttributeType.Integer),
        attributes = map['attributes'] != null
            ? (map['attributes'] as List<dynamic>)
                .map((dynamic map) => AttributeModel.fromJson(map))
                .toList()
            : <AttributeModel>[],
        modelSearchTerm = map['searchTerm'] ?? '',
        modelToString = map['toString'] ?? '',
        moreCode = map['moreCode'] ?? '',
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
    map['languageType'] = languageType.toMap();
    map['packagePath'] = packagePath;
    map['idType'] = idType.toMap();
    map['attributes'] =
        attributes.map((AttributeModel model) => model.toMap()).toList();
    map['searchTerm'] = modelSearchTerm;
    map['toString'] = modelToString;
    map['moreCode'] = moreCode;
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
