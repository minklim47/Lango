import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:lango_application/providers/app_provider.dart';

class Word {
  final String eng;
  final String other;

  Word({required this.eng, required this.other});

  @override
  String toString() {
    return 'Word(Eng: $eng, other: $other)';
  }
}

class Question {
  final String questionWord;
  final int answerIndex;
  final List<Word> choice;

  Question(
      {required this.questionWord,
      required this.answerIndex,
      required this.choice});

  @override
  String toString() {
    return 'Question(questionWord: $questionWord, answerIndex: $answerIndex, choice: $choice)';
  }
}

class PairMatchQuestion {
  final List<Word> wordList;

  PairMatchQuestion({required this.wordList});
}

class GameProvider extends ChangeNotifier {
  final List<Word> _words = [];
  final List<Word> _newWords = [];
  final List<Question> _questions = [];
  final List<Word> _matchingPair = [];
  final int _totalPoint = 0;
  int get totalPoint => _totalPoint;

  int _point = 0;
  int get point => _point;
  // String _start = "";
  // String _end = "";

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
      if (kDebugMode) {
        print(start);
        print(end);
      }
      if (range.exists) {
        QuerySnapshot newWordList = await FirebaseFirestore.instance
            .collection("vocab")
            .where("value", isLessThanOrEqualTo: end)
            .get();
        String? language = appProvider.language ?? "es";
        for (int i = 0; i < newWordList.docs.length; i++) {
          var doc = newWordList.docs[i];
          if (i + 1 >= start) {
            _newWords.add(Word(eng: doc["en"], other: doc[language]));
          } else {
            _words.add(Word(eng: doc["en"], other: doc[language]));
          }
        }
        List<Word> choiceWords = newWords;
        int temp = Random().nextInt(3);
        if (_newWords.length < 3) {
          choiceWords.add(_words[Random().nextInt(words.length)]);
        }
        for (int i = 0; i < 2; i++) {
          List<int> indexOrder = [2, 0, 1];

          for (int index in indexOrder) {
            questions.add(Question(
                questionWord: choiceWords[index].eng,
                answerIndex: temp,
                choice: shuffle(choiceWords, index, temp)));
            temp = Random().nextInt(3);
          }
        }
        if (kDebugMode) {
          print(questions);
        }
        if (stage == "12") {
          for (int i = 0; i < 5; i++) {
            _matchingPair.add(choiceWords[i]);
          }
        }
      }

      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void addPoint(int newPoint) {
    _point += newPoint;
    notifyListeners();
  }

  List<Word> shuffle(List<Word> list, int index1, int index2) {
    List<Word> ls = List.from(list);
    Word temp = ls[index1];
    ls[index1] = ls[index2];
    ls[index2] = temp;
    return ls;
  }

  Future<void> updateProgress(int level, int stage) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(appProvider.userId)
        .set({
      'progress': {
        '${appProvider.language}': {
          'level': stage < 12
              ? level
              : stage == 12 && level < 3
                  ? level + 1
                  : level,
          'stage': stage < 12
              ? stage + 1
              : stage == 12 && level < 3
                  ? 1
                  : stage,
        }
      },
    }, SetOptions(merge: true));
    notifyListeners();
  }

  Future<void> completeStage(int level, int stage) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(appProvider.userId)
          .collection('complete')
          .doc('${appProvider.language}level${level}stage$stage')
          .set({
        'language': appProvider.language,
        'level': level,
        'stage': stage,
        'timestamp': Timestamp.now(),
        'passed': _point >= _totalPoint ? true : false,
        'exp': _point,
      });
      appProvider.fetchUserInfo(appProvider.userId);
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Failed to add data to subcollection: $e');
      } 
    }
  }
}
