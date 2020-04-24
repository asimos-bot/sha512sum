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

  final hintText = "Your Sha512sum result will be shown here";

  String hash;
  int hashSize=128;

  PanelState() {
    hash = hintText;
  }

  bool passwd=true;

  //update saved hash value
  void updateHash() {

    setState(() {

      if( _controller.text != "" )
        hash = sha512.convert(utf8.encode(_controller.text)).toString().substring(0,hashSize);
      else
        hash = hintText;
    });
  }

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
              padding: EdgeInsets.all(0.0),
              child: ListTile(
                leading: IconButton(
                  icon: Icon(Icons.delete_outline),
                  onPressed: () => _controller.text = ""
                ),
                trailing: IconButton(
                  icon: Icon( passwd ? Icons.panorama_fish_eye : Icons.remove_circle_outline),
                  onPressed: () => setState(() => passwd = !passwd)
                ),
                title: TextField(
                  obscureText: passwd,
                  controller: _controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20)
                      )
                    ),
                    hintText: 'text to hash'
                  )
                )
              )
            ),

            Padding(
              padding: EdgeInsets.all(10.0),
              child: Slider(
                min: 1,
                max: 128,
                onChanged: (newValue) {
                  hashSize = newValue.round();
                  updateHash();
                },
                value: hashSize.toDouble()
              )
            ),

            Text(
              '${hashSize}',
              textAlign: TextAlign.center,
              textScaleFactor: 2,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Open Sans'
              ),
            )

          ],

        )
    );
  }
}

