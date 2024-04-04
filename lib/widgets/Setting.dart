import 'package:flutter/material.dart';
import 'package:prodive/main.dart';
import "package:provider/provider.dart";

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Settings",
            style: TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.w800),
          ),
          Container(
              padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 15, vertical: 20),
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 30),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Consumer<AppData>(builder: (context, data, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Timer",
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            decoration:
                                BoxDecoration(color: Colors.blue.shade800),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    onPressed: data.timer <= 5
                                        ? null
                                        : () {
                                            data.handleTimer(data.timer - 5);
                                          },
                                    disabledColor: Colors.red,
                                    style: const ButtonStyle(
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap),
                                    icon: Icon(
                                      Icons.arrow_left,
                                      color: data.timer <= 5
                                          ? Colors.grey
                                          : Colors.white,
                                      size: 35,
                                    )),
                                TextField(
                                  controller: TextEditingController(
                                      text: data.timer.toString()),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20),
                                  keyboardType: TextInputType.number,
                                  onSubmitted: (value) {
                                    int val = int.parse(value);
                                    data.handleTimer(val);
                                  },
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      constraints:
                                          BoxConstraints(maxWidth: 40)),
                                ),
                                IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    onPressed: data.timer >= 100
                                        ? null
                                        : () {
                                            data.handleTimer(data.timer + 5);
                                          },
                                    style: const ButtonStyle(
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap),
                                    icon: Icon(
                                      Icons.arrow_right,
                                      color: data.timer >= 100
                                          ? Colors.grey
                                          : Colors.white,
                                      size: 35,
                                    ))
                              ],
                            ))
                      ],
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Short Break",
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            decoration:
                                BoxDecoration(color: Colors.blue.shade800),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    onPressed: data.sBreak <= 1
                                        ? null
                                        : () {
                                            data.handleSbreak(data.sBreak - 1);
                                          },
                                    style: const ButtonStyle(
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap),
                                    icon: Icon(
                                      Icons.arrow_left,
                                      color: data.sBreak <= 1
                                          ? Colors.grey
                                          : Colors.white,
                                      size: 35,
                                    )),
                                TextField(
                                  controller: TextEditingController(
                                      text: data.sBreak.toString()),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20),
                                  keyboardType: TextInputType.number,
                                  onSubmitted: (value) {
                                    int val = int.parse(value);
                                    data.handleSbreak(val);
                                  },
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      constraints:
                                          BoxConstraints(maxWidth: 25)),
                                ),
                                IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    onPressed: data.sBreak >= 20
                                        ? null
                                        : () {
                                            data.handleSbreak(data.sBreak + 1);
                                          },
                                    style: const ButtonStyle(
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap),
                                    icon: Icon(
                                      Icons.arrow_right,
                                      color: data.sBreak >= 20
                                          ? Colors.grey
                                          : Colors.white,
                                      size: 35,
                                    ))
                              ],
                            ))
                      ],
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Long Break",
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            decoration:
                                BoxDecoration(color: Colors.blue.shade800),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    onPressed: data.lBreak <= 5
                                        ? null
                                        : () {
                                            data.handleLbreak(data.lBreak - 1);
                                          },
                                    style: const ButtonStyle(
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap),
                                    icon: Icon(
                                      Icons.arrow_left,
                                      color: data.lBreak <= 5
                                          ? Colors.grey
                                          : Colors.white,
                                      size: 35,
                                    )),
                                TextField(
                                  controller: TextEditingController(
                                      text: data.lBreak.toString()),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20),
                                  keyboardType: TextInputType.number,
                                  onSubmitted: (value) {
                                    int val = int.parse(value);
                                    data.handleLbreak(val);
                                  },
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      constraints:
                                          BoxConstraints(maxWidth: 25)),
                                ),
                                IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    onPressed: data.lBreak >= 50
                                        ? null
                                        : () {
                                            data.handleLbreak(data.lBreak + 1);
                                          },
                                    style: const ButtonStyle(
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap),
                                    icon: Icon(
                                      Icons.arrow_right,
                                      color: data.lBreak >= 50
                                          ? Colors.grey
                                          : Colors.white,
                                      size: 35,
                                    ))
                              ],
                            ))
                      ],
                    ),
                  ],
                );
              }))
        ],
      ),
    );
  }
}
