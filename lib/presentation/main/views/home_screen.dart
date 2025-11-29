import 'package:clean_architecture_mvvm/application/dependency_injection.dart';
import 'package:clean_architecture_mvvm/presentation/common/state_renderer/state_renderer_implementation.dart';
import 'package:clean_architecture_mvvm/presentation/main/view_models/home_view_model.dart';
import 'package:clean_architecture_mvvm/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeViewModel _homeViewModel = instance<HomeViewModel>();

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  void dispose() {
    _homeViewModel.dispose();
    super.dispose();
  }

  void _bind() {
    _homeViewModel.start();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlowState>(
      stream: _homeViewModel.outputState,
      builder: (context, snapshot) {
        return snapshot.data?.getScreen(
              context,
              () => _homeViewModel.getHomeData(),
              _getContent(),
            ) ??
            _getContent();
      },
    );
  }

  Widget _getContent() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ValuesManager.padding16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: ValuesManager.spacing8,
            children: [
              _getBanners(),
              _getSection(),
              _getServices(),
              _getSection(),
              _getStores(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getBanners() {
    return Container();
  }

  Widget _getSection() {
    return Container();
  }

  Widget _getServices() {
    return Container();
  }

  Widget _getStores() {
    return Container();
  }
}
