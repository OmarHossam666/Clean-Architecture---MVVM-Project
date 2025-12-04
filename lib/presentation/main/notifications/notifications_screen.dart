import 'package:clean_architecture_mvvm/presentation/resources/styles_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:clean_architecture_mvvm/presentation/resources/strings_manager.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        StringsManager.notifications.tr(),
        style: StylesManager.sectionHeaderTextStyle,
      ),
    );
  }
}
