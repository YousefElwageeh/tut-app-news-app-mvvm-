import 'package:advanced_flutter_arabic/domain/model/notification.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../../../data/repository/api_repo_impl.dart';
import '../../../../../domain/repository/api_repo.dart';
import '../../../../common/state_renderer/state_renderer.dart';
import '../../../../common/state_renderer/state_renderer_impl.dart';
import '../../../../resources/strings_manager.dart';

class NotificationVeiwModel extends GetxController {
  @override
  void onInit() {
    getNotificationData();
    super.onInit();
  }

  FlowState screenState = LoadingState(
      message: AppStrings.loading,
      stateRendererType: StateRendererType.fullScreenLoadingState);
  Repository repo = RepositoryImpl();
  NotificationModel? notificationData;
  void getNotificationData() {
    screenState = LoadingState(
        message: AppStrings.loading,
        stateRendererType: StateRendererType.fullScreenLoadingState);
    update();
    repo.getNotification().then((value) => value.fold((faliuer) {
          screenState = ErrorState(
              StateRendererType.fullScreenErrorState, faliuer.message);
          update();
        }, (data) {
          screenState = ContentState();
          notificationData = data;
          update();
        }));
  }
}
