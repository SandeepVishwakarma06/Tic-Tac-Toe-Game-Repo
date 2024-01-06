// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, avoid_unnecessary_containers
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_toe_toe_game/constant/colors.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool oTurn = true;
  List<String> displayXO = ['', '', '', '', '', '', '', '', ''];
  int attempts = 0;
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;
  bool winnerFound = false;
  List<int> matchedIndexes = [];
  String resultDeclaration = '';
  static const maxSecond = 30;
  int seconds = maxSecond;

  Timer? timer;

  static var customFontWhite = GoogleFonts.coiny(
      textStyle: const TextStyle(
    color: Colors.white,
    letterSpacing: 3,
    fontSize: 28,
  ));

  void _startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          _stopTimer();
        }
      });
    });
  }

  void _stopTimer() {
    _resetTimer();
    timer?.cancel();
  }

  void _resetTimer() => seconds = maxSecond;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColor.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Player O",
                          style: customFontWhite,
                        ),
                        Text(
                          oScore.toString(),
                          style: customFontWhite,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Player X",
                          style: customFontWhite,
                        ),
                        Text(
                          xScore.toString(),
                          style: customFontWhite,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        _tapped(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: MainColor.primaryColor, width: 5),
                          color: matchedIndexes.contains(index)
                              ? MainColor.accentColor
                              : MainColor.secondoryColor,
                        ),
                        child: Center(
                          child: Text(
                            displayXO[index],
                            style: GoogleFonts.coiny(
                                textStyle: TextStyle(
                                    color: MainColor.primaryColor,
                                    fontSize: 64)),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Expanded(
                flex: 2,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        resultDeclaration,
                        style: customFontWhite,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _buildTimer()
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void _tapped(int index) {
    final isRunning = timer == null ? false : timer!.isActive;
    if (isRunning) {
      setState(() {
        if (oTurn && displayXO[index] == '') {
          displayXO[index] = 'O';
          filledBoxes++;
        } else if (!oTurn && displayXO[index] == '') {
          displayXO[index] = 'X';
          filledBoxes++;
        }
        oTurn = !oTurn;
        _checkWinner();
      });
    }
  }

  void _checkWinner() {
    // Check 1st Row
    if (displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = "Player " + displayXO[0] + " Wins!";
        matchedIndexes.addAll([0, 1, 2]);
        _stopTimer();
        _updateScore(displayXO[0]);
      });
    }
    // Check 2nd Row
    if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] &&
        displayXO[3] != '') {
      setState(() {
        resultDeclaration = "Player " + displayXO[3] + " Wins!";
        matchedIndexes.addAll([3, 4, 5]);
        _stopTimer();
        _updateScore(displayXO[3]);
      });
    }
    // Check 3rd Row
    if (displayXO[6] == displayXO[7] &&
        displayXO[6] == displayXO[8] &&
        displayXO[6] != '') {
      setState(() {
        resultDeclaration = "Player " + displayXO[6] + " Wins!";
        matchedIndexes.addAll([6, 7, 8]);
        _stopTimer();
        _updateScore(displayXO[6]);
      });
    }
    // Check 1st Colunm
    if (displayXO[0] == displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = "Player " + displayXO[0] + " Wins!";
        matchedIndexes.addAll([0, 3, 6]);
        _stopTimer();
        _updateScore(displayXO[0]);
      });
    }
    // Check 2nd Column
    if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != '') {
      setState(() {
        resultDeclaration = "Player " + displayXO[1] + " Wins!";
        matchedIndexes.addAll([1, 4, 7]);
        _stopTimer();
        _updateScore(displayXO[1]);
      });
    }
    // Check 3rd Column
    if (displayXO[2] == displayXO[5] &&
        displayXO[2] == displayXO[8] &&
        displayXO[2] != '') {
      setState(() {
        resultDeclaration = "Player " + displayXO[2] + " Wins!";
        matchedIndexes.addAll([2, 5, 8]);
        _stopTimer();
        _updateScore(displayXO[2]);
      });
    }
    // Check 1st Diagonal
    if (displayXO[0] == displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = "Player " + displayXO[0] + " Wins!";
        matchedIndexes.addAll([0, 4, 8]);
        _stopTimer();
        _updateScore(displayXO[0]);
      });
    }
    // Check 2nd Diagonal
    if (displayXO[6] == displayXO[4] &&
        displayXO[6] == displayXO[2] &&
        displayXO[6] != '') {
      setState(() {
        resultDeclaration = "Player " + displayXO[6] + " Wins!";
        matchedIndexes.addAll([6, 4, 2]);
        _stopTimer();
        _updateScore(displayXO[6]);
      });
    }
    if (!winnerFound && filledBoxes == 9) {
      setState(() {
        resultDeclaration = "Nobody Wins!";
        _stopTimer();
      });
    }
  }

  void _updateScore(String winner) {
    if (winner == 'O') {
      oScore++;
    } else if (winner == 'X') {
      xScore++;
    }
    winnerFound = true;
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayXO[i] = '';
      }
      resultDeclaration = '';
    });
    filledBoxes = 0;
    matchedIndexes = [];
  }

  Widget _buildTimer() {
    final isRunning = timer == null ? false : timer!.isActive;
    return isRunning
        ? SizedBox(
            height: 100,
            width: 100,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: 1 - seconds / maxSecond,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                  strokeWidth: 8,
                  backgroundColor: MainColor.accentColor,
                ),
                Center(
                  child: Text(
                    "$seconds",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 50),
                  ),
                )
              ],
            ),
          )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
            onPressed: () {
              _startTimer();
              _clearBoard();
              attempts++;
            },
            child: Text(
              attempts == 0 ? "Start" : "Play Again!",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ));
  }
}
