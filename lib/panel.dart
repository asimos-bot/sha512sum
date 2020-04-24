import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'controller.dart';

class Panel extends StatefulWidget {

  final navbarTitle;

  Panel(this.navbarTitle);

  @override
  createState() => PanelState(navbarTitle);
}

class PanelState extends State<Panel> {

  final navbarTitle;
  final hasher = Hasher();

  PanelState(this.navbarTitle);

  void dispose(){

    hasher.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Center(
          child: Text(
            navbarTitle,
            textScaleFactor: 1.5,
            textAlign: TextAlign.center
          )
        )
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

            //where we put the content to be hashed
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: hasher.getController(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30)
                    )
                  ),
                  hintText: 'text to hash'
                )
              )
            ),
            //display the hash
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Container(
                    child: InkWell(
                      onTap: () => Clipboard.setData(ClipboardData(text: hasher.getHash())),
                      child: ListTile(
                        title: Text(
                          hasher.getHash(),
                          textAlign: TextAlign.center,
                        ),
                        subtitle: Text(
                          'Click the hash to copy it',
                          textAlign: TextAlign.center
                        )
                      )
                    )
                  )
                )
              )
            ),

            //main button, when pressed the hash is displayed below
            Padding(
                padding: EdgeInsets.all(20.0),
                child:RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)
                    ),
                    onPressed: () => setState(() {
                      hasher.updateHash();
                    }),
                    child: Text(
                      'Get sha512 result',
                      textScaleFactor: 1.5,
                    )
                )
            )

          ],
        )
      )
    );
  }
}

