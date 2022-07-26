import 'package:advanced_flutter_arabic/domain/model/homeDetails.dart';
import 'package:advanced_flutter_arabic/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:advanced_flutter_arabic/presentation/resources/strings_manager.dart';
import 'package:get/get.dart';

import '../../../../../../data/repository/api_repo_impl.dart';
import '../../../../../../domain/repository/api_repo.dart';
import '../../../../../common/state_renderer/state_renderer.dart';

class HomeDetailsViewModel extends GetxController {
  @override
  void onInit() {
    getHomeDetailsData();

    super.onInit();
  }

  FlowState screenState = LoadingState(
      message: AppStrings.loading,
      stateRendererType: StateRendererType.fullScreenLoadingState);
  Repository repo = RepositoryImpl();
  HomeDetailsModel? homeDetailsdata;
  void getHomeDetailsData() {
    repo.getHomeDetails().then((value) => value.fold((fauiler) {
          screenState = ErrorState(
              StateRendererType.fullScreenErrorState, fauiler.message);
          update();
        }, (data) {
          homeDetailsdata = data;
          screenState = ContentState();
          update();
        }));
  }
}
