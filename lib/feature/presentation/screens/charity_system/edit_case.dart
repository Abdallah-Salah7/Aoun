import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/routes_manager/routes.dart';
import '../../../domain/entities/case_entity.dart';
import '../../state_management/cubit/ai_description_cubit.dart';
import '../../state_management/cubit/ai_description_state.dart';
import '../../state_management/cubit/case_cubit.dart';
import '../widget/field_dropdown.dart';

class EditCase extends StatefulWidget {
  late  CaseEntity caseEntity;

   EditCase({super.key, required this.caseEntity});

  @override
  State<EditCase> createState() => _EditCaseState();
}

class _EditCaseState extends State<EditCase> {
  late TextEditingController titleController;
  late TextEditingController amountController;
  late TextEditingController descriptionController;
  String getCategoryName(int id) {
    switch (id) {
      case 1:
        return "الصحة";
      case 2:
        return "التعليم";
      case 3:
        return "الإغاثة";
      case 4:
        return "كفالات";
      case 5:
        return "مشاريع بناء";
      case 6:
        return "التنمية";
      case 7:
        return "ذوي الاحتياجات";
      case 8:
        return "كفارات";
      case 9:
        return "الغارمين";
      case 10:
        return "الإطعام";
      default:
        return "الصحة";
    }
  }
  File? _image;
  final ImagePicker _picker = ImagePicker();

  bool isUrgent = false;

  int selectedCategory = 1; // ✅ خليها int

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

    titleController =
        TextEditingController(text: widget.caseEntity.title);

    amountController =
        TextEditingController(text: widget.caseEntity.requiredAmount.toString());

    descriptionController =
        TextEditingController(text: widget.caseEntity.description);

    selectedCategory = widget.caseEntity.categoryId; // ✅ صح كده

    isUrgent = widget.caseEntity.isUrgent;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AiDescriptionCubit, AiDescriptionState>(
        listener: (context, state) {
          if (state is AiDescriptionLoaded) {
            descriptionController.text = state.entity.result;
          }

          if (state is AiDescriptionError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
    child: Directionality(
    textDirection: TextDirection.rtl,
    child: Scaffold(
        backgroundColor: const Color(0xffE5EBE9),
        appBar: AppBar(
          title: Text(
            "تعديل بيانات الحالة ",
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
                    fit: BoxFit.cover,
                  )
                        : widget.caseEntity.imageUrl.isNotEmpty
                ? Image(
                    image: getImage(widget.caseEntity.imageUrl),
                fit: BoxFit.cover,
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
              _buildField(
                "عنوان الحالة",
                "مثال: علاج طفل مريض ",
                titleController,
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: FieldDropdown(
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = int.tryParse(value.toString()) ?? 1;
                    });
                  },
                ),
              ),
              const SizedBox(height: 15),
              _buildField("المبلغ المستهدف", "20000 ج.م", amountController),
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
                      child:     /// 👇 Switch
                      Switch(
                        value: isUrgent,
                        onChanged: (value) {
                          setState(() {
                            isUrgent = value;
                          });
                        },
                        trackColor: WidgetStateProperty.resolveWith<Color?>((
                          states,
                        ) {
                          if (states.contains(WidgetState.selected)) {
                            return const Color(0xff2F674D);
                          }
                          return Colors.grey.shade600;
                        }),
                        thumbColor: WidgetStateProperty.resolveWith<Color?>((
                          states,
                        ) {
                          if (states.contains(WidgetState.selected)) {
                            return Colors.white;
                          }
                          return const Color(0xFFE0E0E0);
                        }),
                        trackOutlineColor: WidgetStateProperty.all(
                          Colors.transparent,
                        ),

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
    BlocBuilder<AiDescriptionCubit, AiDescriptionState>(
    builder: (context, state) {
    if (state is AiDescriptionLoading) {
    return const CircularProgressIndicator();
    }

    return InkWell(
    onTap: () {
    context.read<AiDescriptionCubit>().generateDescription(
    title: titleController.text,
    category: getCategoryName(selectedCategory),
    amount: double.tryParse(amountController.text) ?? 0,
    );},
    child: Row(
    children: [
    const Icon(
    Icons.auto_awesome_outlined,
    size: 20,
    color: Color(0xff2F674D),
    ),
    const SizedBox(width: 5),

    Text(
    "تحسين بالذكاء الاصطناعى",
    style: GoogleFonts.manrope(
    fontSize: 16,
    color: const Color(0xff2F674D),
    fontWeight: FontWeight.w500,
    ),
    ),
    ],
    ),
    );
    })],
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
                  onPressed: () async {
                    final updated = widget.caseEntity.copyWith(
                      title: titleController.text,
                      description: descriptionController.text,
                      requiredAmount:
                      double.tryParse(amountController.text) ??
                          widget.caseEntity.requiredAmount,

                      categoryId: selectedCategory, // ✅ صح

                      status: widget.caseEntity.status,
                      isUrgent: isUrgent, // ✅ مهم جداً
                      imageUrl: widget.caseEntity.imageUrl,
                    );

                    await context.read<CaseCubit>().updateCase(
                      updated,
                      imageFile: _image,
                    );

                    await context.read<CaseCubit>().fetchCases();

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
                    final caseCubit = context.read<CaseCubit>();
                    showDialog(
                      context: context,
                      builder: (BuildContext dialogContext) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "هل أنت متأكد من حذف هذه الحالة ؟",
                                style: GoogleFonts.saira(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.right,
                              ),
                              SizedBox(height: 12),
                              Text(
                                "سيتم حذف جميع البيانات المرتبطة بها \n نهائيًا ولا يمكن استرجاعها ",
                                style: GoogleFonts.saira(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.right,
                              ),
                              SizedBox(height: 30),

                              Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      // داخل الـ AlertDialog -> Row -> InkWell (حذف الحالة)
                                      onTap: () {
                                        // بدون await
                                        caseCubit.deleteCase(widget.caseEntity.id);

                                        Navigator.pop(dialogContext);
                                        Navigator.pop(context);
                                      },                                      child: Text(
                                        "حذف الحالة",
                                        style: GoogleFonts.saira(
                                          fontSize: 23,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xffB73131),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),

                                  SizedBox(width: 10),

                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pop(dialogContext);
                                      },
                                      child: Text(
                                        "إلغاء",
                                        style: GoogleFonts.saira(
                                          fontSize: 23,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
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
    ));
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
            controller: controller,
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
  ImageProvider getImage(String image) {
    if (image.startsWith('http')) {
      return NetworkImage(image);
    }

    if (image.startsWith('/images')) {
      return NetworkImage("https://aounplatform.runasp.net$image");
    }

    return const AssetImage(ImageAssets.upload);
  }
}
