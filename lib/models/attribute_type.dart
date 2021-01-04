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
      case 'Model':
        return AttributeType.Model;
      case 'List':
        return AttributeType.List;
      default:
        return null;
    }
  }

  ///
  ///
  ///
  static String string(AttributeType attributeType) =>
      attributeType.toString().split('.').last;
}
