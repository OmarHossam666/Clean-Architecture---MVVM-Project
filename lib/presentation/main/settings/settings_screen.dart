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
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late List<SettingsItemData> settingsItems;
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final LocalDataSource _localDataSource = instance<LocalDataSource>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initSettingsItems();
  }

  void _initSettingsItems() {
    settingsItems = [
      SettingsItemData(
        title: StringsManager.changeLanguage.tr(),
        icon: Icons.translate,
        hasTrailingIcon: true,
        onTap: () => _changeLanguage(context),
        semanticLabel: StringsManager.changeLanguage.tr(),
      ),
      SettingsItemData(
        title: StringsManager.contactUs.tr(),
        icon: Icons.contact_mail,
        hasTrailingIcon: true,
        onTap: () {},
        semanticLabel: StringsManager.contactUs.tr(),
      ),
      SettingsItemData(
        title: StringsManager.inviteYourFriends.tr(),
        icon: Icons.share,
        hasTrailingIcon: true,
        onTap: () {},
        semanticLabel: StringsManager.inviteYourFriends.tr(),
      ),
      SettingsItemData(
        title: StringsManager.logout.tr(),
        icon: Icons.logout,
        hasTrailingIcon: false,
        onTap: () => _showLogoutConfirmation(),
        semanticLabel: StringsManager.logout.tr(),
      ),
    ];
  }

  Future<void> _showLogoutConfirmation() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          StringsManager.logout.tr(),
          style: StylesManager.sectionHeaderTextStyle,
        ),
        content: Text(
          StringsManager.logoutConfirmation.tr(),
          style: StylesManager.bodyTextStyle,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(StringsManager.cancel.tr()),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(StringsManager.logout.tr()),
          ),
        ],
      ),
    );

    if (shouldLogout == true) {
      await _logout();
    }
  }

  Future<void> _logout() async {
    HapticFeedback.mediumImpact();
    _localDataSource.clearCache();
    await _appPreferences.clear();

    if (mounted) {
      Navigator.pushReplacementNamed(context, RoutesManager.loginRoute);
    }
  }

  Future<void> _changeLanguage(BuildContext context) async {
    HapticFeedback.selectionClick();
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
        padding: const EdgeInsets.all(ValuesManager.padding16),
        child: ListView.separated(
          itemCount: settingsItems.length,
          itemBuilder: (context, index) {
            return _getSettingsItem(settingsItems[index]);
          },
          separatorBuilder: (context, index) {
            return const Divider(
              color: ColorsManager.divider,
              height: ValuesManager.spacing16,
            );
          },
        ),
      ),
    );
  }

  Widget _getSettingsItem(SettingsItemData settingsItemData) {
    return Semantics(
      button: true,
      label: settingsItemData.semanticLabel,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: ValuesManager.padding8,
          vertical: ValuesManager.padding4,
        ),
        minVerticalPadding: ValuesManager.padding8,
        title: Text(settingsItemData.title, style: StylesManager.bodyLarge),
        leading: Container(
          padding: const EdgeInsets.all(ValuesManager.padding8),
          decoration: BoxDecoration(
            color: ColorsManager.primaryLight.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(ValuesManager.radius8),
          ),
          child: Icon(
            settingsItemData.icon,
            size: ValuesManager.iconSize24,
            color: ColorsManager.primary,
          ),
        ),
        trailing: settingsItemData.hasTrailingIcon
            ? Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(isRTL() ? math.pi : 0),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: ColorsManager.grey,
                  size: ValuesManager.iconSize20,
                ),
              )
            : null,
        onTap: () {
          HapticFeedback.lightImpact();
          settingsItemData.onTap();
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ValuesManager.radius8),
        ),
      ),
    );
  }
}

class SettingsItemData {
  const SettingsItemData({
    required this.title,
    required this.icon,
    required this.hasTrailingIcon,
    required this.onTap,
    this.semanticLabel,
  });

  final String title;
  final IconData icon;
  final bool hasTrailingIcon;
  final VoidCallback onTap;
  final String? semanticLabel;
}
