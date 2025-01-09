import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  late final FirebaseDatabase _database;
  static const String DATABASE_URL =
      'https://catan-board-generator-27696-default-rtdb.europe-west1.firebasedatabase.app';

  FirebaseService() {
    // FirebaseDatabase.instance.databaseURL = DATABASE_URL;
    _database = FirebaseDatabase.instance;
  }

  Future<Map<String, dynamic>?> getSessionData(String sessionCode) async {
    try {
      DatabaseReference ref = _database.ref('sessions/$sessionCode');
      DatabaseEvent event = await ref.once();
      if (event.snapshot.value != null) {
        return Map<String, dynamic>.from(event.snapshot.value as Map);
      }
    } catch (e) {
      print('Error getting session data: $e');
    }
    return null;
  }

  Future<void> updateRoll(
      String sessionCode, int roll1Value, int roll2Value) async {
    int rollValue = roll1Value + roll2Value;
    try {
      DatabaseReference ref = _database.ref('sessions/$sessionCode');
      DatabaseEvent event = await ref.once();
      if (event.snapshot.value != null) {
        Map<Object?, Object?> snapshotMap =
            event.snapshot.value as Map<Object?, Object?>;
        List<dynamic> rolls = snapshotMap['rolls'] as List<dynamic>;
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

  Future<String?> createSession(String admin_name, String uid) async {
    try {
      DatabaseReference newSessionRef =
          _database.ref().child('sessions').push();
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
          uid: {
            "uid": uid,
            "name": admin_name,
            "is_admin": true,
            "turn_number": 1
          },
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
      DatabaseReference ref = _database.ref('sessions/$sessionCode/users');
      DatabaseEvent event = await ref.once();
      if (event.snapshot.value != null) {
        Map<Object?, Object?> users =
            event.snapshot.value as Map<Object?, Object?>;
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
            "uid": uid,
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

  Future<void> increaseCurrentTurn(String sessionCode) async {
    try {
      DatabaseReference ref = _database.ref('sessions/$sessionCode');
      DatabaseEvent event = await ref.once();
      if (event.snapshot.value != null) {
        Map<Object?, Object?> snapshotMap =
            event.snapshot.value as Map<Object?, Object?>;
        int numOfUsers = (snapshotMap['users'] as Map<Object?, Object?>).length;
        int currentTurnNumber = snapshotMap['current_turn_number'] as int;
        int nextTurnNumber = (currentTurnNumber % numOfUsers) + 1;
        await ref.update({'current_turn_number': nextTurnNumber});
      }
    } catch (e) {
      print('Error updating current turn: $e');
    }
  }

  Future<void> updateUserTurnNumber(
      String sessionCode, String uid, int newTurnNumber) async {
    try {
      DatabaseReference ref = _database.ref('sessions/$sessionCode/users/$uid');
      DatabaseEvent event = await ref.once();
      if (event.snapshot.value != null) {
        await ref.update({'turn_number': newTurnNumber});
      }
    } catch (e) {
      print('Error updating user turn number: $e');
    }
  }

  // Future<void> byeByeUser(String sessionCode, String uid) async {
  //   print("bye bye user");
  //   try {
  //     DatabaseReference ref =
  //         _database.child('sessions').child(sessionCode).child('users');
  //     DataSnapshot snapshot = await ref.get();
  //     if (snapshot.exists) {
  //       Map<Object?, Object?> users = snapshot.value as Map<Object?, Object?>;
  //       Map<Object?, Object?> byeUserMap = users[uid] as Map<Object?, Object?>;
  //       if (byeUserMap['is_admin'] as bool) {
  //         print("bye admin");
  //         await byeByeAdmin(sessionCode);
  //       } else {
  //         print("bye not admin");
  //         await byebyeNotAdmin(sessionCode, uid);
  //       }
  //     }
  //   } catch (e) {
  //     print('Error removing user: $e');
  //   }
  // }

  // Future<void> byeByeAdmin(String sessionCode) async {
  //   try {
  //     DatabaseReference ref =
  //         _database.child('sessions').child(sessionCode).child('users');
  //     DataSnapshot snapshot = await ref.get();
  //     if (snapshot.exists) {
  //       Map<Object?, Object?> users = snapshot.value as Map<Object?, Object?>;
  //       for (var user in users.entries) {
  //         var userMap = user.value as Map<Object?, Object?>;
  //         String userKey = user.key as String;
  //         // delete user with turn 0,
  //         if (userMap['turn_number'] as int == 0) {
  //           users.remove(userKey);
  //         } else {
  //           // update the turn numbers of the other users
  //           // set the new admin to the user with turn 1
  //           users[userKey] = <String, dynamic>{
  //             "name": userMap['name'] as String,
  //             "is_admin": userMap['turn_number'] as int == 1,
  //             "turn_number": (userMap['turn_number'] as int) - 1
  //           };
  //         }
  //       }
  //       await ref.set(users);
  //     }
  //   } catch (e) {
  //     print('Error passing admin: $e');
  //   }
  // }

  // Future<void> byebyeNotAdmin(String sessionCode, String uid) async {
  //   try {
  //     DatabaseReference ref =
  //         _database.child('sessions').child(sessionCode).child('users');
  //     DataSnapshot snapshot = await ref.get();
  //     if (snapshot.exists) {
  //       Map<Object?, Object?> users = snapshot.value as Map<Object?, Object?>;
  //       Map<Object?, Object?> byeUserMap = users[uid] as Map<Object?, Object?>;
  //       int leavingUserTurnNumber = byeUserMap['turn_number'] as int;
  //       users.remove(uid);
  //       // update the turn numbers of the other users that are higher than the user that is leaving
  //       for (var user in users.entries) {
  //         var userMap = user.value as Map<Object?, Object?>;
  //         if (userMap['turn_number'] as int > leavingUserTurnNumber) {
  //           users[user.key] = <String, dynamic>{
  //             "name": userMap['name'] as String,
  //             "is_admin": userMap['is_admin'] as bool,
  //             "turn_number": (userMap['turn_number'] as int) - 1
  //           };
  //         }
  //       }
  //     }
  //   } catch (e) {
  //     print('Error removing user: $e');
  //   }
  // }

  // Future<bool> checkIfSessionExists(String sessionCode) async {
  //   try {
  //     final ref = _database.child('sessions').child(sessionCode);
  //     final snapshot = await ref.get();
  //     return snapshot.exists;
  //   } catch (e) {
  //     print('Error checking session: $e');
  //     rethrow;
  //   }
  // }

  Future<void> changeUserName(
      String sessionCode, String uid, String newName) async {
    try {
      DatabaseReference userRef = FirebaseDatabase.instance
          .ref('sessions/$sessionCode/users/$uid/name');
      // DatabaseEvent event = await userRef.once();
      // Update only the name
      await userRef.set(newName);
    } catch (e) {
      print('Error changing user name: $e');
    }
  }

  Future<void> updateTurnOrder(
      String sessionCode, List<Map<dynamic, dynamic>> newOrderList) async {
    try {
      // DatabaseReference ref =
      //     _database.child('sessions').child(sessionCode).child('users');
      // DataSnapshot snapshot = await ref.get();
      DatabaseReference ref = _database.ref('sessions/$sessionCode/users');
      DatabaseEvent event = await ref.once();
      if (event.snapshot.value != null) {
        // Map<Object?, Object?> session = snapshot.value as Map<Object?, Object?>;
        // // weirdly enough, only on mobile, the snapshot.value is the map of the entire session instead of the users... even though we're getting the users ref
        // // so we have to get the users map from the session map IF WE ARE ON MOBILE ⬇︎

        // Map<Object?, Object?> users;

        // // check if "users" is a key in the session map
        // if (session.containsKey('users')) {
        //   users = session['users'] as Map<Object?, Object?>;
        // } else {
        //   // if it's not, we're on web, so we can just use the session map as the users map
        //   users = session;
        // }

        Map<Object?, Object?> users =
            event.snapshot.value as Map<Object?, Object?>;

        for (int i = 0; i < newOrderList.length; i++) {
          String uid = newOrderList[i]['uid'] as String;
          Map<Object?, Object?> user = users[uid] as Map<Object?, Object?>;
          user['turn_number'] = i + 1;

          users[uid] = user;
        }
        await ref.set(users);
      }
    } catch (e) {
      print('Error updating turn order: $e');
    }
  }
}
