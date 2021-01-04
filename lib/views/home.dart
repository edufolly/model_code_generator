import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:folly_fields/fields/list_field.dart';
import 'package:folly_fields/fields/string_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:model_code_generator/consumers/attribute_consumer.dart';
import 'package:model_code_generator/models/attribute_model.dart';
import 'package:model_code_generator/models/attribute_type_model.dart';
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
  final TextEditingController _codeController = TextEditingController();

  EntityModel model = EntityModel.fromJson(json.decode(
      '{"name":"Company","attributes":[{"name":"active","type":{'
          '"name":"Boolean","type":"AttributeType.Boolean","langTypeName":"bool",'
          '"hasInternalType":false,"needName":false},"nullAware":"true"},'
          '{"name":"cnpj","type":{"name":"String","type":"AttributeType.String",'
          '"langTypeName":"String","hasInternalType":false,"needName":false}},'
          '{"name":"companyName","type":{"name":"String","type":"AttributeType.String",'
          '"langTypeName":"String","hasInternalType":false,"needName":false}},'
          '{"name":"fancyName","type":{"name":"String","type":"AttributeType.String",'
          '"langTypeName":"String","hasInternalType":false,"needName":false}}]}'));

  // EntityModel model = EntityModel();

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
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                flex: 1,
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
              Flexible(
                flex: 1,
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
  void _process() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    Map<String, dynamic> map = model.toMap();
    print(json.encode(map));

    String className = '${model.name}Model';

    String code = '';
    code += 'import \'package:folly_fields/crud/abstract_model.dart\';\n';
    code += '\n';
    code += '///\n';
    code += '///\n';
    code += '///\n';
    code += 'class $className extends AbstractModel {\n';
    for (AttributeModel attribute in model.attributes) {
      code += '  ${attribute.getTextType()} ${attribute.name}';
      if (attribute.hasNullAware) code += ' = ${attribute.nullAware}';
      code += ';\n';
    }
    code += '\n';

    ///
    ///
    ///
    code += '  ///\n';
    code += '  ///\n';
    code += '  ///\n';
    code += '  $className();\n';
    code += '\n';

    ///
    ///
    ///
    code += '  ///\n';
    code += '  ///\n';
    code += '  ///\n';
    code += '  $className.fromJson(Map<String, dynamic> map)\n';
    code += '      :\n';

    for (AttributeModel attribute in model.attributes) {
      String name = attribute.name;
      switch (attribute.type.type) {
        case AttributeType.String:
          code += '        $name = map[\'$name\']';
          break;
        case AttributeType.Boolean:
          code += '        $name = map[\'$name\']';
          break;
        case AttributeType.Integer:
          code += '        $name = map[\'$name\']';
          break;
        case AttributeType.Double:
          code += '        $name = map[\'$name\']';
          break;
        case AttributeType.Model:
          code += '        AttributeType.Model - ??????????\n';
          break;
        case AttributeType.List:
          code += '        AttributeType.List - ??????????\n';
          break;
      }

      if (attribute.hasNullAware) code += ' ?? ${attribute.nullAware}';

      code += ',\n';
    }
    code += '        super.fromJson(map);\n';
    code += '\n';

    ///
    ///
    ///
    code += '  ///\n';
    code += '  ///\n';
    code += '  ///\n';
    code += '  @override\n';
    code += '  $className fromJson(Map<String, dynamic> map) =>\n';
    code += '      $className.fromJson(map);\n';
    code += '\n';

    ///
    ///
    ///
    code += '  ///\n';
    code += '  ///\n';
    code += '  ///\n';
    code += '  @override\n';
    code += '  Map<String, dynamic> toMap() {\n';
    code += '    Map<String, dynamic> map = super.toMap();\n';
    for (AttributeModel attribute in model.attributes) {
      String name = attribute.name;
      code += '    ';
      if (!attribute.hasNullAware) {
        code += 'if ($name != null) ';
      }

      switch (attribute.type.type) {
        case AttributeType.String:
          code += 'map[\'$name\'] = $name';
          break;
        case AttributeType.Boolean:
          code += 'map[\'$name\'] = $name';
          break;
        case AttributeType.Integer:
          code += 'map[\'$name\'] = $name';
          break;
        case AttributeType.Double:
          code += 'map[\'$name\'] = $name';
          break;
        case AttributeType.Model:
          code += '    AttributeType.Model - ??????????\n';
          break;
        case AttributeType.List:
          code += '    AttributeType.List - ??????????\n';
          break;
      }

      if (attribute.hasNullAware) code += ' ?? ${attribute.nullAware}';

      code += ';\n';
    }
    code += '    return map;\n';
    code += '  }\n';
    code += '\n';

    ///
    ///
    ///
    code += '  ///\n';
    code += '  ///\n';
    code += '  ///\n';
    code += '  @override\n';
    code += '  // TODO: implement searchTerm\n';
    code += '  String get searchTerm => throw UnimplementedError();\n';
    code += '}\n';

    _codeController.text = code;
  }
}
