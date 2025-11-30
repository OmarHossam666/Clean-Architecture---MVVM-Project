import 'package:carousel_slider/carousel_slider.dart';
import 'package:clean_architecture_mvvm/application/dependency_injection.dart';
import 'package:clean_architecture_mvvm/presentation/common/state_renderer/state_renderer_implementation.dart';
import 'package:clean_architecture_mvvm/presentation/main/view_models/home_view_model.dart';
import 'package:clean_architecture_mvvm/presentation/resources/colors_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/strings_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/styles_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart' hide Banner;
import 'package:clean_architecture_mvvm/domain/models/models.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeViewModel _homeViewModel = instance<HomeViewModel>();

  @override
  void initState() {
    _bind();
    super.initState();
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
    return Padding(
      padding: const EdgeInsets.all(ValuesManager.padding16),
      child: Center(
        child: StreamBuilder<FlowState>(
          stream: _homeViewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data?.getScreen(
                  context,
                  () => _homeViewModel.getHomeData(),
                  _getContent(),
                ) ??
                _getContent();
          },
        ),
      ),
    );
  }

  Widget _getContent() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: ValuesManager.spacing8,
          children: [
            _getBanners(),
            _getSection(StringsManager.services),
            _getServices(),
            _getSection(StringsManager.stores),
            _getStores(),
          ],
        ),
      ),
    );
  }

  Widget _getBanners() {
    return StreamBuilder<List<Banner>>(
      stream: _homeViewModel.outputBanners,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return CarouselSlider(
            items: snapshot.data?.map((banner) => _getBanner(banner)).toList(),
            options: CarouselOptions(
              height: ValuesManager.height100,
              viewportFraction: 0.8,
              autoPlay: true,
              enableInfiniteScroll: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              scrollDirection: Axis.horizontal,
            ),
          );
        } else {
          return _getLoading();
        }
      },
    );
  }

  Widget _getBanner(Banner banner) {
    return Card(
      elevation: ValuesManager.elevation4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ValuesManager.radius16),
        side: BorderSide(
          color: ColorsManager.primary,
          width: ValuesManager.width1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(ValuesManager.radius16),
        child: Image.network(banner.image, fit: BoxFit.cover),
      ),
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

  Widget _getServices() {
    return StreamBuilder<List<Service>>(
      stream: _homeViewModel.outputServices,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return _getService(snapshot.data![index]);
            },
          );
        } else {
          return _getLoading();
        }
      },
    );
  }

  Widget _getService(Service service) {
    return Card(
      color: ColorsManager.white,
      shadowColor: ColorsManager.primary,
      elevation: ValuesManager.elevation4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ValuesManager.radius16),
        side: BorderSide(
          color: ColorsManager.primary,
          width: ValuesManager.width1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: ValuesManager.spacing8,
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(ValuesManager.radius16),
            child: Image.network(service.image, fit: BoxFit.cover),
          ),
          Text(service.title, style: StylesManager.subtitleTextStyle),
        ],
      ),
    );
  }

  Widget _getStores() {
    return StreamBuilder<List<Store>>(
      stream: _homeViewModel.outputStores,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: ValuesManager.spacing8,
              crossAxisSpacing: ValuesManager.spacing8,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return _getStore(snapshot.data![index]);
            },
          );
        } else {
          return _getLoading();
        }
      },
    );
  }
}

Widget _getStore(Store store) {
  return InkWell(
    child: Card(
      color: ColorsManager.white,
      shadowColor: ColorsManager.primary,
      elevation: ValuesManager.elevation4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ValuesManager.radius16),
        side: BorderSide(
          color: ColorsManager.primary,
          width: ValuesManager.width1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(ValuesManager.radius16),
        child: Image.network(store.image, fit: BoxFit.cover),
      ),
    ),
  );
}

Widget _getLoading() {
  return const Center(
    child: CircularProgressIndicator(
      color: ColorsManager.primary,
      strokeWidth: ValuesManager.width2,
    ),
  );
}
