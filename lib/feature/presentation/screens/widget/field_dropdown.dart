import 'package:flutter/material.dart';

class FieldDropdown extends StatefulWidget {
  final Function(String?) onChanged;

  const FieldDropdown({super.key, required this.onChanged});

  @override
  State<FieldDropdown> createState() => _FieldDropdownState();
}

class _FieldDropdownState extends State<FieldDropdown> {
  final List<String> categories = [
    'الكل',
    'الصحة',
    'التعليم',
    'الإغاثة',
    'كفالات',
    'مشاريع بناء',
    'التنمية',
    'ذوي الاحتياجات',
    'كفارات',
    'الغارمين',
    'الإطعام',
  ];

  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    selectedCategory = 'الكل';
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: 55,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffC4C4C4), width: 1.5),
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            menuMaxHeight: 300,
            value: selectedCategory,
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.black87,
              size: 28,
            ),
            dropdownColor: Colors.white,
            items: categories.map((category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    category,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedCategory = value;
              });
              widget.onChanged(value);
            },
          ),
        ),
      ),
    );
  }
}