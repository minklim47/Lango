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
  String _userId = '';
  String get userId => _userId;
  String? _language = "es";
  String? get language => _language;
  int _currentLevel = 1;
  int get currentLevel => _currentLevel;
  int _currentStage = 1;
  int get currentStage => _currentStage;

  int _appLevel = 1;
  int get appLevel => _appLevel;


  

  String _createdAt = "";
  String get createdAt => _createdAt;

  int _exp = 0;
  int get exp => _exp;

  String _selectedReason = "";
  String get selectedReason => _selectedReason;

  String _languageLevel = "";
  String get languageLevel => _languageLevel;

  String _imageProfile = "";
  String get imageProfile => _imageProfile;
  
  AppProvider() {
    init();
  }

  Future<void> init() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        _user = user;
        _isLoading = true;
        notifyListeners();
        _userId = user.uid;
        await fetchUserInfo(user.uid);
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

  Future<void> fetchUserInfo(String userId) async {
    try {
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      _username = userData['username'];
      _email = userData['email'];
      _createdAt = userData['created_at'];
      _exp = userData['exp'];
      _selectedReason = userData['selectedReason'];
      _languageLevel = userData['languageLevel'];
      _imageProfile = userData['profileImageUrl'];
      // print(userData['username']);

      // print(userData['selectedReason']);
      Map<String, dynamic>? progress = userData['progress'];
      if (progress != null && _language != null) {
        _language = userData['language'];
        Map<String, dynamic>? languageProgress = progress[_language!];
        if (languageProgress != null) {
          _currentLevel = languageProgress['level'];
          _currentStage = languageProgress['stage'];
          _appLevel = _currentLevel;

          // print(languageProgress);
        }
      }
      notifyListeners();
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

  Future<void> changeLanguage(String newLanguage) async {
    _isLoading = true;
    _language = newLanguage;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({'language': newLanguage});
    await fetchUserInfo(userId);
    _isLoading = false;
    notifyListeners();
  }

  void updateUsername(String newName) {
    _username = newName;
    notifyListeners();
  }

  void updateProfilePath(String newPath) {
    _imageProfile = newPath;
    notifyListeners();
  }

  void incrementLevel() {
    if (_appLevel < 3) {
      _appLevel++;
      notifyListeners();
    }
  }

  void decrementLevel() {
    if (_appLevel > 1) {
      _appLevel--;
      notifyListeners();
    }
  }

  // void surveyLevel(String level) {
  //   _languageLevel = level;
  //   notifyListeners();
  // }

  Future<void> surveyLevel(String level) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'languageLevel': level,
    }, SetOptions(merge: true));

    _languageLevel = level;

    notifyListeners();
  }

  Future<void> surveyReason(String reason) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'selectedReason': reason,
    }, SetOptions(merge: true));

    _selectedReason = reason;

    notifyListeners();
  }
}
