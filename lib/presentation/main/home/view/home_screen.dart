import 'package:carousel_slider/carousel_slider.dart';
import 'package:clean_architecture_mvvm/application/dependency_injection.dart';
import 'package:clean_architecture_mvvm/presentation/common/state_renderer/state_renderer_implementation.dart';
import 'package:clean_architecture_mvvm/presentation/main/home/view_model/home_view_model.dart';
import 'package:clean_architecture_mvvm/presentation/resources/colors_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/constants_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/routes_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/strings_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/styles_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' hide Banner;
import 'package:flutter/services.dart';
import 'package:clean_architecture_mvvm/domain/models/models.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  final HomeViewModel _homeViewModel = instance<HomeViewModel>();

  @override
  bool get wantKeepAlive => true;

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
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async {
        HapticFeedback.mediumImpact();
        _homeViewModel.getHomeData();
      },
      color: ColorsManager.primary,
      child: Padding(
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
      ),
    );
  }

  Widget _getContent() {
    return StreamBuilder<HomeModel>(
      stream: _homeViewModel.outputHome,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const SizedBox.shrink();
        }
        return SafeArea(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _getBanners(snapshot.data?.data.banners ?? []),
                const SizedBox(height: ValuesManager.spacing16),
                _getSection(StringsManager.services.tr()),
                const SizedBox(height: ValuesManager.spacing8),
                _getServices(snapshot.data?.data.services ?? []),
                const SizedBox(height: ValuesManager.spacing16),
                _getSection(StringsManager.stores.tr()),
                const SizedBox(height: ValuesManager.spacing8),
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
      return const SizedBox.shrink();
    }
    return RepaintBoundary(
      child: CarouselSlider(
        items: banners.map((banner) => _getBanner(banner)).toList(),
        options: CarouselOptions(
          height: ValuesManager.height140,
          viewportFraction: 0.85,
          autoPlay: true,
          enableInfiniteScroll: true,
          autoPlayInterval: ConstantsManager.carouselAutoPlayInterval,
          autoPlayAnimationDuration: ConstantsManager.carouselAnimationDuration,
          autoPlayCurve: Curves.easeInOutCubic,
          enlargeCenterPage: true,
          enlargeFactor: 0.25,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }

  Widget _getBanner(Banner banner) {
    return Semantics(
      image: true,
      label: banner.title,
      child: SizedBox(
        width: double.infinity,
        child: Card(
          elevation: ValuesManager.elevation2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ValuesManager.radius12),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Image.network(
            banner.image,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                color: ColorsManager.shimmerBase,
                child: Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                        : null,
                    color: ColorsManager.primary,
                    strokeWidth: 2,
                  ),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: ColorsManager.surfaceVariant,
                child: const Center(
                  child: Icon(
                    Icons.broken_image_outlined,
                    color: ColorsManager.grey,
                    size: ValuesManager.iconSize48,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _getSection(String title) {
    return Semantics(
      header: true,
      child: Text(
        title,
        style: StylesManager.sectionHeaderTextStyle.copyWith(
          color: ColorsManager.primary,
        ),
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
          return Padding(
            padding: EdgeInsets.only(
              right: index < services.length - 1 ? ValuesManager.spacing8 : 0,
            ),
            child: _getService(services[index]),
          );
        },
      ),
    );
  }

  Widget _getService(Service service) {
    return Semantics(
      label: service.title,
      child: SizedBox(
        width: ValuesManager.width200,
        child: Card(
          color: ColorsManager.surface,
          elevation: ValuesManager.elevation2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ValuesManager.radius12),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Image.network(
                  service.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: ColorsManager.shimmerBase,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: ColorsManager.primary,
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: ColorsManager.surfaceVariant,
                      child: const Center(
                        child: Icon(
                          Icons.broken_image_outlined,
                          color: ColorsManager.grey,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(ValuesManager.padding8),
                  child: Text(
                    service.title,
                    style: StylesManager.subtitleTextStyle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
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
        return _StoreCard(store: stores[index]);
      },
    );
  }
}

class _StoreCard extends StatelessWidget {
  const _StoreCard({required this.store});

  final Store store;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: store.title,
      child: InkWell(
        onTap: () {
          HapticFeedback.lightImpact();
          Navigator.pushNamed(context, RoutesManager.detailsRoute);
        },
        borderRadius: BorderRadius.circular(ValuesManager.radius12),
        child: Card(
          color: ColorsManager.surface,
          elevation: ValuesManager.elevation2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ValuesManager.radius12),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Image.network(
            store.image,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                color: ColorsManager.shimmerBase,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: ColorsManager.primary,
                    strokeWidth: 2,
                  ),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: ColorsManager.surfaceVariant,
                child: const Center(
                  child: Icon(
                    Icons.broken_image_outlined,
                    color: ColorsManager.grey,
                    size: ValuesManager.iconSize48,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
