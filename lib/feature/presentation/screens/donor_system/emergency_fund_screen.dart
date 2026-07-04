import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmergencyFundScreen extends StatefulWidget {
  const EmergencyFundScreen({super.key});

  @override
  State<EmergencyFundScreen> createState() => _EmergencyFundScreenState();
}

class _EmergencyFundScreenState extends State<EmergencyFundScreen> {
  final TextEditingController amountController = TextEditingController();
  int? selectedAmount;

  final List<int> amounts = [50, 100, 500, 1000];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xffEEF2F0),
        appBar: AppBar(
          backgroundColor: const Color(0xff2F674D),
          toolbarHeight: 189,
          shape: const OutlineInputBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35),
            ),
            borderSide: BorderSide(color: Color(0xff2F674D)),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(bottom: 38.0),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 38.0),
            child: Row(
              children: [
                Center(
                  child: Text(
                    " خزنة الطوارئ",
                    style: GoogleFonts.manrope(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              /// HEADER
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Row(
                          children: [
                            Container(
                              width: 5,
                              height: 23,
                              decoration: BoxDecoration(
                                color: Color(0xFF2E7D5B),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            SizedBox(width: 8),

                            Text(
                              "عن خزنة الطوارئ",
                              style: GoogleFonts.saira(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 12),

                      /// INFO CARD
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xffF3F1E9),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.green.shade100),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.info_outline, color: Colors.green.shade700, size: 20),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "خزنة الطوارئ هي رصيد إنساني داخل الجمعية، يُستخدم فقط في الحالات العاجلة التي تتطلب تدخل سريع دون تأخير.\nتبرعك هنا ليس مجرد مساهمة... بل هو إنقاذ فوري لحياة قد تكون في خطر...\nاجعل عطائك حاضرًا وقت الحاجة... وكن سببًا في نجاة إنسان.. 💚",
                                textAlign: TextAlign.right,
                                style: GoogleFonts.cairo(fontSize: 12, height: 1.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      /// DONATION CARD
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Column(
                          children: [
                            Text("ساهم في صندوق الطوارئ", style: GoogleFonts.cairo(fontSize: 16, fontWeight: FontWeight.bold)),
                            Text("(جنيه مصري)", style: GoogleFonts.cairo(color: Colors.grey, fontSize: 12)),
                            const SizedBox(height: 15),
                            TextField(
                              controller: amountController,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: "أدخل مبلغ التبرع",
                                hintStyle: GoogleFonts.cairo(color: Colors.grey),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Colors.grey.shade300)),
                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: const BorderSide(color: Color(0xff2F6F4F))),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: amounts.map((amount) {
                                final selected = selectedAmount == amount;
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedAmount = amount;
                                      amountController.text = amount.toString();
                                    });
                                  },
                                  child: Container(
                                    width: 65,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      color: selected ? const Color(0xff2F6F4F) : Colors.white,
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(color: const Color(0xff2F6F4F)),
                                    ),
                                    child: Center(
                                      child: Text(amount.toString(), style: GoogleFonts.cairo(color: selected ? Colors.white : const Color(0xff2F6F4F), fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 25),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff2F6F4F),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                onPressed: () {},
                                child: Text("تبرع الآن", style: GoogleFonts.cairo(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.info_outline, size: 16, color: Colors.green.shade700),
                          const SizedBox(width: 6),
                          Text("تبرعك آمن ويستخدم للحالات العاجلة فقط", style: GoogleFonts.cairo(fontSize: 12, color: Colors.grey.shade700)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}