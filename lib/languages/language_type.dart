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
class LanguageTypeHelper {
  ///
  ///
  ///
  static LanguageType parse(String type) {
    switch (type) {
      case 'Dart':
        return LanguageType.Dart;
      case 'Java':
        return LanguageType.Java;
      default:
        return LanguageType.Unknown;
    }
  }

  ///
  ///
  ///
  static String string(LanguageType languageType) =>
      languageType.toString().split('.').last;

  ///
  ///
  ///
  static Map<LanguageType, String> get languageItems =>
      LanguageType.values.asMap().map(
            (_, LanguageType value) => MapEntry<LanguageType, String>(
              value,
              LanguageTypeHelper.string(value),
            ),
          );
}
