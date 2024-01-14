import 'package:cctv_iot/home_screen/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: IconThemeData(color: Colors.purple[800], size: 25.h),
        selectedItemColor: Colors.black,
        onTap: (value) {
          setState(() {
            activeIndex = value;
          });
        },
        currentIndex: activeIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_graph),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tune),
            label: 'Setting',
          ),
        ],
      ),
      body: HomePage(),
    );
  }
}
