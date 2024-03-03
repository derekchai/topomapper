import 'package:flutter/material.dart';

class ProjectText {
  static const TextStyle title = TextStyle(
    fontSize: 32
  );

  static const TextStyle heading1 = TextStyle(
    fontSize: 26
  );

  static TextStyle subtitle({italics = false}) => TextStyle(
    color: Colors.grey,
    fontStyle: (italics) ? FontStyle.italic : FontStyle.normal
  );

  static TextStyle link = TextStyle(
    color: Colors.blue
  );
  
}