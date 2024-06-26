// ignore: file_names
import "package:circular_countdown_timer/circular_countdown_timer.dart";
import "package:flutter/material.dart";
// import "package:flutter/services.dart";
import "../db/db.dart";
import "package:prodive/main.dart";
import "package:auto_size_text/auto_size_text.dart";
import "package:provider/provider.dart";
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:just_audio/just_audio.dart';

class Timer extends StatefulWidget {
  const Timer({super.key});

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  final _controller = CountDownController();
  final db = DbService();
  late AudioPlayer player;

  bool started = false;
  bool running = false;
  bool reset = false;
  bool playerInit = false;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void addTime(int value) {
    final time = _controller.getTime()!.split(":");
    final data = ((value - 1) - int.parse(time[0])) / 60 +
        (60 - int.parse(time[1])) / 3600;
    db.updateHours(data);
    print(data);
  }

  Future<double> getData() {
    return db.getToday();
  }

  Future<void> vibrate() async {
    bool isVib = await Vibrate.canVibrate;
    Vibrate.vibrate();
  }

  Future<void> play() async {
    await player.setAsset('assets/timer.mp3');
    player.play();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(builder: (context, data, child) {
      final size = MediaQuery.of(context).size;
      // final textFactor = MediaQuery.of(context).textScaler.clamp();
      final width = size.width;
      final height = size.height;
      // print(width);
      // print(textFactor);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 400,
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.onPrimary,
                const Color.fromRGBO(43, 49, 91, 1),
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: Colors.blue.shade100.withOpacity(0.20),
                    spreadRadius: 5,
                    blurRadius: 70,
                    offset: const Offset(-60, -50))
              ],
            ),
            // child: Count(),
            child: CircularCountDownTimer(
              // Countdown duration in Seconds.
              duration: data.timer * 60,

              // Controls (i.e Start, Pause, Resume, Restart) the Countdown Timer.
              controller: _controller,

              // Width of the Countdown Widget.
              width: 260,

              // Height of the Countdown Widget.
              height: width * 0.6,

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
                fontSize: 55,
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
              autoStart: false,

              onComplete: () async {
                if (!reset) {
                  if (!data.rest) {
                    data.increSes();
                    player.setAsset("assets/timer.mp3");
                    addTime(data.timer);
                  } else {
                    player.setAsset("assets/rest.mp3");
                  }
                  player.play();
                  data.restStat();
                  print(data.rest);
                  // play(data.rest);
                  _controller.restart(
                      duration: data.rest
                          ? data.sesCount == 4
                              ? data.lBreak * 60
                              : data.sBreak * 60
                          : data.timer * 60);
                }

                // // setState(() {
                // started = false;
                // _controller.reset();
              },
            ),
          ),
          SizedBox(
            height: height * 0.04,
          ),
          FutureBuilder(
              future: db.getToday(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // final data = snapshot.data?.toStringAsPrecision(1);
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white, width: 2)),
                    child: AutoSizeText(
                      "Today's session: ${snapshot.data?.toStringAsFixed(1)}hrs",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                      maxFontSize: 30,
                      maxLines: 3,
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          const SizedBox(
            height: 30,
          ),
          data.started
              ? running
                  ? Column(
                      children: [
                        ElevatedButton.icon(
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.red),
                                side: MaterialStatePropertyAll(
                                    BorderSide(color: Colors.red, width: 2)),
                                padding: MaterialStatePropertyAll(
                                    EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 40))),
                            onPressed: () => setState(() {
                                  running = false;
                                  _controller.pause();
                                }),
                            icon: const Icon(
                              Icons.pause,
                              color: Colors.white,
                            ),
                            label: const AutoSizeText(
                              "Pause",
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                              ),
                              maxFontSize: 30,
                            ))
                      ],
                    )
                  : Column(
                      children: [
                        ElevatedButton.icon(
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Theme.of(context).colorScheme.background),
                                side: const MaterialStatePropertyAll(
                                    BorderSide(color: Colors.white, width: 2)),
                                padding: const MaterialStatePropertyAll(
                                    EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 40))),
                            onPressed: () => setState(() {
                                  if (data.rest) {
                                    data.restStat();
                                  } else {
                                    addTime(data.timer);
                                  }
                                  data.setStarted(false);
                                  reset = true;
                                  running = false;
                                  _controller.reset();
                                }),
                            icon: const Icon(
                              Icons.restart_alt,
                              color: Colors.white,
                            ),
                            label: const AutoSizeText(
                              "Restart",
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                              ),
                              maxFontSize: 30,
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton.icon(
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Theme.of(context).colorScheme.secondary),
                                padding: const MaterialStatePropertyAll(
                                    EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 40))),
                            onPressed: () => setState(() {
                                  running = true;
                                  _controller.resume();
                                }),
                            icon: const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                            ),
                            label: const AutoSizeText(
                              "Resume",
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                              ),
                              maxFontSize: 30,
                            )),
                      ],
                    )
              : ElevatedButton.icon(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Theme.of(context).colorScheme.secondary),
                      padding: const MaterialStatePropertyAll(
                          EdgeInsets.symmetric(vertical: 10, horizontal: 40))),
                  onPressed: () => setState(() {
                        data.setStarted(true);
                        reset = false;
                        _controller.start();
                        vibrate();
                        running = true;
                      }),
                  icon: const Icon(
                    Icons.play_arrow,
                    opticalSize: 2,
                    color: Colors.white,
                  ),
                  label: const AutoSizeText(
                    "Start",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                    maxFontSize: 30,
                  ))
        ],
      );
    });
  }
}
