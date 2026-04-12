
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../domain/entities/campaign_entity.dart';
import '../widget/field_dropdown.dart';

class AddCampaign extends StatefulWidget {
  const AddCampaign({super.key});

  @override
  State<AddCampaign> createState() => _AddCampaignState();
}

class _AddCampaignState extends State<AddCampaign> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;

  final Color mainColor = const Color(0xff2F674D);

  Future<void> _pickDate({required bool isStart}) async {
    DateTime now = DateTime.now();

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),

      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: mainColor,
            colorScheme: ColorScheme.light(
              primary: mainColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }
  String _formatDate(DateTime? date) {
    if (date == null) return "";
    return "${date.year}/${date.month}/${date.day}";
  }

  File? _image;
  final ImagePicker _picker = ImagePicker();

  bool isUrgent = false;
  String selectedCategory = "الصحة";

  Future<void> _pickImage() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    descController.dispose();
    super.dispose();
  }

  void _submitCase() {
    if (titleController.text.isEmpty ||
        amountController.text.isEmpty ||
        descController.text.isEmpty ||
        startDate == null ||
        endDate == null) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("من فضلك املي كل البيانات بما فيها التواريخ")),
      );
      return;
    }

    final newCase = CampaignEntity(
      id: "",
      image: _image?.path ?? ImageAssets.upload,
      title: titleController.text,
      description: descController.text,
      rateValue: 0.0,
      collectedValue: "0",
      allValue: amountController.text,
      status: isUrgent ? "عاجلة جداً" : "نشطة",
      category: selectedCategory,
      startDate: startDate!,   // ✅ هنا الآمان بعد التحقق
      endDate: endDate!,       // ✅
    );

    Navigator.pop(context, newCase);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xffE5EBE9),
        appBar: AppBar(
          title: Text(
            "إضافة حملة جديدة",
            style: GoogleFonts.manrope(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios_new,
                size: 30, color: Colors.black),
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
                  "صورة الحملة",
                  style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w500, fontSize: 22),
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
                        color: const Color(0xffC4C4C4), width: 1.5),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: _image != null
                        ? Image.file(_image!, fit: BoxFit.fill)
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
                "عنوان الحملة",
                "مثال: حملة اغاثة غزة",
                controller: titleController,
              ),

              const SizedBox(height: 15),
              _buildField(
                "المبلغ المستهدف",
                "20000 ج.م",
                controller: amountController,
                isNumber: true,
              ),

              const SizedBox(height: 25),

              _buildDateField(
                title: "بداية الحملة",
                hint: "تاريخ البداية",
                date: startDate,
                onTap: () => _pickDate(isStart: true),
              ),

              const SizedBox(height: 20),

              _buildDateField(
                title: "نهاية الحملة",
                hint: "تاريخ النهاية",
                date: endDate,
                onTap: () => _pickDate(isStart: false),
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
                          "وصف الحملة",
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


                  // حقل النص (TextField)
                ],
              ),

              const SizedBox(height: 10),

              Container(
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: const Color(0xffC4C4C4), width: 1.5),
                ),
                child: TextField(
                  controller: descController,
                  expands: true,
                  maxLines: null,
                  textAlign: TextAlign.right,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    hintText: "اكتب وصف تفصيلي للحملة",
                    hintStyle: GoogleFonts.manrope(
                      fontSize: 20,
                      color: const Color(0xff737373),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(15),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitCase,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff2F674D),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    "رفع الحملة",
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
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            title,
            style: GoogleFonts.manrope(
                fontWeight: FontWeight.w500, fontSize: 22),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border:
            Border.all(color: const Color(0xffC4C4C4), width: 1.5),
          ),
          child: TextField(
            controller: controller,
            keyboardType:
            isNumber ? TextInputType.number : TextInputType.text,
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
  Widget _buildDateField({
    required String title,
    required String hint,
    required DateTime? date,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            title,
            style: GoogleFonts.manrope(
                fontWeight: FontWeight.w500, fontSize: 22),
          ),
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: const Color(0xffC4C4C4), width: 1.5),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    date == null ? hint : _formatDate(date),
                    textAlign: TextAlign.right,
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      color: date == null ? Colors.grey : Colors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                Padding(
                  padding: const EdgeInsets.only(right: 18.0),
                  child: Image(
                    image: AssetImage(ImageAssets.iconDate),
                    height: 34,
                    width: 34,
                  ),
                ),

              ],
            ),
          ),
        ),
      ],
    );
  }
}
