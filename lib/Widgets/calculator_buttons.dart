import 'dart:io';

import 'package:calculator/Model/calc_screen.dart';
import 'package:calculator/Providers/calc_input_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class Button extends StatefulWidget {
  Button(
      {Key? key,
      required this.color,
      required this.textColor,
      required this.buttonText,
      required this.index})
      : super(key: key);

  Color? color;
  Color textColor;
  String buttonText;
  int index;

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    var inputProvider = Provider.of<CalcInput>(context);
    CalcScreen calcScreen = CalcScreen();
    return Container(
      child: SizedBox(
        width: 85,
        height: Platform.isAndroid ? 70 : 80,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () {
            inputProvider.input(widget.index);
          },
          child: Text(
            widget.buttonText,
            style: TextStyle(color: widget.textColor, fontSize: 27),
          ),
        ),
      ),
    );
  }
}
