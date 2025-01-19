import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMins = 1500;
  int totalSecs = twentyFiveMins;
  bool isRunning = false;
  int totalPomodoros = 0;
  late Timer timer;

  void onTick(Timer timer) {
    if (totalSecs == 0) {
      setState(() {
        totalPomodoros = totalPomodoros + 1;
        isRunning = false;
        totalSecs = twentyFiveMins;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSecs -= 1;
      });
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(const Duration(seconds: 1), onTick);

    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onResetPressed() {
    setState(() {
      totalSecs = twentyFiveMins;
      isRunning = false;
    });

    timer.cancel();
  }

  String format(int secs) {
    var duration = Duration(seconds: secs);
    var formatedSecs = duration.toString().split('.')[0].substring(2, 7);

    return formatedSecs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Flexible(
              flex: 1,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Text(
                  format(totalSecs),
                  style: TextStyle(
                    color: Theme.of(context).cardColor,
                    fontSize: 90,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )),
          Flexible(
              flex: 2,
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      isRunning
                          ? Icons.pause_circle_outline_outlined
                          : Icons.play_circle_outline_outlined,
                      size: 100,
                      color: Theme.of(context).cardColor,
                    ),
                    onPressed: isRunning ? onPausePressed : onStartPressed,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.restore,
                      size: 100,
                      color: Theme.of(context).cardColor,
                    ),
                    onPressed: isRunning ? onPausePressed : onResetPressed,
                  ),
                ],
              ))),
          Flexible(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Pomodoros',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .color,
                            ),
                          ),
                          Text(
                            '$totalPomodoros',
                            style: TextStyle(
                              fontSize: 52,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .color,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
