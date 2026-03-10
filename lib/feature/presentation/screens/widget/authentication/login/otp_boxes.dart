import 'package:flutter/material.dart';

class OtpBoxes extends StatelessWidget {
  const OtpBoxes({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final boxWidth = (screenWidth - 130) / 5;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        5,
        (index) => Container(
          width: boxWidth,
          height: boxWidth,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          child: TextField(
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            decoration: InputDecoration(
              counterText: "",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.green),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
