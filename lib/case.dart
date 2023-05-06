import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class ShowCase extends StatelessWidget {
  const ShowCase({Key? key}) : super(key: key);

  static const kits = <Widget>[
    SpinKitRotatingCircle(color: Colors.black),
    SpinKitRotatingPlain(color: Colors.black),
    SpinKitChasingDots(color: Colors.black),

    SpinKitPumpingHeart(color: Colors.black),
    SpinKitPulse(color: Colors.black),
    SpinKitDoubleBounce(color: Colors.black),

    SpinKitWave(color: Colors.black, type: SpinKitWaveType.start),
    SpinKitWave(color: Colors.black, type: SpinKitWaveType.center),
    SpinKitWave(color: Colors.black, type: SpinKitWaveType.end),

    SpinKitPianoWave(color: Colors.black, type: SpinKitPianoWaveType.start),
    SpinKitPianoWave(color: Colors.black, type: SpinKitPianoWaveType.center),
    SpinKitPianoWave(color: Colors.black, type: SpinKitPianoWaveType.end),

    SpinKitThreeBounce(color: Colors.red, size: 15),
    SpinKitThreeInOut(color: Colors.black),
    SpinKitWanderingCubes(color: Colors.black),

    SpinKitWanderingCubes(color: Colors.black, shape: BoxShape.circle),
    SpinKitCircle(color: Colors.black),
    SpinKitFadingFour(color: Colors.black),

    SpinKitFadingFour(color: Colors.black, shape: BoxShape.rectangle),
    SpinKitFadingCube(color: Colors.black),
    SpinKitCubeGrid(size: 51.0, color: Colors.black),

    SpinKitFoldingCube(color: Colors.black),
    SpinKitRing(color: Colors.black),
    SpinKitDualRing(color: Colors.black),

    SpinKitSpinningLines(color: Colors.black),
    SpinKitFadingGrid(color: Colors.black),
    SpinKitFadingGrid(color: Colors.black, shape: BoxShape.rectangle),

    SpinKitSquareCircle(color: Colors.black),
    SpinKitSpinningCircle(color: Colors.black),
    SpinKitSpinningCircle(color: Colors.black, shape: BoxShape.rectangle),

    SpinKitFadingCircle(color: Colors.black),
    SpinKitHourGlass(color: Colors.black),
    SpinKitPouringHourGlass(color: Colors.black),

    SpinKitPouringHourGlassRefined(color: Colors.black),
    SpinKitRipple(color: Colors.black),
    SpinKitDancingSquare(color: Colors.black),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: const Text('SpinKit', style: TextStyle(fontSize: 24.0)),
      ),
      body:
      Column(
        children: [

   GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: context.adaptiveCrossAxisCount,
              mainAxisSpacing: 46,
              childAspectRatio: 2,
            ),
            padding: const EdgeInsets.only(top: 0, bottom: 0),
            itemCount: kits.length,
            itemBuilder: (context, index) => kits[index],
          ),
        ]
      ),


    );
  }
}

extension on BuildContext {
  int get adaptiveCrossAxisCount {
    final width = MediaQuery.of(this).size.width;
    if (width > 1024) {
      return 8;
    } else if (width > 720 && width < 1024) {
      return 6;
    } else if (width > 480) {
      return 4;
    } else if (width > 320) {
      return 3;
    }
    return 1;
  }
}