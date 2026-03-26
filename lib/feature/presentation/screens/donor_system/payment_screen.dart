import 'package:aoun/core/routes_manager/routes.dart';
import 'package:aoun/feature/presentation/screens/widget/authentication/auth_botton.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? selectedPaymentMethod;
  int? selectedAmount;

  final TextEditingController customAmountController = TextEditingController();

  bool isGift = false;

  final TextEditingController recipientNameController = TextEditingController();
  final TextEditingController recipientPhoneController =
      TextEditingController();
  final TextEditingController messageController = TextEditingController();

  final List<int> amounts = [50, 100, 500, 10];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xffE5EBE9),
        appBar: AppBar(
          title: const Text(
            'الدفع',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          foregroundColor: const Color(0xff255A41),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'حدد مبلغ التبرع',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 16,
                runSpacing: 10,
                children:
                    amounts.map((amt) {
                      bool isSelected = selectedAmount == amt;
                      return ChoiceChip(
                        labelStyle: const TextStyle(color: Color(0xff255A41)),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 3,
                        ),
                        color: const WidgetStatePropertyAll(Color(0xffE5EBE9)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(color: Color(0xff255A41)),
                        ),
                        label: Text('$amt'),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            selectedAmount = selected ? amt : null;
                            customAmountController.clear();
                          });
                        },
                      );
                    }).toList(),
              ),
              const SizedBox(height: 12),
              const Text(
                "أو أدخل مبلغ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 35,
                width: double.infinity,
                child: TextField(
                  controller: customAmountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Color(0xff6E6A6A)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Color(0xff6E6A6A)),
                    ),
                    hintText: "قيمة التبرع",
                    hintStyle: const TextStyle(color: Colors.grey),
                  ),
                  onChanged: (value) {
                    setState(() {
                      selectedAmount = null;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/present_payment.png",
                        width: 24,
                      ),
                      const SizedBox(width: 8),
                      const Text('أرسل التبرع كهدية'),
                    ],
                  ),
                  Transform.scale(
                    scaleY: 0.5,
                    child: Switch(
                      value: isGift,
                      onChanged: (val) {
                        setState(() {
                          isGift = val;
                        });
                      },
                      activeColor: Colors.white,
                      activeTrackColor: const Color(0xff255A41),
                      inactiveThumbColor: const Color(0xffD9D9D9),
                      inactiveTrackColor: const Color(0xff717573),
                    ),
                  ),
                ],
              ),
              if (isGift) ...[
                const SizedBox(height: 12),
                const Text(
                  "بيانات مستلم الهدية",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 12),
                _buildGiftField("اسم المستلم", recipientNameController),
                const SizedBox(height: 12),
                _buildGiftField("رقم هاتف المستلم", recipientPhoneController),
                const SizedBox(height: 12),
                _buildGiftField(
                  "اكتب له رسالة",
                  messageController,
                  maxLines: 3,
                ),
              ],
              const SizedBox(height: 20),
              Row(
                children: [
                  Image.asset("assets/images/pay_way.png", width: 24),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _showPaymentMethods(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(selectedPaymentMethod ?? 'اختر طريقة الدفع'),
                            const Icon(Icons.arrow_forward_ios, size: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: 30),
              AuthButton(
                text: "تابع الدفع",
                onTap: () {
                  Navigator.pushNamed(context, Routes.creditDetailsScreen);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGiftField(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
  }) {
    return SizedBox(
      width: double.infinity,
      height: maxLines == 1 ? 35 : 65,
      child: TextField(
        maxLines: maxLines,
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Color(0xff6E6A6A)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Color(0xff6E6A6A)),
          ),
          labelText: label,
        ),
      ),
    );
  }

  void _showPaymentMethods(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Color(0xffEDEDED),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _paymentItem("دفع جوجل", "assets/images/logos_google-pay.png"),
              const Divider(),
              _paymentItem(
                "بطاقة ائتمان جديدة",
                "assets/images/logos_visaelectron.png",
              ),
              const Divider(),
              _paymentItem(
                "محفظة إلكترونية",
                "assets/images/lets-icons_wallet-duotone.png",
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _paymentItem(String title, String imagePath) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedPaymentMethod = title;
        });
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 10),
            Container(
              width: 55,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: const Color(0xffCEE5DA),
              ),
              child: Image.asset(imagePath, width: 30, height: 30),
            ),
          ],
        ),
      ),
    );
  }
}
