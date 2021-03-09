///
///
///
enum AttributeType {
  String,
  Boolean,
  Integer,
  Double,
  Float,
  Date,
  Object,
  Model,
  List,
  IconData,
  Empty,
  Unknown
}

///
///
///
class AttributeTypeModel {
  AttributeType value;

  ///
  ///
  ///
  AttributeTypeModel({this.value = AttributeType.Unknown});

  ///
  ///
  ///
  static Map<AttributeType, String> getItems() => AttributeType.values
      .asMap()
      .map((int key, AttributeType value) => MapEntry<AttributeType, String>(
            value,
            AttributeTypeModel(value: value).toMap(),
          ));

  ///
  ///
  ///
  static AttributeTypeModel fromJson(String type) {
    switch (type) {
      case 'String':
        return AttributeTypeModel(value: AttributeType.String);
      case 'Boolean':
        return AttributeTypeModel(value: AttributeType.Boolean);
      case 'Integer':
        return AttributeTypeModel(value: AttributeType.Integer);
      case 'Double':
        return AttributeTypeModel(value: AttributeType.Double);
      case 'Float':
        return AttributeTypeModel(value: AttributeType.Float);
      case 'Date':
        return AttributeTypeModel(value: AttributeType.Date);
      case 'Object':
        return AttributeTypeModel(value: AttributeType.Object);
      case 'Model':
        return AttributeTypeModel(value: AttributeType.Model);
      case 'List':
        return AttributeTypeModel(value: AttributeType.List);
      case 'IconData':
        return AttributeTypeModel(value: AttributeType.IconData);
      case 'Empty':
        return AttributeTypeModel(value: AttributeType.Empty);
      default:
        return AttributeTypeModel(value: AttributeType.Unknown);
    }
  }

  ///
  ///
  ///
  String toMap() {
    switch (value) {
      case AttributeType.String:
        return 'String';
      case AttributeType.Boolean:
        return 'Boolean';
      case AttributeType.Integer:
        return 'Integer';
      case AttributeType.Double:
        return 'Double';
      case AttributeType.Float:
        return 'Float';
      case AttributeType.Date:
        return 'Date';
      case AttributeType.Object:
        return 'Object';
      case AttributeType.Model:
        return 'Model';
      case AttributeType.List:
        return 'List';
      case AttributeType.IconData:
        return 'IconData';
      case AttributeType.Empty:
        return 'Empty';
      default:
        return '[Unknown]';
    }
  }

  ///
  ///
  ///
  @override
  int get hashCode => value.hashCode;

  ///
  ///
  ///
  @override
  bool operator ==(Object other) =>
      value == (other as AttributeTypeModel).value;
}
