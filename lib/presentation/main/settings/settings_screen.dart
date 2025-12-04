import 'dart:math' as math;

import 'package:clean_architecture_mvvm/application/app_preferences.dart';
import 'package:clean_architecture_mvvm/application/dependency_injection.dart';
import 'package:clean_architecture_mvvm/data/data_source/local_data_source.dart';
import 'package:clean_architecture_mvvm/presentation/resources/colors_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/language_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/routes_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/strings_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/styles_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late List<SettingsItemData> settingsItems = [
    SettingsItemData(
      title: StringsManager.changeLanguage.tr(),
      icon: Icons.translate,
      hasTrailingIcon: true,
      onTap: () => _changeLanguage(context),
    ),
    SettingsItemData(
      title: StringsManager.contactUs.tr(),
      icon: Icons.contact_mail,
      hasTrailingIcon: true,
      onTap: () {},
    ),
    SettingsItemData(
      title: StringsManager.inviteYourFriends.tr(),
      icon: Icons.share,
      hasTrailingIcon: true,
      onTap: () {},
    ),
    SettingsItemData(
      title: StringsManager.logout.tr(),
      icon: Icons.logout,
      hasTrailingIcon: false,
      onTap: () => _logout(),
    ),
  ];
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final LocalDataSource _localDataSource = instance<LocalDataSource>();

  Future<void> _logout() async {
    _localDataSource.clearCache();
    await _appPreferences.clear();

    if (mounted) {
      Navigator.pushReplacementNamed(context, RoutesManager.loginRoute);
    }
  }

  Future<void> _changeLanguage(BuildContext context) async {
    await _appPreferences.changeLanguage();
    if (context.mounted) {
      Phoenix.rebirth(context);
    }
  }

  bool isRTL() => context.locale == LanguageManager.arabicLocale;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(ValuesManager.padding16),
        child: ListView.separated(
          itemCount: settingsItems.length,
          itemBuilder: (context, index) {
            return _getSettingsItem(settingsItems[index]);
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
        ),
      ),
    );
  }

  Widget _getSettingsItem(SettingsItemData settingsItemData) {
    return ListTile(
      contentPadding: EdgeInsets.all(ValuesManager.padding8),
      title: Text(
        settingsItemData.title,
        style: StylesManager.sectionHeaderTextStyle,
      ),
      leading: Icon(
        settingsItemData.icon,
        size: ValuesManager.iconSize32,
        color: ColorsManager.primary,
      ),
      trailing: settingsItemData.hasTrailingIcon
          ? Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(isRTL() ? math.pi : 0),
              child: Icon(
                Icons.arrow_forward_ios,
                color: ColorsManager.primary,
                size: ValuesManager.iconSize32,
              ),
            )
          : null,
      onTap: settingsItemData.onTap,
    );
  }
}

class SettingsItemData {
  SettingsItemData({
    required this.title,
    required this.icon,
    required this.hasTrailingIcon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final bool hasTrailingIcon;
  final VoidCallback onTap;
}
