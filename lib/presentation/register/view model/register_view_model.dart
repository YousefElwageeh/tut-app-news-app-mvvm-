import 'package:advanced_flutter_arabic/app/app_prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/network/requstes/register_request.dart';
import '../../../data/repository/api_repo_impl.dart';
import '../../../domain/repository/api_repo.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../../main/main_view.dart';
import '../../resources/strings_manager.dart';

class RegisterViewModel extends GetxController {
  TextEditingController userNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  TextEditingController profileController = TextEditingController();
  String countryCode = '+20';
  RxBool isUserNameVaild = true.obs;
  RxBool isPhoneVaild = true.obs;

  RxBool isEmailVaild = true.obs;

  RxBool isPasswordVaild = true.obs;

  RxBool allInputsValid = false.obs;

  FlowState screenState = ContentState();
  void addlistener({
    required int index,
  }) {
    switch (index) {
      case 1:
        userNameController.addListener(() {
          isUserNameVaild.value =
              userNameController.text.length >= 8 ? true : false;
          areAllInputsValid();
        });
        break;
      case 2:
        mobileNumberController.addListener(() {
          isPhoneVaild.value =
              mobileNumberController.text.length > 10 ? true : false;
          areAllInputsValid();
        });
        break;
      case 3:
        emailController.addListener(() {
          isEmailVaild.value = GetUtils.isEmail(emailController.text);
          areAllInputsValid();
        });
        break;
      case 4:
        userPasswordController.addListener(() {
          isPasswordVaild.value =
              userPasswordController.text.length >= 6 ? true : false;
          areAllInputsValid();
        });
        break;

      default:
        print('wrong number');
    }
  }

  void areAllInputsValid() {
    if (userNameController.text.length >= 8 &&
        mobileNumberController.text.length > 10 &&
        GetUtils.isEmail(emailController.text) &&
        userPasswordController.text.length >= 6) {
      allInputsValid.value = true;
    }
  }

  final ImagePicker imagePicker = ImagePicker();
  Future<void> imageFromGallery() async {
    var image = await imagePicker.pickImage(source: ImageSource.gallery);
    profileController.text = image?.path ?? "";
  }

  Future<void> imageFromCamera() async {
    var image = await imagePicker.pickImage(source: ImageSource.camera);
    profileController.text = image?.path ?? "";
  }

  Repository authRepository = RepositoryImpl();
  Future<void> register() async {
    screenState = LoadingState(
        message: AppStrings.loading,
        stateRendererType: StateRendererType.fullScreenLoadingState);
    update();
    RegisterRequest _registerRequest = RegisterRequest(
      email: emailController.text,
      password: userPasswordController.text,
      mobileNumber: mobileNumberController.text,
      userName: userNameController.text,
      profilePicture: '',
      countryMobileCode: countryCode,
    );
    print(_registerRequest);
    await authRepository
        .register(_registerRequest)
        .then((value) => value.fold((failure) {
              screenState = ErrorState(
                  StateRendererType.popupErrorState, failure.message);

              update();
            }, (data) {
              AppPreferences.setUserLoggedIn()
                  .then((value) => Get.off(() => const MainView()));

              update();
            }));
  }
}
