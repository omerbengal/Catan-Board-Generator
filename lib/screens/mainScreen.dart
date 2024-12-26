// import 'package:catan_board_generator/screens/diceScreen.dart';
import 'package:catan_board_generator/screens/dice_screen.dart';
import 'package:catan_board_generator/widgets/expansionBoardScreen.dart';
import 'package:catan_board_generator/widgets/regularBoardScreen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with AutomaticKeepAliveClientMixin<MainScreen> {
  // Holds the index of the current page
  int _currentPageIndex = 0;
  // Controls the page view widget
  final _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  // Holds the pages and their order
  final List<Widget> _pages = [
    RegularBoardScreen(),
    ExpansionBoardScreen(),
    // DiceScreen(),
    DiceScreen(),
  ];
  // Holds the colors of the bottom navigation bar based on the order of the pages
  List<MaterialColor> colors = [
    Colors.blue,
    Colors.red,
    Colors.green,
  ];

  @override
  void dispose() {
    // Dispose of the page controller when the widget is disposed
    _pageController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) {
          // This happnes when we swipe to a new page
          setState(() {
            _currentPageIndex = index;
          });
        },
      ),
      bottomNavigationBar: AnimatedContainer(
        height: MediaQuery.of(context).size.height * 0.11,
        color: colors[_currentPageIndex],
        duration: Duration(
          milliseconds: 500,
        ),
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
                // This happens when we press the home button
                _pageController.animateToPage(
                  0,
                  duration: Duration(
                    milliseconds: 500,
                  ),
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
                // This happens when we press the extension button
                _pageController.animateToPage(
                  1,
                  duration: Duration(
                    milliseconds: 500,
                  ),
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
                // This happens when we press the dice button
                _pageController.animateToPage(
                  2,
                  duration: Duration(
                    milliseconds: 500,
                  ),
                  curve: Curves.ease,
                );
              },
              // no need for iconSize property because we are setting the width of the image in the image.asset widget
              iconSize: MediaQuery.of(context).size.width * 0.13,
            ),
          ],
        ),
      ),
    );
  }
}
