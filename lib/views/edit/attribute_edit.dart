import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_edit.dart';
import 'package:folly_fields/fields/dropdown_field.dart';
import 'package:folly_fields/fields/string_field.dart';
import 'package:folly_fields/util/string_utils.dart';
import 'package:model_code_generator/consumers/attribute_consumer.dart';
import 'package:model_code_generator/models/attribute_model.dart';
import 'package:model_code_generator/models/attribute_type.dart';
import 'package:model_code_generator/models/attribute_type_config.dart';
import 'package:model_code_generator/util/config.dart';
import 'package:model_code_generator/views/builders/attribute_builder.dart';

///
///
///
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
    Key? key,
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
    Function(bool refresh) refresh,
  ) {
    AttributeTypeConfig typeConfig = Config().attributeConfig[model.type]!;

    AttributeTypeConfig internalTypeConfig =
        Config().attributeInternalConfig[model.internalType]!;

    return <Widget>[
      /// Name
      StringField(
        prefix: prefix,
        label: 'Name*',
        initialValue: model.name,
        validator: (String value) => StringUtils.isCamelCase(value)
            ? null
            : 'Name is invalid. Use camelCase.',
        onSaved: (String value) => model.name = value,
      ),

      /// Attribute Type
      DropdownField<AttributeType>(
        prefix: prefix,
        label: 'Type*',
        items: Config().attributeConfig.map(
            (AttributeType key, AttributeTypeConfig value) =>
                MapEntry<AttributeType, String>(key, value.name)),
        initialValue: model.type,
        onChanged: (AttributeType? value) {
          model.type = value!;
          refresh(true);
        },
        validator: (AttributeType? value) =>
            value == null ? 'Type is required.' : null,
        onSaved: (AttributeType? value) => model.type = value!,
      ),

      /// Internal Type
      DropdownField<AttributeType>(
        prefix: prefix,
        label: 'Internal Type*',
        enabled: typeConfig.hasInternalType,
        items: Config().attributeInternalTypeItems,
        initialValue: model.internalType,
        onChanged: (AttributeType? value) {
          model.internalType = value!;
          refresh(true);
        },
        validator: (AttributeType? value) =>
            value == null ? 'Internal Type is required.' : null,
        onSaved: (AttributeType? value) => model.internalType = value!,
      ),

      /// Internal Name
      StringField(
        prefix: prefix,
        label: 'Internal Name*',
        enabled: typeConfig.hasName ||internalTypeConfig.hasName,
        initialValue: model.internalName,
        validator: (String value) => StringUtils.isPascalCase(value)
            ? null
            : 'Internal name is invalid. Use PascalCase.',
        onSaved: (String value) => model.internalName = value,
      ),

      /// Null-aware
      StringField(
        prefix: prefix,
        label: 'Null-aware',
        initialValue: model.nullAware,
        onSaved: (String value) => model.nullAware = value,
      ),
    ];
  }
}
