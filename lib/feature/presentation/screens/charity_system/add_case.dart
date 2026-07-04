import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../data/data_sources/case_api_service.dart';
import '../../../data/repositories_imp/case_repository.dart';
import '../../state_management/cubit/ai_description_cubit.dart';
import '../../state_management/cubit/ai_description_state.dart';
import '../widget/field_dropdown.dart';

class AddCase extends StatefulWidget {
  const AddCase({super.key});

  @override
  State<AddCase> createState() => _AddCaseState();
}

class _AddCaseState extends State<AddCase> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  File? _image;

  final ImagePicker _picker = ImagePicker();

  final CaseRepository repository =
  CaseRepository(CaseApiService());


  bool isUrgent = false;

  bool isLoading = false;

  String selectedCategory = "الصحة";

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://aounplatform.runasp.net',
      headers: {
        'accept': '*/*',
      },
    ),
  );

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
  int getCategoryId(String value) {
    switch (value.trim()) {
      case "الصحة":
        return 1;

      case "التعليم":
        return 2;

      case "الإغاثة":
        return 3;

      case "كفالات":
        return 4;

      case "مشاريع بناء":
        return 5;

      case "التنمية":
        return 6;

      case "ذوي الاحتياجات":
        return 7;

      case "كفارات":
        return 8;

      case "الغارمين":
        return 9;

      case "الإطعام":
      case "الاطعام": // عشان لو مكتوبة بدون همزة
        return 10;

      default:
        return 1;
    }
  }


  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    descController.dispose();
    super.dispose();
  }
  Future<void> _submitCase() async {
    if (titleController.text.isEmpty ||
        amountController.text.isEmpty ||
        descController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("من فضلك املي كل البيانات")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      FormData formData = FormData.fromMap({
        "title": titleController.text,
        "description": descController.text,
        "categoryId": getCategoryId(selectedCategory),
        "isUrgent": isUrgent,
        "requiredAmount":
        double.tryParse(amountController.text) ?? 0,
      });

      if (_image != null) {
        formData.files.add(
          MapEntry(
            "image",
            await MultipartFile.fromFile(
              _image!.path,
              filename: _image!.path.split('/').last,
            ),
          ),
        );
      }

      print("FIELDS:");
      print(formData.fields);

      print("FILES:");
      print(formData.files);

      await repository.addCase(formData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("تم رفع الحالة بنجاح")),
      );

      Navigator.pop(context, true);
    } on DioException catch (e) {
      print("ERROR:");
      print(e.response?.data);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.response?.data.toString() ?? "حدث خطأ",
          ),
        ),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

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

        body: BlocListener<AiDescriptionCubit, AiDescriptionState>(
    listener: (context, state) {
    if (state is AiDescriptionLoaded) {
    descController.text = state.entity.result;
    }

    if (state is AiDescriptionError) {
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
    content: Text(state.message),
    ),
    );
    }
    },
    child: SingleChildScrollView(
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
                  height: 200,
                  width: double.infinity,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),

                    border: Border.all(
                      color: const Color(0xffC4C4C4),
                      width: 1.5,
                    ),
                  ),

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),

                    child: _image != null
                        ? Image.file(
                      _image!,
                      fit: BoxFit.fill,
                    )
                        : Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Image(
                          image: AssetImage(ImageAssets.upload),
                          height: 59,
                          width: 59,
                          color: Colors.grey,
                        ),

                        const SizedBox(height: 10),

                        Text(
                          "اضغط لتحميل الصورة",
                          style: GoogleFonts.manrope(
                            color: Colors.grey,
                            fontSize: 16,
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
                "مثال: علاج طفل مريض",
                controller: titleController,
              ),

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

              _buildField(
                "المبلغ المستهدف",
                "20000 ج.م",
                controller: amountController,
                isNumber: true,
              ),

              const SizedBox(height: 25),

              Container(
                padding: const EdgeInsets.all(16.0),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),

                  border: Border.all(
                    color: const Color(0xffC4C4C4),
                    width: 1.5,
                  ),
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

                        trackColor:
                        WidgetStateProperty.resolveWith<Color?>(
                              (states) {
                            if (states.contains(WidgetState.selected)) {
                              return const Color(0xff2F674D);
                            }

                            return Colors.grey.shade600;
                          },
                        ),

                        thumbColor:
                        WidgetStateProperty.resolveWith<Color?>(
                              (states) {
                            if (states.contains(WidgetState.selected)) {
                              return Colors.white;
                            }

                            return const Color(0xFFE0E0E0);
                          },
                        ),

                        trackOutlineColor:
                        WidgetStateProperty.all(
                          Colors.transparent,
                        ),

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

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),

                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

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
                        context.read<AiDescriptionCubit>().generateDescription(
                          title: titleController.text,
                          category: selectedCategory,
                          amount: double.tryParse(amountController.text) ?? 0,
                        );
                      },

                      child: Row(
                        children: [
                          const Icon(
                            Icons.auto_awesome_outlined,
                            size: 25,
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

                  border: Border.all(
                    color: const Color(0xffC4C4C4),
                    width: 1.5,
                  ),
                ),

                child: TextField(
                  controller: descController,
                  expands: true,
                  maxLines: null,
                  textAlign: TextAlign.right,
                  textAlignVertical: TextAlignVertical.top,

                  decoration: InputDecoration(
                    hintText: "اكتب وصف تفصيلي للحالة",

                    hintStyle: GoogleFonts.manrope(
                      fontSize: 20,
                      color: const Color(0xff737373),
                    ),

                    border: InputBorder.none,

                    contentPadding:
                    const EdgeInsets.all(15),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  onPressed: isLoading ? null : _submitCase,

                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    const Color(0xff2F674D),

                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ),

                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(15),
                    ),
                  ),

                  child: isLoading
                      ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                      : Text(
                    "رفع الحالة",
                    style: GoogleFonts.manrope(
                      fontSize: 26,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      )
    );
  }

  Widget _buildField(
      String title,
      String hint, {
        required TextEditingController controller,
        bool isNumber = false,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),

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

            border: Border.all(
              color: const Color(0xffC4C4C4),
              width: 1.5,
            ),
          ),

          child: TextField(
            controller: controller,

            keyboardType: isNumber
                ? TextInputType.number
                : TextInputType.text,

            decoration: InputDecoration(
              hintText: hint,

              hintStyle: GoogleFonts.manrope(
                color: const Color(0xff737373),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),

              border: InputBorder.none,

              contentPadding:
              const EdgeInsets.all(12),
            ),
          ),
        ),
      ],
    );
  }
}