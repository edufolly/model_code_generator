import 'package:folly_fields/crud/abstract_model.dart';
import 'package:model_code_generator/models/attribute_type.dart';
import 'package:model_code_generator/models/attribute_type_config.dart';
import 'package:model_code_generator/util/config.dart';

///
///
///
class AttributeModel extends AbstractModel {
  String name;
  AttributeType type;
  String internalName;
  AttributeType internalType;
  String nullAware;

  ///
  ///
  ///
  AttributeModel();

  ///
  ///
  ///
  AttributeModel.fromJson(Map<String, dynamic> map)
      : name = map['name'],
        type =
            map['type'] == null ? null : AttributeTypeHelper.parse(map['type']),
        internalName = map['internalName'],
        internalType = map['internalType'] == null
            ? null
            : AttributeTypeHelper.parse(map['internalType']),
        nullAware = map['nullAware'],
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
    if (name != null) map['name'] = name;

    if (type != null) {
      map['type'] = AttributeTypeHelper.string(type);
    }

    if (internalName != null && internalName.isNotEmpty) {
      map['internalName'] = internalName;
    }

    if (internalType != null) {
      map['internalType'] = AttributeTypeHelper.string(internalType);
    }

    if (nullAware != null && nullAware.isNotEmpty) {
      map['nullAware'] = nullAware;
    }

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
  String get textType {
    AttributeTypeConfig typeConfig = Config().attributeConfig[type];

    AttributeTypeConfig internalTypeConfig = internalType == null
        ? null
        : Config().attributeInternalConfig[internalType];

    if (typeConfig.hasInternalType) {
      String s = typeConfig.name;
      if (internalTypeConfig.hasName) {
        s += '<$internalName>';
      } else {
        s += '<${internalTypeConfig.name}>';
      }
      return s;
    }

    if (typeConfig.hasName) {
      return internalName;
    }

    return typeConfig.name;
  }

  ///
  ///
  ///
  bool get hasNullAware => nullAware != null && nullAware.isNotEmpty;
}
