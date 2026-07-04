import 'package:aoun/core/routes_manager/routes.dart';
import 'package:aoun/feature/presentation/screens/widget/custom_switch.dart';
import 'package:flutter/material.dart';

class SecuritySction extends StatefulWidget {
  const SecuritySction({super.key});

  @override
  State<SecuritySction> createState() => _SecuritySctionState();
}

class _SecuritySctionState extends State<SecuritySction> {
  bool isTwoFactorEnabled = true;

  static const _iconBgColor = Color(0xffEAF2EF);
  static const _fieldBgColor = Color(0xffF9FAFB);
  static const _arrowColor = Color(0xff43332B);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Column(
      children: [
        _buildCard(
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: width * 0.09,
                    height: width * 0.09,
                    decoration: BoxDecoration(
                      color: _iconBgColor,
                      borderRadius: BorderRadius.circular(width * 0.03),
                    ),
                    child: Center(
                      child: Image.asset(
                        "assets/images/hugeicons_security-lock (1).png",
                      ),
                    ),
                  ),
                  SizedBox(width: width * 0.025),
                  Text(
                    "الأمان",
                    style: TextStyle(
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.015),
              Container(
                padding: EdgeInsets.all(width * 0.03),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: _fieldBgColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'تغيير كلمة المرور',
                            style: TextStyle(
                              fontSize: width * 0.045,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: height * 0.003),
                          Text(
                            'آخر تغيير: 15 يناير 2024',
                            style: TextStyle(
                              color: Color(0xff6B7280),
                              fontSize: width * 0.04,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: width * 0.02),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          Routes.changePasswordScreen,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(color: Colors.grey),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black87,
                        elevation: 0,
                        minimumSize: Size(width * 0.14, height * 0.038),
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.025,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'تغيير',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: width * 0.038,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.01),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'المصادقة الثنائية',
                          style: TextStyle(
                            fontSize: width * 0.045,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: height * 0.004),
                        Text(
                          'طبقة أمان إضافية لحسابك',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: width * 0.04,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomSwitch(
                    value: isTwoFactorEnabled,
                    onChanged: (value) {
                      setState(() {
                        isTwoFactorEnabled = value;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCard({required double width, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(width * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  
