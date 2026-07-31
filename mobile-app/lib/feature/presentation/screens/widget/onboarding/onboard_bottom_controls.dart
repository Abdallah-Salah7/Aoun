import 'package:aoun/core/color_manager/primary_colors.dart';
import 'package:flutter/material.dart';

class BottomControls extends StatelessWidget {
  final VoidCallback? skipFunction;
  final VoidCallback? followFunction;

  const BottomControls({super.key, this.skipFunction, required this.followFunction});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(bottom: size.height * 0.04),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isTablet ? 500 : double.infinity,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Back Button
                InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: followFunction,
                  child:
                      skipFunction != null
                          ? Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: isTablet ? 30 : size.width * 0.05,
                              vertical: isTablet ? 14 : size.height * 0.015,
                            ),
                            decoration: BoxDecoration(
                              color: PrimaryColors.primaryColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                  size: isTablet ? 20 : size.width * 0.045,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  "التالى",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: isTablet ? 16 : size.width * 0.05,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          )
                          : Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: isTablet ? 30 : size.width * 0.05,
                              vertical: isTablet ? 14 : size.height * 0.015,
                            ),
                            decoration: BoxDecoration(
                              color: PrimaryColors.primaryColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                  size: isTablet ? 20 : size.width * 0.045,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  "ابدأ الآن",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: isTablet ? 16 : size.width * 0.05,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                ),
      
                /// Skip Button
                skipFunction != null
                    ? TextButton(
                      onPressed: skipFunction,
                      child: Text(
                        "تخطى",
                        style: TextStyle(
                          color: PrimaryColors.secondaryColor,
                          fontSize: isTablet ? 16 : size.width * 0.045,
                        ),
                      ),
                    )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
