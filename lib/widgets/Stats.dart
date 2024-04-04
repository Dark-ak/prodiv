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
            final scale = MediaQuery.of(context).textScaler;
            print(scale);
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        constraints: const BoxConstraints(
                            minHeight: 130,
                            maxHeight: 180,
                            minWidth: 110,
                            maxWidth: 150),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blueGrey.shade400,
                            ),
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const AutoSizeText("Longest Session ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600),
                                maxFontSize: 25,
                                minFontSize: 16,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis),
                            AutoSizeText(
                              "${data!['max']!.toStringAsFixed(2)} hrs",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400),
                              maxFontSize: 25,
                              minFontSize: 16,
                              maxLines: 1,
                            )
                          ],
                        )),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        constraints: const BoxConstraints(
                            minHeight: 130,
                            maxHeight: 180,
                            minWidth: 110,
                            maxWidth: 150),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blueGrey.shade400,
                            ),
                            borderRadius: BorderRadius.circular(15)),
                        width: 160,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const AutoSizeText("Avg. Session ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600),
                                maxFontSize: 25,
                                minFontSize: 16,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis),
                            AutoSizeText(
                              "${data['avg']!.toStringAsFixed(2)} hrs",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400),
                              maxFontSize: 25,
                              minFontSize: 16,
                              maxLines: 1,
                            )
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
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        constraints: const BoxConstraints(
                            minHeight: 130,
                            maxHeight: 180,
                            minWidth: 110,
                            maxWidth: 150),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blueGrey.shade400,
                            ),
                            borderRadius: BorderRadius.circular(15)),
                        width: 160,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const AutoSizeText("Weekly Avg. ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600),
                                maxFontSize: 25,
                                minFontSize: 16,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis),
                            AutoSizeText(
                              "${data['weekAvg']!.toStringAsFixed(2)} hrs",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400),
                              maxFontSize: 25,
                              minFontSize: 16,
                              maxLines: 1,
                            )
                          ],
                        )),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        constraints: const BoxConstraints(
                            minHeight: 130,
                            maxHeight: 180,
                            minWidth: 110,
                            maxWidth: 150),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blueGrey.shade400,
                            ),
                            borderRadius: BorderRadius.circular(15)),
                        width: 160,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const AutoSizeText("Monthly Avg.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600),
                                maxFontSize: 25,
                                minFontSize: 16,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis),
                            AutoSizeText(
                              "${data['monthAvg']!.toStringAsFixed(2)} hrs",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400),
                              maxFontSize: 25,
                              minFontSize: 16,
                              maxLines: 1,
                            )
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
