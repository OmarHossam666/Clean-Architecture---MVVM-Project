import 'package:clean_architecture_mvvm/presentation/main/screens/home_screen.dart';
import 'package:clean_architecture_mvvm/presentation/main/screens/notifications_screen.dart';
import 'package:clean_architecture_mvvm/presentation/main/screens/search_screen.dart';
import 'package:clean_architecture_mvvm/presentation/main/screens/settings_screen.dart';
import 'package:clean_architecture_mvvm/presentation/resources/colors_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/strings_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  final List<String> titles = [
    StringsManager.home,
    StringsManager.search,
    StringsManager.notifications,
    StringsManager.settings,
  ];
  final List<Widget> screens = [
    HomeScreen(),
    SearchScreen(),
    NotificationsScreen(),
    SettingsScreen(),
  ];
  final List<BottomNavigationBarItem> bottomNavigationBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      label: StringsManager.home,
      activeIcon: Icon(Icons.home),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search_outlined),
      label: StringsManager.search,
      activeIcon: Icon(Icons.search),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.notifications_outlined),
      label: StringsManager.notifications,
      activeIcon: Icon(Icons.notifications),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings_outlined),
      label: StringsManager.settings,
      activeIcon: Icon(Icons.settings),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[currentIndex], style: StylesManager.titleTextStyle),
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: ColorsManager.primary,
        unselectedItemColor: ColorsManager.grey,
        backgroundColor: ColorsManager.white,
        items: bottomNavigationBarItems,
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
      ),
    );
  }
}
