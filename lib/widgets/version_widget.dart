import 'package:flutter/material.dart';

///
///
///
class VersionWidget extends StatelessWidget {
  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _loadData(context),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data ?? '');
        }
        return Text('...');
      },
    );
  }

  ///
  ///
  ///
  Future<String> _loadData(BuildContext context) async {
    String content =
        await DefaultAssetBundle.of(context).loadString('assets/version.txt');

    if (content.isNotEmpty) {
      return content.trim();
    }

    return 'No Version';
  }
}
