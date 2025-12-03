import 'package:clean_architecture_mvvm/data/error/error_handler.dart';
import 'package:clean_architecture_mvvm/data/response/responses.dart';

const String homeCacheKey = 'home';
const int cacheDuration = 60 * 1000;

abstract class LocalDataSource {
  Future<HomeResponse> getHomeData();
  Future<void> cacheHomeData(HomeResponse homeResponse);
  void clearCache();
  void removeFromCache(String key);
}

class LocalDataSourceImplementation implements LocalDataSource {
  Map<String, CachedItem> cache = {};

  @override
  Future<void> cacheHomeData(HomeResponse homeResponse) async {
    cache[homeCacheKey] = CachedItem(data: homeResponse);
  }

  @override
  Future<HomeResponse> getHomeData() async {
    final cachedItem = cache[homeCacheKey];
    if (cachedItem != null && cachedItem.isValid(cacheDuration)) {
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
