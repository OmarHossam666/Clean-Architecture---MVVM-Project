import 'package:carousel_slider/carousel_slider.dart';
import 'package:clean_architecture_mvvm/application/dependency_injection.dart';
import 'package:clean_architecture_mvvm/presentation/common/state_renderer/state_renderer_implementation.dart';
import 'package:clean_architecture_mvvm/presentation/main/home/view_model/home_view_model.dart';
import 'package:clean_architecture_mvvm/presentation/resources/colors_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/routes_manager.dart';
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
    return StreamBuilder<HomeModel>(
      stream: _homeViewModel.outputHome,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Container();
        }
        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: ValuesManager.spacing8,
              children: [
                _getBanners(snapshot.data?.data.banners ?? []),
                _getSection(StringsManager.services),
                _getServices(snapshot.data?.data.services ?? []),
                _getSection(StringsManager.stores),
                _getStores(snapshot.data?.data.stores ?? []),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _getBanners(List<Banner> banners) {
    if (banners.isEmpty) {
      return const SizedBox();
    }
    return CarouselSlider(
      items: banners.map((banner) => _getBanner(banner)).toList(),
      options: CarouselOptions(
        height: ValuesManager.height140,
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
  }

  Widget _getBanner(Banner banner) {
    return SizedBox(
      width: double.infinity,
      child: Card(
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

  Widget _getServices(List<Service> services) {
    return SizedBox(
      height: ValuesManager.height200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: services.length,
        itemBuilder: (context, index) {
          return _getService(services[index]);
        },
      ),
    );
  }

  Widget _getService(Service service) {
    return SizedBox(
      width: ValuesManager.width200,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: ValuesManager.spacing8,
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(
                ValuesManager.radius16,
              ),
              child: Image.network(service.image, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: ValuesManager.padding8,
              ),
              child: Text(
                service.title,
                style: StylesManager.subtitleTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getStores(List<Store> stores) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: ValuesManager.spacing8,
        crossAxisSpacing: ValuesManager.spacing8,
      ),
      itemCount: stores.length,
      itemBuilder: (context, index) {
        return _getStore(stores[index], context);
      },
    );
  }
}

Widget _getStore(Store store, BuildContext context) {
  return InkWell(
    onTap: () => Navigator.pushNamed(context, RoutesManager.detailsRoute),
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
