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
class AttributeTypeHelper {
  static AttributeType parse(String type) {
    switch (type) {
      case 'String':
        return AttributeType.String;
      case 'Boolean':
        return AttributeType.Boolean;
      case 'Integer':
        return AttributeType.Integer;
      case 'Double':
        return AttributeType.Double;
      case 'Float':
        return AttributeType.Float;
      case 'Date':
        return AttributeType.Date;
      case 'Object':
        return AttributeType.Object;
      case 'Model':
        return AttributeType.Model;
      case 'List':
        return AttributeType.List;
      case 'IconData':
        return AttributeType.IconData;
      case 'Empty':
        return AttributeType.Empty;
      default:
        return AttributeType.Unknown;
    }
  }

  ///
  ///
  ///
  static String string(AttributeType attributeType) =>
      attributeType.toString().split('.').last;
}
