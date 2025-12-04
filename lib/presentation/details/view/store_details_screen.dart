import 'package:clean_architecture_mvvm/application/dependency_injection.dart';
import 'package:clean_architecture_mvvm/domain/models/models.dart';
import 'package:clean_architecture_mvvm/presentation/common/state_renderer/state_renderer_implementation.dart';
import 'package:clean_architecture_mvvm/presentation/details/view_model/store_details_view_model.dart';
import 'package:clean_architecture_mvvm/presentation/resources/colors_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/strings_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/styles_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

class StoreDetailsScreen extends StatefulWidget {
  const StoreDetailsScreen({super.key});

  @override
  State<StoreDetailsScreen> createState() => _StoreDetailsScreenState();
}

class _StoreDetailsScreenState extends State<StoreDetailsScreen> {
  final StoreDetailsViewModel _storeDetailsViewModel =
      instance<StoreDetailsViewModel>();

  @override
  void initState() {
    super.initState();
    _bind();
  }

  void _bind() {
    _storeDetailsViewModel.start();
  }

  @override
  void dispose() {
    _storeDetailsViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(StringsManager.storeDetails)),
      body: Padding(
        padding: const EdgeInsets.all(ValuesManager.padding16),
        child: Center(
          child: StreamBuilder<FlowState>(
            stream: _storeDetailsViewModel.outputState,
            builder: (context, snapshot) {
              return snapshot.data?.getScreen(
                    context,
                    () => _storeDetailsViewModel.getStoreDetails(),
                    _getContent(),
                  ) ??
                  _getContent();
            },
          ),
        ),
      ),
    );
  }

  Widget _getContent() {
    return StreamBuilder<StoreDetails>(
      stream: _storeDetailsViewModel.storeDetailsOutput,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Container();
        }

        final storeDetails = snapshot.data!;

        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: ValuesManager.spacing12,
              children: [
                Image.network(storeDetails.image, width: double.infinity),
                _getSection(StringsManager.details),
                Text(storeDetails.details, style: StylesManager.bodyTextStyle),
                _getSection(StringsManager.services),
                Text(storeDetails.services, style: StylesManager.bodyTextStyle),
                _getSection(StringsManager.about),
                Text(storeDetails.about, style: StylesManager.bodyTextStyle),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _getSection(String title) {
    return Text(
      title,
      style: StylesManager.sectionHeaderTextStyle.copyWith(
        color: ColorsManager.primary,
      ),
    );
  }
}
