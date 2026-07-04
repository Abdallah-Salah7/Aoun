import 'package:aoun/feature/presentation/screens/donor_system/payments/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routes_manager/routes.dart';

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
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
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
                        margin: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xffF3F1E9),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Color(0xffCEBF3D),
                            width: 2,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Color(0xff2C7956),
                              size: 25,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "خزنة الطوارئ هي رصيد إنساني داخل\nالجمعية، يُستخدم فقط في الحالات\nالعاجلة التي تتطلب تدخل سريع دون\nتأخير.\nتبرعك هنا ليس مجرد مساهمة…\nبل هو إنقاذ فوري لحياة قد تكون في\nخطر...\nاجعل عطائك حاضرًا وقت الحاجة… وكن\nسببًا في نجاة إنسان.. 💚",
                                textAlign: TextAlign.right,
                                style: GoogleFonts.cairo(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w600,
                                ),
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
                        margin: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black54, width: 2),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "ساهم في صندوق الطوارئ",
                              style: GoogleFonts.cairo(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff393838)
                              ),
                            ),
                            const SizedBox(height: 15),

                            Text(
                              "  مبلغ التبرع (جنيه مصرى)",
                              style: GoogleFonts.cairo(
                                color: Color(0xff393838),
                                fontSize: 18,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: amountController,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    color: Color(0xffC4C4C4),
                                    width: 2
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                      color: Color(0xffC4C4C4),
                                      width: 2)
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:
                                  amounts.map((amount) {
                                    final selected = selectedAmount == amount;
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedAmount = amount;
                                          amountController.text =
                                              amount.toString();
                                        });
                                      },
                                      child: Container(
                                        width: 65,
                                        height: 65,
                                        decoration: BoxDecoration(
                                          color:
                                              selected
                                                  ? const Color(0xff2F674D)
                                                  : Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          border: Border.all(
                                            color: const Color(0xff2F674D),
                                            width: 1.4
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            amount.toString(),
                                            style: GoogleFonts.cairo(
                                              color:
                                                  selected
                                                      ? Colors.white
                                                      : const Color(0xff2F6F4F),
                                              fontWeight: FontWeight.w700,
                                              fontSize: 22
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                            ),
                            const SizedBox(height: 25),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff2F674D),
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => PaymentScreen(
                                        initialAmount: int.tryParse(amountController.text),
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  "تبرع الآن",
                                  style: GoogleFonts.manrope(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 22,
                            color: Color(0xff2C7956),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "تبرعك آمن ويستخدم للحالات العاجلة فقط",
                            style: GoogleFonts.cairo(
                              fontSize: 19,
                              color: Color(0xff2D2D2D),
                              fontWeight: FontWeight.w700
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

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
