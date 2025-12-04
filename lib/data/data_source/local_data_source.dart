import 'package:clean_architecture_mvvm/application/app_constants.dart';
import 'package:clean_architecture_mvvm/data/error/error_handler.dart';
import 'package:clean_architecture_mvvm/data/response/responses.dart';

abstract class LocalDataSource {
  Future<HomeResponse> getHomeData();
  Future<StoreDetailsResponse> getStoreDetails();
  Future<void> cacheHomeData(HomeResponse homeResponse);
  Future<void> cacheStoreDetails(StoreDetailsResponse storeDetailsResponse);
  void clearCache();
  void removeFromCache(String key);
}

class LocalDataSourceImplementation implements LocalDataSource {
  Map<String, CachedItem> cache = {};

  @override
  Future<void> cacheHomeData(HomeResponse homeResponse) async {
    cache[AppConstants.homeCacheKey] = CachedItem(data: homeResponse);
  }

  @override
  Future<HomeResponse> getHomeData() async {
    final cachedItem = cache[AppConstants.homeCacheKey];
    if (cachedItem != null &&
        cachedItem.isValid(AppConstants.cacheDurationMs)) {
      return cachedItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  void clearCache() {
    cache.clear();
  }

  @override
  void removeFromCache(String key) {
    cache.remove(key);
  }

  @override
  Future<void> cacheStoreDetails(
    StoreDetailsResponse storeDetailsResponse,
  ) async {
    cache[AppConstants.storeDetailsCacheKey] = CachedItem(
      data: storeDetailsResponse,
    );
  }

  @override
  Future<StoreDetailsResponse> getStoreDetails() async {
    final cachedItem = cache[AppConstants.storeDetailsCacheKey];

    if (cachedItem != null &&
        cachedItem.isValid(AppConstants.cacheDurationMs)) {
      return cachedItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }
}

class CachedItem {
  CachedItem({required this.data});

  dynamic data;
  int timestamp = DateTime.now().millisecondsSinceEpoch;

  bool isValid(int expirationTime) {
    final currentTime = DateTime.now().millisecondsSinceEpoch;

    bool isValid = currentTime - timestamp <= expirationTime;

    return isValid;
  }
}
