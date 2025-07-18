import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:english_words/english_words.dart' as words;
import 'package:word_hurdle_game/wordle.dart';

class HurdleProvider extends ChangeNotifier {
  final random = Random.secure();
  List<String> totalWords = [];
  List<String> rowInputs = [];
  List<String> excludedLetters = [];
  List<Wordle> hurdleBoard = [];
  String targetWord = "";
  int count = 0;
  final lettersPerRow = 5;
  int index = 0;
  
  init() {
    totalWords = words.all.where((element) => element.length == 5).toList();  // generate a list of 5 letter words
    generateBoard();
    generateRandomWord();
  }

  generateBoard() {
    hurdleBoard = List.generate(30, (index) => Wordle(letter: ""));
  }

  generateRandomWord() {
    targetWord = totalWords[random.nextInt(totalWords.length)].toUpperCase();
    print(targetWord);
  }

  bool get isAValidWord => totalWords.contains(rowInputs.join("").toLowerCase());

  inputLetter(String letter) {
    if (count < lettersPerRow) {
      rowInputs.add(letter);
      hurdleBoard[index] = Wordle(letter: letter);
      index++;
      count++;
      notifyListeners();
      print(rowInputs);
    }
    
    
  }

  void deleteLetter() {
    if(rowInputs.isNotEmpty) {
      rowInputs.removeAt(rowInputs.length - 1);
      // print(rowInputs);
    }
    if(count > 0) {
      hurdleBoard[index - 1] = Wordle(letter: "");
      count--;
      index--;
    }
    notifyListeners();
  }
}