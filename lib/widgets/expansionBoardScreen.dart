import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import 'package:animated_button/animated_button.dart';

class ExpansionBoardScreen extends StatefulWidget {
  const ExpansionBoardScreen({Key? key}) : super(key: key);

  @override
  State<ExpansionBoardScreen> createState() => _ExpansionBoardScreenState();
}

class _ExpansionBoardScreenState extends State<ExpansionBoardScreen>
    with AutomaticKeepAliveClientMixin<ExpansionBoardScreen> {
  List<String> boardResources = [
    'Wood',
    'Wood',
    'Wood',
    'Wood',
    'Wood',
    'Wood',
    'Tit',
    'Tit',
    'Tit',
    'Tit',
    'Tit',
    'Ore',
    'Ore',
    'Ore',
    'Ore',
    'Ore',
    'Wheat',
    'Wheat',
    'Wheat',
    'Wheat',
    'Wheat',
    'Wheat',
    'Sheep',
    'Sheep',
    'Sheep',
    'Sheep',
    'Sheep',
    'Sheep',
    'Desert',
    'Desert'
  ];
  List<String> boardNumbers = [
    '2',
    '2',
    '3',
    '3',
    '3',
    '4',
    '4',
    '4',
    '5',
    '5',
    '5',
    '6',
    '6',
    '6',
    '8',
    '8',
    '8',
    '9',
    '9',
    '9',
    '10',
    '10',
    '10',
    '11',
    '11',
    '11',
    '12',
    '12',
    'd',
    'd',
  ];
  List<double> upsideDownOrNot = [0, math.pi];
  bool disableButton = false;
  var desertIndex1;
  var desertIndex2;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var offSetX_1 = MediaQuery.of(context).size.width * 0.1775;
    var offSetY_1 = MediaQuery.of(context).size.width * 0.0775;
    var fromOffSetY_1 = MediaQuery.of(context).size.width * 0.112;
    var tileWidth = MediaQuery.of(context).size.width * 0.12895;
    var tileHeight = 450 * tileWidth / 389;

    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.04,
        ),
        Stack(
          children: [
            Transform.rotate(
              angle: upsideDownOrNot[0].toDouble(),
              child: Image(
                // image: AssetImage('assets/images/fullBoard.png'),
                image: AssetImage(
                  'assets/new/expansionFullBoard.png',
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

            //fourth row (from left to right)

            //#1
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 3,
              left: offSetX_1 - tileWidth / 2,
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
              left: offSetX_1 + tileWidth / 2,
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
              left: offSetX_1 + tileWidth * 1.5,
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
              left: offSetX_1 + tileWidth * 2.5,
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

            //#5
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 3,
              left: offSetX_1 + tileWidth * 3.5,
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

            //#6
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 3,
              left: offSetX_1 + tileWidth * 4.5,
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

            //fifth row (from left to right)

            //#1
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 4,
              left: offSetX_1,
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

            //#2
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 4,
              left: offSetX_1 + tileWidth,
              child: Container(
                width: tileWidth,
                height: tileHeight,
                child: Image(
                  image: AssetImage(
                    'assets/images/' + boardResources[19] + '.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            //#3
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 4,
              left: offSetX_1 + tileWidth * 2,
              child: Container(
                width: tileWidth,
                height: tileHeight,
                child: Image(
                  image: AssetImage(
                    'assets/images/' + boardResources[20] + '.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            //#4
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 4,
              left: offSetX_1 + tileWidth * 3,
              child: Container(
                width: tileWidth,
                height: tileHeight,
                child: Image(
                  image: AssetImage(
                    'assets/images/' + boardResources[21] + '.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            //#5
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 4,
              left: offSetX_1 + tileWidth * 4,
              child: Container(
                width: tileWidth,
                height: tileHeight,
                child: Image(
                  image: AssetImage(
                    'assets/images/' + boardResources[22] + '.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            //sixth row (from left to right)

            //#1
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 5,
              left: offSetX_1 + tileWidth / 2,
              child: Container(
                width: tileWidth,
                height: tileHeight,
                child: Image(
                  image: AssetImage(
                    'assets/images/' + boardResources[23] + '.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            //#2
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 5,
              left: offSetX_1 + tileWidth * 1.5,
              child: Container(
                width: tileWidth,
                height: tileHeight,
                child: Image(
                  image: AssetImage(
                    'assets/images/' + boardResources[24] + '.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            //#3
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 5,
              left: offSetX_1 + tileWidth * 2.5,
              child: Container(
                width: tileWidth,
                height: tileHeight,
                child: Image(
                  image: AssetImage(
                    'assets/images/' + boardResources[25] + '.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            //#4
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 5,
              left: offSetX_1 + tileWidth * 3.5,
              child: Container(
                width: tileWidth,
                height: tileHeight,
                child: Image(
                  image: AssetImage(
                    'assets/images/' + boardResources[26] + '.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            //seventh row (from left to right)

            //#1
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 6,
              left: offSetX_1 + tileWidth,
              child: Container(
                width: tileWidth,
                height: tileHeight,
                child: Image(
                  image: AssetImage(
                    'assets/images/' + boardResources[27] + '.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            //#2
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 6,
              left: offSetX_1 + tileWidth * 2,
              child: Container(
                width: tileWidth,
                height: tileHeight,
                child: Image(
                  image: AssetImage(
                    'assets/images/' + boardResources[28] + '.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            //#3
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 6,
              left: offSetX_1 + tileWidth * 3,
              child: Container(
                width: tileWidth,
                height: tileHeight,
                child: Image(
                  image: AssetImage(
                    'assets/images/' + boardResources[29] + '.png',
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
                    'assets/images/' + 'Number' + boardNumbers[7] + '.png'),
              ),
            ),
            //random number #9
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 2 + tileHeight / 4,
              left: offSetX_1 + tileWidth + tileWidth / 4,
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
              left: offSetX_1 + tileWidth * 2 + tileWidth / 4,
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
              left: offSetX_1 + tileWidth * 3 + tileWidth / 4,
              child: Image(
                width: tileWidth / 2,
                height: tileHeight / 2,
                image: AssetImage(
                    'assets/images/' + 'Number' + boardNumbers[10] + '.png'),
              ),
            ),
            //random number #12
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 2 + tileHeight / 4,
              left: offSetX_1 + tileWidth * 4 + tileWidth / 4,
              child: Image(
                width: tileWidth / 2,
                height: tileHeight / 2,
                image: AssetImage(
                    'assets/images/' + 'Number' + boardNumbers[11] + '.png'),
              ),
            ),
            //random number #13
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 3 + tileHeight / 4,
              left: offSetX_1 - tileWidth / 4,
              child: Image(
                width: tileWidth / 2,
                height: tileHeight / 2,
                image: AssetImage(
                    'assets/images/' + 'Number' + boardNumbers[12] + '.png'),
              ),
            ),
            //random number #14
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 3 + tileHeight / 4,
              left: offSetX_1 + tileWidth / 4 + tileWidth / 2,
              child: Image(
                width: tileWidth / 2,
                height: tileHeight / 2,
                image: AssetImage(
                    'assets/images/' + 'Number' + boardNumbers[13] + '.png'),
              ),
            ),
            //random number #15
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 3 + tileHeight / 4,
              left: offSetX_1 + tileWidth * 1.5 + tileWidth / 4,
              child: Image(
                width: tileWidth / 2,
                height: tileHeight / 2,
                image: AssetImage(
                    'assets/images/' + 'Number' + boardNumbers[14] + '.png'),
              ),
            ),
            //random number #16
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 3 + tileHeight / 4,
              left: offSetX_1 + tileWidth * 2.5 + tileWidth / 4,
              child: Image(
                width: tileWidth / 2,
                height: tileHeight / 2,
                image: AssetImage(
                    'assets/images/' + 'Number' + boardNumbers[15] + '.png'),
              ),
            ),
            //random number #17
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 3 + tileHeight / 4,
              left: offSetX_1 + tileWidth * 3.5 + tileWidth / 4,
              child: Image(
                width: tileWidth / 2,
                height: tileHeight / 2,
                image: AssetImage(
                    'assets/images/' + 'Number' + boardNumbers[16] + '.png'),
              ),
            ),
            //random number #18
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 3 + tileHeight / 4,
              left: offSetX_1 + tileWidth * 4.5 + tileWidth / 4,
              child: Image(
                width: tileWidth / 2,
                height: tileHeight / 2,
                image: AssetImage(
                    'assets/images/' + 'Number' + boardNumbers[17] + '.png'),
              ),
            ),
            //random number #19
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 4 + tileHeight / 4,
              left: offSetX_1 + tileWidth / 2 - tileWidth / 4,
              child: Image(
                width: tileWidth / 2,
                height: tileHeight / 2,
                image: AssetImage(
                    'assets/images/' + 'Number' + boardNumbers[18] + '.png'),
              ),
            ),
            //random number #20
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 4 + tileHeight / 4,
              left: offSetX_1 + tileWidth * 1.5 - tileWidth / 4,
              child: Image(
                width: tileWidth / 2,
                height: tileHeight / 2,
                image: AssetImage(
                    'assets/images/' + 'Number' + boardNumbers[19] + '.png'),
              ),
            ),
            //random number #21
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 4 + tileHeight / 4,
              left: offSetX_1 + tileWidth * 2.5 - tileWidth / 4,
              child: Image(
                width: tileWidth / 2,
                height: tileHeight / 2,
                image: AssetImage(
                    'assets/images/' + 'Number' + boardNumbers[20] + '.png'),
              ),
            ),
            //random number #22
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 4 + tileHeight / 4,
              left: offSetX_1 + tileWidth * 3.5 - tileWidth / 4,
              child: Image(
                width: tileWidth / 2,
                height: tileHeight / 2,
                image: AssetImage(
                    'assets/images/' + 'Number' + boardNumbers[21] + '.png'),
              ),
            ),
            //random number #23
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 4 + tileHeight / 4,
              left: offSetX_1 + tileWidth * 4.5 - tileWidth / 4,
              child: Image(
                width: tileWidth / 2,
                height: tileHeight / 2,
                image: AssetImage(
                    'assets/images/' + 'Number' + boardNumbers[22] + '.png'),
              ),
            ),
            //random number #24
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 5 + tileHeight / 4,
              left: offSetX_1 + tileWidth / 4 + tileWidth / 2,
              child: Image(
                width: tileWidth / 2,
                height: tileHeight / 2,
                image: AssetImage(
                    'assets/images/' + 'Number' + boardNumbers[23] + '.png'),
              ),
            ),
            //random number #25
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 5 + tileHeight / 4,
              left: offSetX_1 + tileWidth * 1.5 + tileWidth / 4,
              child: Image(
                width: tileWidth / 2,
                height: tileHeight / 2,
                image: AssetImage(
                    'assets/images/' + 'Number' + boardNumbers[24] + '.png'),
              ),
            ),
            //random number #26
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 5 + tileHeight / 4,
              left: offSetX_1 + tileWidth * 2.5 + tileWidth / 4,
              child: Image(
                width: tileWidth / 2,
                height: tileHeight / 2,
                image: AssetImage(
                    'assets/images/' + 'Number' + boardNumbers[25] + '.png'),
              ),
            ),
            //random number #27
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 5 + tileHeight / 4,
              left: offSetX_1 + tileWidth * 3.5 + tileWidth / 4,
              child: Image(
                width: tileWidth / 2,
                height: tileHeight / 2,
                image: AssetImage(
                    'assets/images/' + 'Number' + boardNumbers[26] + '.png'),
              ),
            ),
            //random number #28
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 6 + tileHeight / 4,
              left: offSetX_1 + tileWidth * 1.5 - tileWidth / 4,
              child: Image(
                width: tileWidth / 2,
                height: tileHeight / 2,
                image: AssetImage(
                    'assets/images/' + 'Number' + boardNumbers[27] + '.png'),
              ),
            ),
            //random number #29
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 6 + tileHeight / 4,
              left: offSetX_1 + tileWidth * 2.5 - tileWidth / 4,
              child: Image(
                width: tileWidth / 2,
                height: tileHeight / 2,
                image: AssetImage(
                    'assets/images/' + 'Number' + boardNumbers[28] + '.png'),
              ),
            ),
            //random number #30
            Positioned(
              top: offSetY_1 + fromOffSetY_1 * 6 + tileHeight / 4,
              left: offSetX_1 + tileWidth * 3.5 - tileWidth / 4,
              child: Image(
                width: tileWidth / 2,
                height: tileHeight / 2,
                image: AssetImage(
                    'assets/images/' + 'Number' + boardNumbers[29] + '.png'),
              ),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.04,
        ),
        AnimatedButton(
          enabled: !disableButton,
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
              randomize();
            });
          },
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.04,
        ),
        AnimatedButton(
          enabled: !disableButton,
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
            for (var i = 1; i <= 20; i++) {
              await Future.delayed(
                const Duration(milliseconds: 40),
                () {
                  setState(
                    () {
                      if (i == 1) {
                        disableButton = true;
                      }
                      randomize();
                      if (i == 20) {
                        disableButton = false;
                      }
                    },
                  );
                },
              );
            }
          },
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;

  // old (and not working) randomize:
  // void randomize() {
  //   boardResources.shuffle();
  //   desertIndex1 = boardResources.indexOf('Desert');
  //   desertIndex2 = boardResources.lastIndexOf('Desert');
  //   boardNumbers.shuffle();
  //   boardNumbers[boardNumbers.indexOf('d')] = boardNumbers[desertIndex1];
  //   boardNumbers[boardNumbers.lastIndexOf('d')] = boardNumbers[desertIndex2];
  //   boardNumbers[desertIndex1] = 'd';
  //   boardNumbers[desertIndex2] = 'd';
  //   upsideDownOrNot.shuffle();
  // }

  void randomize() {
    boardResources.shuffle();
    desertIndex1 = boardResources.indexOf('Desert');
    desertIndex2 = boardResources.lastIndexOf('Desert');

    // Create a new list of numbers without 'd'
    List<String> tempBoardNumbers = List.from(boardNumbers)
      ..removeWhere((number) => number == 'd');

    // Shuffle the list of numbers
    tempBoardNumbers.shuffle();

    // Insert 'd' at the desert positions
    tempBoardNumbers.insert(desertIndex1, 'd');
    tempBoardNumbers.insert(desertIndex2, 'd');

    // Replace the original boardNumbers with the newly arranged numbers
    boardNumbers = tempBoardNumbers;

    upsideDownOrNot.shuffle();
  }

  // EXPERIMENTAL - start
  void randomizeEvenly() {
    Map<String, int> resourceCount = {};
    for (var resource in boardResources) {
      resourceCount[resource] = (resourceCount[resource] ?? 0) + 1;
    }

    List<List<String>> chunks = [];
    resourceCount.forEach((resource, count) {
      while (count > 0) {
        int take = math.min(2, count); // Take up to 2 of the same resource
        chunks.add(List.filled(take, resource));
        count -= take;
      }
    });

    // Shuffle the chunks
    chunks.shuffle();

    // Merge chunks into a single list while ensuring the constraint
    List<String> shuffledResources = [];
    for (int i = 0; i < chunks.length; i++) {
      shuffledResources.addAll(chunks[i]);
      if (i < chunks.length - 1 && chunks[i].last == chunks[i + 1].first) {
        // Swap the next chunk with a suitable one
        int swapIndex = findSwapIndex(chunks, i);
        if (swapIndex != -1) {
          var temp = chunks[i + 1];
          chunks[i + 1] = chunks[swapIndex];
          chunks[swapIndex] = temp;
        }
      }
    }

    boardResources = shuffledResources;
    // Shuffle numbers and orientation
    randomize();
  }

  int findSwapIndex(List<List<String>> chunks, int currentIndex) {
    String currentEnd = chunks[currentIndex].last;
    for (int i = currentIndex + 2; i < chunks.length; i++) {
      if (chunks[i].first != currentEnd) {
        return i;
      }
    }
    return -1; // No suitable swap found
  }
  // EXPERIMENTAL - end
}
