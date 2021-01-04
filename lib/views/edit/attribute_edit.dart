import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_edit.dart';
import 'package:folly_fields/fields/string_field.dart';
import 'package:model_code_generator/consumers/attribute_consumer.dart';
import 'package:model_code_generator/models/attribute_model.dart';
import 'package:model_code_generator/views/builders/attribute_builder.dart';

class AttributeEdit
    extends AbstractEdit<AttributeModel, AttributeBuilder, AttributeConsumer> {
  ///
  ///
  ///
  AttributeEdit(
    AttributeModel model,
    AttributeBuilder uiBuilder,
    AttributeConsumer consumer,
    bool edit, {
    Key key,
  }) : super(model, uiBuilder, consumer, edit, key: key);

  ///
  ///
  ///
  @override
  List<Widget> formContent(
    BuildContext context,
    AttributeModel model,
    bool edit,
    Map<String, dynamic> stateInjection,
    String prefix,
  ) {
    return <Widget>[
      StringField(
        prefix: prefix,
        label: 'Nome*',
        initialValue: model.name,
        validator: (String value) => value.isEmpty ? 'Informe o nome' : null,
        onSaved: (String value) => model.name = value,
      )
    ];
  }
}
