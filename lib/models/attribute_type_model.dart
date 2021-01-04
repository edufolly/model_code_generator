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
  final String langTypeName;
  final bool hasInternalType;
  final bool needName;

  static final AttributeTypeModel _string = AttributeTypeModel(
    'String',
    AttributeType.String,
    'String',
    false,
    false,
  );
  static final AttributeTypeModel _boolean = AttributeTypeModel(
    'Boolean',
    AttributeType.Boolean,
    'bool',
    false,
    false,
  );
  static final AttributeTypeModel _integer = AttributeTypeModel(
    'Integer',
    AttributeType.Integer,
    'int',
    false,
    false,
  );
  static final AttributeTypeModel _double = AttributeTypeModel(
    'Double',
    AttributeType.Double,
    'double',
    false,
    false,
  );
  static final AttributeTypeModel _model = AttributeTypeModel(
    'Model',
    AttributeType.Model,
    'Model',
    false,
    true,
  );
  static final AttributeTypeModel _list = AttributeTypeModel(
    'List',
    AttributeType.List,
    'List',
    true,
    false,
  );

  ///
  ///
  ///
  static List<AttributeTypeModel> list = <AttributeTypeModel>[
    _string,
    _boolean,
    _integer,
    _double,
    _model,
    _list
  ];

  ///
  ///
  ///
  static List<AttributeTypeModel> internalList = <AttributeTypeModel>[
    _string,
    _boolean,
    _integer,
    _double,
    _model,
  ];

  ///
  ///
  ///
  static AttributeType parse(String type) {
    switch (type) {
      case 'AttributeType.String':
        return AttributeType.String;
      case 'AttributeType.Boolean':
        return AttributeType.Boolean;
      case 'AttributeType.Integer':
        return AttributeType.Integer;
      case 'AttributeType.Double':
        return AttributeType.Double;
      case 'AttributeType.Model':
        return AttributeType.Model;
      case 'AttributeType.List':
        return AttributeType.List;
      default:
        return null;
    }
  }

  ///
  ///
  ///
  AttributeTypeModel(
    this.name,
    this.type,
    this.langTypeName,
    this.hasInternalType,
    this.needName,
  );

  ///
  ///
  ///
  AttributeTypeModel.fromJson(Map<String, dynamic> map)
      : name = map['name'],
        type = AttributeTypeModel.parse(map['type']),
        langTypeName = map['langTypeName'],
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
    if (langTypeName != null) map['langTypeName'] = langTypeName;
    map['hasInternalType'] = hasInternalType ?? false;
    map['needName'] = needName ?? false;
    return map;
  }

  ///
  ///
  ///
  @override
  String toString() => name;

  ///
  ///
  ///
  @override
  String get searchTerm => name;
}
