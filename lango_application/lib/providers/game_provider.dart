import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lango_application/providers/app_provider.dart';
import 'package:provider/provider.dart';

class Word {
  final String eng;
  final String other;

  Word({required this.eng, required this.other});
}

class Question {
  final String questionWord;
  final int answerIndex;
  final List<Word> choice;

  Question(
      {required this.questionWord,
      required this.answerIndex,
      required this.choice});
}

class GameProvider extends ChangeNotifier {
  final List<Word> _words = [];
  final List<Word> _newWords = [];
  final List<Question> _questions = [];
  final String _stage = "1";
  final String _level = "1";
  int _currentGame = 0;
  int _totalPoint = 0;
  String _start = "";
  String _end = "";

  int get currentGame => _currentGame;
  String get stage => _stage;
  String get level => _level;
  int get length => _questions.length;
  List<Word> get words => _words;
  List<Word> get newWords => _newWords;
  List<Question> get questions => _questions;
  final AppProvider appProvider;

  GameProvider(this.appProvider);

  Future<void> initData(String stage, String level) async {
    try {
      _words.clear();
      _newWords.clear();
      _questions.clear();

      DocumentSnapshot range = await FirebaseFirestore.instance
          .collection("game")
          .doc("level$level")
          .collection("stages")
          .doc("stage$stage")
          .get();
      int start = range["start"];
      int end = range["end"];
      if (range.exists) {
        QuerySnapshot newWordList = await FirebaseFirestore.instance
            .collection("vocab")
            .where("value", isLessThanOrEqualTo: end)
            .get(); 
        String? language = appProvider.language;
        print("lang");
        print(language);
        for (int i = 0; i < newWordList.docs.length; i++) {
          var doc = newWordList.docs[i];
          if (i + 1 >= start) {
            _newWords.add(Word(eng: doc["en"], other: doc["es"]));
          } else {
            _words.add(Word(eng: doc["en"], other: doc["es"]));
          }
        }

        questions.add(Question(
            questionWord: _newWords[0].eng, answerIndex: 2, choice: _newWords));
        // // }
      }

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void incrementGame() {
    _currentGame++;
    notifyListeners();
  }

  void addPoint(int point) {
    _totalPoint += point;
    notifyListeners();
  }
}
