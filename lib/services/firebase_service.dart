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

  Future<void> updateRoll(String sessionCode, int rollValue) async {
    try {
      DatabaseReference ref = _database
          .child('sessions')
          .child(sessionCode)
          .child(rollValue.toString());
      DataSnapshot snapshot = await ref.get();
      int currentCount = (snapshot.value ?? 0) as int;
      print('Current count: $currentCount');
      await ref.set(currentCount + 1);
    } catch (e) {
      print('Error updating roll: $e');
    }
  }

  Future<String?> createSession() async {
    try {
      DatabaseReference newSessionRef = _database.child('sessions').push();
      await newSessionRef.set({
        '2': 0,
        '3': 0,
        '4': 0,
        '5': 0,
        '6': 0,
        '7': 0,
        '8': 0,
        '9': 0,
        '10': 0,
        '11': 0,
        '12': 0
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
