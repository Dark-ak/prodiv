import 'package:flutter/material.dart';
import "../db/db.dart";
import 'package:auto_size_text/auto_size_text.dart';

class Stats extends StatelessWidget {
  const Stats({super.key});

  Future<Map<String, double>> data() async {
    final val = await DbService().getStats();
    print(val);
    return val;
  }

  @override
  Widget build(BuildContext context) {
    // data();
    return FutureBuilder(
        future: DbService().getStats(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        constraints: const BoxConstraints(maxHeight: 130),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blueGrey.shade400,
                            ),
                            borderRadius: BorderRadius.circular(15)),
                        width: 160,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const AutoSizeText(
                              "Longest Session",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                              maxFontSize: 20,
                              minFontSize: 16,
                            ),
                            Text(
                              "${data!['max']!.toStringAsFixed(2)} hrs",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        )),
                    Container(
                        constraints: const BoxConstraints(maxHeight: 130),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blueGrey.shade400,
                            ),
                            borderRadius: BorderRadius.circular(15)),
                        width: 160,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Average Session",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "${data!['avg']!.toStringAsFixed(2)}hrs",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        constraints: const BoxConstraints(maxHeight: 130),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blueGrey.shade400,
                            ),
                            borderRadius: BorderRadius.circular(15)),
                        width: 160,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Weekly Average",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "${data['weekAvg']!.toStringAsFixed(2)}hrs",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        )),
                    Container(
                        constraints: const BoxConstraints(maxHeight: 130),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blueGrey.shade400,
                            ),
                            borderRadius: BorderRadius.circular(15)),
                        width: 160,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Monthly Average",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "${data['monthAvg']!.toStringAsFixed(2)}hrs",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        )),
                  ],
                )
              ],
            );
          } else {
            // ignore: prefer_const_constructors
            return Center(
              child: const CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }
        });
  }
}
