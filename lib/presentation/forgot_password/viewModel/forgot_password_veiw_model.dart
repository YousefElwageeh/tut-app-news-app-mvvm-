import 'package:advanced_flutter_arabic/data/repository/api_repo_impl.dart';
import 'package:advanced_flutter_arabic/domain/repository/api_repo.dart';
import 'package:advanced_flutter_arabic/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/network/requstes/forgot_password_request.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../resources/strings_manager.dart';

class ForgotPasswordViewModel extends GetxController {
  TextEditingController emailController = TextEditingController();

  @override
  void onInit() {
    emailController.addListener(() {
      checkEmail(emailController.text);
    });

    super.onInit();
  }

  RxBool isEmailVaild = false.obs;
  void checkEmail(String email) {
    isEmailVaild.value = GetUtils.isEmail(email);
  }

  FlowState screenState = ContentState();
  Repository model = RepositoryImpl();
  void resetPassword() {
    screenState = LoadingState(
        message: AppStrings.loading,
        stateRendererType: StateRendererType.fullScreenLoadingState);
    model
        .resetPassword(ForgotPasswordRequset(email: emailController.text))
        .then((value) => value.fold((failure) {
              screenState = ErrorState(
                  StateRendererType.popupErrorState, failure.message);
              update();
            }, (data) {
              screenState = SucessState(StateRendererType.popSuccessState,
                  data.message! + '\n' + data.support!);
              update();
            }));
  }
}
