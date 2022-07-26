import 'package:advanced_flutter_arabic/domain/model/homeDetails.dart';
import 'package:advanced_flutter_arabic/domain/model/notification.dart';

import '../model/home.dart';

const CACHE_HOME_DETAILS_KEY = "CACHE_HOME_DETAILS_KEY";
const CACHE_HOME_KEY = "CACHE_HOME_KEY";
const CACHE_NOTIFICATION_KEY = "CACHE_NOTIFICATION_KEY";
const CACHE_HOME_INTERVAL = 1 * 60 * 1000; // 1 minute cache in millis

abstract class LocalDataSource {
  Home getHomeData();
  HomeDetailsModel getHomeDetailsData();
  NotificationModel getNotificationData();
  void saveHomeToCache(Home homeResponse);
  void saveHomeDetailsToCache(HomeDetailsModel homeResponse);
  void saveNotificationToCache(NotificationModel notificationResponse);
  void clearCache();

  void removeFromCache(String key);
}
