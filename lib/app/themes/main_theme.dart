import 'package:flutter/material.dart';


Map<int, Color> _swatchOpacity = {
    50: const Color.fromRGBO(43, 43, 43, .1),
    100: const Color.fromRGBO(43, 43, 43, .2),
    200: const Color.fromRGBO(43, 43, 43, .3),
    300: const Color.fromRGBO(43, 43, 43, .4),
    400: const Color.fromRGBO(43, 43, 43, .5),
    500: const Color.fromRGBO(43, 43, 43, .6),
    600: const Color.fromRGBO(43, 43, 43, .7),
    700: const Color.fromRGBO(43, 43, 43, .8),
    800: const Color.fromRGBO(43, 43, 43, .9),
    900: const Color.fromRGBO(43, 43, 43, 1),
  };

abstract class ColorTheme {

  static Color primary = const Color.fromARGB(255, 43, 43, 43);

  static MaterialColor primarySwatch = MaterialColor(0xFF2B2B2B, _swatchOpacity);
}
