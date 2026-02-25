import 'package:aoun/feature/presentation/screens/tabs/donation_tab.dart';
import 'package:aoun/feature/presentation/screens/tabs/main_tab.dart';
import 'package:aoun/feature/presentation/screens/tabs/profile_tab.dart';
import 'package:aoun/feature/presentation/screens/tabs/zakat_tab.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../../../core/resources/assets_manager.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  final labels = ["الرئيسية", " التبرعات", "الزكاة", "حسابي"];

  final icons = [
    ImageAssets.mainTab,
    ImageAssets.donationTab,
    ImageAssets.zakatTab,
    ImageAssets.profileTab
  ];

  final List<Widget> pages = [
    const MainTab(),
    const DonationTab(),
    const ZakatTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final itemWidth = width / icons.length;

    return Scaffold(
      extendBody: true,
      body: pages[currentIndex],

      bottomNavigationBar: Stack(
        children: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: CurvedNavigationBar(
              index: currentIndex,
              height: 75,
              backgroundColor: Colors.white,
              color: const Color(0xff2C5240),
              buttonBackgroundColor: const Color(0xff2C5240),
              animationDuration: const Duration(milliseconds: 300),
              items: icons
                  .map((e) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Image.asset(e, width: 28, color: Colors.white),
                ),
              ))
                  .toList(),
              onTap: (index) => setState(() => currentIndex = index),
            ),
          ),

          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            bottom: 2,
            right: itemWidth * currentIndex + (itemWidth / 2) - 35,
            child: SizedBox(
              width: 70,
              child: Center(

                child: Text(
                  labels[currentIndex],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                     fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}