import 'package:aoun/core/routes_manager/routes.dart';
import 'package:aoun/feature/data/data_sources/api_services.dart';
import 'package:aoun/feature/data/models/chat_msg.dart';
import 'package:aoun/feature/presentation/screens/widget/msg_bubble.dart';
import 'package:flutter/material.dart';
import 'package:aoun/core/color_manager/primary_colors.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  bool isSuggestionsExpanded = false;
  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  final ScrollController scrollController = ScrollController();
  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  final TextEditingController controller = TextEditingController();
  List<ChatMessage> messages = [
    ChatMessage(
      text: "مرحباً! أنا مساعدك الذكي، كيف يمكنني مساعدتك اليوم؟",
      isUser: false,
    ),
  ];
  bool isLoading = false;
  Future<void> sendMessage() async {
    if (controller.text.trim().isEmpty) return;

    final question = controller.text.trim();

    // أضيف رسالة المستخدم
    setState(() {
      messages.add(ChatMessage(text: question, isUser: true));

      isLoading = true;
    });
    scrollToBottom();

    controller.clear();

    try {
      final answer = await ApiServices.askAdmin(question);

      setState(() {
        messages.add(ChatMessage(text: answer, isUser: false));
      });
      scrollToBottom();
    } catch (e) {
      setState(() {
        messages.add(
          ChatMessage(text: "حدث خطأ أثناء الاتصال بالسيرفر", isUser: false),
        );
      });
      scrollToBottom();
    }

    setState(() {
      isLoading = false;
    });
    scrollToBottom();
  }

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

              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];

                    return MessageBubble(text: msg.text, isUser: msg.isUser);
                  },
                ),
              ),
              if (isLoading)
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      "جاري كتابة الرد...",
                      style: TextStyle(
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              SuggestionsSection(
                isExpanded: isSuggestionsExpanded,
                onExpand: () {
                  setState(() {
                    isSuggestionsExpanded = !isSuggestionsExpanded;
                  });
                },
                onSuggestionTap: (text) {
                  controller.text = text;
                  sendMessage();
                },
              ),
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
              child: TextField(
                controller: controller,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => sendMessage(),
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
          InkWell(
            onTap: sendMessage,
            child: Container(
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
          ),
        ],
      ),
    );
  }
}

class SuggestionsSection extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onExpand;
  final Function(String) onSuggestionTap;
  const SuggestionsSection({
    super.key,
    required this.onSuggestionTap,
    required this.isExpanded,
    required this.onExpand,
  });

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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onExpand,
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 250),
                    child: const Icon(Icons.keyboard_arrow_down),
                  ),

                  const SizedBox(width: 8),

                  Text(
                    "اقتراحات",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: PrimaryColors.secondaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (isExpanded)
            ...suggestions.map(
              (item) => InkWell(
                onTap: () {
                  onSuggestionTap(item["text"] as String);
                },
                child: Container(
                  margin: const EdgeInsets.fromLTRB(12, 0, 12, 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6F6F6),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        item["icon"] as IconData,
                        color: const Color(0xFF1E5E4F),
                      ),
                      const SizedBox(width: 10),
                      Expanded(child: Text(item["text"] as String)),
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
