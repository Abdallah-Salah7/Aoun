import 'package:flutter/material.dart';

class ProcessingScreen extends StatelessWidget {
  final int amount;
  const ProcessingScreen({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Circular Progress
                SizedBox(
                  width: size.width * 0.2,
                  height: size.width * 0.2,
                  child: CircularProgressIndicator(
                    strokeWidth: 6,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xff308354),
                    ),
                    backgroundColor: Color(0xffD9D9D9),
                  ),
                ),

                SizedBox(height: size.height * 0.04),

                // Main Text
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(
                    "جارى تنفيذ العملية ...",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: size.width * 0.06,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),

                SizedBox(height: size.height * 0.01),

                // Sub Text
                Text(
                  "الرجاء الانتظار",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: size.width * 0.045,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}