import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:folly_fields/folly_fields.dart';
import 'package:model_code_generator/views/home.dart';
import 'package:model_code_generator/util/config.dart';

///
///
///
void main() {
  bool debug = false;

  assert(debug = true);

  WidgetsFlutterBinding.ensureInitialized();

  FollyFields.start(Config(), debug: debug);

  runApp(ModelCodeGenerator());
}

///
/// TODO - Implementar o redutor de tamanho de envio no toSave().
///
class ModelCodeGenerator extends StatelessWidget {
  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Model Code Generator',
      theme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        snackBarTheme: ThemeData.dark().snackBarTheme.copyWith(
              backgroundColor: Colors.blue,
              contentTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
      ),
      home: Home(),
      localizationsDelegates: <LocalizationsDelegate<dynamic>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: <Locale>[
        const Locale('en', 'US'),
      ],
    );
  }
}
