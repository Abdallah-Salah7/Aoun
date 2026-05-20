import 'package:aoun/core/routes_manager/routes.dart';
import 'package:aoun/feature/presentation/screens/widget/authentication/user_type_content.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class GeneralLoginChoicePage extends StatelessWidget {
  const GeneralLoginChoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xffE5EBE9),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double cardWidth;
            if (constraints.maxWidth > 1200) {
              cardWidth = 500; // Desktop / Web 
            } else if (constraints.maxWidth > 900) {
              cardWidth = 450; // Web / Large Tablet
            } else if (constraints.maxWidth > 600) {
              cardWidth = 400; // Tablet
            } else {
              cardWidth = min(size.width * 0.9, 400); // Mobile
            }

            return Center(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: cardWidth),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: min(size.width * 0.05, 20),
                      vertical: 20,
                    ),
                    child: Content(
                      textButton1: "متبرع",
                      textButton2: "جمعية خيرية",
                      onTap1: () {
                        Navigator.pushNamed(
                          context,
                          Routes.loginChoiceScreen,
                          arguments: "donor",
                        );
                      },
                      onTap2: () {
                        Navigator.pushNamed(
                          context,
                          Routes.loginChoiceScreen,
                          arguments: "charity",
                        );
                      }, textButton3: 'أدمن', onTap3: () {
                         Navigator.pushNamed(
                          context,
                          Routes.loginChoiceScreen,
                          arguments: "admin",
                        );
                        },
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
