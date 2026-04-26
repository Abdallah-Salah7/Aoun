import 'package:flutter/material.dart';

class FieldDropdown extends StatefulWidget {
  final Function(String?) onChanged;
  const FieldDropdown({super.key, required this.onChanged});
  @override
  _FieldDropdownState createState() => _FieldDropdownState();
}

class _FieldDropdownState extends State<FieldDropdown> {
  final List<String> categories = [
    'الصحة',
    'الإغاثة',
    'التعليم',
    'كفالات',
    'مشاريع بناء',
  ];

  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: 55,
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffC4C4C4), width: 1.5),
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            menuMaxHeight: 300,
            alignment: AlignmentDirectional.bottomStart,
            borderRadius: BorderRadius.circular(16),
            hint: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                selectedCategory ?? "الكل",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            value: selectedCategory,
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.black87,
              size: 28,
            ),
            dropdownColor: Colors.white,
            elevation: 8,
            items:
                categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        category,
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                    ),
                  );
                }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedCategory = newValue;
              });

              widget.onChanged(newValue);
            },
          ),
        ),
      ),
    );
  }
}
