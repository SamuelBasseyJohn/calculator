import 'package:calculator/Model/calc_screen.dart';
import 'package:calculator/Providers/theme_provider.dart';
import 'package:calculator/View/calculator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Providers/calc_input_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppTheme>(
            create: (context) => AppTheme(ThemeMode.light)),
        ChangeNotifierProvider<CalcInput>(create: (context) => CalcInput())
      ],
      builder: (context, _) => const Calculator(),
    );
  }
}
