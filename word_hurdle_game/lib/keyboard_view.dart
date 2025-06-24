import 'package:flutter/material.dart';

const keysList = [
  ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"],
  ["A", "S", "D", "F", "G", "H", "J", "K", "L"],
  [
    "Z",
    "X",
    "C",
    "V",
    "B",
    "N",
    "M",
  ],
];

class KeyboardView extends StatelessWidget {
  const KeyboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(4.0),
        child: Column(
          children: [
            for (int i = 0; i < keysList.length; i++)
              {
                Row(
                  children: keysList[i].map((e) => null).toList(),
                ),
              }
          ],
        ),
      ),
    );
  }
}
