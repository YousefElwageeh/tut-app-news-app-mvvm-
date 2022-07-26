import 'package:advanced_flutter_arabic/presentation/common/state_renderer/state_renderer.dart';
import 'package:advanced_flutter_arabic/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:get/get.dart';

import '../../../../../data/repository/api_repo_impl.dart';
import '../../../../../domain/model/home.dart';
import '../../../../../domain/repository/api_repo.dart';
import '../../../../resources/strings_manager.dart';

class HomeViewModel extends GetxController {
  @override
  void onInit() {
    getHomeData();
    super.onInit();
  }

  FlowState screenState = LoadingState(
      message: AppStrings.loading,
      stateRendererType: StateRendererType.fullScreenLoadingState);
  Repository repo = RepositoryImpl();
  Home? homeData;

  void getHomeData() {
    screenState = LoadingState(
        message: AppStrings.loading,
        stateRendererType: StateRendererType.fullScreenLoadingState);
    update();
    repo.getHome().then((value) => value.fold((faliuer) {
          screenState = ErrorState(
              StateRendererType.fullScreenErrorState, faliuer.message);
          update();
        }, (data) {
          screenState = ContentState();
          homeData = data;
          update();
        }));
  }
}
