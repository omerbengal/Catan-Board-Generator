import 'individualBar.dart';

class BarData {
  final int oneAmount;
  final int twoAmount;
  final int threeAmount;
  final int fourAmount;
  final int fiveAmount;
  final int sixAmount;
  final int sevenAmount;
  final int eightAmount;
  final int nineAmount;
  final int tenAmount;
  final int elevenAmount;
  final int twelveAmount;

  BarData({
    required this.oneAmount,
    required this.twoAmount,
    required this.threeAmount,
    required this.fourAmount,
    required this.fiveAmount,
    required this.sixAmount,
    required this.sevenAmount,
    required this.eightAmount,
    required this.nineAmount,
    required this.tenAmount,
    required this.elevenAmount,
    required this.twelveAmount,
  });

  List<IndividualBar> barData = [];

  // intialize the barData
  void intializeBarData() {
    barData = [
      IndividualBar(x: 1, y: oneAmount),
      IndividualBar(x: 2, y: twoAmount),
      IndividualBar(x: 3, y: threeAmount),
      IndividualBar(x: 4, y: fourAmount),
      IndividualBar(x: 5, y: fiveAmount),
      IndividualBar(x: 6, y: sixAmount),
      IndividualBar(x: 7, y: sevenAmount),
      IndividualBar(x: 8, y: eightAmount),
      IndividualBar(x: 9, y: nineAmount),
      IndividualBar(x: 10, y: tenAmount),
      IndividualBar(x: 11, y: elevenAmount),
      IndividualBar(x: 12, y: twelveAmount),
    ];
  }
}
