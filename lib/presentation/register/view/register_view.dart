import 'package:advanced_flutter_arabic/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:advanced_flutter_arabic/presentation/login/view/login_view.dart';
import 'package:advanced_flutter_arabic/presentation/resources/assets_manager.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/color_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';
import '../view model/register_view_model.dart';

var _registerViweModel = Get.put(RegisterViewModel());

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: GetBuilder<RegisterViewModel>(
        init: RegisterViewModel(),
        builder: (controller) {
          return controller.screenState
              .getScreenWidget(context, _getContentWidget(context), () {});
        },
      ),
    );
  }
}

Widget _getContentWidget(BuildContext context) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.only(
        top: AppPadding.p28,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              right: AppPadding.p28, left: AppPadding.p28),
          child: Column(
            children: [
              const Center(
                  child: Image(
                image: AssetImage(ImageAssets.splashLogo),
              )),
              const SizedBox(
                height: AppSize.s12,
              ),
              Obx(
                () => TextFormField(
                  onTap: () => _registerViweModel.addlistener(index: 1),
                  keyboardType: TextInputType.emailAddress,
                  controller: _registerViweModel.userNameController,
                  decoration: InputDecoration(
                      hintText: AppStrings.username.tr,
                      labelText: AppStrings.username.tr,
                      errorText: _registerViweModel.isUserNameVaild.value
                          ? null
                          : AppStrings.usernameError.tr),
                ),
              ),
              const SizedBox(
                height: AppSize.s12,
              ),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: CountryCodePicker(
                        onChanged: (country) {
                          _registerViweModel.countryCode =
                              country.dialCode.toString();
                        },
                        initialSelection: '+20',
                        favorite: const ['+39', 'FR', '+966', '+20'],
                        hideMainText: true,
                        showCountryOnly: true,
                        showOnlyCountryWhenClosed: true,
                        alignLeft: false,
                      )),
                  Expanded(
                    flex: 4,
                    child: Obx(
                      () => TextFormField(
                        onTap: () => _registerViweModel.addlistener(index: 2),
                        keyboardType: TextInputType.phone,
                        controller: _registerViweModel.mobileNumberController,
                        decoration: InputDecoration(
                            hintText: AppStrings.mobilePhone.tr,
                            labelText: AppStrings.mobilePhone.tr,
                            errorText: _registerViweModel.isPhoneVaild.value
                                ? null
                                : AppStrings.mobilePhoneInvalid.tr),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: AppSize.s12,
              ),
              Obx(
                () => TextFormField(
                  onTap: () => _registerViweModel.addlistener(index: 3),
                  keyboardType: TextInputType.emailAddress,
                  controller: _registerViweModel.emailController,
                  decoration: InputDecoration(
                      hintText: AppStrings.email.tr,
                      labelText: AppStrings.email.tr,
                      errorText: _registerViweModel.isEmailVaild.value
                          ? null
                          : AppStrings.emailInvalid.tr),
                ),
              ),
              const SizedBox(
                height: AppSize.s12,
              ),
              Obx(
                () => TextFormField(
                  onTap: () => _registerViweModel.addlistener(index: 4),
                  keyboardType: TextInputType.emailAddress,
                  controller: _registerViweModel.userPasswordController,
                  decoration: InputDecoration(
                      hintText: AppStrings.password.tr,
                      labelText: AppStrings.password.tr,
                      errorText: _registerViweModel.isPasswordVaild.value
                          ? null
                          : AppStrings.passwordError.tr),
                ),
              ),
              const SizedBox(
                height: AppSize.s12,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      enabled: false,
                      onTap: () => _registerViweModel.addlistener(index: 5),
                      keyboardType: TextInputType.emailAddress,
                      controller: _registerViweModel.profileController,
                      decoration: InputDecoration(
                        hintText: AppStrings.profilePicture.tr,
                        labelText: AppStrings.profilePicture.tr,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                        iconSize: AppSize.s28,
                        onPressed: () {
                          _showPicker(context);
                        },
                        icon: const Icon(Icons.camera_alt_outlined)),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: AppPadding.p20,
                    left: AppPadding.p28,
                    right: AppPadding.p28),
                child: SizedBox(
                  width: double.infinity,
                  height: AppSize.s40,
                  child: Obx(
                    () => ElevatedButton(
                        onPressed: _registerViweModel.allInputsValid.value
                            ? () {
                                _registerViweModel.register();
                              }
                            : null,
                        child: Text(AppStrings.register.tr)),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(
                      top: AppPadding.p8,
                      left: AppPadding.p28,
                      right: AppPadding.p28),
                  child: TextButton(
                    onPressed: () {
                      Get.off(const LoginView());
                    },
                    child: Text(AppStrings.alreadyHaveAccount,
                        style: Theme.of(context).textTheme.titleMedium),
                  )),
            ],
          ),
        ),
      ),
    ),
  );
}

_showPicker(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
            child: Wrap(
          children: [
            ListTile(
              trailing: const Icon(Icons.arrow_forward),
              leading: const Icon(Icons.camera),
              title: Text(AppStrings.photoGallery.tr),
              onTap: () {
                _registerViweModel.imageFromGallery();
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              trailing: const Icon(Icons.arrow_forward),
              leading: const Icon(Icons.camera_alt_outlined),
              title: Text(AppStrings.photoCamera.tr),
              onTap: () {
                _registerViweModel.imageFromCamera();
                Navigator.of(context).pop();
              },
            )
          ],
        ));
      });
}
