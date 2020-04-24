import 'package:flutter/material.dart';
import 'panel.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    //disable screen rotation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);

    return MaterialApp(
      title: 'Sha512Sum',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Center(
            child: Text(
              'Sha512Sum',
              textScaleFactor: 1.5,
              textAlign: TextAlign.center
            )
          )
        ),
        body: Panel()
      )
    );
  }
}