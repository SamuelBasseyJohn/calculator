import 'package:calculator/Model/calc_screen.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalcInput extends ChangeNotifier {
  CalcScreen calcScreen = CalcScreen();
  var userInput = '';
  var answer = ' ';
  RegExp addition = RegExp(r'\d+[+]\d+');
  RegExp endAddition = RegExp(r'[+]$');
  RegExp subtraction = RegExp(r'\d+[-]\d+');
  RegExp endSubtraction = RegExp(r'[-]$');
  RegExp multiplication = RegExp(r'\d+[x]\d+');
  RegExp endMultiplication = RegExp(r'[x]$');
  RegExp division = RegExp(r'\d+[÷]\d+');
  RegExp endDivision = RegExp(r'[÷]$');
  RegExp modulo = RegExp(r'\d+[%]\d+');
  RegExp endModulo = RegExp(r'[%]$');

  void equalPressed(String input) {
    if (endAddition.hasMatch(userInput) || endSubtraction.hasMatch(userInput)) {
      input += '0';
    }

    if (endMultiplication.hasMatch(userInput) ||
        endDivision.hasMatch(userInput)) {
      input += '1';
    }

    String finalInput = input;
    finalInput = finalInput.replaceAll('x', '*');
    finalInput = finalInput.replaceAll('÷', '/');
    finalInput = finalInput.replaceAll('MOD', '%');
    Parser parser = Parser();
    Expression exp = parser.parse(finalInput);
    ContextModel contextModel = ContextModel();
    double evaluate = exp.evaluate(EvaluationType.REAL, contextModel);
    answer = evaluate.toString();
    if (answer.length > 12) {
      answer = evaluate.toStringAsFixed(12);
      answer = answer.substring(0, 12);
    }
  }

  void input(int index) {
    if (index == 0) {
      userInput = '';
      answer = ' ';
    } else if (index == 1) {
      userInput = userInput.substring(0, userInput.length - 1);
      equalPressed(userInput);
    } else if (index == 18) {
      equalPressed(userInput);
      userInput = answer;
      answer = '';
    } else {
      userInput += calcScreen.buttonText[index];
      if (addition.hasMatch(userInput) ||
          subtraction.hasMatch(userInput) ||
          multiplication.hasMatch(userInput) ||
          division.hasMatch(userInput) ||
          modulo.hasMatch(userInput)) {
        equalPressed(userInput);
      }
    }

    notifyListeners();
  }

  void sciInput(int index) {
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
