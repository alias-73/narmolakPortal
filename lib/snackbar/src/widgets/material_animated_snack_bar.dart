import 'package:flutter/material.dart';


import '../types.dart';

const _infoBackgroundColor = Color(0xffcbcbcb);
const _errorBackgrounColor = Color(0xfffac80a);
const _successBackgroundColor = Color(0xff7dc701);
const _warningBackgroundColor = Color.fromRGBO(232, 145, 72, 1);

final defaultBorderRadius = BorderRadius.circular(8);

class MaterialAnimatedSnackBar extends StatelessWidget {
  const MaterialAnimatedSnackBar({
    Key? key,
    required this.type,
    required this.borderRadius,
    required this.messageText,
  }) : super(key: key);

  final AnimatedSnackBarType type;
  final BorderRadius borderRadius;
  final String messageText;

  Color get foregroundColor => Colors.black;

  Color get backgroundColor {
    switch (type) {
      case AnimatedSnackBarType.info:
        return _infoBackgroundColor;

      case AnimatedSnackBarType.error:
        return _errorBackgrounColor;

      case AnimatedSnackBarType.success:
        return _successBackgroundColor;

      case AnimatedSnackBarType.warning:
        return _warningBackgroundColor;

      default:
        throw UnimplementedError();
    }
  }

  IconData get iconData {
    switch (type) {
      case AnimatedSnackBarType.info:
        return Icons.info_outline;

      case AnimatedSnackBarType.error:
        return Icons.error_outline;

      case AnimatedSnackBarType.success:
        return Icons.done;

      case AnimatedSnackBarType.warning:
        return Icons.warning_amber_rounded;

      default:
        throw UnimplementedError();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              iconData,
              color: foregroundColor,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Column(
                children: [
                  Text(
                    messageText,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: foregroundColor,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
