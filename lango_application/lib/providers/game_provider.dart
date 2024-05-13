import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
  final String _stage;
  final String _level;
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

  GameProvider({
    required String stage,
    required String level,
  })  : _stage = stage,
        _level = level {
    _init();
  }

  Future<void> _init() async {
    try {
      DocumentSnapshot range = await FirebaseFirestore.instance
          .collection("game")
          .doc("level$_level")
          .collection("stages")
          .doc("stage$_stage")
          .get();
      if (range.exists) {
        QuerySnapshot newWordList = await FirebaseFirestore.instance
            .collection("vocab")
            .where("value", isLessThanOrEqualTo: range["end"])
            .get();
        for (int i = 0; i < newWordList.docs.length; i++) {
          var doc = newWordList.docs[i];
          if (i + 1 >= range["start"]) {
            _newWords.add(Word(eng: doc["en"], other: doc["es"]));
          } else {
            _words.add(Word(eng: doc["en"], other: doc["es"]));
          }
        }
        if (_newWords.isNotEmpty) { //ใส่ 3 คำ
          questions.add(Question(
              questionWord: _newWords[0].eng,
              answerIndex: 2,
              choice: _newWords));
        }
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
