// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class GameHomeScreen extends StatefulWidget {
  const GameHomeScreen({super.key});

  @override
  State<GameHomeScreen> createState() => _GameHomeScreenState();
}

class _GameHomeScreenState extends State<GameHomeScreen> {
  bool onTurn = true;
  List oxItemsLists = ["", "", "", "", "", "", "", "", ""];
  String result = ' ';
  int xScore = 0;
  int oScore = 0;
  int filledBoxses = 0;
  bool winnerFound = false;
  int attemps = 0;
  List<int> matchedIndexed = [];

  //*************** For Timer**************** */
  static const maxSeconds = 30;
  int seconds = maxSeconds;
  Timer? timer;
  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          stopTimer();
        }
      });
    });
  }

  void stopTimer() {
    resetTimer();
    timer?.cancel();
  }

  void resetTimer() {
    seconds = maxSeconds;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            SizedBox(
              height: 90.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Player 0",
                    style: GoogleFonts.coiny(
                      textStyle:
                          TextStyle(color: Colors.white, fontSize: 35.sp),
                    )),
                SizedBox(
                  width: 10.w,
                ),
                Text("Player X",
                    style: GoogleFonts.coiny(
                      textStyle:
                          TextStyle(color: Colors.white, fontSize: 35.sp),
                    )),
              ],
            ),
            SizedBox(
              height: 10.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(oScore.toString(),
                    style: GoogleFonts.coiny(
                      textStyle:
                          TextStyle(color: Colors.white, fontSize: 30.sp),
                    )),
                SizedBox(
                  width: 10.w,
                ),
                Text(xScore.toString(),
                    style: GoogleFonts.coiny(
                      textStyle:
                          TextStyle(color: Colors.white, fontSize: 30.sp),
                    )),
              ],
            ),
            Expanded(
              flex: 2,
              child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            tappedFun(index);
                          },
                          child: Container(
                            height: 140.h,
                            width: 165.w,
                            decoration: BoxDecoration(
                                color: matchedIndexed.contains(index)
                                    ? const Color.fromARGB(255, 18, 105, 21)
                                    : const Color.fromARGB(255, 221, 83, 9),
                                borderRadius: BorderRadius.circular(12)),
                            child: Center(
                                child: Text(
                              oxItemsLists[index],
                              style: GoogleFonts.coiny(
                                  textStyle: TextStyle(fontSize: 60.sp)),
                            )),
                          ),
                        ),
                      ),
                    );
                  })),
            ),
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Text(result,
                      style: GoogleFonts.coiny(
                        textStyle:
                            TextStyle(color: Colors.white, fontSize: 30.sp),
                      )),
                  SizedBox(
                    height: 30.h,
                  ),
                  buildTimer()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void tappedFun(int index) {
    final isRunning = timer == null ? false : timer!.isActive;
    if (isRunning) {
      setState(() {
        if (onTurn && oxItemsLists[index] == "") {
          oxItemsLists[index] = "O";
          filledBoxses++;
        } else if (!onTurn && oxItemsLists[index] == "") {
          oxItemsLists[index] = "X";
          filledBoxses++;
        }
      });
    }

    onTurn = !onTurn;
    checkWinner();
  }

  void checkWinner() {
    //****************************** ROWS *********************************** */
    // Check for 1st row
    if (oxItemsLists[0] == oxItemsLists[1] &&
        oxItemsLists[0] == oxItemsLists[2] &&
        oxItemsLists[0] != '') {
      setState(() {
        result = "Player " + oxItemsLists[0] + " Wins!";
        updateScore(oxItemsLists[0]);
        matchedIndexed.addAll([0, 1, 2]);
        stopTimer();
      });
    }
    // Check for 2nd row
    if (oxItemsLists[3] == oxItemsLists[4] &&
        oxItemsLists[3] == oxItemsLists[5] &&
        oxItemsLists[3] != '') {
      setState(() {
        result = "Player " + oxItemsLists[3] + " Wins!";
        updateScore(oxItemsLists[3]);
        matchedIndexed.addAll([3, 4, 5]);
        stopTimer();
      });
    }
    // Check for 3rd row
    if (oxItemsLists[6] == oxItemsLists[7] &&
        oxItemsLists[6] == oxItemsLists[8] &&
        oxItemsLists[6] != '') {
      setState(() {
        result = "Player " + oxItemsLists[6] + " Wins!";
        updateScore(oxItemsLists[6]);
        updateScore(oxItemsLists[3]);
        matchedIndexed.addAll([6, 7, 8]);
        stopTimer();
      });
    }
    //****************************** COLUMNS *********************************** */
    // Check for 1st column
    if (oxItemsLists[0] == oxItemsLists[3] &&
        oxItemsLists[0] == oxItemsLists[6] &&
        oxItemsLists[0] != '') {
      setState(() {
        result = "Player " + oxItemsLists[0] + " Wins!";
        updateScore(oxItemsLists[0]);
        matchedIndexed.addAll([0, 3, 6]);
        stopTimer();
      });
    }
    // Check for 2nd column
    if (oxItemsLists[1] == oxItemsLists[4] &&
        oxItemsLists[1] == oxItemsLists[7] &&
        oxItemsLists[1] != '') {
      setState(() {
        result = "Player " + oxItemsLists[1] + " Wins!";
        updateScore(oxItemsLists[1]);
        matchedIndexed.addAll([1, 4, 7]);
        stopTimer();
      });
    }
    // Check for 3rd column
    if (oxItemsLists[2] == oxItemsLists[5] &&
        oxItemsLists[2] == oxItemsLists[8] &&
        oxItemsLists[2] != '') {
      setState(() {
        result = "Player " + oxItemsLists[2] + " Wins!";
        updateScore(oxItemsLists[0]);
        matchedIndexed.addAll([2, 5, 8]);
        stopTimer();
      });
    }
    //****************************** DIAGONALS *********************************** */
    // Check for left diagonal
    if (oxItemsLists[0] == oxItemsLists[4] &&
        oxItemsLists[0] == oxItemsLists[8] &&
        oxItemsLists[0] != '') {
      setState(() {
        result = "Player " + oxItemsLists[0] + " Wins!";
        updateScore(oxItemsLists[0]);
        matchedIndexed.addAll([0, 4, 8]);
        stopTimer();
      });
    }
    // Check for right diagonal
    if (oxItemsLists[2] == oxItemsLists[4] &&
        oxItemsLists[2] == oxItemsLists[6] &&
        oxItemsLists[2] != '') {
      setState(() {
        result = "Player " + oxItemsLists[2] + " Wins!";
        updateScore(oxItemsLists[2]);
        matchedIndexed.addAll([2, 4, 6]);
        stopTimer();
      });
    }

    if (!winnerFound && filledBoxses == 9) {
      setState(() {
        result = "Nobody Wins!";
      });
    }
  }

  // ************************* For Winner Method *******************
  void updateScore(String winner) {
    if (winner == "O") {
      oScore++;
    } else if (winner == "X") {
      xScore++;
    }
    winnerFound = true;
  }

  // ************************ Clear Board Method *******************
  void clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        oxItemsLists[i] = "";
      }
      result = "";
    });
    filledBoxses = 0;
    xScore = 0;
    oScore = 0;
  }

  //********************** For Timer ***************** */
  Widget buildTimer() {
    final isRunning = timer == null ? false : timer!.isActive;

    return isRunning
        ? SizedBox(
            height: 100.h,
            width: 100.w,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: 1 - seconds / maxSeconds,
                  valueColor: const AlwaysStoppedAnimation(Colors.white),
                  strokeWidth: 8,
                  backgroundColor: const Color.fromARGB(255, 221, 83, 9),
                ),
                Center(
                  child: Text("$seconds",
                      style: GoogleFonts.coiny(
                        textStyle:
                            TextStyle(color: Colors.white, fontSize: 30.sp),
                      )),
                )
              ],
            ),
          )
        : InkWell(
            onTap: () {
              startTimer();
              clearBoard();
              attemps++;
            },
            child: Container(
              height: 50.h,
              width: 200.w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r)),
              child: Center(
                  child: Text(attemps == 0 ? "Start" : "Try Again!",
                      style: GoogleFonts.coiny(
                        textStyle:
                            TextStyle(color: Colors.black, fontSize: 20.sp),
                      ))),
            ),
          );
  }
}
