import 'package:advanced_flutter_arabic/app/extensions.dart';
import 'package:advanced_flutter_arabic/data/network/error_handler.dart';
import 'package:advanced_flutter_arabic/domain/model/home.dart';
import 'package:advanced_flutter_arabic/domain/model/homeDetails.dart';
import 'package:advanced_flutter_arabic/domain/model/notification.dart';

import '../../domain/repository/local_repo.dart';

Map<String, CachedItem> cacheMap = {};

class LocalDataSourceImpl implements LocalDataSource {
  // run time cache

  @override
  Home getHomeData() {
    CachedItem? cachedItem = cacheMap[CACHE_HOME_KEY];

    if (cachedItem != null && cachedItem.isValid(CACHE_HOME_INTERVAL)) {
      // return the response from cache
      return cachedItem.data;
    } else {
      // return an error that cache is not there or its not valid
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveHomeToCache(Home homeResponse) async {
    cacheMap[CACHE_HOME_KEY] = CachedItem(homeResponse);
  }

  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }

  @override
  void saveHomeDetailsToCache(HomeDetailsModel homeResponse) {
    cacheMap[CACHE_HOME_DETAILS_KEY] = CachedItem(homeResponse);
    print(cacheMap[CACHE_HOME_DETAILS_KEY]);
  }

  @override
  HomeDetailsModel getHomeDetailsData() {
    CachedItem? cachedItem = cacheMap[CACHE_HOME_DETAILS_KEY];
    print(cachedItem?.data);
    if (cachedItem != null && cachedItem.isValid(CACHE_HOME_INTERVAL)) {
      print('wasssssl');
      // return the response from cache
      return cachedItem.data;
    } else {
      // return an error that cache is not there or its not valid
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  NotificationModel getNotificationData() {
    CachedItem? cachedItem = cacheMap[CACHE_NOTIFICATION_KEY];

    if (cachedItem != null && cachedItem.isValid(CACHE_HOME_INTERVAL)) {
      // return the response from cache
      return cachedItem.data;
    } else {
      // return an error that cache is not there or its not valid
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  void saveNotificationToCache(NotificationModel notificationResponse) {
    cacheMap[CACHE_NOTIFICATION_KEY] = CachedItem(notificationResponse);
    print(cacheMap[CACHE_NOTIFICATION_KEY]);
  }
}

class CachedItem {
  dynamic data;

  int cacheTime = DateTime.now().millisecondsSinceEpoch;

  CachedItem(this.data);
}
