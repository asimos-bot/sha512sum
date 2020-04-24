import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class Panel extends StatefulWidget {

  @override
  createState() => PanelState();
}

class PanelState extends State<Panel> {

  final _controller = TextEditingController();

  String hash="Your Sha512sum result will be shown here";

  //update saved hash value
  void updateHash() => setState(() => hash = sha512.convert(utf8.encode(_controller.text)).toString());

  //add Listener that will update the hash everytime we type
  void initState() {

    _controller.addListener(updateHash);
    super.initState();
  }
  //dispose controller
  void dispose() {

    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){

    return Center(
        child: ListView(
          children: <Widget>[

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
                      onTap: () => Clipboard.setData(ClipboardData(text: hash)).then((result){
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text('Copied to Clipboard'),
                          duration: Duration(seconds: 3),
                        ));
                      }).catchError((error) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text('Error: Couldn\'t copy to Clipboard'),
                          duration: Duration(seconds: 3),
                        ));
                      }),
                      child: ListTile(
                        title: Text(
                          hash,
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

            //where we put the content to be hashed
            Padding(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(30)
                            )
                        ),
                        hintText: 'text to hash'
                    )
                )
            )

          ],

        )
    );
  }
}

