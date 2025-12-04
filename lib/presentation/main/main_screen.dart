import 'package:clean_architecture_mvvm/presentation/main/home/view/home_screen.dart';
import 'package:clean_architecture_mvvm/presentation/main/notifications/notifications_screen.dart';
import 'package:clean_architecture_mvvm/presentation/main/search/search_screen.dart';
import 'package:clean_architecture_mvvm/presentation/main/settings/settings_screen.dart';
import 'package:clean_architecture_mvvm/presentation/resources/colors_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/constants_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/strings_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/styles_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  // Using const constructors for better performance
  static const List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    NotificationsScreen(),
    SettingsScreen(),
  ];

  List<BottomNavigationBarItem> get bottomNavigationBarItems => [
    BottomNavigationBarItem(
      icon: const Icon(Icons.home_outlined),
      label: StringsManager.home.tr(),
      activeIcon: const Icon(Icons.home),
      tooltip: StringsManager.home.tr(),
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.search_outlined),
      label: StringsManager.search.tr(),
      activeIcon: const Icon(Icons.search),
      tooltip: StringsManager.search.tr(),
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.notifications_outlined),
      label: StringsManager.notifications.tr(),
      activeIcon: const Icon(Icons.notifications),
      tooltip: StringsManager.notifications.tr(),
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.settings_outlined),
      label: StringsManager.settings.tr(),
      activeIcon: const Icon(Icons.settings),
      tooltip: StringsManager.settings.tr(),
    ),
  ];

  void _onItemTapped(int index) {
    if (index != currentIndex) {
      HapticFeedback.selectionClick();
      setState(() {
        currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Semantics(
          header: true,
          child: Text(
            titles[currentIndex],
            style: StylesManager.titleTextStyle,
          ),
        ),
      ),
      body: IndexedStack(index: currentIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: ColorsManager.primary,
        unselectedItemColor: ColorsManager.grey,
        backgroundColor: ColorsManager.surface,
        elevation: ValuesManager.elevation8,
        selectedFontSize: ConstantsManager.bottomNavSelectedFontSize,
        unselectedFontSize: ConstantsManager.bottomNavUnselectedFontSize,
        items: bottomNavigationBarItems,
        currentIndex: currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
