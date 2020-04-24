import 'package:flutter/material.dart';
import 'panel.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

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
        body: Panel(),
        bottomNavigationBar: BottomAppBar(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: GestureDetector(
              onTap: () => launch('https://gitlab.com/asimos-bot/sha512sum'),
              child: Text(
                  'Click here to view the project in Github! \U0000270D',
                  textAlign: TextAlign.center,
              )
            )
          )
        )
      )
    );
  }
}