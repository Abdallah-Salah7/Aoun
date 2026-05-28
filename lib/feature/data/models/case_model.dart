import '../../domain/entities/case_entity.dart';

class CaseModel {
  final int id;
  final int donorCount;
  final String title;
  final String description;
  final String imageUrl;
  final String status;
  final int categoryId;
  final String categoryName; // تم إضافة الحقل هنا للاحتفاظ بالاسم النصي القادم من السيرفر
  final double requiredAmount;
  final double collectedAmount;
  final bool isUrgent;
  final bool isCompleted;
  final double progress;

  CaseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.status,
    required this.categoryId,
    required this.categoryName, // تم إضافته للمشيد
    required this.requiredAmount,
    required this.collectedAmount,
    required this.isUrgent,
    required this.isCompleted,
    required this.progress,
    required this.donorCount,
  });

  factory CaseModel.fromJson(Map<String, dynamic> json) {
    // 1. قراءة اسم القسم القادم من السيرفر بشكل آمن
    final String serverCategoryName = json['categoryName'] ?? "";

    // 2. محاولة قراءة الـ ID القادم من السيرفر
    int extractedCategoryId = json['categoryId'] ?? 0;

    // 3. ذكاء اصطناعي محلي: إذا كان الـ ID مفقوداً (بسبب الـ PUT) ولكن الاسم موجود، نستنتج الـ ID برمجياً
    if (extractedCategoryId == 0 && serverCategoryName.isNotEmpty) {
      // خريطة عكسية لتحويل النص المكتوب إلى ID المقابل له
      final Map<String, int> categoriesIdsMap = {
        "الصحة": 1,
        "التعليم": 2,
        "الإغاثة": 3,
        "كفالات": 4,
        "مشاريع بناء": 5,
        "التنمية": 6,
        "ذوى الاحتياجات": 7,
        "ذوي الاحتياجات": 7, // تحسباً لاختلاف الياء/الألف اللينة
        "كفارات": 8,
        "الغارمين": 9,
        "الإطعام": 10,
      };

      // تنظيف النص المقروء من الفراغات للمطابقة الدقيقة
      final cleanName = serverCategoryName.trim();
      extractedCategoryId = categoriesIdsMap[cleanName] ?? 0;
    }

    // حساب حقل الـ progress بشكل آمن لمنع الـ Divide by Zero
    final double reqAmount = (json['requiredAmount'] ?? 0).toDouble();
    final double colAmount = (json['collectedAmount'] ?? 0).toDouble();
    final double calculatedProgress = (reqAmount == 0) ? 0.0 : (colAmount / reqAmount);

    return CaseModel(
      id: json['id'] ?? 0,
      donorCount: json['donorsCount'] ?? json['donorCount'] ?? 0,
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      imageUrl: json['imageUrl'] ?? "",
      status: json['status'] ?? "",
      categoryId: extractedCategoryId, // أصبح الآن يحمل القيمة الصحيحة دائماً
      categoryName: serverCategoryName,
      requiredAmount: reqAmount,
      collectedAmount: colAmount,
      progress: json['progress']?.toDouble() ?? calculatedProgress, // إذا كان السيرفر يرسل البروجريس جاهزاً نستخدمه، وإلا نحسبه
      isUrgent: json['isUrgent'] ?? false,
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  CaseEntity toEntity() {
    return CaseEntity(
      id: id,
      title: title,
      description: description,
      imageUrl: imageUrl,
      status: status,
      categoryId: categoryId,
      requiredAmount: requiredAmount,
      collectedAmount: collectedAmount,
      isUrgent: isUrgent,
      isCompleted: isCompleted,
      progress: progress,
      donorCount: donorCount,
    );
  }
}