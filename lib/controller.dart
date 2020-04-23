import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class Hasher {

  TextEditingController _controller = TextEditingController();

  String hash="Your Sha512sum result will be shown here";

  //update saved hash value
  String updateHash() => hash = sha512.convert(utf8.encode(_controller.text)).toString();

  //get hash from current _controller text
  String getHash() => hash != ""? hash : "Your Sha512Sum result will be shown here";

  //get controller object
  TextEditingController getController() => _controller;

  //dispose controller
  void dispose() => _controller.dispose();
}