import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_hurdle_game/hurdle_provider.dart';
import 'package:word_hurdle_game/keyboard_view.dart';
import 'package:word_hurdle_game/wordle_view.dart';

class WordHurdlePage extends StatefulWidget {
  const WordHurdlePage({super.key});

  @override
  State<WordHurdlePage> createState() => _WordHurdlePageState();
}

class _WordHurdlePageState extends State<WordHurdlePage> {
  @override
  void didChangeDependencies() {
    Provider.of<HurdleProvider>(context, listen: false).init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Word Hurdle"),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.70,
                child: Consumer<HurdleProvider>(
                  builder: (context, provider, child) => GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                    ),
                    itemCount: provider.hurdleBoard.length,
                    itemBuilder: (context, index) {
                      final wordle = provider.hurdleBoard[index];
                      return WordleView(wordle: wordle);
                    },
                  ),
                ),
              ),
            ),
            Consumer<HurdleProvider>(
              builder: (context, provider, child) => KeyboardView(
                excludedLetters: provider.excludedLetters,
                onPressed: (value) {
                  provider.inputLetter(value);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Consumer<HurdleProvider>(
                builder: (context, provider, child) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        provider.deleteLetter();
                      },
                      child: Text("DELETE"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (!provider.isAValidWord) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Word does not match!")));
                              return;
                        }
                      },
                      child: Text("SUBMIT"),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
