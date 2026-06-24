import 'package:aoun/core/routes_manager/routes.dart';
import 'package:aoun/feature/data/data_sources/api_services.dart';
import 'package:aoun/feature/presentation/screens/widget/charity_register/dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:aoun/core/color_manager/primary_colors.dart';

class AccountState extends StatefulWidget {
  const AccountState({super.key});

  @override
  State<AccountState> createState() => _AccountStateState();
}

class _AccountStateState extends State<AccountState> {
  // Pending = حسابك قيد المراجعة
  // Approved = تم تفعيل الحساب
  // Rejected = لم يتم تفعيل الحساب

  Future<void> checkStatus() async {
    try {
      final response = await ApiServices.getCharityStatus();

      final status = response.data["data"]["status"];

      if (status == "Pending") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("الحساب مازال قيد المراجعة")),
        );
      } else if (status == "Approved") {
        showDialog(
          context: context,
          builder:
              (context) => DialogWidget(
                markColor: PrimaryColors.primaryColor,
                markColorBacground: const Color(0xffA7C0B5),
                accounState: 'تم تفعيل الحساب!',
                accounStateParagraph: const Text(
                  "تمت الموافقة على حساب الجمعية ويمكنك الآن استخدام المنصة.",
                  textAlign: TextAlign.end,
                ),
                accountStateButton: 'تسجيل الدخول الآن',
                icon: Icons.check,
                onTap: () {
                  Navigator.pushReplacementNamed(
                    context,
                    Routes.charityLoginScreen,
                  );
                },
              ),
        );
      } else if (status == "Rejected") {
        showDialog(
          context: context,
          builder:
              (context) => DialogWidget(
                markColor: const Color(0xffAF3F3F),
                markColorBacground: Colors.red.withAlpha(50),
                accounState: 'لم يتم تفعيل الحساب!',
                accounStateParagraph: const Text(
                  "يرجى مراجعة البيانات والمستندات وإعادة التقديم.",
                  textAlign: TextAlign.end,
                ),
                accountStateButton: 'التواصل مع الدعم',
                icon: Icons.close,
                onTap: () {},
              ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    double scale(double value) => value * (width / 390);

    /// Responsive spacing helper
    double vSpace(double fraction) => height * fraction;
    double hSpace(double fraction) => width * fraction;

    return Scaffold(
      backgroundColor: const Color(0xffE5EBE9),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: hSpace(0.08)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: vSpace(0.12)),

                      /// Title
                      Text(
                        "حالة الحساب",
                        style: TextStyle(
                          fontSize: scale(28),
                          fontWeight: FontWeight.bold,
                          color: PrimaryColors.primaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: vSpace(0.03)),

                      /// Icon
                      Image.asset(
                        "assets/images/account_revision.png",
                        width: width * 0.35,
                        fit: BoxFit.contain,
                      ),

                      SizedBox(height: vSpace(0.03)),

                      /// Status Text
                      Text(
                        "حسابك قيد المراجعة",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: scale(22),
                          fontWeight: FontWeight.w600,
                          color: PrimaryColors.primaryColor,
                        ),
                      ),

                      SizedBox(height: vSpace(0.015)),

                      /// Description
                      Text(
                        "سيتم التواصل معكم خلال أيام عبر البريد الإلكتروني المرفق أثناء التسجيل",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: scale(18),
                          color: const Color(0xff7E7B7B),
                        ),
                      ),

                      SizedBox(height: vSpace(0.05)),

                      /// Buttons
                      _buildStatusButton(
                        context,
                        scale,
                        color: PrimaryColors.primaryColor,
                        icon: Icons.refresh,
                        text: "تحديث الحالة",
                        onPressed: checkStatus,
                      ),

                      SizedBox(height: vSpace(0.02)),

                      _buildSupportButton(
                        scale,
                        "التواصل مع الدعم",
                        Icons.headset_mic,
                      ),

                      SizedBox(height: vSpace(0.08)),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatusButton(
    BuildContext context,
    double Function(double) scale, {
    required Color color,
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: scale(50),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(scale(10)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(3.1416),
              child: Icon(icon, size: 24, color: Colors.white),
            ),
            SizedBox(width: scale(8)),
            Text(
              text,
              style: TextStyle(fontSize: scale(18), color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportButton(
    double Function(double) scale,
    String text,
    IconData icon,
  ) {
    return SizedBox(
      width: double.infinity,
      height: scale(50),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: PrimaryColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(scale(10)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24, color: Colors.white),
            SizedBox(width: scale(8)),
            Text(
              text,
              style: TextStyle(fontSize: scale(18), color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
