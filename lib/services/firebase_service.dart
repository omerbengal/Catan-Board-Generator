import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  late final DatabaseReference _database;
  static const String DATABASE_URL =
      'https://catan-board-generator-27696-default-rtdb.europe-west1.firebasedatabase.app';

  FirebaseService() {
    FirebaseDatabase.instance.databaseURL = DATABASE_URL;
    _database = FirebaseDatabase.instance.ref();
  }

  Future<Map<String, dynamic>?> getSessionRolls(String sessionCode) async {
    try {
      DataSnapshot snapshot =
          await _database.child('sessions/$sessionCode').get();
      return snapshot.value as Map<String, dynamic>?;
    } catch (e) {
      print('Error getting session rolls: $e');
      return null;
    }
  }

  // Future<void> updateRoll(String sessionCode, int rollValue) async {
  //   print(
  //       "Updating roll with session code $sessionCode and roll value $rollValue");
  //   try {
  //     DatabaseReference ref = _database.child('sessions').child(sessionCode);
  //     DataSnapshot snapshot = await ref.get();
  //     print("snapshot.value: ${snapshot.value}");
  //     Map<String, dynamic> rolls = snapshot.value as Map<String, dynamic>;
  //     String key = 'rolls_$rollValue';
  //     rolls.update(key, (value) => value + 1);
  //     await ref.set(rolls);
  //   } catch (e) {
  //     print('Error updating roll: $e');
  //   }
  // }

  //! BELOW WORKING if each session has a map of rolls
  // Future<void> updateRoll(String sessionCode, int rollValue) async {
  //   print(
  //       "Updating roll with session code $sessionCode and roll value $rollValue");
  //   try {
  //     DatabaseReference ref = _database.child('sessions').child(sessionCode);
  //     DataSnapshot snapshot = await ref.get();
  //     print("snapshot.value: ${snapshot.value}");

  //     Map<String, dynamic> rolls =
  //         (snapshot.value as Map<Object?, Object?>).cast<String, dynamic>();
  //     String key = 'rolls_$rollValue';
  //     rolls.update(key, (value) => value + 1);
  //     await ref.set(rolls);
  //   } catch (e) {
  //     print('Error updating roll: $e');
  //   }
  // }

  Future<void> updateRoll(String sessionCode, int rollValue) async {
    try {
      DatabaseReference ref =
          _database.child('sessions').child(sessionCode).child('rolls');
      DataSnapshot snapshot = await ref.get();
      if (snapshot.exists) {
        Map<Object?, Object?> snapshotMap =
            snapshot.value as Map<Object?, Object?>;
        List<dynamic> rolls = snapshotMap['rolls'] as List<dynamic>;
        rolls[rollValue] = rolls[rollValue] + 1;
        await ref.set(rolls);
      }
    } catch (e) {
      print('Error updating roll: $e');
    }
  }

  // Future<String?> createSession() async {
  //   try {
  //     DatabaseReference newSessionRef = _database.child('sessions').push();
  //     await newSessionRef.set({
  //       'rolls_2': 0,
  //       'rolls_3': 0,
  //       'rolls_4': 0,
  //       'rolls_5': 0,
  //       'rolls_6': 0,
  //       'rolls_7': 0,
  //       'rolls_8': 0,
  //       'rolls_9': 0,
  //       'rolls_10': 0,
  //       'rolls_11': 0,
  //       'rolls_12': 0
  //     });
  //     return newSessionRef.key;
  //   } catch (e) {
  //     print('Error creating session: $e');
  //     return null;
  //   }
  // }

  Future<String?> createSession() async {
    try {
      DatabaseReference newSessionRef = _database.child('sessions').push();
      await newSessionRef.set({
        'rolls': {
          "2": 0,
          "3": 0,
          "4": 0,
          "5": 0,
          "6": 0,
          "7": 0,
          "8": 0,
          "9": 0,
          "10": 0,
          "11": 0,
          "12": 0,
        },
      });
      return newSessionRef.key;
    } catch (e) {
      print('Error creating session: $e');
      return null;
    }
  }

  Future<bool> checkIfSessionExists(String sessionCode) async {
    try {
      final ref = _database.child('sessions').child(sessionCode);
      final snapshot = await ref.get();
      return snapshot.exists;
    } catch (e) {
      print('Error checking session: $e');
      rethrow;
    }
  }
}
