import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:folly_fields/fields/dropdown_field.dart';
import 'package:folly_fields/fields/list_field.dart';
import 'package:folly_fields/fields/string_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:model_code_generator/consumers/attribute_consumer.dart';
import 'package:model_code_generator/languages/abstract_language.dart';
import 'package:model_code_generator/models/attribute_model.dart';
import 'package:model_code_generator/models/entity_model.dart';
import 'package:model_code_generator/languages/language_type.dart';
import 'package:model_code_generator/util/config.dart';
import 'package:model_code_generator/views/builders/attribute_builder.dart';
import 'package:model_code_generator/views/edit/attribute_edit.dart';
import 'package:model_code_generator/views/json_import.dart';

///
///
///
class Home extends StatefulWidget {
  ///
  ///
  ///
  @override
  _HomeState createState() => _HomeState();
}

///
///
///
class _HomeState extends State<Home> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _codeController =
      TextEditingController(text: ' ');

  // EntityModel model = EntityModel.fromJson(json.decode(
  //     '{"name":"Platform","languageType":"Dart","attributes":[{"name":"active",'
  //     '"type":"Boolean","nullAware":"true"},{"name":"description",'
  //     '"type":"String"},{"name":"name","type":"String"}]}'));

  EntityModel entity;

  @override
  void initState() {
    super.initState();
    entity = EntityModel();
  }

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Model Code Generator'),
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.fileImport),
            onPressed: _jsonImport,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: _formKey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      /// Language
                      DropdownField<LanguageType>(
                        label: 'Linguagem*',
                        items: LanguageTypeHelper.languageItems,
                        initialValue: entity.languageType ?? LanguageType.Dart,
                        validator: (LanguageType value) =>
                            value == null ? 'Informe a linguagem' : null,
                        onSaved: (LanguageType value) =>
                            entity.languageType = value,
                      ),

                      /// Name
                      StringField(
                        label: 'Nome*',
                        initialValue: entity.name,
                        validator: (String value) =>
                            value.isEmpty ? 'Informe o nome' : null,
                        onSaved: (String value) => entity.name = value,
                      ),

                      /// Attributes
                      ListField<AttributeModel, AttributeBuilder>(
                        initialValue: entity.attributes ?? <AttributeModel>[],
                        uiBuilder: AttributeBuilder(null),
                        routeAddBuilder: (
                          BuildContext context,
                          AttributeBuilder uiBuilder,
                        ) =>
                            AttributeEdit(
                          AttributeModel(),
                          uiBuilder,
                          AttributeConsumer(),
                          true,
                        ),
                        routeEditBuilder: (
                          BuildContext context,
                          AttributeModel model,
                          AttributeBuilder uiBuilder,
                          bool edit,
                        ) =>
                            AttributeEdit(model, uiBuilder, null, edit),
                        validator: (List<AttributeModel> value) =>
                            value == null || value.isEmpty
                                ? 'Informe os atributos'
                                : null,
                        onSaved: (List<AttributeModel> value) =>
                            entity.attributes = value,
                      ),

                      /// Process
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton.icon(
                          onPressed: _process,
                          icon: Icon(Icons.send),
                          label: Text('PROCESSAR'),
                          padding: const EdgeInsets.all(20.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Código',
                      border: OutlineInputBorder(),
                      counterText: '',
                    ),
                    controller: _codeController,
                    keyboardType: TextInputType.multiline,
                    minLines: 30,
                    maxLines: 999,
                    style: GoogleFonts.firaCode(),
                    enableSuggestions: false,
                    textAlignVertical: TextAlignVertical.top,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _jsonImport() {
    String text = ' ';
    // if (_formKey.currentState.validate()) {
    //   _formKey.currentState.save();
    //   Map<String, dynamic> map = entity.toMap();
    //   text = json.encode(map);
    // }

    /*
{"name":"Platform","languageType":"Dart","attributes":[{"name":"active","type":"Boolean","nullAware":"true"},{"name":"description","type":"String"},{"name":"name","type":"String"}]}
     */

    Navigator.of(context)
        .push(MaterialPageRoute<EntityModel>(
            builder: (_) => JsonImport(text: text)))
        .then(
      (EntityModel value) {
        if (value != null) {
          print(value.name);
          setState(() {
            entity = value;
          });
          _formKey.currentState.reset();
        }
      },
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

    Map<String, dynamic> map = entity.toMap();
    print(json.encode(map));

    AbstractLanguage language = Config().languages[entity.languageType];

    _codeController.text = language.getModelClass(entity);
  }
}
