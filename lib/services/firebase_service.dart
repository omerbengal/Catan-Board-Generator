import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  late final DatabaseReference _database;
  static const String DATABASE_URL =
      'https://catan-board-generator-27696-default-rtdb.europe-west1.firebasedatabase.app';

  FirebaseService() {
    FirebaseDatabase.instance.databaseURL = DATABASE_URL;
    _database = FirebaseDatabase.instance.ref();
  }

  // Future<Map<String, dynamic>?> getSessionRolls(String sessionCode) async {
  //   try {
  //     DataSnapshot snapshot =
  //         await _database.child('sessions/$sessionCode').get();
  //     return snapshot.value as Map<String, dynamic>?;
  //   } catch (e) {
  //     print('Error getting session rolls: $e');
  //     return null;
  //   }
  // }

  Future<void> updateRoll(
      String sessionCode, int roll1Value, int roll2Value) async {
    int rollValue = roll1Value + roll2Value;
    try {
      DatabaseReference ref = _database.child('sessions').child(sessionCode);
      DataSnapshot snapshot = await ref.get();
      if (snapshot.exists) {
        Map<Object?, Object?> snapshotMap =
            snapshot.value as Map<Object?, Object?>;
        Map<Object?, Object?> users =
            snapshotMap['users'] as Map<Object?, Object?>;
        List<dynamic> rolls = snapshotMap['rolls'] as List<dynamic>;
        // chop off the first 2 elements, which are null
        rolls = rolls.sublist(2);
        rolls[rollValue - 2] = rolls[rollValue - 2] + 1;
        Map<String, dynamic> newMap = {
          'rolls': {
            "2": rolls[0],
            "3": rolls[1],
            "4": rolls[2],
            "5": rolls[3],
            "6": rolls[4],
            "7": rolls[5],
            "8": rolls[6],
            "9": rolls[7],
            "10": rolls[8],
            "11": rolls[9],
            "12": rolls[10],
          },
          "last_roll1": roll1Value,
          "last_roll2": roll2Value,
          "users": users,
        };
        await ref.set(newMap);
      }
    } catch (e) {
      print('Error updating roll: $e');
    }
  }

  Future<String?> createSession(String admin, String uid) async {
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
        "last_roll1": 1,
        "last_roll2": 1,
        "users": {
          uid: {"name": admin, "isAdmin": true}
        },
      });
      return newSessionRef.key;
    } catch (e) {
      print('Error creating session: $e');
      return null;
    }
  }

  Future<bool> joinSession(String sessionCode, String name, String uid) async {
    try {
      DatabaseReference ref =
          _database.child('sessions').child(sessionCode).child('users');
      DataSnapshot snapshot = await ref.get();
      if (snapshot.exists) {
        Map<Object?, Object?> users = snapshot.value as Map<Object?, Object?>;
        if (users.containsKey(uid)) {
          return true;
        } else {
          users[uid] = {"name": name, "isAdmin": false};
          await ref.set(users);
          return true;
        }
      }
    } catch (e) {
      print('Error joining session: $e');
      rethrow;
    }
    return false;
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
