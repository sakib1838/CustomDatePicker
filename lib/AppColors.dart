import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppColors {
  static const Map<int, Color> customColor = {
    50: Color.fromRGBO(40, 68, 140, 0.1),
    100: Color.fromRGBO(40, 68, 140, 0.2),
    200: Color.fromRGBO(40, 68, 140, 0.3),
    300: Color.fromRGBO(40, 68, 140, 0.4),
    400: Color.fromRGBO(40, 68, 140, 0.5),
    500: Color.fromRGBO(40, 68, 140, 0.6),
    600: Color.fromRGBO(40, 68, 140, 0.7),
    700: Color.fromRGBO(40, 68, 140, 0.8),
    800: Color.fromRGBO(40, 68, 140, 0.9),
    900: Color.fromRGBO(40, 68, 140, 1.0),
  };




  static const String primaryColor = "#263d89";//"#28448c";
  static const String primaryColor2 = "#118acb";
  static const String primaryColor3 = "#203978";
  static const String backgroundColor = "#f3f3f3";
  static const String whiteColor = "#ffffff";
  static const String texColorBlue = "#3f69b2";
  static const String iconColorBlue = "#40bcec";
  static const String textFieldBackgroundColor = "#f6f4f3";
  static const String textFieldBorderColor = "#ecded7e6";
  static const String tabSelectedColor = "#118acb";
  static const String tabUnSelectedColor = "#000000";
  static const String iconColor = "#20447c";//"#24418a";
  static const String facebookButtonColor = "#3157b0";
  static const String deshiTextColor = "#26408A";
  static const String deshiTextColor2 = "#f3f5f7";
  static const String deshiTextColorGrey = "#dddddd";
  static const String yellowColor = "#FFA500";
  static const String greyLighColor = "#e2e6e6";
  static const String greyColor = "#616872";
  static const String pageSelectedColor = "#518acb";


}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
