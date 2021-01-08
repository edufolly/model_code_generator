import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  /// z
  Future<String> _checkClipboard() async {
    if (widget.text == null || widget.text.trim().isEmpty) {
      // TODO - Check clipboard content and map.
      ClipboardData data = await Clipboard.getData('text/plain');
      print(data.text);
    }
    return '';
  }

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Json Import'),
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.solidCopy),
            onPressed: _copyToClipboard,
          ),
          IconButton(
            icon: Icon(FontAwesomeIcons.check),
            onPressed: _import,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Json',
            border: OutlineInputBorder(),
            counterText: '',
          ),
          controller: _jsonController,
          keyboardType: TextInputType.multiline,
          autofocus: true,
          minLines: 1,
          maxLines: 999,
          style: GoogleFonts.firaCode(),
          enableSuggestions: false,
          autocorrect: false,
          toolbarOptions: ToolbarOptions(
            copy: true,
            cut: false,
            paste: true,
            selectAll: true,
          ),
        ),
      ),
    );
  }

  ///
  ///
  ///
  void _copyToClipboard() async {
    if (_jsonController.text.isNotEmpty) {
      await Clipboard.setData(ClipboardData(text: _jsonController.text));
      // TODO - better message.
      await FollyDialogs.dialogMessage(
        context: context,
        title: 'Copied!',
        message: 'Json copied to clipboard.',
      );
    }
  }

  ///
  ///
  ///
  void _import() {
    try {
      String text = _jsonController.text;
      Map<String, dynamic> map = json.decode(text);
      EntityModel entity = EntityModel.fromJson(map);
      if (entity == null) throw Exception('Entity not mapped.');
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
  }
}
