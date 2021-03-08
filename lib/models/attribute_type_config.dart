import 'package:folly_fields/crud/abstract_model.dart';

///
///
///
class AttributeTypeConfig extends AbstractModel {
  final String name;
  final bool hasInternalType;
  final bool hasName;

  ///
  ///
  ///
  AttributeTypeConfig({
    required this.name,
    required this.hasInternalType,
    required this.hasName,
  });

  ///
  ///
  ///
  AttributeTypeConfig.fromJson(Map<String, dynamic> map)
      : name = map['name'] ?? '',
        hasInternalType = map['hasInternalType'] ?? false,
        hasName = map['needName'] ?? false,
        super.fromJson(map);

  ///
  ///
  ///
  @override
  AttributeTypeConfig fromJson(Map<String, dynamic> map) =>
      AttributeTypeConfig.fromJson(map);

  ///
  ///
  ///
  @override
  AttributeTypeConfig fromMulti(Map<String, dynamic> map) =>
      AttributeTypeConfig.fromJson(AbstractModel.fromMultiMap(map));

  ///
  ///
  ///
  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    map['name'] = name;
    map['hasInternalType'] = hasInternalType;
    map['needName'] = hasName;
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
