import 'package:flutter/material.dart';
import 'package:sidawa/constants.dart';
import 'package:sidawa/launcher/vLauncher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sidawa',
      theme: ThemeData(
        fontFamily: 'NeoSans',
        primaryColor: SidawaPalette.green,
        accentColor: SidawaPalette.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LauncherPage(),
    );
  }
}
