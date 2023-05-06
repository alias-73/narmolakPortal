import 'package:flutter/material.dart';


import '../types.dart';

class RawAnimatedSnackBar extends StatefulWidget {
  const RawAnimatedSnackBar({
    Key? key,
    required this.duration,
    required this.child,
    required this.onRemoved,
    required this.mobileSnackBarPosition,
    required this.desktopSnackBarPosition,
  }) : super(key: key);

  final Duration duration;
  final Widget child;
  final VoidCallback onRemoved;
  final MobileSnackBarPosition mobileSnackBarPosition;
  final DesktopSnackBarPosition desktopSnackBarPosition;

  @override
  State<RawAnimatedSnackBar> createState() => RawAnimatedSnackBarState();
}

class RawAnimatedSnackBarState extends State<RawAnimatedSnackBar> {
  bool isVisible = false;
  bool removed = false;

  final duration = const Duration(milliseconds: 400);

  final GlobalKey positionedKey = GlobalKey();

  void remove() {
    if (mounted && removed == false) {
      widget.onRemoved();
    } else {
      removed = true;
    }
  }

  @override
  void initState() {
    Future.delayed(
      const Duration(milliseconds: 100),
      () {
        setState(() => isVisible = true);
      },
    );
    Future.delayed(
      Duration(milliseconds: widget.duration.inMilliseconds - 2000),
      () {
        if (mounted) {
          setState(() => isVisible = false);
          Future.delayed(const Duration(seconds: 2), () {
            remove();
          });
        }
      },
    );

    super.initState();
  }

  bool get isDesktop {
    final mediaQuery = MediaQuery.of(context);
    return mediaQuery.size.width > 600;
  }

  double? get top {
    if (widget.mobileSnackBarPosition == MobileSnackBarPosition.top) {
      if (isVisible) {
        return 70;
      } else {
        return -100;
      }
    } else if (widget.mobileSnackBarPosition == MobileSnackBarPosition.bottom) {
      return null;
    }

    throw UnimplementedError();
  }

  double? get bottom {
    if (widget.mobileSnackBarPosition == MobileSnackBarPosition.top) {
      return null;
    } else if (widget.mobileSnackBarPosition == MobileSnackBarPosition.bottom) {
      if (isVisible) {
        return 70;
      } else {
        return -100;
      }
    }

    throw UnimplementedError();
  }

  double? get left {
    if (isDesktop) {
      switch (widget.desktopSnackBarPosition) {
        case DesktopSnackBarPosition.bottomLeft:
        case DesktopSnackBarPosition.topLeft:
          return 35;

        case DesktopSnackBarPosition.bottomCenter:
        case DesktopSnackBarPosition.topCenter:
          return (MediaQuery.of(context).size.width - width!) / 2;

        case DesktopSnackBarPosition.bottomRight:
        case DesktopSnackBarPosition.topRight:
          return MediaQuery.of(context).size.width - width! - 35;

        default:
          throw UnimplementedError();
      }
    }
    return 35;
  }

  double? get right {
    if (isDesktop) {
      switch (widget.desktopSnackBarPosition) {
        case DesktopSnackBarPosition.bottomLeft:
        case DesktopSnackBarPosition.topLeft:
          return MediaQuery.of(context).size.width - width! - 35;

        case DesktopSnackBarPosition.topCenter:
        case DesktopSnackBarPosition.bottomCenter:
          return (MediaQuery.of(context).size.width - width!) / 2;

        case DesktopSnackBarPosition.bottomRight:
        case DesktopSnackBarPosition.topRight:
          return 35;

        default:
          throw UnimplementedError();
      }
    }
    return 35;
  }

  double? get width {
    if (isDesktop) {
      final width = MediaQuery.of(context).size.width;

      return (width * .4).clamp(180, 350);
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      key: positionedKey,
      duration: duration,
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: widget.child,
        ),
      ),
    );
  }
}
