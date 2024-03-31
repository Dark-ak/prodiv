import 'package:flutter/material.dart';
// import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:prodive/widgets/Weekly.dart';
import 'Stats.dart';

class Graph extends StatelessWidget {
  const Graph({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // constraints: BoxConstraints(maxWidth: 320, maxHeight: 320),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Reports",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Weekly(),
          SizedBox(
            height: 20,
          ),
          Stats()
        ],
      ),
    );
  }
}
