import 'package:catan_board_generator/providers/game_provider.dart';
import 'package:catan_board_generator/screens/mainScreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (_) => GameProvider()..initialize(),
      child: MaterialApp(
        home: MainScreen(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
