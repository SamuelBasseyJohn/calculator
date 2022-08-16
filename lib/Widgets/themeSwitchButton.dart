import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../Providers/theme_provider.dart';

class ThemeSwitchButton extends StatefulWidget {
  ThemeSwitchButton({
    Key? key,
  }) : super(key: key);

  @override
  State<ThemeSwitchButton> createState() => _ThemeSwitchButtonState();
}

class _ThemeSwitchButtonState extends State<ThemeSwitchButton> {
  List<bool> isSelected = [true, false];
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppTheme>(context);
    return ToggleButtons(
      renderBorder: true,
      direction: Axis.horizontal,
      color: Colors.grey,
      fillColor: provider.appTheme == ThemeMode.light
          ? Colors.blueGrey.shade100
          : Colors.blueGrey.shade900,
      selectedColor: Colors.black,
      borderRadius: BorderRadius.all(Radius.circular(15)),
      onPressed: (int newIndex) {
        setState(() {
          for (var index = 0; index < isSelected.length; index++) {
            if (index == newIndex) {
              isSelected[index] = true;
            } else {
              isSelected[index] = false;
            }
          }
        });
        if (isSelected[1] == false) {
          provider.selected = false;
        }
        if (isSelected[1] == true) {
          provider.selected = true;
        }
        provider.setTheme();
        print(provider.selected);
      },
      isSelected: isSelected,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(provider.selected == true
              ? Icons.light_mode_outlined
              : Icons.light_mode),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(
            provider.selected == true
                ? Icons.dark_mode
                : Icons.dark_mode_outlined,
            color: provider.selected == true ? Colors.white : Colors.grey,
          ),
        )
      ],
    );
  }
}
