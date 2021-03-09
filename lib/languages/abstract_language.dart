import 'package:model_code_generator/models/attribute_type_model.dart';
import 'package:model_code_generator/models/entity_model.dart';
import 'package:model_code_generator/models/language_type_model.dart';

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
