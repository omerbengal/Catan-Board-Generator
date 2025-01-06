import 'package:uuid/uuid.dart';

class IdGenerator {
  static final _uuid = Uuid();

  /// Generates a unique UUID v4 string
  static String generateUniqueId() {
    try {
      return _uuid.v4();
    } catch (e) {
      throw Exception('Failed to generate unique ID: $e');
    }
  }
}
