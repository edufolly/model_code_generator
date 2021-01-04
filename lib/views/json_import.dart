import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:folly_fields/widgets/folly_dialogs.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:model_code_generator/models/entity_model.dart';
import 'package:model_code_generator/util/config.dart';

///
///
///
class JsonImport extends StatefulWidget {
  final String text;

  ///
  ///
  ///
  const JsonImport({Key key, this.text}) : super(key: key);

  ///
  ///
  ///
  @override
  _JsonImportState createState() => _JsonImportState();
}

///
///
///
class _JsonImportState extends State<JsonImport> {
  TextEditingController _jsonController;

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();
    _jsonController = TextEditingController(text: widget.text);
  }

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Importação'),
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.check),
            onPressed: () {
              try {
                String text = _jsonController.text;
                Map<String, dynamic> map = json.decode(text);
                EntityModel entity = EntityModel.fromJson(map);
                if (entity == null) throw Exception('Entidade não mapeada.');
                Navigator.of(context).pop(entity);
              } catch (e, s) {
                if (Config().isDebug) {
                  print(e);
                  print(s);
                }
                FollyDialogs.dialogMessage(
                  context: context,
                  message: e.toString(),
                );
              }
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Json',
            border: OutlineInputBorder(),
            counterText: '',
          ),
          controller: _jsonController,
          keyboardType: TextInputType.multiline,
          minLines: 30,
          maxLines: 999,
          style: GoogleFonts.firaCode(),
          enableSuggestions: false,
          textAlignVertical: TextAlignVertical.top,
        ),
      ),
    );
  }
}
