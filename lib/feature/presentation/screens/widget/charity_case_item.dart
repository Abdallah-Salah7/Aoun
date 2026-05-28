import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/routes_manager/routes.dart';
import '../../../domain/entities/case_entity.dart';
import '../../state_management/cubit/case_cubit.dart';
import '../../state_management/cubit/case_state.dart';

class CharityCaseItem extends StatefulWidget {
  final CaseEntity caseEntity;
  const CharityCaseItem({super.key, required this.caseEntity});

  @override
  State<CharityCaseItem> createState() => _CharityCaseItemState();
}

class _CharityCaseItemState extends State<CharityCaseItem> {
  bool _isFetched = false; // حاجز أمان لمنع التكرار اللانهائي للطلب

  @override
  void initState() {
    super.initState();
    _checkAndRefresh();
  }

  @override
  void didUpdateWidget(covariant CharityCaseItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    // إعادة الفحص في حال تغيرت الـ Entity الممررة للكارت
    if (oldWidget.caseEntity.id != widget.caseEntity.id) {
      _isFetched = false;
      _checkAndRefresh();
    }
  }
  void _checkAndRefresh() {
    // إذا كانت الحالة تحمل بالفعل عدد متبرعين أكبر من 0، أو تم جلبها مسبقاً، نمنع الطلب تماماً
    if (widget.caseEntity.donorCount == 0 && !_isFetched) {
      // فحص أخير للتأكد من أن الـ Cubit لا يحتوي بالفعل على القيمة المحدثة في قائمته العامة
      final currentCases = context.read<CaseCubit>().state;
      if (currentCases is CaseLoaded) {
        final matchingCase = currentCases.cases.firstWhere((c) => c.id == widget.caseEntity.id);
        if (matchingCase.donorCount > 0) {
          if (mounted) {
            setState(() {
              _isFetched = true;
            });
          }
          return;
        }
      }

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _isFetched = true;
          });
          context.read<CaseCubit>().refreshCaseDetails(widget.caseEntity.id);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final caseData = widget.caseEntity;
    final image = caseData.imageUrl;

    final progress = caseData.requiredAmount == 0
        ? 0.0
        : caseData.collectedAmount / caseData.requiredAmount;

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.charityCaseDetails,
          arguments: caseData,
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  child: Image.network(
                    "https://aounplatform.runasp.net$image",
                    height: 220,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) {
                      return Image.asset(
                        ImageAssets.upload,
                        height: 220,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
                if (caseData.isUrgent)
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            color: Colors.white,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "عاجلة",
                            style: GoogleFonts.cairo(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      caseData.status,
                      style: GoogleFonts.cairo(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 20,
              ),
              child: Text(
                caseData.title,
                textAlign: TextAlign.right,
                style: GoogleFonts.cairo(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: progress.clamp(0.0, 1.0),
                  minHeight: 6,
                  backgroundColor: const Color(0xffE0E0E0),
                  color: const Color(0xff2F674D),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "تم جمع ${caseData.collectedAmount} ج.م",
                        style: GoogleFonts.manrope(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff255A41),
                        ),
                      ),
                      Text(
                        "من ${caseData.requiredAmount}",
                        style: GoogleFonts.manrope(
                          fontSize: 16,
                          color: const Color(0xff757575),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      Image.asset(ImageAssets.vector),
                      const SizedBox(height: 5),
                      Text(
                        "${caseData.donorCount} متبرع",
                        style: GoogleFonts.cairo(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            caseData.isCompleted
                ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xff8FAF9A),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "اكتملت",
                      style: GoogleFonts.manrope(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(
                      Icons.check_circle_outline,
                      color: Colors.white,
                      size: 30,
                    ),
                  ],
                ),
              ),
            )
                : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    side: const BorderSide(
                      color: Color(0xff737373),
                      width: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      Routes.editCase,
                      arguments: caseData,
                    );
                  },
                  icon: const Icon(
                    Icons.mode_edit_outline_outlined,
                    color: Color(0xff737373),
                  ),
                  label: Text(
                    "تعديل الحالة",
                    style: GoogleFonts.cairo(
                      fontSize: 16,
                      color: const Color(0xff737373),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}