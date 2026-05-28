import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/routes_manager/routes.dart';
import '../../../domain/entities/case_entity.dart';
import '../../state_management/cubit/case_cubit.dart';
import '../../state_management/cubit/case_state.dart';
import '../widget/charity_case_item.dart';
import '../widget/field_dropdown.dart';
import 'app_drawer.dart';

class CaseManagement extends StatefulWidget {
  const CaseManagement({super.key});

  @override
  State<CaseManagement> createState() => _CaseManagementState();
}

class _CaseManagementState extends State<CaseManagement> {
  String selectedFilter = "الكل";
  String selectedCategory = "الكل";

  // دالة تنظيف النصوص لتوحيد الحروف المتشابهة في اللغة العربية منعاً لأي خطأ إملائي
  String normalizeText(String text) {
    return text.trim()
        .replaceAll('أ', 'ا')
        .replaceAll('إ', 'ا')
        .replaceAll('آ', 'ا')
        .replaceAll('ة', 'ه')
        .replaceAll('ى', 'ي');
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButton: SizedBox(
          width: 70,
          height: 70,
          child: FloatingActionButton(

            onPressed: () async {
              // 1. انتظر نتيجة الإضافة من صفحة AddCase
              final result = await Navigator.pushNamed(context, Routes.addCase);

              // 2. إذا نجحت الإضافة (مثلاً إذا رجعت الشاشة بقيمة true)
              if (result == true) {
                // 3. قم بإعادة جلب البيانات من السيرفر لتحديث القائمة بالكامل
                context.read<CaseCubit>().fetchCases();
              }
            },
            backgroundColor: const Color(0xff2F674D),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
            child: const Icon(Icons.add, size: 40, color: Colors.white),
          ),
        ),
        appBar: AppBar(
          backgroundColor: const Color(0xff2F674D),
          toolbarHeight: 0,
        ),
        drawer: const AppDrawer(),
        backgroundColor: const Color(0xffC7CDCD),
        body: BlocBuilder<CaseCubit, CaseState>(
          builder: (context, state) {
            if (state is CaseLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is CaseError) {
              return Center(child: Text(state.message, style: const TextStyle(color: Colors.red)));
            }

            if (state is CaseLoaded) {
              final totalDonations = state.cases.fold<double>(
                0.0, (sum, item) => sum + item.collectedAmount,
              );

              // تصفية وفلترة الحالات بناءً على النصوص القادمة من السيرفر مباشرة
              final filteredCases = state.cases.where((c) {
                // 1. فلترة نوع الحالة (مكتملة / عاجلة / الكل)
                bool statusMatch = false;
                if (selectedFilter == "مكتملة") {
                  statusMatch = c.isCompleted == true;
                } else if (selectedFilter == "عاجلة جداً") {
                  statusMatch = (c.isUrgent == true) && (c.isCompleted != true);
                } else {
                  statusMatch = c.isCompleted != true;
                }

                // 2. فلترة القسم (التصنيف) الاعتماد الكلي على الاسم النصي لأن الـ ID يضيع بعد الـ PUT
                bool categoryMatch = false;
                if (selectedCategory == "الكل" || selectedCategory.trim().isEmpty) {
                  categoryMatch = true;
                } else {
                  String currentCaseCategoryName = "";

                  // محاولة استخراج الاسم النصي للقسم بأي شكل متاح داخل الـ Entity
                  try {
                    // نقرأ الحقل بشكل ديناميكي تماماً حتى لو لم يكن معرّفاً كـ String صريح في الـ Entity
                    currentCaseCategoryName = (c as dynamic).categoryName?.toString() ?? "";
                  } catch (_) {
                    currentCaseCategoryName = "";
                  }

                  // إذا فشل الاستخراج الديناميكي وكان الـ ID لا يزال متوفراً (كخط دفاع أخير)
                  if (currentCaseCategoryName.isEmpty && c.categoryId != null && c.categoryId != 0) {
                    final Map<int, String> categoriesMap = {
                      1: "الصحة",
                      2: "التعليم",
                      3: "الإغاثة",
                      4: "كفالات",
                      5: "مشاريع بناء",
                      6: "التنمية",
                      7: "ذوى الاحتياجات", // مطابقة لـ "ذوى الاحتياجات" في الـ Log
                      8: "كفارات",
                      9: "الغارمين",
                      10: "الإطعام",
                    };
                    currentCaseCategoryName = categoriesMap[c.categoryId] ?? "";
                  }

                  // طباعة اختبارية في الـ Console لمعرفة الاسم المستخرج أثناء التنقل بين الأقسام
                  debugPrint("Case ID: ${c.id} -> Category Name extracted: '$currentCaseCategoryName' vs Selected: '$selectedCategory'");

                  // المقارنة بعد توحيد الحروف المتشابهة (مثل الهاء والتاء المربوطة، والألف اللينة)
                  categoryMatch = normalizeText(currentCaseCategoryName) == normalizeText(selectedCategory);
                }

                return statusMatch && categoryMatch;
              }).toList();

              return ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          ),
                          color: Color(0xff2F674D),
                        ),
                        height: 148,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
                          child: Row(
                            children: [
                              Builder(
                                builder: (context) {
                                  return InkWell(
                                    onTap: () => Scaffold.of(context).openDrawer(),
                                    child: Image(image: AssetImage(ImageAssets.charityIcon)),
                                  );
                                },
                              ),
                              const SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("إدارة الحالات", style: GoogleFonts.manrope(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white)),
                                  Text("لوحة التحكم", style: GoogleFonts.manrope(fontSize: 19, fontWeight: FontWeight.w400, color: Colors.white)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(right: 18, left: 18, top: 18, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildFilterButton("الكل"),
                            buildFilterButton("عاجلة جداً"),
                            buildFilterButton("مكتملة"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: FieldDropdown(
                          onChanged: (value) {
                            setState(() {
                              selectedCategory = value ?? "الكل";
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 10, offset: const Offset(0, 6)),
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xffE3F0EA),
                                  borderRadius: BorderRadius.circular(45),
                                ),
                                padding: const EdgeInsets.all(8),
                                child: Image(image: AssetImage(ImageAssets.totalDonation), height: 36, width: 36),
                              ),
                              const SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("إجمالى التبرعات", style: GoogleFonts.manrope(fontSize: 19, fontWeight: FontWeight.w800, color: const Color(0xff6A6969))),
                                  Text("$totalDonations ج.م", style: GoogleFonts.manrope(fontSize: 17, fontWeight: FontWeight.w700)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      if (filteredCases.isEmpty)
                        const Padding(
                          padding: EdgeInsets.all(40),
                          child: Center(
                            child: Text(
                              "لا توجد حالات ضمن هذه الفئة حالياً",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
                            ),
                          ),
                        )
                      else
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: filteredCases.length,
                          itemBuilder: (context, index) {
                            return CharityCaseItem(
                              key: ValueKey(filteredCases[index].id), // حماية الكروت لمنع تصفير الـ State أثناء الفلترة
                              caseEntity: filteredCases[index],
                            );
                          },
                        ),
                    ],
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget buildFilterButton(String title) {
    final bool isSelected = selectedFilter == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 13),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xff2F674D) : Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(title, style: GoogleFonts.manrope(fontSize: 20, fontWeight: FontWeight.w600, color: isSelected ? Colors.white : Colors.black)),
      ),
    );
  }
}