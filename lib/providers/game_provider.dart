import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:catan_board_generator/services/firebase_service.dart';
import 'package:catan_board_generator/utils/id_generator.dart';

class GameProvider with ChangeNotifier {
  String? _sessionCode;
  String? _playerUid;
  int _currentTurnNumber = 0;
  int _lastRoll1 = 1;
  int _lastRoll2 = 1;
  List<Map<String, dynamic>> _usersList = [];

  String? get sessionCode => _sessionCode;
  String? get playerUid => _playerUid;
  int get currentTurnNumber => _currentTurnNumber;
  int get lastRoll1 => _lastRoll1;
  int get lastRoll2 => _lastRoll2;
  List<Map<String, dynamic>> get usersList => _usersList;
  // set user list
  set usersList(List<Map<String, dynamic>> value) {
    _usersList = value;
    notifyListeners();
  }

  void initialize() {
    _sessionCode = null;
    _playerUid = null;
    _currentTurnNumber = 0;
    _lastRoll1 = 1; // Changed from 0 to 1
    _lastRoll2 = 1; // Changed from 0 to 1
    _usersList = [];
    notifyListeners();
  }

  Future<void> createSession(String adminName) async {
    String uid = IdGenerator.generateUniqueId();
    _playerUid = uid;
    final code = await FirebaseService().createSession(adminName, uid);
    _sessionCode = code;
    _loadSessionData();
    notifyListeners();
  }

  Future<void> joinSession(String code, String name) async {
    String uid = IdGenerator.generateUniqueId();
    _playerUid = uid;
    final joined = await FirebaseService().joinSession(code, name, uid);
    if (joined) {
      _sessionCode = code;
      _loadSessionData();
      notifyListeners();
    } else {
      throw Exception('Session does not exist');
    }
  }

  Future<List<int>> rollDice() async {
    final random = Random();
    final roll1 = random.nextInt(6) + 1;
    final roll2 = random.nextInt(6) + 1;
    if (_sessionCode != null) {
      await FirebaseService().updateRoll(_sessionCode!, roll1, roll2);
      if (_currentTurnNumber != 0) {
        await FirebaseService().increaseCurrentTurn(_sessionCode!);
      }
    }
    _lastRoll1 = roll1;
    _lastRoll2 = roll2;
    notifyListeners();
    return [roll1, roll2];
  }

  void _loadSessionData() {
    if (_sessionCode != null) {
      DatabaseReference ref =
          FirebaseDatabase.instance.ref('sessions/$sessionCode');

      ref.onValue.listen((event) {
        final data = event.snapshot.value as Map<dynamic, dynamic>?;
        if (data != null) {
          _currentTurnNumber = data['current_turn_number'];
          _lastRoll1 = data['last_roll1'];
          _lastRoll2 = data['last_roll2'];
          _usersList = [];
          if (data['users'] != null) {
            (data['users'] as Map<dynamic, dynamic>).forEach((key, value) {
              _usersList.add({
                'uid': value['uid'],
                'name': value['name'],
                'turn_number': value['turn_number'],
                'is_admin': value['is_admin'],
              });
            });
            _usersList
                .sort((a, b) => a['turn_number'].compareTo(b['turn_number']));
            if (_currentTurnNumber > 0) {
              final currentTurnIndex = _usersList.indexWhere(
                  (user) => user['turn_number'] == _currentTurnNumber);
              if (currentTurnIndex != -1) {
                final firstPart = _usersList.sublist(currentTurnIndex);
                final secondPart = _usersList.sublist(0, currentTurnIndex);
                _usersList = [...firstPart, ...secondPart];
              }
            }
          }
          notifyListeners();
        }
      });
      //   Map<dynamic, dynamic>? data =
      //       await FirebaseService().getSessionData(_sessionCode!);
      //   if (data != null) {
      //     _currentTurnNumber = data['current_turn_number'];
      //     _lastRoll1 = data['last_roll1'];
      //     _lastRoll2 = data['last_roll2'];
      //     _usersList = [];
      //     if (data['users'] != null) {
      //       (data['users'] as Map<dynamic, dynamic>).forEach((key, value) {
      //         _usersList.add({
      //           'uid': value['uid'],
      //           'name': value['name'],
      //           'turn_number': value['turn_number'],
      //           'is_admin': value['is_admin'],
      //         });
      //       });
      //       _usersList
      //           .sort((a, b) => a['turn_number'].compareTo(b['turn_number']));
      //     }
      //     notifyListeners();
      //   }
      // }
    }
  }

  void updateUserName(String newName) async {
    if (_sessionCode != null && _playerUid != null) {
      await FirebaseService()
          .changeUserName(_sessionCode!, _playerUid!, newName);
      notifyListeners();
    }
  }

  void reorderUsers(int oldIndex, int newIndex) {
    if (oldIndex < _usersList.length && newIndex < _usersList.length) {
      final item = _usersList.removeAt(oldIndex);
      _usersList.insert(newIndex, item);
      notifyListeners();
    }
  }
}
