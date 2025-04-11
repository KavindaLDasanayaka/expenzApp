import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/constants.dart';
import 'package:flutter/material.dart';

class IncomeExpenceCard extends StatefulWidget {
  final String title;
  final double amount;
  final String imageUrl;
  final Color bgColor;

  const IncomeExpenceCard({
    super.key,
    required this.title,
    required this.amount,
    required this.imageUrl,
    required this.bgColor,
  });

  @override
  State<IncomeExpenceCard> createState() => _IncomeExpenceCardState();
}

class _IncomeExpenceCardState extends State<IncomeExpenceCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      height: MediaQuery.of(context).size.height * 0.11,
      decoration: BoxDecoration(
        color: widget.bgColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(child: Image.asset(widget.imageUrl, width: 70)),
            ),
            SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 17,
                    color: kWhite,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "\$ ${widget.amount.toStringAsFixed(0)}",
                  style: TextStyle(
                    fontSize: 20,
                    color: kWhite,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
