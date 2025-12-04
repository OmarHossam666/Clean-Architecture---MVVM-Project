import 'package:clean_architecture_mvvm/presentation/main/home/view/home_screen.dart';
import 'package:clean_architecture_mvvm/presentation/main/notifications/notifications_screen.dart';
import 'package:clean_architecture_mvvm/presentation/main/search/search_screen.dart';
import 'package:clean_architecture_mvvm/presentation/main/settings/settings_screen.dart';
import 'package:clean_architecture_mvvm/presentation/resources/colors_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/strings_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/styles_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  List<String> get titles => [
    StringsManager.home.tr(),
    StringsManager.search.tr(),
    StringsManager.notifications.tr(),
    StringsManager.settings.tr(),
  ];
  final List<Widget> screens = [
    HomeScreen(),
    SearchScreen(),
    NotificationsScreen(),
    SettingsScreen(),
  ];
  List<BottomNavigationBarItem> get bottomNavigationBarItems => [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      label: StringsManager.home.tr(),
      activeIcon: Icon(Icons.home),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search_outlined),
      label: StringsManager.search.tr(),
      activeIcon: Icon(Icons.search),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.notifications_outlined),
      label: StringsManager.notifications.tr(),
      activeIcon: Icon(Icons.notifications),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings_outlined),
      label: StringsManager.settings.tr(),
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
