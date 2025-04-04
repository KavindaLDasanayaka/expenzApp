import 'package:expenz/constants/colors.dart';
import 'package:flutter/material.dart';

class FrontPage extends StatelessWidget {
  const FrontPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/images/logo.png", fit: BoxFit.cover, width: 100),
        SizedBox(height: 20),
        Text(
          "Expenz",
          style: TextStyle(
            fontSize: 40,
            color: kMainColor,
            fontWeight: FontWeight.bold, //
          ),
        ),
      ],
    );
  }
}
