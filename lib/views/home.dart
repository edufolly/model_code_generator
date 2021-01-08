import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folly_fields/fields/dropdown_field.dart';
import 'package:folly_fields/fields/list_field.dart';
import 'package:folly_fields/fields/string_field.dart';
import 'package:folly_fields/util/string_utils.dart';
import 'package:folly_fields/widgets/circular_waiting.dart';
import 'package:folly_fields/widgets/folly_dialogs.dart';
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
  final TextEditingController _codeController = TextEditingController();

  EntityModel entity = EntityModel();

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
            icon: Icon(FontAwesomeIcons.solidCopy),
            onPressed: _copyToClipboard,
          ),
          IconButton(
            icon: Icon(FontAwesomeIcons.solidTrashAlt),
            onPressed: _clear,
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: FlatButton(
              child: Text('JSON'),
              onPressed: _jsonImport,
              color: Theme.of(context).colorScheme.onBackground,
              colorBrightness: Brightness.light,
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
                        label: 'Linguagem*',
                        items: LanguageTypeHelper.languageItems,
                        initialValue: entity.languageType ?? LanguageType.Dart,
                        validator: (LanguageType value) =>
                            value == null ? 'Informe a linguagem' : null,
                        onSaved: (LanguageType value) =>
                            entity.languageType = value,
                      ),

                      /// Package Path
                      StringField(
                        label: 'Caminho do Pacote*',
                        initialValue: entity.packagePath,
                        validator: (String value) => value.isEmpty
                            ? 'Informe o caminho do pacote'
                            : null,
                        onSaved: (String value) => entity.packagePath = value,
                      ),

                      /// Name
                      StringField(
                        label: 'Nome*',
                        initialValue: entity.name,
                        validator: (String value) =>
                            StringUtils.isPascalCase(value)
                                ? null
                                : 'Informe um nome válido. (PascalCase)',
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

                      /// Search Term
                      StringField(
                        label: 'Termo de Busca*',
                        initialValue: entity.searchterm,
                        validator: (String value) =>
                            value.isEmpty ? 'Informe o termo de busca' : null,
                        onSaved: (String value) => entity.searchterm = value,
                      ),

                      /// toString()
                      StringField(
                        label: 'toString()*',
                        initialValue: entity.tostring,
                        validator: (String value) =>
                            value.isEmpty ? 'Informe o toString()' : null,
                        onSaved: (String value) => entity.tostring = value,
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
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Map<String, dynamic> map = entity.toMap();
      JsonEncoder encoder = JsonEncoder.withIndent('  ');
      text = encoder.convert(map);
    }

    EntityModel newEntity = await Navigator.of(context).push(
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
      // TODO - Melhorar a forma da mensagem.
      await FollyDialogs.dialogMessage(
        context: context,
        title: 'Copiado!',
        message: 'Código copiado para a área de transferência.',
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
  void _refresh(EntityModel newEntity) async {
    CircularWaiting wait = CircularWaiting(context);
    wait.show();
    _codeController.clear();
    setState(() {
      entity = newEntity;
    });
    await Future<void>.delayed(Duration(milliseconds: 1000));
    _formKey.currentState.reset();
    wait.close();
  }

  ///
  ///
  ///
  Future<bool> _process() async {
    if (!_formKey.currentState.validate()) {
      return false;
    }

    _formKey.currentState.save();

    AbstractLanguage language = Config().languages[entity.languageType];

    _codeController.text = language.getModelClass(entity);

    return true;
  }
}
