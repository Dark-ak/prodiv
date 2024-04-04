// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'Timer.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Text(
              "Prodive",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white, fontSize: 28),
            ),
            const SizedBox(height: 20),
            const Timer(),
          ],
        ),
      ),
    );
  }
}
