import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GetStorage _box = GetStorage();
  static const String _tokenKey = 'auth_token';
  static const String _userIdKey = 'user_id';

  static Future<void> init() async {
    // GetStorage.init() is now called in main.dart
  }

  static Future<void> saveToken(String token) async {
    await _box.write(_tokenKey, token);
  }

  static Future<void> saveUserId(String userId) async {
    await _box.write(_userIdKey, userId);
  }

  static String? getToken() {
    return _box.read<String>(_tokenKey);
  }

  static String? getUserId() {
    return _box.read<String>(_userIdKey);
  }

  static bool hasToken() {
    return _box.hasData(_tokenKey);
  }

  static Future<void> clearToken() async {
    await _box.remove(_tokenKey);
    await _box.remove(_userIdKey);
  }
  static Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = userCredential.user;
      if (user != null) {
        final String? token = await user.getIdToken();
        await saveToken(token!);
        await saveUserId(user.uid);
      } else {
        throw Exception('User is null after sign in.');
      }

      return userCredential;
    } catch (e) {
      print('Unexpected sign-in error: $e');
      rethrow;
    }
  }

  static Future<UserCredential> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = userCredential.user;
      if (user != null) {
        final String? token = await user.getIdToken();
        await saveToken(token!);
        await saveUserId(user.uid);
      } else {
        throw Exception('User is null after account creation.');
      }

      return userCredential;
    } catch (e) {
      print('Unexpected signup error: $e');
      rethrow;
    }
  }

  static Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Error signing out: $e');
    } finally {
      await clearToken();
    }
  }
}
