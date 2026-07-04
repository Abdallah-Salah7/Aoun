import 'package:aoun/core/resources/assets_manager.dart';
import 'package:aoun/feature/presentation/screens/admin_system/admin_app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Centralized design tokens so colors / spacing are defined once
/// and stay consistent across the screen.
class _AppColors {
  static const primary = Color(0xff2F674D);
  static const danger = Color(0xffC30B0B);
  static const background = Color(0xffEEF2EE);
  static const chipBg = Color(0xffE8F1EC);
}

class DetaineeCharity extends StatelessWidget {
  const DetaineeCharity({super.key});

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

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: const AdminAppDrawer(),
        backgroundColor: _AppColors.background,
        appBar: AppBar(backgroundColor: _AppColors.primary, toolbarHeight: 0),
        body: SafeArea(
          child: Column(
            children: [
              _Header(
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
                          _BasicInfoCard(),
                          SizedBox(height: 18),
                          _DocumentsCard(),
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
                                "سبب الإيقاف",
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
                                    "تم إيقاف حساب الجمعية مؤقتًا بسبب مخالفة سياسات وشروط استخدام المنصة.",
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
                          _ActionButtons(),
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

class _Header extends StatelessWidget {
  final double titleFontSize;
  final double subtitleFontSize;

  const _Header({required this.titleFontSize, required this.subtitleFontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Intrinsic height driven by content + padding instead of a fixed
      // height, so it won't overflow when the user increases text scale.
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        color: _AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Builder(
            builder:
                (context) => InkWell(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: Image.asset(
                    ImageAssets.charityIcon,
                    width: 30,
                    height: 30,
                  ),
                ),
          ),
          const Spacer(),
          Flexible(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "بيانات الجمعية",
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.manrope(
                    fontSize: titleFontSize * 0.9,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "لوحة التحكم",
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.manrope(
                    fontSize: subtitleFontSize,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_none,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              Positioned(
                top: 11,
                right: 25,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(color: _AppColors.primary, width: 2),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Reusable white rounded card with a colored accent bar + section title.
class _SectionCard extends StatelessWidget {
  final String title;
  final double titleFontSize;
  final Widget child;

  const _SectionCard({
    required this.title,
    required this.child,
    this.titleFontSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(height: 20, width: 4, color: _AppColors.primary),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: _AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: titleFontSize,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }
}

class _BasicInfoCard extends StatelessWidget {
  const _BasicInfoCard();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: "البيانات الأساسية",
      child: const Column(
        children: [
          InfoColumn(
            title: "اسم الجمعية",
            value: "جمعية عين للتنمية المجتمعية",
          ),
          InfoColumn(title: "رقم القيد", value: "REG-2024-001"),
          InfoColumn(title: "البريد الإلكتروني", value: "info@charity.org"),
          InfoColumn(title: "العنوان", value: "القاهرة"),
          InfoColumn(title: "المسؤول عن الجمعية", value: "أحمد محمد علي"),
          InfoColumn(title: "تاريخ التقديم", value: "2025/02/15"),
          InfoColumn(
            title: "نبذة عن الجمعية",
            value:
                "جمعية خيرية تعمل على دعم الأسر المحتاجة ومساعدة المرضى والأيتام.",
            multiLine: true,
          ),
        ],
      ),
    );
  }
}

class _DocumentsCard extends StatelessWidget {
  const _DocumentsCard();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: "المستندات الرسمية",
      titleFontSize: 22,
      child: const Column(
        children: [
          DocumentItem(title: "شهادة تسجيل الجمعية"),
          SizedBox(height: 12),
          DocumentItem(title: "البطاقة الضريبية"),
          SizedBox(height: 12),
          DocumentItem(title: "إثبات حساب بنكي"),
          SizedBox(height: 12),
          DocumentItem(title: "بطاقة الرقم القومي للمسؤول"),
        ],
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons();

  @override
  Widget build(BuildContext context) {
    // Row of two buttons; on very narrow screens (< 320 logical px) this
    // could still be tight, so labels are wrapped in Flexible/FittedBox
    // inside _ActionButton to avoid overflow rather than hardcoding sizes.
    return Row(
      children: [
        SizedBox(width: MediaQuery.sizeOf(context).width * 0.20),

        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.65,
          child: _ActionButton(
            color: _AppColors.primary,
            iconColor: _AppColors.primary,
            icon: Icons.play_circle_outline,
            label: "إعادة تفعيل الحساب",
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => const reactivationCharityDialog(),
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

class InfoColumn extends StatelessWidget {
  final String title;
  final String value;
  final bool multiLine;

  const InfoColumn({
    super.key,
    required this.title,
    required this.value,
    this.multiLine = false,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              color: _AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 15,
              height: 1.6,
            ),
            maxLines: multiLine ? null : 1,
            overflow: multiLine ? null : TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class DocumentItem extends StatelessWidget {
  final String title;
  final VoidCallback? onDownload;

  const DocumentItem({super.key, required this.title, this.onDownload});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: _AppColors.chipBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.description_outlined,
              color: _AppColors.primary,
              size: 15,
            ),
          ),
          const SizedBox(width: 12),
          // Flexible so long document titles wrap/ellipsize instead of
          // pushing the "تحميل" download action off-screen.
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "PDF",
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 10),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: onDownload,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "تحميل",
                  style: TextStyle(
                    color: _AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                Icon(Icons.download, color: _AppColors.primary, size: 15),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class reactivationCharityDialog extends StatelessWidget {
  const reactivationCharityDialog({super.key});

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
                "تأكيد إعادة تفعيل الحساب",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: width * .055,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: width * .04),

              const Text(
                """
هل أنت متأكدمن إعادة تفعيل حساب جمعبة “غيث للتنمية المجتمعية “؟
ستتمكن الجمعية من الوصول إلى النظام مرة أخرى
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
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff2F674D),
                        minimumSize: const Size.fromHeight(45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const FittedBox(
                        child: Text(
                          "إعادة التفعيل",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
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
