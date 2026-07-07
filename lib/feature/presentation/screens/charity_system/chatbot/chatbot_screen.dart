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
      final answer = await ApiServices.askCharityAI(
        question: question,
      );

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
        body: Column(
          children: [
            _buildHeader(context),
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
                      color: Colors.black54,
                      fontStyle: FontStyle.italic,
                      fontSize: 19
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
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF1E5E4F),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(22),
          bottomRight: Radius.circular(22),
        ),
      ),
      padding: EdgeInsets.only(top: 30),
      child: SafeArea(
        child: Stack(
          children: [
            /// Close Button
            Positioned(
              left: 20,
              top: 14,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.homeCharity);
                },
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),

            /// Center Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 68.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    "AI Assistant",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    "مساعد عون الذكى",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),

            /// Star Icon
            Positioned(
              right: 22,
              top: 16,
              child: Image.asset(
                "assets/images/star.png",
                width: 36,
                height: 36,
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildInputBar(double h, double w) {
    return Padding(
      padding: EdgeInsets.only(right: 13,left:13,top: 10,bottom: 60),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 56,
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
                  hintStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff838181)
                  ),
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

                  const SizedBox(width: 8),

                  Text(
                    "اقتراحات:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff3E403F),
                      fontSize: 22,

                    ),
                  ),
                ],
              ),
            ),
          ),


          if (isExpanded)
            ...suggestions.map(
                  (item) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(35),
                      onTap: () {
                        onSuggestionTap(item["text"] as String);
                      },
                      child: Container(
                        height: 60,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: const Color(0xffE0E0E0),
                          borderRadius: BorderRadius.circular(35),
                          border: Border.all(
                            color: const Color(0xffCCCCCC),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          textDirection: TextDirection.rtl,
                          children: [
                            Icon(
                              item["icon"] as IconData,
                              color: const Color(0xff2F6B52),
                              size: 34,
                            ),
                    SizedBox(width: 8),
                            Text(
                              item["text"] as String,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 19,
                                color: Color(0xff3E403F),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
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
