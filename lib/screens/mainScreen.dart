import 'package:catan_board_generator/screens/dice_screen.dart';
import 'package:catan_board_generator/screens/expansionBoardScreen.dart';
import 'package:catan_board_generator/screens/regularBoardScreen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with AutomaticKeepAliveClientMixin<MainScreen> {
  int _currentPageIndex = 0;
  final _pageController = PageController(initialPage: 0, keepPage: true);

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.teal[100],
      appBar: AppBar(
        backgroundColor: Colors.teal[300],
        title: Text(
          "Catan Board Generator!",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: PageView(
        controller: _pageController,
        children: [
          RegularBoardScreen(),
          ExpansionBoardScreen(),
          DiceScreen(),
        ],
        onPageChanged: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
      ),
      bottomNavigationBar: AnimatedContainer(
        height: MediaQuery.of(context).size.height * 0.11,
        color: [Colors.blue, Colors.red, Colors.green][_currentPageIndex],
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.home,
                color: _currentPageIndex == 0
                    ? Colors.black
                    : Colors.blueGrey[700],
              ),
              onPressed: () {
                _pageController.animateToPage(
                  0,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
              },
              iconSize: MediaQuery.of(context).size.width * 0.13,
            ),
            IconButton(
              icon: Icon(
                Icons.extension,
                color: _currentPageIndex == 1
                    ? Colors.black
                    : Colors.blueGrey[700],
              ),
              onPressed: () {
                _pageController.animateToPage(
                  1,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
              },
              iconSize: MediaQuery.of(context).size.width * 0.13,
            ),
            IconButton(
              icon: Image.asset(
                'assets/new/diceIcon.png',
                width: MediaQuery.of(context).size.width * 0.13,
                color: _currentPageIndex == 2
                    ? Colors.black
                    : Colors.blueGrey[700],
              ),
              onPressed: () {
                _pageController.animateToPage(
                  2,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
              },
              iconSize: MediaQuery.of(context).size.width * 0.13,
            ),
          ],
        ),
      ),
    );
  }
}
