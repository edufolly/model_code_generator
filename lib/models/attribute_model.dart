import 'package:folly_fields/crud/abstract_model.dart';
import 'package:model_code_generator/models/attribute_type.dart';
import 'package:model_code_generator/models/attribute_type_config.dart';
import 'package:model_code_generator/util/config.dart';

///
///
///
class AttributeModel extends AbstractModel {
  String name = '';
  AttributeType type = AttributeType.Unknown;
  String internalName = '';
  AttributeType internalType = AttributeType.Empty;
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
            ? AttributeTypeHelper.parse(map['type'])
            : AttributeType.Empty,
        internalName = map['internalName'] ?? '',
        internalType = map['internalType'] != null
            ? AttributeTypeHelper.parse(map['internalType'])
            : AttributeType.Empty,
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
    map['type'] = AttributeTypeHelper.string(type);
    map['internalName'] = internalName;
    map['internalType'] = AttributeTypeHelper.string(internalType);
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
  String get textType {
    AttributeTypeConfig typeConfig = Config().attributeConfig[type]!;

    AttributeTypeConfig internalTypeConfig =
        Config().attributeInternalConfig[internalType]!;

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
  bool get hasNullAware => nullAware.isNotEmpty;
}
