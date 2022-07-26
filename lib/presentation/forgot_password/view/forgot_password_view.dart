import 'package:advanced_flutter_arabic/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:advanced_flutter_arabic/presentation/forgot_password/viewModel/forgot_password_veiw_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';

var _forgotPasswordViewModel = Get.put(ForgotPasswordViewModel());

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.white,
        body: GetBuilder<ForgotPasswordViewModel>(
          init: ForgotPasswordViewModel(),
          builder: (controller) {
            return controller.screenState
                .getScreenWidget(context, _getContentWidget(context), () {});
          },
        ));
  }
}

Widget _getContentWidget(context) {
  return Container(
      padding: const EdgeInsets.only(top: AppPadding.p100),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Center(
                child: Image(image: AssetImage(ImageAssets.splashLogo))),
            const SizedBox(
              height: AppSize.s40,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: AppPadding.p28, right: AppPadding.p28),
              child: Obx(
                () => TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _forgotPasswordViewModel.emailController,
                  decoration: InputDecoration(
                      hintText: AppStrings.email.tr,
                      labelText: AppStrings.email.tr,
                      errorText: _forgotPasswordViewModel.isEmailVaild.value
                          ? null
                          : AppStrings.usernameError.tr),
                ),
              ),
            ),
            const SizedBox(
              height: AppSize.s40,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: AppPadding.p28, right: AppPadding.p28),
              child: SizedBox(
                width: double.infinity,
                height: AppSize.s50,
                child: Obx(
                  () => ElevatedButton(
                      onPressed: _forgotPasswordViewModel.isEmailVaild.value
                          ? () {
                              _forgotPasswordViewModel.resetPassword();
                            }
                          : null,
                      child: Text(AppStrings.resetPassword.tr)),
                ),
              ),
            ),
            const SizedBox(
              height: AppSize.s28,
            ),
            TextButton(
              child: Text(AppStrings.didnotRecieveEmailResnd.tr,
                  style: Theme.of(context).textTheme.titleMedium),
              onPressed: () {},
            ),
          ],
        ),
      ));
}
