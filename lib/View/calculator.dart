import 'package:calculator/Model/calc_screen.dart';
import 'package:calculator/Model/theme_mode.dart';
import 'package:calculator/Providers/ad_state.dart';
import 'package:calculator/Providers/calc_input_provider.dart';
import 'package:calculator/Widgets/calculator_buttons.dart';
import 'package:calculator/Widgets/themeSwitchButton.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import '../Providers/theme_provider.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  BannerAd? banner;
  bool staticAdLoaded = false;

  void loadStaticAd() {
    // staticAd = BannerAd(
    //     size: AdSize.banner,
    //     adUnitId: BannerAd.getAdUnitId,
    //     listener: listener,
    //     request: request);
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
    adState.initialization.then((status) {
      setState(() {
        banner = BannerAd(
            size: AdSize.banner,
            adUnitId: adState.bannerAdUnitId,
            listener: BannerAdListener(
              onAdLoaded: (ad) => setState(() {
                staticAdLoaded = true;
              }),
              onAdFailedToLoad: (ad, error) {
                ad.dispose();
                print('Ad failed to load, ${error.message}');
              },
            ),
            request: const AdRequest())
          ..load();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var inputProvider = Provider.of<CalcInput>(context);
    var themeProvider = Provider.of<AppTheme>(context);
    Widget displayAd = banner == null
        ? const SizedBox(
            height: 50,
          )
        : SizedBox(
            height: 50,
            child: AdWidget(ad: banner!),
          );

    var color = themeProvider.appTheme == ThemeMode.light
        ? MyTheme.lightTheme.primaryColor
        : MyTheme.darkTheme.primaryColor;
    var specialColor = themeProvider.appTheme == ThemeMode.dark
        ? MyTheme.lightTheme.primaryColor
        : MyTheme.darkTheme.primaryColor;
    var textColor = themeProvider.appTheme == ThemeMode.light
        ? MyTheme.lightTheme.colorScheme.onPrimary
        : MyTheme.darkTheme.colorScheme.onPrimary;
    var specialTextColor = themeProvider.appTheme == ThemeMode.dark
        ? MyTheme.lightTheme.colorScheme.onPrimary
        : MyTheme.darkTheme.colorScheme.onPrimary;
    CalcScreen numberPad = CalcScreen();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      themeMode: themeProvider.appTheme,
      darkTheme: MyTheme.darkTheme,
      theme: MyTheme.lightTheme,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            children: [
              displayAd,
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ThemeSwitchButton(),
                      ],
                    ),
                    Container(
                        height: 200,
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                inputProvider.userInput,
                                style: const TextStyle(fontSize: 30),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                inputProvider.answer,
                                style: const TextStyle(fontSize: 50),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: themeProvider.appTheme == ThemeMode.light
                        ? Colors.blueGrey.shade100
                        : Colors.blueGrey.shade900,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Button(
                            index: 0,
                            color: themeProvider.appTheme == ThemeMode.light
                                ? Colors.amber
                                : Colors.amber[300],
                            textColor: textColor,
                            buttonText: numberPad.buttonText[0],
                          ),
                          Button(
                            index: 1,
                            color: themeProvider.appTheme == ThemeMode.light
                                ? Colors.red
                                : Colors.red[300],
                            textColor: textColor,
                            buttonText: numberPad.buttonText[1],
                          ),
                          Button(
                            index: 2,
                            color: specialColor,
                            textColor: specialTextColor,
                            buttonText: numberPad.buttonText[2],
                          ),
                          Button(
                            index: 3,
                            color: specialColor,
                            textColor: specialTextColor,
                            buttonText: numberPad.buttonText[3],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Button(
                            index: 4,
                            color: color,
                            textColor: textColor,
                            buttonText: numberPad.buttonText[4],
                          ),
                          Button(
                            index: 5,
                            color: color,
                            textColor: textColor,
                            buttonText: numberPad.buttonText[5],
                          ),
                          Button(
                            index: 6,
                            color: color,
                            textColor: textColor,
                            buttonText: numberPad.buttonText[6],
                          ),
                          Button(
                            index: 7,
                            color: specialColor,
                            textColor: specialTextColor,
                            buttonText: numberPad.buttonText[7],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Button(
                            index: 8,
                            color: color,
                            textColor: textColor,
                            buttonText: numberPad.buttonText[8],
                          ),
                          Button(
                            index: 9,
                            color: color,
                            textColor: textColor,
                            buttonText: numberPad.buttonText[9],
                          ),
                          Button(
                            index: 10,
                            color: color,
                            textColor: textColor,
                            buttonText: numberPad.buttonText[10],
                          ),
                          Button(
                            index: 11,
                            color: specialColor,
                            textColor: specialTextColor,
                            buttonText: numberPad.buttonText[11],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Button(
                            index: 12,
                            color: color,
                            textColor: textColor,
                            buttonText: numberPad.buttonText[12],
                          ),
                          Button(
                            index: 13,
                            color: color,
                            textColor: textColor,
                            buttonText: numberPad.buttonText[13],
                          ),
                          Button(
                            index: 14,
                            color: color,
                            textColor: textColor,
                            buttonText: numberPad.buttonText[14],
                          ),
                          Button(
                            index: 15,
                            color: specialColor,
                            textColor: specialTextColor,
                            buttonText: numberPad.buttonText[15],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            child: SizedBox(
                              width: 188,
                              height: 82,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: color,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onPressed: () {
                                  inputProvider.input(16);
                                },
                                child: Text(
                                  numberPad.buttonText[16],
                                  style:
                                      TextStyle(color: textColor, fontSize: 30),
                                ),
                              ),
                            ),
                          ),
                          Button(
                            index: 17,
                            color: color,
                            textColor: textColor,
                            buttonText: numberPad.buttonText[17],
                          ),
                          Button(
                            index: 18,
                            color: themeProvider.appTheme == ThemeMode.light
                                ? Colors.green
                                : Colors.green[300],
                            textColor: textColor,
                            buttonText: numberPad.buttonText[18],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
