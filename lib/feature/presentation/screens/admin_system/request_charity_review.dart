import 'package:aoun/core/color_manager/app_color.dart';
import 'package:aoun/core/routes_manager/routes.dart';
import 'package:aoun/feature/data/data_sources/api_services.dart';
import 'package:aoun/feature/data/models/charity_details_model.dart';
import 'package:aoun/feature/presentation/screens/admin_system/admin_app_drawer.dart';
import 'package:aoun/feature/presentation/screens/widget/document_card.dart';
import 'package:aoun/feature/presentation/screens/widget/header.dart';
import 'package:aoun/feature/presentation/screens/widget/info_card.dart';
import 'package:flutter/material.dart';

/// Centralized design tokens so colors / spacing are defined once
/// and stay consistent across the screen.

class RequestCharityReview extends StatefulWidget {
  final int charityId;
  const RequestCharityReview({super.key, required this.charityId});

  @override
  State<RequestCharityReview> createState() => _RequestCharityReviewState();
}

class _RequestCharityReviewState extends State<RequestCharityReview> {
  CharityDetailsModel? charity;
  bool isLoading = true;

  Future<void> getCharityData() async {
    try {
      final response = await ApiServices.getCharityDetails(widget.charityId);

      setState(() {
        charity = CharityDetailsModel.fromJson(response.data["data"]);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCharityData();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    // Clamp so text/icons scale with screen width but never
    // become absurdly large (tablets) or cramped (small phones).
    final titleFontSize = (width * 0.06).clamp(20.0, 26.0);
    final subtitleFontSize = (width * 0.045).clamp(14.0, 18.0);

    // Cap content width on large screens (tablet/desktop/web) so
    // cards don't stretch edge-to-edge unnaturally.
    final maxContentWidth = width > 700 ? 700.0 : double.infinity;
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: const AdminAppDrawer(),
        backgroundColor: AppColors.background,
        appBar: AppBar(backgroundColor: AppColors.primary, toolbarHeight: 0),
        body: SafeArea(
          child: Column(
            children: [
              Header(
                titleFontSize: titleFontSize,
                subtitleFontSize: subtitleFontSize,
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: maxContentWidth),
                      child: Column(
                        children: [
                          BasicInfoCard(charity: charity!),

                          const SizedBox(height: 18),

                          DocumentsCard(documents: charity!.documents),

                          const SizedBox(height: 24),

                          _ActionButtons(charityId: charity!.id, charityName: charity!.charityName),
                          SizedBox(height: 25),
                        ],
                      ),
                    ),
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

class _ActionButtons extends StatelessWidget {
  final int charityId;
  final String charityName;
  const _ActionButtons({required this.charityId, required this.charityName});

  @override
  Widget build(BuildContext context) {
    // Row of two buttons; on very narrow screens (< 320 logical px) this
    // could still be tight, so labels are wrapped in Flexible/FittedBox
    // inside _ActionButton to avoid overflow rather than hardcoding sizes.
    return Row(
      children: [
        Expanded(
          child: _ActionButton(
            color: AppColors.primary,
            iconColor: AppColors.primaryDark,
            icon: Icons.check,
            label: "قبول الجمعية",
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AcceptCharityDialog(charityId: charityId, charityName: charityName,),
              );
            },
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: _ActionButton(
            color: AppColors.danger,
            iconColor: AppColors.danger,
            icon: Icons.close,
            label: "رفض الجمعية",
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => RejectCharityDialog(charityId: charityId, charityName: charityName,),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final Color color;
  final Color iconColor;
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.color,
    required this.iconColor,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: const Size.fromHeight(45),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        padding: const EdgeInsets.symmetric(horizontal: 12),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 15,
            height: 15,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Center(child: Icon(icon, color: iconColor, size: 14)),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AcceptCharityDialog extends StatelessWidget {
  final String charityName;
  final int charityId;
  const AcceptCharityDialog({super.key, required this.charityId, required this.charityName});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;

    return Dialog(
      backgroundColor: Colors.white,

      insetPadding: EdgeInsets.symmetric(horizontal: width * .08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Padding(
          padding: EdgeInsets.all(width * .05),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "تأكيد قبول الجمعية",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: width * .055,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: width * .04),

               Text(
                """هل أنت متأكد من قبول جمعية “$charityName “؟
سيتم تفيعل حسابها وإرسال إشعار بالقبول""",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 15,
                  height: 1.7,
                  color: Colors.black54,
                ),
              ),

              SizedBox(height: width * .06),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          await ApiServices.updateCharityStatus(
                            charityId: charityId,
                            status: "Approved",
                          );

                          Navigator.pop(context); // يقفل الـ Dialog

                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            Routes.adminHome,
                            (route) => false,
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("حدث خطأ")),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff2F674D),
                        minimumSize: const Size.fromHeight(45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const FittedBox(
                        child: Text(
                          "تأكيد القبول",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "إلغاء",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RejectCharityDialog extends StatelessWidget {
  final int charityId;
  final String charityName;
  const RejectCharityDialog({super.key, required this.charityId, required this.charityName});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;

    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: width * 0.08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Padding(
          padding: EdgeInsets.all(width * 0.05),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "رفض الجمعية",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: width < 600 ? 22 : 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff3B3B3B),
                ),
              ),

              SizedBox(height: width * 0.04),

               Directionality(
                textDirection: TextDirection.rtl,
                child: Text(
                  """
يرجى إدخال سبب رفض جمعية $charityName , هذا السبب سيتم إرساله للجمعية
""",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.7,
                    color: Color(0xff666666),
                  ),
                ),
              ),

              SizedBox(height: width * 0.001),

              SizedBox(
                height: width < 600 ? 120 : 140,
                child: TextField(
                  expands: true,
                  maxLines: null,
                  minLines: null,
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    hintText: "اكتب سبب الرفض هنا...",
                    hintTextDirection: TextDirection.rtl,
                    hintStyle: const TextStyle(color: Color(0xffD9D9D9)),
                    filled: true,
                    fillColor: const Color(0xffF3F3F3),
                    contentPadding: const EdgeInsets.all(16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              SizedBox(height: width * 0.06),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          await ApiServices.updateCharityStatus(
                            charityId: charityId,
                            status: "Rejected",
                          );
                          Navigator.pop(context); // يقفل الـ Dialog

                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            Routes.adminHome,
                            (route) => false,
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("حدث خطأ")),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: const Color(0xffC30B0B),
                        minimumSize: const Size.fromHeight(45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const FittedBox(
                        child: Text(
                          "تأكيد الرفض",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(45),
                        side: const BorderSide(color: Color(0xffBDBDBD)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const FittedBox(
                        child: Text(
                          "إلغاء",
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String getDocumentName(String type) {
  switch (type) {
    case "RegistrationCertificate":
      return "شهادة تسجيل الجمعية";

    case "TaxCard":
      return "البطاقة الضريبية";

    case "BankAccountProof":
      return "إثبات حساب  بنكي";

    case "NationalId":
      return "بطاقة الرقم القومي للمسؤول";

    default:
      return type;
  }
}
