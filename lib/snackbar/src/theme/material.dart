import 'package:flutter/material.dart';

const _infoBackgroundColor = Color(0xffb2b2b2);
const _errorBackgrounColor = Color(0xfffac80a);
const _successBackgroundColor = Color(0xffa0ff00);
const _warningBackgroundColor = Color.fromRGBO(255, 205, 0, 1);

final defaultBorderRadius = BorderRadius.circular(8);

class MaterialSnackBarConfig {
  Widget icon;
  Color backgroundColor;
  BorderRadius borderRadius;

  MaterialSnackBarConfig({
    required this.icon,
    required this.backgroundColor,
    required this.borderRadius,
  });
}

class MaterialInfoSnackBarConfig extends MaterialSnackBarConfig {
  MaterialInfoSnackBarConfig()
      : super(
          icon: Icon(
            Icons.info,
            color: getForegroundColor(_infoBackgroundColor),
          ),
          backgroundColor: _infoBackgroundColor,
          borderRadius: defaultBorderRadius,
        );
}

class MaterialErrorSnackBarConfig extends MaterialSnackBarConfig {
  MaterialErrorSnackBarConfig()
      : super(
          icon: Icon(
            Icons.error_outline,
            color: getForegroundColor(_errorBackgrounColor),
          ),
          backgroundColor: _errorBackgrounColor,
          borderRadius: defaultBorderRadius,
        );
}

class MaterialSuccessSnackBarConfig extends MaterialSnackBarConfig {
  MaterialSuccessSnackBarConfig()
      : super(
          icon: Icon(
            Icons.done,
            color: getForegroundColor(_successBackgroundColor),
          ),
          backgroundColor: _successBackgroundColor,
          borderRadius: defaultBorderRadius,
        );
}

class MaterialWarningSnackBarConfig extends MaterialSnackBarConfig {
  MaterialWarningSnackBarConfig()
      : super(
          icon: Icon(
            Icons.warning_amber_rounded,
            color: getForegroundColor(_warningBackgroundColor),
          ),
          backgroundColor: _warningBackgroundColor,
          borderRadius: defaultBorderRadius,
        );
}

Color getForegroundColor(Color backgroundColor) {
  return ThemeData.estimateBrightnessForColor(backgroundColor) ==
          Brightness.dark
      ? Colors.white
      : Colors.black;
}
