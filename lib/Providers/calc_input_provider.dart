import 'package:calculator/Model/calc_screen.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalcInput extends ChangeNotifier {
  CalcScreen calcScreen = CalcScreen();
  var userInput = '';
  var answer = '0';

  void equalPressed(String input) {
    String finalInput = input;
    finalInput = finalInput.replaceAll('x', '*');
    Parser parser = Parser();
    Expression exp = parser.parse(finalInput);
    ContextModel contextModel = ContextModel();
    double evaluate = exp.evaluate(EvaluationType.REAL, contextModel);
    answer = evaluate.toString();
  }

  void input(int index) {
    if (index == 0) {
      userInput = '';
      answer = '0';
    } else if (index == 1) {
      userInput = userInput.substring(0, userInput.length - 1);
    } else if (index == 18) {
      equalPressed(userInput);
    } else {
      userInput += calcScreen.buttonText[index];
    }

    notifyListeners();
  }
}
