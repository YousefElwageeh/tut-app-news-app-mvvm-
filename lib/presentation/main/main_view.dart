import 'package:advanced_flutter_arabic/presentation/main/pages/search/search.dart';
import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import '../resources/strings_manager.dart';
import 'pages/Setting/setting.dart';
import 'pages/home/view/home_view.dart';
import 'pages/notification/view/notification.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> screens = [
    const HomeScreen(),
    const SearchScreen(),
    const NotificationScreen(),
    const SettingsScreen(),
  ];
  List<String> titles = [
    AppStrings.home,
    AppStrings.search,
    AppStrings.notifications,
    AppStrings.settings,
  ];
  String _title = AppStrings.home;
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: ColorManager.primary,
        unselectedItemColor: ColorManager.grey,
        currentIndex: _currentIndex,
        onTap: onTap,
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined), label: AppStrings.home),
          BottomNavigationBarItem(
              icon: const Icon(Icons.search), label: AppStrings.search),
          BottomNavigationBarItem(
              icon: const Icon(Icons.notifications),
              label: AppStrings.notifications),
          BottomNavigationBarItem(
              icon: const Icon(Icons.settings), label: AppStrings.settings),
        ],
      ),
    );
  }

  onTap(int index) {
    setState(() {
      _currentIndex = index;
      _title = titles[index];
    });
  }
}
