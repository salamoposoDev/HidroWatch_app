import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TabbarList extends StatefulWidget {
  const TabbarList({super.key, required this.onChange});
  final void Function(String value) onChange;

  @override
  State<TabbarList> createState() => _TabbarListState();
}

class _TabbarListState extends State<TabbarList> {
  int selectedIndex = 0;
  final textFilter = ['Harian', 'Mingguan', 'Bulanan', 'Tahunan'];
  String selectedText = '';

  @override
  void initState() {
    selectedText = textFilter[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
          textFilter.length,
          (index) => Tabbar(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                  selectedText = textFilter[selectedIndex];
                  widget.onChange(selectedText);
                },
                isSelected: selectedIndex == index ? true : false,
                text: textFilter[index],
              )),
    );
  }
}

class Tabbar extends StatelessWidget {
  const Tabbar({
    super.key,
    required this.text,
    this.isSelected = false,
    required this.onTap,
  });
  final String text;
  final bool? isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.h),
        decoration: BoxDecoration(
          // color: isSelected! ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          // border: Border.all(),
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
              fontSize: isSelected! ? 18 : 16,
              color: isSelected! ? Colors.black : Colors.grey),
        ),
      ),
    );
  }
}
