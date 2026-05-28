import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../domain/entities/camp_entity.dart';
import '../../state_management/cubit/camp_cubit.dart';


class EditCampaign extends StatefulWidget {
  final CampaignEntity campaignEntity;

  const EditCampaign({super.key, required this.campaignEntity});

  @override
  State<EditCampaign> createState() => _EditCampaignState();
}

class _EditCampaignState extends State<EditCampaign> {
  late TextEditingController titleController;
  late TextEditingController amountController;
  late TextEditingController descriptionController;

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

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.campaignEntity.title);
    amountController = TextEditingController(text: widget.campaignEntity.requiredAmount.toString());
    descriptionController = TextEditingController(text: widget.campaignEntity.description);

    startDate = widget.campaignEntity.startDate;
    endDate = widget.campaignEntity.endDate;
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
          title: Text("تعديل بيانات الحملة ", style: GoogleFonts.manrope(fontSize: 23, fontWeight: FontWeight.bold)),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios_new, size: 30, color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text("صورة الحملة", style: GoogleFonts.manrope(fontWeight: FontWeight.w500, fontSize: 22)),
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
                    border: Border.all(color: const Color(0xffC4C4C4), width: 1.5),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: _image != null
                        ? Image.file(_image!, width: double.infinity, height: double.infinity, fit: BoxFit.fill)
                        : Image.network(widget.campaignEntity.imageUrl, fit: BoxFit.cover, errorBuilder: (c, o, s) => _buildUploadPlaceholder()),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildField("عنوان الحملة", "مثال: علاج طفل مريض ", titleController),
              const SizedBox(height: 15),
              _buildField("المبلغ المستهدف", "20000 ج.م", amountController),
              const SizedBox(height: 25),
              _buildDateField(title: "بداية الحملة", hint: "تاريخ البداية", date: startDate, onTap: () => _pickDate(isStart: true)),
              const SizedBox(height: 20),
              _buildDateField(title: "نهاية الحملة", hint: "تاريخ النهاية", date: endDate, onTap: () => _pickDate(isStart: false)),
              const SizedBox(height: 25),
              _buildDescriptionField(),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final formData = FormData.fromMap({
                      "Title": titleController.text,
                      "Description": descriptionController.text,
                      "RequiredAmount": double.tryParse(amountController.text) ?? 0.0,
                      "StartDate": startDate?.toIso8601String(),
                      "EndDate": endDate?.toIso8601String(),
                      if (_image != null && !_image!.path.startsWith('http'))
                        "Image": await MultipartFile.fromFile(_image!.path, filename: _image!.path.split('/').last),
                    });

                    context.read<CampaignCubit>().updateCampaign(widget.campaignEntity.id, formData);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff2F674D), padding: const EdgeInsets.symmetric(vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                  child: Text("حفظ التغييرات", style: GoogleFonts.manrope(fontSize: 26, fontWeight: FontWeight.w400, color: Colors.white)),
                ),
              ),
              // ... بقية الـ UI (زر الحذف)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUploadPlaceholder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(image: AssetImage(ImageAssets.upload), height: 59, width: 59, fit: BoxFit.contain, color: Colors.grey),
        const SizedBox(height: 10),
        Text("اضغط لتحميل الصورة", style: GoogleFonts.manrope(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: const EdgeInsets.symmetric(horizontal: 10.0), child: Text("وصف الحملة", style: GoogleFonts.manrope(fontWeight: FontWeight.w500, fontSize: 22))),
        const SizedBox(height: 10),
        Container(
          height: 300,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), border: Border.all(color: const Color(0xffC4C4C4), width: 1.5)),
          child: TextField(
            controller: descriptionController,
            maxLines: null,
            expands: true,
            textAlign: TextAlign.right,
            decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.all(15)),
          ),
        ),
      ],
    );
  }

  Widget _buildField(String title, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: const EdgeInsets.symmetric(horizontal: 10.0), child: Text(title, style: GoogleFonts.manrope(fontWeight: FontWeight.w500, fontSize: 22))),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), border: Border.all(color: const Color(0xffC4C4C4), width: 1.5)),
          child: TextField(controller: controller, decoration: InputDecoration(hintText: hint, border: InputBorder.none, contentPadding: const EdgeInsets.all(12))),
        ),
      ],
    );
  }

  Widget _buildDateField({required String title, required String hint, required DateTime? date, required VoidCallback onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: const EdgeInsets.symmetric(horizontal: 10), child: Text(title, style: GoogleFonts.manrope(fontWeight: FontWeight.w500, fontSize: 22))),
        const SizedBox(height: 10),
        InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), border: Border.all(color: const Color(0xffC4C4C4), width: 1.5)),
            child: Row(
              children: [
                Expanded(child: Text(date == null ? hint : _formatDate(date), textAlign: TextAlign.right)),
                const Padding(padding: EdgeInsets.only(right: 18.0), child: Icon(Icons.calendar_today)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}