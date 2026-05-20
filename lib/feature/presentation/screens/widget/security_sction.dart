import 'package:flutter/material.dart';

class SecuritySction extends StatelessWidget {
  const SecuritySction({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        _buildCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      color: const Color(0xffEAF2EF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Image.asset(
                        "assets/images/hugeicons_security-lock.png",
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "الأمان",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xffF9FAFB),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'تغيير كلمة المرور',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Text(
                          'آخر تغيير: 15 يناير 2024',
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 50,
                      height: 30,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          side:BorderSide(color: Colors.grey),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black87,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            
                          ),
                          
                        ),
                        child: const Text(
                          'تغيير',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'المصادقة الثنائية',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'طبقة أمان إضافية لحسابك',
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: false, // Change as needed
                    onChanged: (val) {},
                    activeThumbColor: const Color(0xFF4CAF50),
                  ),
                ],
              ),
              _buildMenuItem(
                widget: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xffEAF2EF),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Center(
                            child: Image.asset(
                              "assets/images/material-symbols_privacy-tip-outline.png",
                            ),
                          ),
                        ),
                title: 'الخصوصية والأمان',
                onTap: () {},
              ),
              _buildMenuItem(
                widget:Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xffEAF2EF),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Center(
                            child: Image.asset(
                              "assets/images/ep_service.png",
                            ),
                          ),
                        ),
                title: 'التواصل مع الدعم',
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
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

  Widget _buildMenuItem({
    required Widget widget,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            widget,
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 18, color: Color(0xff43332B)),
          ],
        ),
      ),
    );
  }
}
