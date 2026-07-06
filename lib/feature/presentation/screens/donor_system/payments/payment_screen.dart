import 'package:aoun/feature/presentation/screens/donor_system/payments/credit_details.dart';
import 'package:aoun/feature/presentation/screens/widget/authentication/auth_botton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({
    super.key,
    required this.isCase,
    required this.targetId,
    required this.targetAmount,
  });
  final bool isCase;
  final int targetId;
  final int targetAmount;

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
  void initState() {
    super.initState();

    if (widget.targetAmount > 0) {
      if (amounts.contains(widget.targetAmount)) {
        selectedAmount = widget.targetAmount;
      } else {
        customAmountController.text = widget.targetAmount.toString();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xffE5EBE9),
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: const Text(
              'الدفع',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          foregroundColor: const Color(0xff255A41),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(top: 18.0, right: 8),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 33,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: const Text(
                  'حدد مبلغ التبرع',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 18),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children:
                    amounts.map((amt) {
                      final selected = selectedAmount == amt;

                      return ChoiceChip(
                        selected: selected,
                        onSelected: (value) {
                          setState(() {
                            selectedAmount = value ? amt : null;
                            customAmountController.clear();
                          });
                        },
                        showCheckmark: false,
                        padding: EdgeInsets.zero,
                        backgroundColor: Color(0xffE5EBE9),
                        selectedColor: const Color(0xff2F674D),
                        side: const BorderSide(
                          color: Color(0xff2F674D),
                          width: 1.4,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        label: SizedBox(
                          width: 60,
                          height: 60,
                          child: Center(
                            child: Text(
                              amt.toString(),
                              style: GoogleFonts.cairo(
                                color:
                                    selected
                                        ? Colors.white
                                        : const Color(0xff2F6F4F),
                                fontWeight: FontWeight.w700,
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
              ),
              const SizedBox(height: 32),
              const Text(
                "أو أدخل قيمة التبرع",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 49,
                width: double.infinity,
                child: TextField(
                  controller: customAmountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color(0xff6E6A6A),
                        width: 1.3,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color(0xff6E6A6A),
                        width: 1.3,
                      ),
                    ),
                    hintText: "قيمة التبرع",
                    hintStyle: const TextStyle(
                      color: Colors.black45,
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      selectedAmount = null;
                    });
                  },
                ),
              ),
              const SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/present_payment.png",
                        width: 25,
                        height: 25,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 27),
                      const Text(
                        'أرسل التبرع كهدية',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff342821),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isGift = !isGift;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 75,
                      height: 30,
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color:
                            isGift
                                ? const Color(0xFF8CB5A2)
                                : const Color(0xff717573),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: AnimatedAlign(
                        duration: const Duration(milliseconds: 200),
                        alignment:
                            isGift
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                        child: Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            color:
                                isGift
                                    ? const Color(0xFF2F674D)
                                    : const Color(0xffD9D9D9),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              const Divider(color: Colors.grey, thickness: 1),
              const SizedBox(height: 20),

              if (isGift) ...[
                const SizedBox(height: 12),
                const Text(
                  "بيانات مستلم الهدية",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                const SizedBox(height: 30),
                _buildGiftField(
                  "اسم المستلم",
                  recipientNameController,
                  height: 60,
                  maxLines: 2,
                ),
                const SizedBox(height: 30),
                _buildGiftField(
                  "رقم هاتف المستلم",
                  recipientPhoneController,
                  height: 60,
                  maxLines: 2,
                ),
                const SizedBox(height: 30),
                _buildGiftField(
                  "اكتب له رسالة",
                  messageController,
                  maxLines: 9,
                  height: 90,
                ),
              ],
              const SizedBox(height: 20),

              Row(
                children: [
                  Image.asset(
                    "assets/images/pay_way.png",
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
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

                            Text(selectedPaymentMethod ?? 'اختر طريقة الدفع',  style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff342821),
                            ),),
                            const Icon(Icons.arrow_forward_ios, size: 26),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              AuthButton(
                text: "تابع الدفع",
                onTap: () {
                  int? finalAmount;

                  /// 1- VALIDATION: AMOUNT
                  if (selectedAmount != null) {
                    finalAmount = selectedAmount;
                  } else if (customAmountController.text.trim().isNotEmpty) {
                    finalAmount = int.tryParse(
                      customAmountController.text.trim(),
                    );
                  }

                  /// لم يدخل مبلغ
                  if (finalAmount == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("من فضلك أدخل مبلغ التبرع")),
                    );
                    return;
                  }

                  /// المبلغ صفر أو سالب
                  if (finalAmount <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("يجب أن يكون مبلغ التبرع أكبر من صفر"),
                      ),
                    );
                    return;
                  }

                  /// أكبر من المطلوب
                  if (finalAmount > widget.targetAmount) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "لا يمكن التبرع بأكثر من ${widget.targetAmount.toInt()} جنيه",
                        ),
                      ),
                    );
                    return;
                  }

                  /// 2- VALIDATION: PAYMENT METHOD
                  if (selectedPaymentMethod == null ||
                      selectedPaymentMethod!.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("من فضلك اختر طريقة الدفع")),
                    );
                    return;
                  }

                  /// 3- VALIDATION: GIFT MODE
                  if (isGift) {
                    final name = recipientNameController.text.trim();
                    final phone = recipientPhoneController.text.trim();

                    if (name.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("من فضلك أدخل اسم المستلم"),
                        ),
                      );
                      return;
                    }

                    if (phone.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("من فضلك أدخل رقم المستلم"),
                        ),
                      );
                      return;
                    }

                    if (phone.length < 10) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("رقم الهاتف غير صحيح")),
                      );
                      return;
                    }
                  }

                  /// 4- SUCCESS NAVIGATION
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => CreditDetails(
                            amount: finalAmount!,
                            targetId: widget.targetId,
                            targetType: widget.isCase ? "Case" : "Campaign",
                          ),
                    ),
                  );
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
    double height = 55,
  }) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xff6E6A6A), width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xff6E6A6A), width: 1.5),
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
