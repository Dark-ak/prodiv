import 'package:flutter/material.dart';
import 'package:prodive/main.dart';
import 'package:provider/provider.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class Count extends StatefulWidget {
  const Count({super.key});

  @override
  State<Count> createState() => _CountState();
}

class _CountState extends State<Count> {
  final _controller = CountDownController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(builder: (context, data, child) {
      return CircularCountDownTimer(
        // Countdown duration in Seconds.
        duration: data.rest ? 5 : 9,

        initialDuration: 0,

        // Controls (i.e Start, Pause, Resume, Restart) the Countdown Timer.
        controller: _controller,

        // Width of the Countdown Widget.
        width: 280,

        // Height of the Countdown Widget.
        height: 250,

        // Ring Color for Countdown Widget.
        ringColor: Theme.of(context).colorScheme.onPrimary,

        // Ring Gradient for Countdown Widget.
        ringGradient: null,

        // Filling Color for Countdown Widget.
        fillColor: Theme.of(context).colorScheme.secondary,

        // Filling Gradient for Countdown Widget.
        fillGradient: null,

        // Background Color for Countdown Widget.
        backgroundColor: Theme.of(context).colorScheme.onPrimary,

        // Border Thickness of the Countdown Ring.
        strokeWidth: 10.0,

        // Begin and end contours with a flat edge and no extension.
        strokeCap: StrokeCap.round,

        // Text Style for Countdown Text.
        textStyle: const TextStyle(
          fontSize: 60,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),

        // Format for the Countdown Text.
        textFormat: CountdownTextFormat.MM_SS,

        // Handles Countdown Timer (true for Reverse Countdown (max to 0), false for Forward Countdown (0 to max)).
        isReverse: true,

        // Handles Animation Direction (true for Reverse Animation, false for Forward Animation).
        isReverseAnimation: false,

        // Handles visibility of the Countdown Text.
        isTimerTextShown: true,

        // Handles the timer start.
        autoStart: true,

        onComplete: () {
          _controller.restart();
          // data.setStarted(false);
          // _controller.reset();
          data.restStat();
          // if (!data.rest) {
          //   data.increSes();
          //   // print(data(context).sesCount);
          // }
          // if (!data(context).rest) {}
        },
      );
    });
  }
}
