import 'package:aoun/core/color_manager/app_color.dart';
import 'package:aoun/core/resources/assets_manager.dart';
import 'package:aoun/core/routes_manager/routes.dart';
import 'package:aoun/feature/data/data_sources/api_services.dart';
import 'package:aoun/feature/data/models/charity_details_model.dart';
import 'package:aoun/feature/presentation/screens/admin_system/admin_app_drawer.dart';
import 'package:aoun/feature/presentation/screens/widget/document_card.dart';
import 'package:aoun/feature/presentation/screens/widget/header.dart';
import 'package:aoun/feature/presentation/screens/widget/info_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Centralized design tokens so colors / spacing are defined once
/// and stay consistent across the screen.

class AcceptCharityDetails extends StatefulWidget {
  final int charityId;
  const AcceptCharityDetails({super.key, required this.charityId});

  @override
  State<AcceptCharityDetails> createState() => _AcceptCharityDetailsState();
}

class _AcceptCharityDetailsState extends State<AcceptCharityDetails> {
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

    if (charity == null) {
      return const Scaffold(body: Center(child: Text("حدث خطأ")));
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
                          Container(
                            width: width * 0.9,
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.05,
                              vertical: width * 0.045,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(.08),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: width * 0.15,
                                  height: width * 0.15,
                                  decoration: const BoxDecoration(
                                    color: Color(0xffEEF7F2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.asset(
                                    "assets/images/streamline-freehand_donation-charity-donate-box.png",
                                  ),
                                ),

                                SizedBox(width: width * 0.03),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "إجمالي تبرعات الجمعية",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: width < 600 ? 15 : 18,
                                          color: const Color(0xff666666),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),

                                      SizedBox(height: width * 0.01),

                                      Text(
                                        "20,000 ج.م",
                                        style: TextStyle(
                                          fontSize: width < 600 ? 13 : 16,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xff3B3B3B),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 18),
                          BasicInfoCard(charity: charity!),
                          SizedBox(height: 18),
                          DocumentsCard(documents: charity!.documents),
                          SizedBox(height: 24),
                          _ActionButtons(
                            charityId: charity!.id,
                            charityName: charity!.charityName,
                          ),
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
        SizedBox(width: MediaQuery.sizeOf(context).width * 0.45),

        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.4,
          child: _ActionButton(
            color: AppColors.danger,
            iconColor: AppColors.danger,
            icon: Icons.block,
            label: "إيقاف الحساب",
            onPressed: () {
              showDialog(
                context: context,
                builder:
                    (_) => StopCharityDialog(
                      charityId: charityId,
                      charityName: charityName,
                    ),
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

class StopCharityDialog extends StatelessWidget {
  final int charityId;
  final String charityName;
  const StopCharityDialog({
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
                "إيقاف حساب الجمعية",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: width < 600 ? 22 : 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff3B3B3B),
                ),
              ),

              SizedBox(height: width * 0.03),

              Directionality(
                textDirection: TextDirection.rtl,
                child: Text(
                  """
هل أنت متأكد من إيقاف حساب جمعية $charityName ؟
 لن تتمكن الجمعية من الوصول إلى النظام بعد الإيقاف
""",
                  textAlign: TextAlign.right,
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
                    hintText: "اكتب سبب الإيقاف هنا ...",
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
                            status: "Suspended",
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
                        elevation: 0,
                        backgroundColor: const Color(0xffC30B0B),
                        minimumSize: const Size.fromHeight(45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const FittedBox(
                        child: Text(
                          "تأكيد الإيقاف",
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
