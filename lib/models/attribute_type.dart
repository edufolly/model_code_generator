///
///
///
enum AttributeType {
  String,
  Boolean,
  Integer,
  Double,
  Object,
  Model,
  List,
  IconData,
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
      case 'Object':
        return AttributeType.Object;
      case 'Model':
        return AttributeType.Model;
      case 'List':
        return AttributeType.List;
      case 'IconData':
        return AttributeType.IconData;
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
