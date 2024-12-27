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
        List<dynamic> rolls = snapshotMap['rolls'] as List<dynamic>;
        // chop off the first 2 elements, which are null
        rolls = rolls.sublist(2);
        rolls[rollValue - 2] = rolls[rollValue - 2] + 1;
        await ref.update({
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
        });
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
          uid: {"name": admin, "is_admin": true, "turn_number": 1},
        },
        "current_turn_number": 1,
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
          int maxTurnNumber = 0;
          for (var user in users.values) {
            var userMap = user as Map<Object?, Object?>;
            if (userMap['turn_number'] as int > maxTurnNumber) {
              maxTurnNumber = userMap['turn_number'] as int;
            }
          }
          users[uid] = {
            "name": name,
            "is_admin": false,
            "turn_number": maxTurnNumber + 1
          };
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

  Future<int> blockCurrentTurnForASecond(String sessionCode) async {
    try {
      DatabaseReference ref = _database.child('sessions').child(sessionCode);
      DataSnapshot snapshot = await ref.get();
      if (snapshot.exists) {
        Map<Object?, Object?> snapshotMap =
            snapshot.value as Map<Object?, Object?>;
        int currentTurnNumber = snapshotMap['current_turn_number'] as int;
        await ref.update({'current_turn_number': -1});
        return currentTurnNumber;
      }
    } catch (e) {
      print('Error blocking current turn: $e');
    }
    return 0;
  }

  Future<void> increaseCurrentTurn(
      String sessionCode, int turnBeforeBlocking) async {
    try {
      DatabaseReference ref = _database.child('sessions').child(sessionCode);
      DataSnapshot snapshot = await ref.get();
      if (snapshot.exists) {
        Map<Object?, Object?> snapshotMap =
            snapshot.value as Map<Object?, Object?>;
        int numOfUsers = (snapshotMap['users'] as Map<Object?, Object?>).length;
        int currentTurnNumber = turnBeforeBlocking;
        int nextTurnNumber = (currentTurnNumber % numOfUsers) + 1;
        await ref.update({'current_turn_number': nextTurnNumber});
      }
    } catch (e) {
      print('Error updating current turn: $e');
    }
  }

  Future<void> byeByeUser(String sessionCode, String uid) async {
    print("bye bye user");
    try {
      DatabaseReference ref =
          _database.child('sessions').child(sessionCode).child('users');
      DataSnapshot snapshot = await ref.get();
      if (snapshot.exists) {
        Map<Object?, Object?> users = snapshot.value as Map<Object?, Object?>;
        Map<Object?, Object?> byeUserMap = users[uid] as Map<Object?, Object?>;
        if (byeUserMap['is_admin'] as bool) {
          print("bye admin");
          await byeByeAdmin(sessionCode);
        } else {
          print("bye not admin");
          await byebyeNotAdmin(sessionCode, uid);
        }
      }
    } catch (e) {
      print('Error removing user: $e');
    }
  }

  Future<void> byeByeAdmin(String sessionCode) async {
    try {
      DatabaseReference ref =
          _database.child('sessions').child(sessionCode).child('users');
      DataSnapshot snapshot = await ref.get();
      if (snapshot.exists) {
        Map<Object?, Object?> users = snapshot.value as Map<Object?, Object?>;
        for (var user in users.entries) {
          var userMap = user.value as Map<Object?, Object?>;
          String userKey = user.key as String;
          // delete user with turn 0,
          if (userMap['turn_number'] as int == 0) {
            users.remove(userKey);
          } else {
            // update the turn numbers of the other users
            // set the new admin to the user with turn 1
            users[userKey] = <String, dynamic>{
              "name": userMap['name'] as String,
              "is_admin": userMap['turn_number'] as int == 1,
              "turn_number": (userMap['turn_number'] as int) - 1
            };
          }
        }
        await ref.set(users);
      }
    } catch (e) {
      print('Error passing admin: $e');
    }
  }

  Future<void> byebyeNotAdmin(String sessionCode, String uid) async {
    try {
      DatabaseReference ref =
          _database.child('sessions').child(sessionCode).child('users');
      DataSnapshot snapshot = await ref.get();
      if (snapshot.exists) {
        Map<Object?, Object?> users = snapshot.value as Map<Object?, Object?>;
        Map<Object?, Object?> byeUserMap = users[uid] as Map<Object?, Object?>;
        int leavingUserTurnNumber = byeUserMap['turn_number'] as int;
        users.remove(uid);
        // update the turn numbers of the other users that are higher than the user that is leaving
        for (var user in users.entries) {
          var userMap = user.value as Map<Object?, Object?>;
          if (userMap['turn_number'] as int > leavingUserTurnNumber) {
            users[user.key] = <String, dynamic>{
              "name": userMap['name'] as String,
              "is_admin": userMap['is_admin'] as bool,
              "turn_number": (userMap['turn_number'] as int) - 1
            };
          }
        }
      }
    } catch (e) {
      print('Error removing user: $e');
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
