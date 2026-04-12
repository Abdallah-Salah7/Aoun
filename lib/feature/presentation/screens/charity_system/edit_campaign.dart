
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../domain/entities/campaign_entity.dart';
import '../../state_management/cubit/campaign_cubit.dart';

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


    titleController = TextEditingController(text: widget.campaignEntity.title);
    amountController = TextEditingController(text: widget.campaignEntity.allValue);
    descriptionController = TextEditingController(text: widget.campaignEntity.description);

    selectedCategory = widget.campaignEntity.category;
    isUrgent = widget.campaignEntity.status == "عاجلة جداً";

    startDate = widget.campaignEntity.startDate;
    endDate = widget.campaignEntity.endDate;

    if (widget.campaignEntity.image.isNotEmpty) {
      _image = File(widget.campaignEntity.image);
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
            "تعديل بيانات الحملة ",
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
                  "صورة الحملة",
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
              _buildField("عنوان الحملة", "مثال: علاج طفل مريض ",titleController),

              const SizedBox(height: 15),
              _buildField("المبلغ المستهدف", "20000 ج.م",amountController),

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
                        hintText: "اكتب وصف تفصيلي للحملة",
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
                    final updated = widget.campaignEntity.copyWith(
                      title: titleController.text,
                      description: descriptionController.text,
                      allValue: amountController.text,
                      category: selectedCategory,
                      status: isUrgent ? "عاجلة جداً" : "عادية",
                      image: _image?.path ?? widget.campaignEntity.image,
                      startDate: startDate,
                      endDate: endDate,
                    );

                    context.read<CampaignCubit>().updateCampaign(updated);

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
                    final campaignCubit = context.read<CampaignCubit>();
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
                                "هل أنت متأكد من حذف هذه الحملة ؟",
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
                                      onTap: () {
                                        campaignCubit.deleteCampaign(widget.campaignEntity.id);
                                        Navigator.pop(dialogContext);
                                        Navigator.pop(dialogContext);
                                      },
                                      child: Text(
                                        "حذف الحملة",
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
                    "حذف الحملة",
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
