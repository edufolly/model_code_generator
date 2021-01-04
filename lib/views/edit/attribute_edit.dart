import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_edit.dart';
import 'package:folly_fields/fields/dropdown_field.dart';
import 'package:folly_fields/fields/string_field.dart';
import 'package:model_code_generator/consumers/attribute_consumer.dart';
import 'package:model_code_generator/models/attribute_model.dart';
import 'package:model_code_generator/models/attribute_type_model.dart';
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
    Function(bool refresh) refresh,
  ) {
    return <Widget>[
      /// Name
      StringField(
        prefix: prefix,
        label: 'Nome*',
        initialValue: model.name,
        validator: (String value) => value.isEmpty ? 'Informe o nome' : null,
        onSaved: (String value) => model.name = value,
      ),

      /// Attribute Type
      DropdownField<AttributeTypeModel>(
        prefix: prefix,
        label: 'Tipo*',
        items: AttributeTypeModel.list.asMap().map(
            (_, AttributeTypeModel value) =>
                MapEntry<AttributeTypeModel, String>(value, value.name)),
        initialValue: model.type,
        onChanged: (AttributeTypeModel value) {
          model.type = value;
          refresh(true);
        },
        validator: (AttributeTypeModel value) =>
            value == null ? 'Informe o tipo' : null,
        onSaved: (AttributeTypeModel value) => model.type = value,
      ),

      /// Attribute Type
      DropdownField<AttributeTypeModel>(
        prefix: prefix,
        label: 'Tipo Interno*',
        enabled: model?.type?.hasInternalType ?? false,
        items: AttributeTypeModel.internalList.asMap().map(
            (_, AttributeTypeModel value) =>
                MapEntry<AttributeTypeModel, String>(value, value.name)),
        initialValue: model.internalType,
        onChanged: (AttributeTypeModel value) {
          model.internalType = value;
          refresh(true);
        },
        validator: (AttributeTypeModel value) =>
            value == null ? 'Informe o tipo interno' : null,
        onSaved: (AttributeTypeModel value) => model.internalType = value,
      ),

      /// Internal Name
      StringField(
        prefix: prefix,
        label: 'Nome Interno*',
        enabled: (model?.type?.needName ?? false) ||
            (model?.internalType?.needName ?? false),
        initialValue: model.internalName,
        validator: (String value) =>
            value.isEmpty ? 'Informe o nome interno' : null,
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
