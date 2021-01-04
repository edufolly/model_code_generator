import 'package:folly_fields/crud/abstract_model.dart';

///
///
///
enum AttributeType {
  String,
  Boolean,
  Integer,
  Double,
  Model,
  List,
}

///
///
///
class AttributeTypeModel extends AbstractModel {
  final String name;
  final AttributeType type;
  final bool hasInternalType;
  final bool needName;

  ///
  ///
  ///
  static List<AttributeTypeModel> list = <AttributeTypeModel>[
    AttributeTypeModel('String', AttributeType.String, false, false),
    AttributeTypeModel('Boolean', AttributeType.Boolean, false, false),
    AttributeTypeModel('Integer', AttributeType.Integer, false, false),
    AttributeTypeModel('Double', AttributeType.Double, false, false),
    AttributeTypeModel('Model', AttributeType.Model, false, true),
    AttributeTypeModel('List', AttributeType.List, true, false),
  ];

  ///
  ///
  ///
  static AttributeType parse(String type) {
    // TODO - Implementar
    return null;
  }

  ///
  ///
  ///
  AttributeTypeModel(this.name, this.type, this.hasInternalType, this.needName);

  ///
  ///
  ///
  AttributeTypeModel.fromJson(Map<String, dynamic> map)
      : name = map['name'],
        type = AttributeTypeModel.parse(map['type']),
        hasInternalType = map['hasInternalType'] ?? false,
        needName = map['needName'] ?? false,
        super.fromJson(map);

  ///
  ///
  ///
  @override
  AttributeTypeModel fromJson(Map<String, dynamic> map) =>
      AttributeTypeModel.fromJson(map);

  ///
  ///
  ///
  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    if (name != null) map['name'] = name;
    if (type != null) map['type'] = type.toString();
    map['hasInternalType'] = hasInternalType ?? false;
    map['needName'] = needName ?? false;
    return map;
  }

  ///
  ///
  ///
  @override
  String get searchTerm => name;
}
