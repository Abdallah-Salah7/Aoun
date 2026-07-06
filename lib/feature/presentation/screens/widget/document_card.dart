import 'package:aoun/feature/data/models/charity_details_model.dart';
import 'package:aoun/feature/presentation/screens/admin_system/request_charity_review.dart';
import 'package:aoun/feature/presentation/screens/widget/doc_item.dart';
import 'package:aoun/feature/presentation/screens/widget/section_card.dart';
import 'package:flutter/material.dart';

class DocumentsCard extends StatelessWidget {
  final List<DocumentModel> documents;
  const DocumentsCard({required this.documents});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title:  "المستندات الرسمية",
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: documents.length,
        itemBuilder: (context, index) {
          final doc = documents[index];
      
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: DocumentItem(
              title: getDocumentName(doc.documentType),
              filePath: doc.filePath,
            ),
          );
        },
      ),
    );
  }
}