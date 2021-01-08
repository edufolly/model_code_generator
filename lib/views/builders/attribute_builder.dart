import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:folly_fields/crud/abstract_ui_builder.dart';
import 'package:model_code_generator/models/attribute_model.dart';

///
///
///
class AttributeBuilder extends AbstractUIBuilder<AttributeModel> {
  ///
  ///
  ///
  AttributeBuilder(String prefix) : super(prefix);

  ///
  ///
  ///
  @override
  String getInternalPlural() => 'Attributes';

  ///
  ///
  ///
  @override
  String getInternalSingle() => 'Attribute';

  ///
  ///
  ///
  @override
  Widget getTitle(AttributeModel model) => Text(model.name);

  ///
  ///
  ///
  @override
  Widget getSubtitle(AttributeModel model) => Text(
        model.textType + (model.hasNullAware ? ' (${model.nullAware})' : ''),
      );
}
