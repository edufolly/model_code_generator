import 'package:model_code_generator/models/attribute_type.dart';
import 'package:model_code_generator/models/entity_model.dart';
import 'package:model_code_generator/languages/language_type.dart';

///
///
///
abstract class AbstractLanguage {
  ///
  ///
  ///
  LanguageType get type;

  ///
  ///
  ///
  String typeName(AttributeType attributeType);

  ///
  ///
  ///
  String getModelClass(EntityModel entity);

}
