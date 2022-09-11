import 'package:calculator/Model/calc_screen.dart';
import 'package:calculator/Providers/ad_state.dart';
import 'package:calculator/Providers/theme_provider.dart';
import 'package:calculator/View/calculator.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import 'Providers/calc_input_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final initFuture = MobileAds.instance.initialize();
  final adState = await AdState(initialization: initFuture);

  runApp(
    MultiProvider(providers: [
      Provider<AdState>(
        create: (context) => adState,
      ),
      ChangeNotifierProvider<AppTheme>(
        create: (context) => AppTheme(ThemeMode.light),
      ),
      ChangeNotifierProvider<CalcInput>(
        create: (context) => CalcInput(),
      )
    ], builder: (context, child) => const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const Calculator();
  }
}
