import 'package:aoun/core/color_manager/app_color.dart';
import 'package:aoun/core/resources/assets_manager.dart';
import 'package:aoun/core/routes_manager/routes.dart';
import 'package:aoun/feature/data/data_sources/api_services.dart';
import 'package:aoun/feature/data/models/charity_details_model.dart';
import 'package:aoun/feature/presentation/screens/admin_system/admin_app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widget/document_card.dart';
import '../widget/header.dart';
import '../widget/info_card.dart';

/// Centralized design tokens so colors / spacing are defined once
/// and stay consistent across the screen.

class RejectedCharity extends StatefulWidget {
  final int charityId;
  const RejectedCharity({super.key, required this.charityId});

  @override
  State<RejectedCharity> createState() => _RejectedCharityState();
}

class _RejectedCharityState extends State<RejectedCharity> {
  CharityDetailsModel? charity;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getCharityData();
  }

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
  return const Scaffold(
    body: Center(
      child: CircularProgressIndicator(),
    ),
  );
}

if (charity == null) {
  return const Scaffold(
    body: Center(
      child: Text("حدث خطأ"),
    ),
  );
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
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: maxContentWidth),
                      child: Column(
                        children: [
                          BasicInfoCard(charity: charity!),
                          SizedBox(height: 18),
                          DocumentsCard(documents: charity!.documents),
                          SizedBox(height: 24),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 4,
                                height: width < 600 ? 20 : 24,
                                decoration: BoxDecoration(
                                  color: const Color(0xff2F674D),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),

                              SizedBox(width: width * 0.02),

                              Text(
                                "سبب الرفض",
                                style: TextStyle(
                                  color: const Color(0xff2F674D),
                                  fontSize: width < 600 ? 18 : 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.01,
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(width * 0.045),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Center(
                                  child: Text(
                                    """عدم اكتمال المستندات المطلوبة 
والبطاقة الضريبية غير واضحة """,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: const Color(0xff777777),
                                      fontSize: width < 600 ? 14 : 16,
                                      height: 1.7,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.04,
                          ),
                          _ActionButtons(charityId: charity!.id, charityName: charity!.charityName,),
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
        SizedBox(width: MediaQuery.sizeOf(context).width * 0.35),

        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.5,
          child: _ActionButton(
            color: AppColors.primary,
            iconColor: AppColors.primary,
            icon: Icons.check,
            label: "قبول الجمعية",
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) =>  AcceptCharityDialog(charityId: charityId, charityName: charityName,),
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
  final int charityId;
  final String charityName;
  const AcceptCharityDialog({
    super.key,
    required this.charityId,
    required this.charityName,
  });

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
                "تأكيد قبول الجمعية ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: width * .055,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: width * .04),

              Text(
                """
هل أنت متأكد من قبول جمعية “$charityName “؟
سيتم تفيعل حسابها وإرسال إشعار بالقبول
""",
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

                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            Routes.adminHome,
                            (route) => false,
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("حدث خطأ: $e")),
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
                          style: TextStyle(color: Colors.white, fontSize: 18),
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
