import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../domain/entities/camp_entity.dart';
import '../../state_management/cubit/camp_cubit.dart';
import '../../state_management/cubit/camp_state.dart';

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
  File? _image;
  String? errorMessage;
  final ImagePicker _picker = ImagePicker();
  final Color mainColor = const Color(0xff2F674D);

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.campaignEntity.title);
    amountController = TextEditingController(text: widget.campaignEntity.requiredAmount.toString());
    descriptionController = TextEditingController(text: widget.campaignEntity.description);
    startDate = widget.campaignEntity.startDate;
    endDate = widget.campaignEntity.endDate;
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _image = File(pickedFile.path));
    }
  }

  Future<void> _pickDate({required bool isStart}) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      builder: (context, child) => Theme(
        data: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light(primary: mainColor),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => isStart ? startDate = picked : endDate = picked);
  }

  String _formatDate(DateTime? date) => date == null ? "" : "${date.year}/${date.month}/${date.day}";

  @override
  Widget build(BuildContext context) {
    return BlocListener<CampaignCubit, CampaignState>(
      listener: (context, state) {
        if (state is CampaignError) setState(() => errorMessage = state.message);
        if (state is CampaignDeletedSuccess || state is CampaignUpdatedSuccess) Navigator.pop(context);
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: const Color(0xffE5EBE9),
          appBar: AppBar(
            title: Text("تعديل بيانات الحملة ", style: GoogleFonts.manrope(fontSize: 23, fontWeight: FontWeight.bold)),
            centerTitle: true,
              leading: GestureDetector(
                onTap: () {
                  context.read<CampaignCubit>().clearError();
                  Navigator.pop(context);
                },
              child: const Icon(Icons.arrow_back_ios_new, size: 30, color: Colors.black)),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(padding: const EdgeInsets.symmetric(horizontal: 10.0), child: Text("صورة الحملة", style: GoogleFonts.manrope(fontWeight: FontWeight.w500, fontSize: 22))),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: double.infinity, height: 200,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xffC4C4C4), width: 1.5)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: _image != null ? Image.file(_image!, fit: BoxFit.fill) : Image.network(widget.campaignEntity.imageUrl, fit: BoxFit.cover, errorBuilder: (c, o, s) => _buildUploadPlaceholder()),
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

                // عرض رسالة الخطأ في حال وجودها
                if (errorMessage != null)
                  Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: Text(errorMessage!, style: const TextStyle(color: Colors.red), textAlign: TextAlign.center)),

                const SizedBox(height: 30),

                // زر الحفظ
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
                      await context.read<CampaignCubit>().updateCampaign(widget.campaignEntity.id, formData);
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff2F674D), padding: const EdgeInsets.symmetric(vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                    child: Text("حفظ التغييرات", style: GoogleFonts.manrope(fontSize: 26, fontWeight: FontWeight.w400, color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 30),

                // زر الحذف
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _showDeleteDialog(context),
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xffFCDEDE), padding: const EdgeInsets.symmetric(vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                    child: Text("حذف الحملة", style: GoogleFonts.manrope(fontSize: 26, fontWeight: FontWeight.w400, color: const Color(0xffB73131))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("هل أنت متأكد من حذف هذه الحملة ؟", style: GoogleFonts.saira(fontWeight: FontWeight.w600, fontSize: 20), textAlign: TextAlign.right),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(child: InkWell(onTap: () { context.read<CampaignCubit>().deleteCampaign(widget.campaignEntity.id); Navigator.pop(dialogContext); }, child: Text("حذف الحملة", style: GoogleFonts.saira(fontSize: 23, color: const Color(0xffB73131)), textAlign: TextAlign.center))),
                Expanded(child: InkWell(onTap: () => Navigator.pop(dialogContext), child: Text("إلغاء", style: GoogleFonts.saira(fontSize: 23, color: Colors.black), textAlign: TextAlign.center))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --- Widgets مساعدة ---
  Widget _buildUploadPlaceholder() => Column(mainAxisAlignment: MainAxisAlignment.center, children: [Image(image: AssetImage(ImageAssets.upload), height: 59, width: 59), Text("اضغط لتحميل الصورة", style: GoogleFonts.manrope(color: Colors.grey))]);

  Widget _buildField(String title, String hint, TextEditingController controller) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Padding(padding: const EdgeInsets.symmetric(horizontal: 10), child: Text(title, style: GoogleFonts.manrope(fontWeight: FontWeight.w500, fontSize: 22))), const SizedBox(height: 10), Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), border: Border.all(color: const Color(0xffC4C4C4), width: 1.5)), child: TextField(controller: controller, decoration: InputDecoration(hintText: hint, border: InputBorder.none, contentPadding: const EdgeInsets.all(12))))]);

  Widget _buildDateField({required String title, required String hint, required DateTime? date, required VoidCallback onTap}) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Padding(padding: const EdgeInsets.symmetric(horizontal: 10), child: Text(title, style: GoogleFonts.manrope(fontWeight: FontWeight.w500, fontSize: 22))), const SizedBox(height: 10), InkWell(onTap: onTap, child: Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), border: Border.all(color: const Color(0xffC4C4C4), width: 1.5)), child: Row(children: [Expanded(child: Text(date == null ? hint : _formatDate(date), textAlign: TextAlign.right)), Image.asset(ImageAssets.iconDate, height: 34, width: 34)])))]);

  Widget _buildDescriptionField() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Padding(padding: const EdgeInsets.symmetric(horizontal: 10), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("وصف الحالة", style: GoogleFonts.manrope(fontWeight: FontWeight.w500, fontSize: 22)), Row(children: [const Icon(Icons.auto_awesome_outlined, color: Color(0xff2F674D)), Text(" تحسين بالذكاء الاصطناعى", style: GoogleFonts.manrope(color: const Color(0xff2F674D)))])])), const SizedBox(height: 10), Container(height: 300, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), border: Border.all(color: const Color(0xffC4C4C4), width: 1.5)), child: TextField(controller: descriptionController, maxLines: null, expands: true, decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.all(15))))]);
}