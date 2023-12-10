import 'package:flutter/material.dart';

class PrimaryBackground extends StatelessWidget {
  const PrimaryBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Image.asset(
        'assets/images/bg.png',
      ),
    );
  }
}
