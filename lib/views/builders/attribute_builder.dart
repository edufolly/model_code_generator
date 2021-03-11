import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:folly_fields/crud/abstract_ui_builder.dart';
import 'package:model_code_generator/models/attribute_model.dart';
import 'package:model_code_generator/util/config.dart';

///
///
///
class AttributeBuilder extends AbstractUIBuilder<int, AttributeModel> {
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
        Config().textType(model) +
            (model.hasNullAware ? ' (${model.nullAware})' : ''),
      );
}
