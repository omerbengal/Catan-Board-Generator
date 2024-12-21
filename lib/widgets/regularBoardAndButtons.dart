import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import 'package:animated_button/animated_button.dart';

class RegularBoardAndButtons extends StatefulWidget {
  const RegularBoardAndButtons({Key? key}) : super(key: key);

  @override
  State<RegularBoardAndButtons> createState() => _RegularBoardAndButtonsState();
}

class _RegularBoardAndButtonsState extends State<RegularBoardAndButtons>
    with AutomaticKeepAliveClientMixin<RegularBoardAndButtons> {
  List<String> boardResources = [
    'Wood',
    'Wood',
    'Wood',
    'Wood',
    'Tit',
    'Tit',
    'Tit',
    'Ore',
    'Ore',
    'Ore',
    'Wheat',
    'Wheat',
    'Wheat',
    'Wheat',
    'Sheep',
    'Sheep',
    'Sheep',
    'Sheep',
    'Desert'
  ];
  List<String> boardNumbers = [
    '2',
    '3',
    '3',
    '4',
    '4',
    '5',
    '5',
    '6',
    '6',
    '8',
    '8',
    '9',
    '9',
    '10',
    '10',
    '11',
    '11',
    '12',
    'd'
  ];
  List<double> upsideDownOrNot = [0, math.pi / 6 * 2, math.pi / 6 * 4, math.pi];
  bool disableButton = false;
  var desertIndex;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var offSetX_1 = MediaQuery.of(context).size.width * 0.1295;
    var offSetY_1 = MediaQuery.of(context).size.width * 0.088;
    var fromOffSetY_1 = MediaQuery.of(context).size.width * 0.1286;
    var tileWidth = MediaQuery.of(context).size.width * 0.148;
    var tileHeight = 450 * tileWidth / 389;

    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.04,
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            Transform.rotate(
              angle: upsideDownOrNot[0].toDouble(),
              child: Image(
                // image: AssetImage('assets/images/fullBoard.png'),
                image: AssetImage(
                  'assets/new/fullBoard2.png',
                ),
              ),
            ),

            //first row (from left to right)

            //#1
            Positioned(
              top: offSetY_1,
              left: offSetX_1 + tileWidth,
              child: Container(
                width: tileWidth,
                height: tileHeight,
                child: Image(
                  image: AssetImage(
                    'assets/images/' + boardResources[0] + '.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            //#2
            Positioned(
              top: offSetY_1,
              left: offSetX_1 + tileWidth * 2,
              child: Container(
                width: tileWidth,
                height: tileHeight,
                child: Image(
                  image: AssetImage(
                    'assets/images/' + boardResources[1] + '.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            //#3
            Positioned(
              top: offSetY_1,
              left: offSetX_1 + tileWidth * 3,
              child: Container(
                width: tileWidth,
                height: tileHeight,
                child: Image(
                  image: AssetImage(
                    'assets/images/' + boardResources[2] + '.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            //second row (from left to right)

            //#1
            Positioned(
              top: offSetY_1 + fromOffSetY_1,
              left: offSetX_1 + tileWidth / 2,
              child: Container(
                width: tileWidth,
                height: tileHeight,
                child: Image(
                  image: AssetImage(
                    'assets/images/' + boardResources[3] + '.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            //#2
            Positioned(
              top: offSetY_1 + fromOffSetY_1,
              left: offSetX_1 + tileWidth * 1.5,
              child: Container(
                width: tileWidth,
                height: tileHeight,
                child: Image(
                  image: AssetImage(
                    'assets/images/' + boardResources[4] + '.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            //#3
            Positioned(
              top: offSetY_1 + fromOffSetY_1,
              left: offSetX_1 + tileWidth * 2.5,
              child: Container(
                width: tileWidth,
                height: tileHeight,
                child: Image(
                  image: AssetImage(
                    'assets/images/' + boardResources[5] + '.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            //#4
            Positioned(
              top: offSetY_1 + fromOffSetY_1,
              left: offSetX_1 + tileWidth * 3.5,
              child: Container(
                width: tileWidth,
                height: tileHeight,
                child: Image(
                  image: AssetImage(
                    'assets/images/' + boardResources[6] + '.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            //third row (from left to right)

            //#1
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 2,
              left: offSetX_1,
              child: Container(
                width: tileWidth,
                height: tileHeight,
                child: Image(
                  image: AssetImage(
                    'assets/images/' + boardResources[7] + '.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            //#2
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 2,
              left: offSetX_1 + tileWidth,
              child: Container(
                width: tileWidth,
                height: tileHeight,
                child: Image(
                  image: AssetImage(
                    'assets/images/' + boardResources[8] + '.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            //#3
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 2,
              left: offSetX_1 + tileWidth * 2,
              child: Container(
                width: tileWidth,
                height: tileHeight,
                child: Image(
                  image: AssetImage(
                    'assets/images/' + boardResources[9] + '.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            //#4
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 2,
              left: offSetX_1 + tileWidth * 3,
              child: Container(
                width: tileWidth,
                height: tileHeight,
                child: Image(
                  image: AssetImage(
                    'assets/images/' + boardResources[10] + '.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            //#5
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 2,
              left: offSetX_1 + tileWidth * 4,
              child: Container(
                width: tileWidth,
                height: tileHeight,
                child: Image(
                  image: AssetImage(
                    'assets/images/' + boardResources[11] + '.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            //forth row (from left to right)

            //#1
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 3,
              left: offSetX_1 + tileWidth / 2,
              child: Container(
                width: tileWidth,
                height: tileHeight,
                child: Image(
                  image: AssetImage(
                    'assets/images/' + boardResources[12] + '.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            //#2
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 3,
              left: offSetX_1 + tileWidth * 1.5,
              child: Container(
                width: tileWidth,
                height: tileHeight,
                child: Image(
                  image: AssetImage(
                    'assets/images/' + boardResources[13] + '.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            //#3
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 3,
              left: offSetX_1 + tileWidth * 2.5,
              child: Container(
                width: tileWidth,
                height: tileHeight,
                child: Image(
                  image: AssetImage(
                    'assets/images/' + boardResources[14] + '.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            //#4
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 3,
              left: offSetX_1 + tileWidth * 3.5,
              child: Container(
                width: tileWidth,
                height: tileHeight,
                child: Image(
                  image: AssetImage(
                    'assets/images/' + boardResources[15] + '.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            //fifth row (from left to right)

            //#1
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 4,
              left: offSetX_1 + tileWidth,
              child: Container(
                width: tileWidth,
                height: tileHeight,
                child: Image(
                  image: AssetImage(
                    'assets/images/' + boardResources[16] + '.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            //#2
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 4,
              left: offSetX_1 + tileWidth * 2,
              child: Container(
                width: tileWidth,
                height: tileHeight,
                child: Image(
                  image: AssetImage(
                    'assets/images/' + boardResources[17] + '.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            //#3
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 4,
              left: offSetX_1 + tileWidth * 3,
              child: Container(
                width: tileWidth,
                height: tileHeight,
                child: Image(
                  image: AssetImage(
                    'assets/images/' + boardResources[18] + '.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            //Numbers

            //random number #1
            Positioned(
              top: offSetY_1 + tileHeight / 4,
              left: offSetX_1 + tileWidth + tileWidth / 4,
              child: Image(
                width: tileWidth / 2,
                height: tileHeight / 2,
                image: AssetImage(
                  'assets/images/' + 'Number' + boardNumbers[0] + '.png',
                ),
              ),
            ),
            //random number #2
            Positioned(
              top: offSetY_1 + tileHeight / 4,
              left: offSetX_1 + tileWidth * 2 + tileWidth / 4,
              child: Image(
                width: tileWidth / 2,
                height: tileHeight / 2,
                image: AssetImage(
                  'assets/images/' + 'Number' + boardNumbers[1] + '.png',
                ),
              ),
            ),
            //random number #3
            Positioned(
              top: offSetY_1 + tileHeight / 4,
              left: offSetX_1 + tileWidth * 3 + tileWidth / 4,
              child: Image(
                width: tileWidth / 2,
                height: tileHeight / 2,
                image: AssetImage(
                  'assets/images/' + 'Number' + boardNumbers[2] + '.png',
                ),
              ),
            ),
            //random number #4
            Positioned(
              top: offSetY_1 + fromOffSetY_1 + tileHeight / 4,
              left: offSetX_1 + tileWidth / 2 + tileWidth / 4,
              child: Image(
                width: tileWidth / 2,
                height: tileHeight / 2,
                image: AssetImage(
                  'assets/images/' + 'Number' + boardNumbers[3] + '.png',
                ),
              ),
            ),
            //random number #5
            Positioned(
              top: offSetY_1 + fromOffSetY_1 + tileHeight / 4,
              left: offSetX_1 + tileWidth * 1.5 + tileWidth / 4,
              child: Image(
                width: tileWidth / 2,
                height: tileHeight / 2,
                image: AssetImage(
                  'assets/images/' + 'Number' + boardNumbers[4] + '.png',
                ),
              ),
            ),
            //random number #6
            Positioned(
              top: offSetY_1 + fromOffSetY_1 + tileHeight / 4,
              left: offSetX_1 + tileWidth * 2.5 + tileWidth / 4,
              child: Image(
                width: tileWidth / 2,
                height: tileHeight / 2,
                image: AssetImage(
                  'assets/images/' + 'Number' + boardNumbers[5] + '.png',
                ),
              ),
            ),
            //random number #7
            Positioned(
              top: offSetY_1 + fromOffSetY_1 + tileHeight / 4,
              left: offSetX_1 + tileWidth * 3.5 + tileWidth / 4,
              child: Image(
                width: tileWidth / 2,
                height: tileHeight / 2,
                image: AssetImage(
                  'assets/images/' + 'Number' + boardNumbers[6] + '.png',
                ),
              ),
            ),
            //random number #8
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 2 + tileHeight / 4,
              left: offSetX_1 + tileWidth / 4,
              child: Image(
                width: tileWidth / 2,
                height: tileHeight / 2,
                image: AssetImage(
                  'assets/images/' + 'Number' + boardNumbers[7] + '.png',
                ),
              ),
            ),
            //random number #9
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 2 + tileHeight / 4,
              left: offSetX_1 + tileWidth / 4 + tileWidth,
              child: Image(
                width: tileWidth / 2,
                height: tileHeight / 2,
                image: AssetImage(
                  'assets/images/' + 'Number' + boardNumbers[8] + '.png',
                ),
              ),
            ),
            //random number #10
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 2 + tileHeight / 4,
              left: offSetX_1 + tileWidth / 4 + tileWidth * 2,
              child: Image(
                width: tileWidth / 2,
                height: tileHeight / 2,
                image: AssetImage(
                  'assets/images/' + 'Number' + boardNumbers[9] + '.png',
                ),
              ),
            ),
            //random number #11
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 2 + tileHeight / 4,
              left: offSetX_1 + tileWidth / 4 + tileWidth * 3,
              child: Image(
                width: tileWidth / 2,
                height: tileHeight / 2,
                image: AssetImage(
                  'assets/images/' + 'Number' + boardNumbers[10] + '.png',
                ),
              ),
            ),
            //random number #12
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 2 + tileHeight / 4,
              left: offSetX_1 + tileWidth / 4 + tileWidth * 4,
              child: Image(
                width: tileWidth / 2,
                height: tileHeight / 2,
                image: AssetImage(
                  'assets/images/' + 'Number' + boardNumbers[11] + '.png',
                ),
              ),
            ),
            //random number #13
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 3 + tileHeight / 4,
              left: offSetX_1 + tileWidth / 2 + tileWidth / 4,
              child: Image(
                width: tileWidth / 2,
                height: tileHeight / 2,
                image: AssetImage(
                  'assets/images/' + 'Number' + boardNumbers[12] + '.png',
                ),
              ),
            ),
            //random number #14
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 3 + tileHeight / 4,
              left: offSetX_1 + tileWidth * 1.5 + tileWidth / 4,
              child: Image(
                width: tileWidth / 2,
                height: tileHeight / 2,
                image: AssetImage(
                  'assets/images/' + 'Number' + boardNumbers[13] + '.png',
                ),
              ),
            ),
            //random number #15
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 3 + tileHeight / 4,
              left: offSetX_1 + tileWidth * 2.5 + tileWidth / 4,
              child: Image(
                width: tileWidth / 2,
                height: tileHeight / 2,
                image: AssetImage(
                  'assets/images/' + 'Number' + boardNumbers[14] + '.png',
                ),
              ),
            ),
            //random number #16
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 3 + tileHeight / 4,
              left: offSetX_1 + tileWidth * 3.5 + tileWidth / 4,
              child: Image(
                width: tileWidth / 2,
                height: tileHeight / 2,
                image: AssetImage(
                  'assets/images/' + 'Number' + boardNumbers[15] + '.png',
                ),
              ),
            ),

            //random number #17
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 4 + tileHeight / 4,
              left: offSetX_1 + tileWidth + tileWidth / 4,
              child: Image(
                width: tileWidth / 2,
                height: tileHeight / 2,
                image: AssetImage(
                  'assets/images/' + 'Number' + boardNumbers[16] + '.png',
                ),
              ),
            ),
            //random number #18
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 4 + tileHeight / 4,
              left: offSetX_1 + tileWidth * 2 + tileWidth / 4,
              child: Image(
                width: tileWidth / 2,
                height: tileHeight / 2,
                image: AssetImage(
                  'assets/images/' + 'Number' + boardNumbers[17] + '.png',
                ),
              ),
            ),
            //random number #19
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 4 + tileHeight / 4,
              left: offSetX_1 + tileWidth * 3 + tileWidth / 4,
              child: Image(
                width: tileWidth / 2,
                height: tileHeight / 2,
                image: AssetImage(
                  'assets/images/' + 'Number' + boardNumbers[18] + '.png',
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.04,
        ),
        AnimatedButton(
          enabled: disableButton ? false : true,
          height: tileHeight,
          width: tileWidth * 3.7,
          color: Colors.green[200] ?? Colors.green,
          shadowDegree: ShadowDegree.dark,
          child: Text(
            "Generate",
            style: TextStyle(
              fontSize: tileWidth * 0.6,
              color: Colors.green[900],
            ),
          ),
          onPressed: () {
            HapticFeedback.mediumImpact();
            setState(() {
              boardResources.shuffle();
              desertIndex = boardResources.indexOf('Desert');
              boardNumbers.shuffle();
              boardNumbers[boardNumbers.indexOf('d')] =
                  boardNumbers[desertIndex];
              boardNumbers[desertIndex] = 'd';
              upsideDownOrNot.shuffle();
            });
          },
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.04,
        ),
        AnimatedButton(
          enabled: disableButton ? false : true,
          height: tileHeight,
          width: tileWidth * 5.5,
          color: Colors.green[200] ?? Colors.green,
          shadowDegree: ShadowDegree.dark,
          child: Text(
            "G E N E R A T E",
            style: TextStyle(
              fontSize: tileWidth * 0.58,
              color: Colors.green[900],
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () async {
            HapticFeedback.mediumImpact();
            disableButton = true;
            for (var i = 0; i < 20; i++) {
              await Future.delayed(
                const Duration(milliseconds: 40),
                () {
                  setState(
                    () {
                      boardResources.shuffle();
                      desertIndex = boardResources.indexOf('Desert');
                      boardNumbers.shuffle();
                      boardNumbers[boardNumbers.indexOf('d')] =
                          boardNumbers[desertIndex];
                      boardNumbers[desertIndex] = 'd';
                      upsideDownOrNot.shuffle();
                    },
                  );
                },
              );
            }
            disableButton = false;
          },
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
