import 'package:aoun/feature/presentation/screens/widget/authentication/auth_botton.dart';
import 'package:flutter/material.dart';

class DialogWidget extends StatelessWidget {
  final Color markColor;
  final Color markColorBacground;
  final String accounState;
  final Widget accounStateParagraph;
  final String accountStateButton;
  final IconData icon;
  final Function() onTap;
  const DialogWidget({
    super.key,
    required this.markColor,
    required this.markColorBacground,
    required this.accounState,
    required this.accounStateParagraph,
    required this.accountStateButton,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    double scale(double value) => value * (width / 390);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(scale(20)),
      ),
      child: Padding(
        padding: EdgeInsets.all(scale(22)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: scale(90),
              height: scale(90),
              decoration: BoxDecoration(
                color: markColorBacground,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  width: scale(50),
                  height: scale(50),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: markColor, width: scale(4)),
                  ),
                  child: Icon(icon, size: scale(30), color: markColor),
                ),
              ),
            ),

            SizedBox(height: scale(20)),

            Text(
              accounState,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: scale(22),
                fontWeight: FontWeight.bold,
                color: markColor,
              ),
              textDirection: TextDirection.rtl,
            ),

            SizedBox(height: scale(10)),

            accounStateParagraph,

            SizedBox(height: scale(20)),

            AuthButton(text: accountStateButton, onTap: onTap),
          ],
        ),
      ),
    );
  }
}
