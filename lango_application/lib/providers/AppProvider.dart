import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppProvider extends ChangeNotifier {
  int counter = 0;
  User? _currentUser = FirebaseAuth.instance.currentUser;
  User? get currentUser => _currentUser;
  String language = "Thai";

  void setCurrentUser(User? user) {
    _currentUser = user;
    notifyListeners();
  }

  void setLanguage(String lang) {
    if (lang.toLowerCase() == 'thai') {
      language = 'Thai';
    } else {
      language = 'Spanish';
    }
    notifyListeners();
  }

  void addCounter() {
    counter++;
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
