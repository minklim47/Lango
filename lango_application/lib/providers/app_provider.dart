import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppProvider extends ChangeNotifier {
  User? _user;
  User? get user => _user;
  String? _username;
  String? get username => _username;
  String? _email;
  String? get email => _email;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _language = "es";
  String? get language => _language;

  int? _currentLevel = 0;
  int? get currentLevel => _currentLevel;
  int? _currentStage = 0;
  int? get currentStage => _currentStage;

  AppProvider() {
    _init();
  }

  Future<void> _init() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        _user = user;
        _isLoading = true;
        notifyListeners();
        await _fetchUserInfo(user.uid);
        _isLoading = false;
        notifyListeners();
      } else {
        _user = null;
        _username = null;
        _email = null;
        notifyListeners();
      }
    });
  }

  Future<void> _fetchUserInfo(String userId) async {
    try {
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      _username = userData['username'];
      _email = userData['email'];
      Map<String, dynamic>? progress = userData['progress'];
      if (progress != null && _language != null) {
        Map<String, dynamic>? languageProgress = progress[_language!];
        if (languageProgress != null) {
          _currentLevel = languageProgress['level'];
          _currentStage = languageProgress['stage'];
          print(languageProgress);
        }
      }
    } catch (error) {
      print('Error fetching user info: $error');
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      _isLoading = true;
      notifyListeners();
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } catch (error) {
      print('Error signing in: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    try {
      _isLoading = true;
      notifyListeners();
      await FirebaseAuth.instance.signOut();
    } catch (error) {
      print('Error signing out: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void changeLanguage(String newLanguage) {
    _language = newLanguage;
    notifyListeners();
  }

  void updateUsername(String newName) {
    _username = newName;
    notifyListeners();
  }
}
