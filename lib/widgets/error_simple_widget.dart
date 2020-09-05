import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ErrorSimpleWidget extends StatelessWidget {
  ErrorSimpleWidget({@required this.errorText});

  final String errorText;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(errorText, style: TextStyle(color: Colors.red)));
  }
}
