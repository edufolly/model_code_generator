import 'package:folly_fields/crud/abstract_model.dart';
import 'package:model_code_generator/models/attribute_type_model.dart';

///
///
///
class AttributeModel extends AbstractModel {
  String name;
  AttributeTypeModel type;
  String internalName;
  AttributeTypeModel internalType;
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
        type = map['type'] == null
            ? null
            : AttributeTypeModel.fromJson(map['type']),
        internalName = map['internalName'],
        internalType = map['internalType'] == null
            ? null
            : AttributeTypeModel.fromJson(map['internalType']),
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
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    if (name != null) map['name'] = name;
    if (type != null) map['type'] = type.toMap();
    if (internalName != null && internalName.isNotEmpty) {
      map['internalName'] = internalName;
    }
    if (internalType != null) map['internalType'] = internalType.toMap();
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
  String toString() => name + ' - ' + getTextType();

  ///
  ///
  ///
  String getTextType() {
    if (type.hasInternalType) {
      String s = type.langTypeName;
      if (internalType.needName) {
        s += '<$internalName>';
      } else {
        s += '<${internalType.langTypeName}>';
      }
      return s;
    }

    if (type.needName) {
      return internalName;
    }
    return type.langTypeName;
  }

  ///
  ///
  ///
  bool get hasNullAware => nullAware != null && nullAware.isNotEmpty;
}
