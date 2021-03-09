import 'package:folly_fields/crud/abstract_model.dart';
import 'package:model_code_generator/models/attribute_type_model.dart';

///
///
///
class AttributeModel extends AbstractModel {
  String name = '';
  AttributeTypeModel type = AttributeTypeModel(value: AttributeType.String);
  AttributeTypeModel internalType =
      AttributeTypeModel(value: AttributeType.Empty);
  String internalName = '';
  String nullAware = '';

  ///
  ///
  ///
  AttributeModel();

  ///
  ///
  ///
  AttributeModel.fromJson(Map<String, dynamic> map)
      : name = map['name'] ?? '',
        type = map['type'] != null
            ? AttributeTypeModel.fromJson(map['type'])
            : AttributeTypeModel(value: AttributeType.String),
        internalType = map['internalType'] != null
            ? AttributeTypeModel.fromJson(map['internalType'])
            : AttributeTypeModel(value: AttributeType.Empty),
        internalName = map['internalName'] ?? '',
        nullAware = map['nullAware'] ?? '',
        super.fromJson(map);

  ///
  ///
  ///
  @override
  AttributeModel fromJson(Map<String, dynamic> map) =>
      AttributeModel.fromJson(map);

  ///
  ///
  ///
  @override
  AttributeModel fromMulti(Map<String, dynamic> map) =>
      AttributeModel.fromJson(AbstractModel.fromMultiMap(map));

  ///
  ///
  ///
  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    map['name'] = name;
    map['type'] = type.toMap();
    map['internalType'] = internalType.toMap();
    map['internalName'] = internalName;
    map['nullAware'] = nullAware;
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

  ///
  ///
  ///
  bool get hasNullAware => nullAware.isNotEmpty;
}
