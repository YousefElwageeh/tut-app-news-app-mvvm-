import 'package:advanced_flutter_arabic/presentation/common/state_renderer/state_renderer.dart';
import 'package:advanced_flutter_arabic/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:advanced_flutter_arabic/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/app_prefs.dart';
import '../../../data/network/requstes/login_request.dart';
import '../../../data/repository/api_repo_impl.dart';
import '../../../domain/repository/api_repo.dart';
import '../../main/main_view.dart';

class LoginViewModel extends GetxController {
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();

  @override
  void onInit() {
    userNameController.addListener(() {
      isUserNameVaild.value = GetUtils.isEmail(userNameController.text);
    });
    userPasswordController.addListener(() {
      userPasswordController.text.length >= 6
          ? isPasswordVaild.value = true
          : false;
    });
    //       .addListener(() => _viewModel.setUserName(_userNameController.text));
    super.onInit();
  }

  RxBool isUserNameVaild = false.obs;

  RxBool isPasswordVaild = false.obs;

  FlowState screenState = ContentState();

  Repository authRepository = RepositoryImpl();
  Future<void> login() async {
    screenState = LoadingState(
        stateRendererType: StateRendererType.popupLoadingState,
        message: AppStrings.loading);

    update();

    var result = await authRepository.login(
        LoginRequest(userNameController.text, userPasswordController.text));
    result.fold((failure) {
      screenState =
          ErrorState(StateRendererType.popupErrorState, failure.message);
      update();
    }, (data) {
      AppPreferences.setUserLoggedIn();
      Get.off(() => const MainView());
      update();
    });
  }
}
