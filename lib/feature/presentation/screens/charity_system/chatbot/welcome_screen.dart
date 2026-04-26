import 'package:aoun/core/routes_manager/routes.dart';
import 'package:flutter/material.dart';
import 'package:aoun/core/color_manager/primary_colors.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final h = size.height;
    final w = size.width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFD9DDDA),
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(h, w, context),
              SizedBox(height: h * 0.02),

              _buildBotMessage(w),

              const Spacer(),

              const SuggestionsSection(),

              _buildInputBar(h, w),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(double h, double w, BuildContext context) {
    return Container(
      height: h * 0.12,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: w * 0.04),
      decoration: const BoxDecoration(
        color: Color(0xFF1E5E4F),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "AI Assistant",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              SizedBox(height: 4),
              Text(
                "مساعد عون الذكى",
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),

          // left icon
          Positioned(
            left: 0,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, Routes.homeCharity);
              },
              child: Image.asset("assets/images/x.png", height: h * 0.03),
            ),
          ),

          // right icon
          Positioned(
            right: w * 0.1,
            child: Image.asset("assets/images/star.png", height: h * 0.055),
          ),
        ],
      ),
    );
  }

  Widget _buildBotMessage(double w) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: w * 0.04),
        padding: const EdgeInsets.all(14),
        constraints: BoxConstraints(maxWidth: w * 0.75),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(16),
          ),
        ),
        child: const Text(
          "مرحباً ! أنا مساعدك الذكى ، كيف يمكننى مساعدتك اليوم ؟",
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: 14),
        ),
      ),
    );
  }

  Widget _buildInputBar(double h, double w) {
    return Padding(
      padding: EdgeInsets.all(w * 0.03),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: h * 0.055,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const TextField(
                textDirection: TextDirection.rtl,
                decoration: InputDecoration(
                  hintText: "اكتب سؤالك هنا...",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            height: h * 0.055,
            width: h * 0.055,
            decoration: BoxDecoration(
              color: Color(0xFF1E5E4F),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset("assets/images/tabler_send.png"),
            ),
          ),
        ],
      ),
    );
  }
}

class SuggestionsSection extends StatelessWidget {
  const SuggestionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    final suggestions = [
      {"text": "اعملى تقرير عن هذا الشهر", "icon": Icons.description_outlined},
      {"text": "ما هو أكثر مجال عليه تبرعات", "icon": Icons.trending_up},
      {"text": "تحليل التبرعات", "icon": Icons.bar_chart},
    ];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: w * 0.04),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "اقتراحات:",
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: PrimaryColors.secondaryColor,
            ),
          ),
          const SizedBox(height: 10),

          ...suggestions.map(
            (item) => InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Routes.chatbotAskScreen,
                  arguments: item["text"] as String,
                );
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F6F6),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Icon(
                      item["icon"] as IconData,
                      size: 20,
                      color: const Color(0xFF1E5E4F),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        item["text"] as String,
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
