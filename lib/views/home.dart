import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folly_fields/fields/dropdown_field.dart';
import 'package:folly_fields/fields/list_field.dart';
import 'package:folly_fields/fields/string_field.dart';
import 'package:folly_fields/util/string_utils.dart';
import 'package:folly_fields/widgets/circular_waiting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:model_code_generator/consumers/attribute_consumer.dart';
import 'package:model_code_generator/languages/abstract_language.dart';
import 'package:model_code_generator/models/attribute_model.dart';
import 'package:model_code_generator/models/attribute_type_config.dart';
import 'package:model_code_generator/models/attribute_type_model.dart';
import 'package:model_code_generator/models/entity_model.dart';
import 'package:model_code_generator/models/language_type_model.dart';
import 'package:model_code_generator/util/config.dart';
import 'package:model_code_generator/views/builders/attribute_builder.dart';
import 'package:model_code_generator/views/edit/attribute_edit.dart';
import 'package:model_code_generator/views/json_import.dart';
import 'package:model_code_generator/widgets/version_widget.dart';

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
  final TextEditingController _codeController = TextEditingController();

  EntityModel entity = EntityModel();

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text('Model Code Generator'),
            DefaultTextStyle(
                style: TextStyle(fontSize: 12.0, color: Colors.white38),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: VersionWidget(),
                )),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.solidCopy),
            onPressed: _copyToClipboard,
          ),
          IconButton(
            icon: Icon(FontAwesomeIcons.solidTrashAlt),
            onPressed: _clear,
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: ElevatedButton(
              child: Text('JSON'),
              onPressed: _jsonImport,
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).colorScheme.onSurface,
                onPrimary: Theme.of(context).colorScheme.surface,
                elevation: 0.0,
                textStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
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
                        label: 'Language*',
                        items: LanguageTypeModel.getItems(),
                        initialValue: entity.languageType.value,
                        validator: (LanguageType? value) =>
                            value == null || value == LanguageType.Unknown
                                ? 'Language is required.'
                                : null,
                        onSaved: (LanguageType? value) => entity.languageType =
                            LanguageTypeModel(value: value!),
                      ),

                      /// Package Path
                      StringField(
                        label: 'Package Path*',
                        initialValue: entity.packagePath,
                        validator: (String value) =>
                            value.isEmpty ? 'Package Path is required.' : null,
                        onSaved: (String value) => entity.packagePath = value,
                      ),

                      /// Name
                      StringField(
                        label: 'Model Class Name*',
                        initialValue: entity.name,
                        validator: (String value) => StringUtils.isPascalCase(
                                value)
                            ? null
                            : 'Model Class Name is invalid. Use PascalCase.',
                        onSaved: (String value) => entity.name = value,
                      ),

                      /// Id Type
                      DropdownField<AttributeType>(
                        label: 'Id Type*',
                        items: Config().attributeConfig.map((AttributeType key,
                                AttributeTypeConfig value) =>
                            MapEntry<AttributeType, String>(key, value.name)),
                        initialValue: entity.idType.value,
                        validator: (AttributeType? value) => value == null ||
                                value == AttributeType.Unknown ||
                                value == AttributeType.Empty
                            ? 'Type is required.'
                            : null,
                        onSaved: (AttributeType? value) =>
                            entity.idType.value = value!,
                      ),

                      /// Attributes
                      ListField<int, AttributeModel, AttributeBuilder>(
                        initialValue: entity.attributes,
                        uiBuilder: AttributeBuilder(''),
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
                            AttributeEdit(
                          model,
                          uiBuilder,
                          AttributeConsumer(),
                          edit,
                        ),
                        validator: (List<AttributeModel> value) =>
                            value.isEmpty ? 'Attributes are required.' : null,
                        onSaved: (List<AttributeModel> value) =>
                            entity.attributes = value,
                        addText: 'Add %s',
                        removeText: 'Remove %s?',
                        emptyListText: 'No %s.',
                      ),

                      /// Search Term
                      StringField(
                        label: 'Search Term*',
                        initialValue: entity.modelSearchTerm,
                        validator: (String value) =>
                            value.isEmpty ? 'Search Term is required.' : null,
                        onSaved: (String value) =>
                            entity.modelSearchTerm = value,
                      ),

                      /// toString()
                      StringField(
                        label: 'toString()*',
                        initialValue: entity.modelToString,
                        validator: (String value) =>
                            value.isEmpty ? 'toString() is required.' : null,
                        onSaved: (String value) => entity.modelToString = value,
                      ),

                      /// More Code
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'More Code',
                            border: OutlineInputBorder(),
                            counterText: '',
                          ),
                          initialValue: entity.moreCode,
                          keyboardType: TextInputType.multiline,
                          onSaved: (String? value) =>
                              entity.moreCode = value ?? '',
                          minLines: 1,
                          maxLines: 999,
                          style: GoogleFonts.firaCode(),
                          enableSuggestions: false,
                          autocorrect: false,
                        ),
                      ),

                      /// Process
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton.icon(
                          onPressed: _process,
                          icon: Icon(Icons.send),
                          label: Text('GENERATE'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(20.0),
                          ),
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
                      labelText: 'Code',
                      border: OutlineInputBorder(),
                      counterText: '',
                    ),
                    controller: _codeController,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 999,
                    style: GoogleFonts.firaCode(),
                    enableSuggestions: false,
                    autocorrect: false,
                    toolbarOptions: ToolbarOptions(
                      copy: true,
                      cut: false,
                      paste: false,
                      selectAll: true,
                    ),
                  ),
                ),
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
  void _jsonImport() async {
    String text = ' ';
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Map<String, dynamic> map = entity.toMap();
      JsonEncoder encoder = JsonEncoder.withIndent('  ');
      text = encoder.convert(map);
    }

    EntityModel? newEntity = await Navigator.of(context).push(
        MaterialPageRoute<EntityModel>(builder: (_) => JsonImport(text: text)));

    if (newEntity != null) {
      await _refresh(newEntity);
      await _process();
    }
  }

  ///
  ///
  ///
  void _copyToClipboard() async {
    bool process = await _process();
    if (process && _codeController.text.isNotEmpty) {
      await Clipboard.setData(ClipboardData(text: _codeController.text));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Code copied to clipboard.',
          ),
        ),
      );
    }
  }

  ///
  ///
  ///
  void _clear() async {
    await _refresh(EntityModel());
  }

  ///
  ///
  ///
  Future<void> _refresh(EntityModel newEntity) async {
    CircularWaiting wait = CircularWaiting(context);
    wait.show();
    _codeController.clear();
    setState(() {
      entity = newEntity;
    });
    await Future<void>.delayed(Duration(milliseconds: 1000));
    _formKey.currentState!.reset();
    wait.close();
  }

  ///
  ///
  ///
  Future<bool> _process() async {
    if (!_formKey.currentState!.validate()) {
      return false;
    }

    _formKey.currentState!.save();

    AbstractLanguage language = Config().languages[entity.languageType.value]!;

    _codeController.text = language.getModelClass(entity);

    return true;
  }
}
