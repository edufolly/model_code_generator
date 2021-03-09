///
///
///
enum LanguageType {
  Dart,
  Java,
  Unknown,
}

///
///
///
class LanguageTypeModel {
  LanguageType value;

  ///
  ///
  ///
  LanguageTypeModel({this.value = LanguageType.Unknown});

  ///
  ///
  ///
  static Map<LanguageType, String> getItems() => LanguageType.values
      .asMap()
      .map((int key, LanguageType value) => MapEntry<LanguageType, String>(
            value,
            LanguageTypeModel(value: value).toMap(),
          ));

  ///
  ///
  ///
  static LanguageTypeModel fromJson(String type) {
    switch (type) {
      case 'Dart':
        return LanguageTypeModel(value: LanguageType.Dart);
      case 'Java':
        return LanguageTypeModel(value: LanguageType.Java);
      default:
        return LanguageTypeModel(value: LanguageType.Unknown);
    }
  }

  ///
  ///
  ///
  String toMap() {
    switch (value) {
      case LanguageType.Dart:
        return 'Dart';
      case LanguageType.Java:
        return 'Java';
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
  bool operator ==(Object other) => value == (other as LanguageTypeModel).value;
}
