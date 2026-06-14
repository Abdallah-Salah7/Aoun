import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/routes_manager/routes.dart';
import '../../../data/data_sources/api_services.dart';
import '../../../data/models/zakat_model.dart';

class ZakatGold extends StatefulWidget {
  final VoidCallback onSeeMorePressed;
  ZakatGold({super.key, required this.onSeeMorePressed});


  @override
  State<ZakatGold> createState() => _ZakatGoldState();
}

class _ZakatGoldState extends State<ZakatGold> {
  final controller24 = TextEditingController();
  final controller21 = TextEditingController();
  final controller18 = TextEditingController();
  final controller14 = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,

      child: Scaffold(
        backgroundColor: Color(0xffE5EBE9),

        appBar: AppBar(
          backgroundColor: Color(0xff2F674D),
          toolbarHeight: 168,
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35),
            ),
            borderSide: BorderSide(color: Color(0xff2F674D)),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),

          title: Padding(
            padding: const EdgeInsets.only(top: 38.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Image(
                    image: AssetImage(ImageAssets.gold),
                    height: 29,
                    width: 29,
                  ),
                ),

                SizedBox(width: 8),

                Text(
                  "زكاة الذهب ",
                  style: GoogleFonts.manrope(
                    fontSize: 26,
                    fontWeight: FontWeight.w700, // SemiBold
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Align(
            alignment: Alignment.topRight,

            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          "إجمالى الذهب",
                          style: GoogleFonts.saira(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.grey.shade400,
                                width: 1.5,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 5,
                            ),
                            child: Row(
                              children: [
                                Image(
                                  image: AssetImage(ImageAssets.caliber),
                                  width: 29,
                                  height: 29,
                                ),
                                Text(
                                  "عيار 24",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),

                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: controller24,
                          textAlign: TextAlign.right,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "الوزن بالجرام",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                "جرام",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                ),
                              ),
                            ),

                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                                width: 1.5,
                              ),
                            ),

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                                width: 1.5,
                              ),
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 26),

                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.grey.shade400,
                                width: 1.5,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 5,
                            ),
                            child: Row(
                              children: [
                                Image(
                                  image: AssetImage(ImageAssets.caliber),
                                  width: 29,
                                  height: 29,
                                ),
                                Text(
                                  "عيار 21",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),

                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: controller21,
                          textAlign: TextAlign.right,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "الوزن بالجرام",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                "جرام",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                ),
                              ),
                            ),

                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                                width: 1.5,
                              ),
                            ),

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                                width: 1.5,
                              ),
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 26),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.grey.shade400,
                                width: 1.5,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 5,
                            ),
                            child: Row(
                              children: [
                                Image(
                                  image: AssetImage(ImageAssets.caliber),
                                  width: 29,
                                  height: 29,
                                ),
                                Text(
                                  "عيار 18",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),

                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: controller18,
                          textAlign: TextAlign.right,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "الوزن بالجرام",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                "جرام",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                ),
                              ),
                            ),

                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                                width: 1.5,
                              ),
                            ),

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                                width: 1.5,
                              ),
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 26),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.grey.shade400,
                                width: 1.5,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 5,
                            ),
                            child: Row(
                              children: [
                                Image(
                                  image: AssetImage(ImageAssets.caliber),
                                  width: 29,
                                  height: 29,
                                ),
                                Text(
                                  "عيار 14",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),

                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: controller14,
                          textAlign: TextAlign.right,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "الوزن بالجرام",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                "جرام",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                ),
                              ),
                            ),

                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                                width: 1.5,
                              ),
                            ),

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                                width: 1.5,
                              ),
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 26),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 36,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffE0E2DA),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Color(0xffDCD79E),
                          width: 1.5,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 25,
                        horizontal: 12,
                      ),
                      child: Row(
                        children: [
                          Image(
                            image: AssetImage(ImageAssets.hint),
                            height: 29,
                            width: 29,
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "تنبيه",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 22,
                                    ),
                                  ),
                                  Text(
                                    " : قيمة نصاب الذهب       ",
                                    style: TextStyle(
                                      color: Color(0xff4B4B4B),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                " من قيمة 85 جرام عيار 24 فأكثر",
                                style: TextStyle(
                                  color: Color(0xff4B4B4B),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff2F674D),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () async {
                          try {
                            final gold24 =
                                double.tryParse(controller24.text.trim()) ?? 0;

                            final gold21 =
                                double.tryParse(controller21.text.trim()) ?? 0;

                            final gold18 =
                                double.tryParse(controller18.text.trim()) ?? 0;

                            final gold14 =
                                double.tryParse(controller14.text.trim()) ?? 0;

                            // تحويل عيار 14 لمكافئ عيار 24
                            final converted14 = gold14 * (14 / 24);

                            final response = await ApiServices().calculateZakat(
                              ZakatModel(
                                cash: 0,
                                bank: 0,
                                gold24: gold24 + converted14,
                                gold21: gold21,
                                gold18: gold18,
                                silverGrams: 0,
                                investments: 0,
                                debts: 0,
                              ),
                            );

                            if (response['isEligible'] == false) {
                              showErrorDialog(
                                context,
                                "حدث خطأ ما !\n قيمة الذهب أقل من النصاب الشرعي، وهو\n ما يعادل 85 جرام من الذهب من عيار 24.",
                              );
                              return;
                            }

                            showZakatSheet(
                              context,
                              response['zakat'],
                            );
                          } catch (e) {
                            print("GOLD ERROR = $e");

                            showErrorDialog(
                              context,
                              "حدث خطأ أثناء حساب الزكاة",
                            );
                          }
                        },

                        child: Text(
                          "احسب قيمة الزكاة",
                          style: GoogleFonts.manrope(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showZakatSheet(
      BuildContext context,
      dynamic zakatAmount,
      ){
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xffE8EBE9),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Color(0xff83A695), width: 1.2),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "إجمالى الزكاة",
                          style: GoogleFonts.saira(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${(zakatAmount as num).toStringAsFixed(2)} ج.م",
                          style: GoogleFonts.saira(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: widget.onSeeMorePressed ?? () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF2F6B4F),
                        padding: EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        "تبرع الآن",
                        style: TextStyle(
                          fontSize: 26,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  void showErrorDialog(BuildContext context, String message) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "error",
      barrierColor: Colors.black.withOpacity(0.4),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, anim1, anim2) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    margin: const EdgeInsets.only(top: kToolbarHeight + 110),
                    padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                       Image(image: AssetImage(ImageAssets.error),
                       width: 39,
                       height: 39,),

                        const SizedBox(width: 10),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                message,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),

                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

}
