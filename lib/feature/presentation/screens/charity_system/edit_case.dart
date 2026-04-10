import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../domain/entities/case_entity.dart';
import '../../state_management/cubit/case_cubit.dart';
import '../widget/field_dropdown.dart';

class EditCase extends StatefulWidget {
  final CaseEntity caseEntity;

  const EditCase({super.key, required this.caseEntity});

  @override
  State<EditCase> createState() => _EditCaseState();
}

class _EditCaseState extends State<EditCase> {
  late TextEditingController titleController;
  late TextEditingController amountController;
  late TextEditingController descriptionController;
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
  @override
  void initState() {
    super.initState();


    titleController = TextEditingController(text: widget.caseEntity.title);
    amountController = TextEditingController(text: widget.caseEntity.allValue);
    descriptionController = TextEditingController(text: widget.caseEntity.description);

    selectedCategory = widget.caseEntity.category;
    isUrgent = widget.caseEntity.status == "عاجلة جداً";

    // 🔥 أهم سطر
    if (widget.caseEntity.image.isNotEmpty) {
      _image = File(widget.caseEntity.image);
    }
  }

  bool isUrgent = false;
  String selectedCategory = "الصحة";

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xffE5EBE9),
        appBar: AppBar(
          title: Text(
            "إضافة حالة جديدة",
            style: GoogleFonts.manrope(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_ios_new,
              size: 30,
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  "صورة الحالة",
                  style: GoogleFonts.manrope(
                    fontWeight: FontWeight.w500,
                    fontSize: 22,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Color(0xffC4C4C4), width: 1.5),

                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: _image != null
                        ? Image.file(
                      _image!,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.fill,
                    )
                        : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage(ImageAssets.upload),
                          height: 59,
                          width: 59,
                          fit: BoxFit.contain,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "اضغط لتحميل الصورة",
                          style: GoogleFonts.manrope(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "JPG, PNG (حد أقصى 5MB)",
                          style: GoogleFonts.manrope(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              _buildField("عنوان الحالة", "مثال: علاج طفل مريض ",titleController),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: FieldDropdown(
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value ?? "الصحة";
                    });
                  },
                ),
              ),
              const SizedBox(height: 15),
              _buildField("المبلغ المستهدف", "20000 ج.م",amountController),
              const SizedBox(height: 25),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xffC4C4C4), width: 1.5),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "حالة عاجلة",
                            style: GoogleFonts.manrope(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "سيتم عرض الحالة في قسم الحالات العاجلة",
                            style: GoogleFonts.manrope(
                              fontSize: 14,
                              color: const Color(0xff737373),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Transform.scale(
                      scale: 0.9,
                      child: Switch(
                        value: isUrgent,
                        trackColor: WidgetStateProperty.resolveWith<Color?>((states) {
                          if (states.contains(WidgetState.selected)) {
                            return const Color(0xff2F674D);
                          }
                          return Colors.grey.shade600;
                        }),
                        thumbColor: WidgetStateProperty.resolveWith<Color?>((states) {
                          if (states.contains(WidgetState.selected)) {
                            return Colors.white;
                          }
                          return const Color(0xFFE0E0E0);
                        }),
                        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
                        onChanged: (value) {
                          setState(() {
                            isUrgent = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "وصف الحالة",
                          style: GoogleFonts.manrope(
                            fontWeight: FontWeight.w500,
                            fontSize: 22,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.auto_awesome_outlined,
                                size: 20,
                                color: Color(0xff2F674D),
                              ),
                              const SizedBox(width: 5),

                              Text(
                                "توليد بالذكاء الاصطناعي",
                                style: GoogleFonts.manrope(
                                  fontSize: 16,
                                  color: const Color(0xff2F674D),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Color(0xffC4C4C4), width: 1.5),
                    ),
                    child: TextField(
                      controller: descriptionController,
                      maxLines: null,
                      expands: true,
                      textAlign: TextAlign.right,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: InputDecoration(
                        hintText: "اكتب وصف تفصيلي للحالة",
                        hintStyle: GoogleFonts.manrope(
                          fontSize: 20,
                          color: const Color(0xff737373),
                          fontWeight: FontWeight.w400,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(15),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final updated = widget.caseEntity.copyWith(
                      title: titleController.text,
                      description: descriptionController.text,
                      allValue: amountController.text,
                      category: selectedCategory,
                      status: isUrgent ? "عاجلة جداً" : "عادية",
                      image: _image?.path ?? widget.caseEntity.image,
                    );

                    context.read<CaseCubit>().updateCase(updated);

                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff2F674D),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    "حفظ التغييرات",
                    style: GoogleFonts.manrope(
                      fontSize: 26,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<CaseCubit>().deleteCase(widget.caseEntity.id);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffFCDEDE),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    "حذف الحالة",
                    style: GoogleFonts.manrope(
                      fontSize: 26,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffB73131),
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
  Widget _buildField(
      String title,
      String hint,
      TextEditingController controller,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            title,
            style: GoogleFonts.manrope(
              fontWeight: FontWeight.w500,
              fontSize: 22,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: const Color(0xffC4C4C4), width: 1.5),
          ),
          child: TextField(
            controller: controller,   // ⭐ أهم سطر
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.manrope(
                color: const Color(0xff737373),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(12),
            ),
          ),
        ),
      ],
    );
  }
}