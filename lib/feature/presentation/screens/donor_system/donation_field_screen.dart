import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../domain/entities/case_entity.dart';
import '../../state_management/cubit/case_cubit.dart';
import '../../state_management/cubit/case_state.dart';
import '../widget/case_item.dart';

class DonationFieldScreen extends StatefulWidget {
  final String fieldName;

  const DonationFieldScreen({super.key, required this.fieldName});

  @override
  State<DonationFieldScreen> createState() =>
      _DonationFieldScreenState();
}

class _DonationFieldScreenState extends State<DonationFieldScreen> {
  String selectedFilter = "الكل";
  String searchText = "";

  List<CaseEntity> _applyFilter(List<CaseEntity> cases) {
    return cases.where((c) {
      final matchFilter = selectedFilter == "الكل"
          ? c.status != "مكتملة"
          : c.status == selectedFilter;

      final matchSearch =
          c.title.contains(searchText) ||
              c.description.contains(searchText);

      return matchFilter && matchSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xffE5EBE9),

        appBar: AppBar(
          backgroundColor: const Color(0xff2F674D),
          toolbarHeight: 189,
          shape: const OutlineInputBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35),
            ),
            borderSide: BorderSide(color: Color(0xff2F674D)),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(bottom: 38.0),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new,
                  color: Colors.white, size: 40),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 38.0),
            child: Row(
              children: [
                const Image(image: AssetImage(ImageAssets.icon)),
                const SizedBox(width: 8),
                Text(
                  "مجال ${widget.fieldName}",
                  style: GoogleFonts.manrope(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),

        body: BlocBuilder<CaseCubit, CaseState>(
          builder: (context, state) {
            if (state is! CaseLoaded) {
              return const Center(child: CircularProgressIndicator());
            }

            final categoryCases =
            context.read<CaseCubit>().getCasesByCategory(widget.fieldName);

            final filteredCases = _applyFilter(categoryCases);
            return ListView(
              children: [
                Column(
                  children: [

                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xff287A54),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Text(
                              "نعمل على توفير الرعاية الطبية والأدوية \nاللازمة والعمليات الجراحية العاجلة لمن \nهم فى أمس الحاجة إليها ، مساهمتك\n  تنقذ حياة !",
                              style: GoogleFonts.manrope(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),

                            _infoRow("حالات مكتملة", "240 حالة"),

                            _infoRow("متبرع", "1800+"),
                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: TextField(
                        textAlign: TextAlign.right,
                        onChanged: (value) {
                          setState(() {
                            searchText = value;
                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xffB0BDB2),
                          hintText: "البحث",
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Color(0xff2F674D),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          buildFilterButton("الكل"),
                          buildFilterButton("عاجلة جداً"),
                          buildFilterButton("مكتملة"),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    ListView.builder(
                      shrinkWrap: true,
                      physics:
                      const NeverScrollableScrollPhysics(),
                      itemCount: filteredCases.length,
                      itemBuilder: (context, index) {
                        final c = filteredCases[index];

                        return CaseItem(
                          image: c.image,
                          title: c.title,
                          description: c.description,
                          rateValue: c.rateValue,
                          collectedValue: c.collectedValue,
                          allValue: c.allValue,
                          status: c.status,
                        );
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildFilterButton(String title) {
    final isSelected = selectedFilter == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = title;
        });
      },
      child: Container(
        padding:
        const EdgeInsets.symmetric(horizontal: 34, vertical: 13),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xff2F674D)
              : Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          title,
          style: GoogleFonts.manrope(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color:
            isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String title, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: 18, vertical: 8),
      padding: const EdgeInsets.symmetric(
          horizontal: 18, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF8FAF9A),
        borderRadius: BorderRadius.circular(45),
      ),
      child: Row(
        children: [
          Text(title,
              style: GoogleFonts.manrope(
                  color: const Color(0xff287A54))),
          const Spacer(),
          Text(value,
              style: GoogleFonts.manrope(
                  color: const Color(0xff287A54))),
        ],
      ),
    );
  }
}