import 'package:flutter/material.dart';
import 'package:folly_fields/fields/list_field.dart';
import 'package:folly_fields/fields/string_field.dart';
import 'package:model_code_generator/models/attribute_model.dart';
import 'package:model_code_generator/models/entity_model.dart';
import 'package:model_code_generator/views/builders/attribute_builder.dart';
import 'package:model_code_generator/views/edit/attribute_edit.dart';

///
///
///
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

///
///
///
class _HomeState extends State<Home> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  EntityModel model = EntityModel();

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Model Code Generator'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              /// Name
              StringField(
                label: 'Nome*',
                initialValue: model.name,
                validator: (String value) =>
                    value.isEmpty ? 'Informe o nome' : null,
                onSaved: (String value) => model.name = value,
              ),

              /// Attributes
              ListField<AttributeModel, AttributeBuilder>(
                initialValue: model.attributes ?? <AttributeModel>[],
                uiBuilder: AttributeBuilder(null),
                routeAddBuilder: (
                  BuildContext context,
                  AttributeBuilder uiBuilder,
                ) =>
                    AttributeEdit(AttributeModel(), uiBuilder, null, true),
                routeEditBuilder: (
                  BuildContext context,
                  AttributeModel model,
                  AttributeBuilder uiBuilder,
                  bool edit,
                ) =>
                    AttributeEdit(model, uiBuilder, null, edit),
                onSaved: (List<AttributeModel> value) =>
                    model.attributes = value,
              ),

              /// Process
              RaisedButton.icon(
                onPressed: _process,
                icon: Icon(Icons.send),
                label: Text('Processar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  ///
  ///
  void _process() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    Map<String, dynamic> map = model.toMap();
    print(map);
  }
}
