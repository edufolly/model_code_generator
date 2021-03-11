import 'package:model_code_generator/consumers/base_consumer_mock.dart';
import 'package:model_code_generator/models/attribute_model.dart';

///
///
///
class AttributeConsumer extends BaseConsumerMock<AttributeModel> {
  ///
  ///
  ///
  @override
  AttributeModel get modelInstance => AttributeModel();

  ///
  ///
  ///
  @override
  List<String> get routeName => <String>[];
}
