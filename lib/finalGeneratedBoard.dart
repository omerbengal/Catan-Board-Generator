import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:math' as math;
import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';

class FinalGeneratedBoard extends StatefulWidget {
  @override
  _FinalGeneratedBoardState createState() => _FinalGeneratedBoardState();
}

class _FinalGeneratedBoardState extends State<FinalGeneratedBoard> {


  var boardResources = new List(19);
  var boardNumbers = new List(19);
  var upsideDownOrNot = new List(2);
  bool disableButton = false;
  var desertIndex;

  @override
  void initState() {
    super.initState();
    boardResources = [
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
    boardNumbers = [
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
    upsideDownOrNot = [0, math.pi];
  }

  @override
  Widget build(BuildContext context) {
    var offSetX_1 = MediaQuery.of(context).size.width * 0.126;
    var offSetY_1 = MediaQuery.of(context).size.width * 0.084;
    var fromOffSetY_1 = MediaQuery.of(context).size.width * 0.128;
    var tileWidth = MediaQuery.of(context).size.width * 0.15;
    var tileHeight = 436 * tileWidth / 389;

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);

    return Scaffold(
        backgroundColor: Colors.teal[100],
        appBar: AppBar(
          title: Text(
            "Catan Board Generator!",
            style: TextStyle(fontSize: 30),
          ),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Transform.rotate(
                  angle: upsideDownOrNot[0].toDouble(),
                  child: Image(
                    image: AssetImage('assets/images/fullBoard.png'),
                  ),
                ),

                //first row (from left to right)

                //#1
                Positioned(
                  top: offSetY_1,
                  left: offSetX_1 + tileWidth,
                  child: Image(
                    width: tileWidth,
                    height: tileHeight,
                    image: AssetImage(
                        'assets/images/' + boardResources[0] + '.png'),
                  ),
                ),

                //#2
                Positioned(
                  top: offSetY_1,
                  left: offSetX_1 + tileWidth * 2,
                  child: Image(
                    width: tileWidth,
                    height: tileHeight,
                    image: AssetImage(
                        'assets/images/' + boardResources[1] + '.png'),
                  ),
                ),
                //#3
                Positioned(
                  top: offSetY_1,
                  left: offSetX_1 + tileWidth * 3,
                  child: Image(
                    width: tileWidth,
                    height: tileHeight,
                    image: AssetImage(
                        'assets/images/' + boardResources[2] + '.png'),
                  ),
                ),

                //second row (from left to right)

                //#1
                Positioned(
                  top: offSetY_1 + fromOffSetY_1,
                  left: offSetX_1 + tileWidth / 2,
                  child: Image(
                    width: tileWidth,
                    height: tileHeight,
                    image: AssetImage(
                        'assets/images/' + boardResources[3] + '.png'),
                  ),
                ),
                //#2
                Positioned(
                  top: offSetY_1 + fromOffSetY_1,
                  left: offSetX_1 + tileWidth * 1.5,
                  child: Image(
                    width: tileWidth,
                    height: tileHeight,
                    image: AssetImage(
                        'assets/images/' + boardResources[4] + '.png'),
                  ),
                ),
                //#3
                Positioned(
                  top: offSetY_1 + fromOffSetY_1,
                  left: offSetX_1 + tileWidth * 2.5,
                  child: Image(
                    width: tileWidth,
                    height: tileHeight,
                    image: AssetImage(
                        'assets/images/' + boardResources[5] + '.png'),
                  ),
                ),
                //#4
                Positioned(
                  top: offSetY_1 + fromOffSetY_1,
                  left: offSetX_1 + tileWidth * 3.5,
                  child: Image(
                    width: tileWidth,
                    height: tileHeight,
                    image: AssetImage(
                        'assets/images/' + boardResources[6] + '.png'),
                  ),
                ),

                //third row (from left to right)

                //#1
                Positioned(
                  top: offSetY_1 + fromOffSetY_1 * 2,
                  left: offSetX_1,
                  child: Image(
                    width: tileWidth,
                    height: tileHeight,
                    image: AssetImage(
                        'assets/images/' + boardResources[7] + '.png'),
                  ),
                ),
                //#2
                Positioned(
                  top: offSetY_1 + fromOffSetY_1 * 2,
                  left: offSetX_1 + tileWidth,
                  child: Image(
                    width: tileWidth,
                    height: tileHeight,
                    image: AssetImage(
                        'assets/images/' + boardResources[8] + '.png'),
                  ),
                ),
                //#3
                Positioned(
                  top: offSetY_1 + fromOffSetY_1 * 2,
                  left: offSetX_1 + tileWidth * 2,
                  child: Image(
                    width: tileWidth,
                    height: tileHeight,
                    image: AssetImage(
                        'assets/images/' + boardResources[9] + '.png'),
                  ),
                ),
                //#4
                Positioned(
                  top: offSetY_1 + fromOffSetY_1 * 2,
                  left: offSetX_1 + tileWidth * 3,
                  child: Image(
                    width: tileWidth,
                    height: tileHeight,
                    image: AssetImage(
                        'assets/images/' + boardResources[10] + '.png'),
                  ),
                ),
                //#5
                Positioned(
                  top: offSetY_1 + fromOffSetY_1 * 2,
                  left: offSetX_1 + tileWidth * 4,
                  child: Image(
                    width: tileWidth,
                    height: tileHeight,
                    image: AssetImage(
                        'assets/images/' + boardResources[11] + '.png'),
                  ),
                ),

                //forth row (from left to right)

                //#1
                Positioned(
                  top: offSetY_1 + fromOffSetY_1 * 3,
                  left: offSetX_1 + tileWidth / 2,
                  child: Image(
                    width: tileWidth,
                    height: tileHeight,
                    image: AssetImage(
                        'assets/images/' + boardResources[12] + '.png'),
                  ),
                ),
                //#2
                Positioned(
                  top: offSetY_1 + fromOffSetY_1 * 3,
                  left: offSetX_1 + tileWidth * 1.5,
                  child: Image(
                    width: tileWidth,
                    height: tileHeight,
                    image: AssetImage(
                        'assets/images/' + boardResources[13] + '.png'),
                  ),
                ),
                //#3
                Positioned(
                  top: offSetY_1 + fromOffSetY_1 * 3,
                  left: offSetX_1 + tileWidth * 2.5,
                  child: Image(
                    width: tileWidth,
                    height: tileHeight,
                    image: AssetImage(
                        'assets/images/' + boardResources[14] + '.png'),
                  ),
                ),
                //#4
                Positioned(
                  top: offSetY_1 + fromOffSetY_1 * 3,
                  left: offSetX_1 + tileWidth * 3.5,
                  child: Image(
                    width: tileWidth,
                    height: tileHeight,
                    image: AssetImage(
                        'assets/images/' + boardResources[15] + '.png'),
                  ),
                ),

                //fifth row (from left to right)

                //#1
                Positioned(
                  top: offSetY_1 + fromOffSetY_1 * 4,
                  left: offSetX_1 + tileWidth,
                  child: Image(
                    width: tileWidth,
                    height: tileHeight,
                    image: AssetImage(
                        'assets/images/' + boardResources[16] + '.png'),
                  ),
                ),
                //#2
                Positioned(
                  top: offSetY_1 + fromOffSetY_1 * 4,
                  left: offSetX_1 + tileWidth * 2,
                  child: Image(
                    width: tileWidth,
                    height: tileHeight,
                    image: AssetImage(
                        'assets/images/' + boardResources[17] + '.png'),
                  ),
                ),
                //#3
                Positioned(
                  top: offSetY_1 + fromOffSetY_1 * 4,
                  left: offSetX_1 + tileWidth * 3,
                  child: Image(
                    width: tileWidth,
                    height: tileHeight,
                    image: AssetImage(
                        'assets/images/' + boardResources[18] + '.png'),
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
                        'assets/images/' + 'Number' + boardNumbers[0] + '.png'),
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
                        'assets/images/' + 'Number' + boardNumbers[1] + '.png'),
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
                        'assets/images/' + 'Number' + boardNumbers[2] + '.png'),
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
                        'assets/images/' + 'Number' + boardNumbers[3] + '.png'),
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
                        'assets/images/' + 'Number' + boardNumbers[4] + '.png'),
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
                        'assets/images/' + 'Number' + boardNumbers[5] + '.png'),
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
                        'assets/images/' + 'Number' + boardNumbers[6] + '.png'),
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
                        'assets/images/' + 'Number' + boardNumbers[7] + '.png'),
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
                        'assets/images/' + 'Number' + boardNumbers[8] + '.png'),
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
                        'assets/images/' + 'Number' + boardNumbers[9] + '.png'),
                  ),
                ),
                //random number #11
                Positioned(
                  top: offSetY_1 + fromOffSetY_1 * 2 + tileHeight / 4,
                  left: offSetX_1 + tileWidth / 4 + tileWidth * 3,
                  child: Image(
                    width: tileWidth / 2,
                    height: tileHeight / 2,
                    image: AssetImage('assets/images/' +
                        'Number' +
                        boardNumbers[10] +
                        '.png'),
                  ),
                ),
                //random number #12
                Positioned(
                  top: offSetY_1 + fromOffSetY_1 * 2 + tileHeight / 4,
                  left: offSetX_1 + tileWidth / 4 + tileWidth * 4,
                  child: Image(
                    width: tileWidth / 2,
                    height: tileHeight / 2,
                    image: AssetImage('assets/images/' +
                        'Number' +
                        boardNumbers[11] +
                        '.png'),
                  ),
                ),
                //random number #13
                Positioned(
                  top: offSetY_1 + fromOffSetY_1 * 3 + tileHeight / 4,
                  left: offSetX_1 + tileWidth / 2 + tileWidth / 4,
                  child: Image(
                    width: tileWidth / 2,
                    height: tileHeight / 2,
                    image: AssetImage('assets/images/' +
                        'Number' +
                        boardNumbers[12] +
                        '.png'),
                  ),
                ),
                //random number #14
                Positioned(
                  top: offSetY_1 + fromOffSetY_1 * 3 + tileHeight / 4,
                  left: offSetX_1 + tileWidth * 1.5 + tileWidth / 4,
                  child: Image(
                    width: tileWidth / 2,
                    height: tileHeight / 2,
                    image: AssetImage('assets/images/' +
                        'Number' +
                        boardNumbers[13] +
                        '.png'),
                  ),
                ),
                //random number #15
                Positioned(
                  top: offSetY_1 + fromOffSetY_1 * 3 + tileHeight / 4,
                  left: offSetX_1 + tileWidth * 2.5 + tileWidth / 4,
                  child: Image(
                    width: tileWidth / 2,
                    height: tileHeight / 2,
                    image: AssetImage('assets/images/' +
                        'Number' +
                        boardNumbers[14] +
                        '.png'),
                  ),
                ),
                //random number #16
                Positioned(
                  top: offSetY_1 + fromOffSetY_1 * 3 + tileHeight / 4,
                  left: offSetX_1 + tileWidth * 3.5 + tileWidth / 4,
                  child: Image(
                    width: tileWidth / 2,
                    height: tileHeight / 2,
                    image: AssetImage('assets/images/' +
                        'Number' +
                        boardNumbers[15] +
                        '.png'),
                  ),
                ),

                //random number #17
                Positioned(
                  top: offSetY_1 + fromOffSetY_1 * 4 + tileHeight / 4,
                  left: offSetX_1 + tileWidth + tileWidth / 4,
                  child: Image(
                    width: tileWidth / 2,
                    height: tileHeight / 2,
                    image: AssetImage('assets/images/' +
                        'Number' +
                        boardNumbers[16] +
                        '.png'),
                  ),
                ),
                //random number #18
                Positioned(
                  top: offSetY_1 + fromOffSetY_1 * 4 + tileHeight / 4,
                  left: offSetX_1 + tileWidth * 2 + tileWidth / 4,
                  child: Image(
                    width: tileWidth / 2,
                    height: tileHeight / 2,
                    image: AssetImage('assets/images/' +
                        'Number' +
                        boardNumbers[17] +
                        '.png'),
                  ),
                ),
                //random number #19
                Positioned(
                  top: offSetY_1 + fromOffSetY_1 * 4 + tileHeight / 4,
                  left: offSetX_1 + tileWidth * 3 + tileWidth / 4,
                  child: Image(
                    width: tileWidth / 2,
                    height: tileHeight / 2,
                    image: AssetImage('assets/images/' +
                        'Number' +
                        boardNumbers[18] +
                        '.png'),
                  ),
                ),
              ],
            ),
            AnimatedButton(
              enabled: disableButton ? false : true,
              height: tileHeight,
              width: tileWidth * 3.7,
              color: Colors.green[200],
              shadowDegree: ShadowDegree.dark,
              child: Text(
                "generate",
                style: TextStyle(
                    fontSize: tileWidth * 0.6, color: Colors.green[900]),
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
            AnimatedButton(
              enabled: disableButton ? false : true,
              height: tileHeight,
              width: tileWidth * 5.5,
              color: Colors.green[200],
              shadowDegree: ShadowDegree.dark,
              child: Text(
                "G E N E R A T E",
                style: TextStyle(
                    fontSize: tileWidth * 0.58, color: Colors.green[900]),
              ),
              onPressed: () async {
                HapticFeedback.mediumImpact();
                disableButton = true;
                for (var i = 0; i < 15; i++) {
                  await Future.delayed(
                      const Duration(milliseconds: 40), () {
                    setState(() {
                      sleep(Duration(milliseconds: 20));
                      boardResources.shuffle();
                      desertIndex = boardResources.indexOf('Desert');
                      boardNumbers.shuffle();
                      boardNumbers[boardNumbers.indexOf('d')] =
                      boardNumbers[desertIndex];
                      boardNumbers[desertIndex] = 'd';
                      upsideDownOrNot.shuffle();
                    });
                  });
                }
                disableButton = false;
              },
            ),

          ],
        ));
  }
}
