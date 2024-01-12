import 'package:catan_board_generator/widgets/expansionBoardAndButtons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExpansionBoardScreen extends StatelessWidget {
  const ExpansionBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      backgroundColor: Colors.teal[100],
      appBar: AppBar(
        backgroundColor: Colors.teal[300],
        title: Text(
          "Catan Board Generator!",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ExpansionBoardAndButtons(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.teal[300],
        height: MediaQuery.of(context).size.height * 0.08,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
              iconSize: 40,
            ),
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              iconSize: 40,
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                Navigator.pushNamed(context, '/finalGeneratedBoard');
              },
              iconSize: 40,
            ),
          ],
        ),
      ),
    );
  }
}
