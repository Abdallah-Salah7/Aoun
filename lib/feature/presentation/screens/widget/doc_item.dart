import 'package:aoun/core/color_manager/app_color.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DocumentItem extends StatelessWidget {
  final String title;
  final String filePath;

  const DocumentItem({super.key, required this.title, required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.chipBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.description_outlined,
              color: AppColors.primary,
              size: 35,
            ),
          ),
          const SizedBox(width: 12),
          // Flexible so long document titles wrap/ellipsize instead of
          // pushing the "تحميل" download action off-screen.
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(0xff1F2937)
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "doc1.pdf",
                  style: TextStyle(color: Color(0xff9CA3AF), fontSize: 16,fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () async {
              final uri = Uri.parse("https://aounplatform.runasp.net$filePath");

              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              } else {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text("تعذر فتح الملف")));
              }
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "تحميل",
                  style: TextStyle(
                    color: Color(0xff256A4A),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Image.asset(
                  "assets/images/download.png",width: 30,height: 30,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}