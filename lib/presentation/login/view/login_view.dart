import 'package:advanced_flutter_arabic/presentation/common/state_renderer/state_renderer_impl.dart';

import 'package:advanced_flutter_arabic/presentation/register/view/register_view.dart';
import 'package:advanced_flutter_arabic/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../forgot_password/view/forgot_password_view.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/strings_manager.dart';
import '../viewModel/login_view_model.dart';

var _loginViewModel = Get.put(LoginViewModel());

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.white,
        body: GetBuilder<LoginViewModel>(
          init: LoginViewModel(),
          builder: (controller) {
            print(controller.screenState);
            return controller.screenState
                .getScreenWidget(context, _getContentWidget(context), () {
              // cubit.login(
              //     email: cubit.userNameController.text,
              //     password: cubit.userPasswordController.text);
            });
          },
        ));
  }

  //
  Widget _getContentWidget(context) {
    return Container(
        padding: const EdgeInsets.only(top: AppPadding.p100),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Center(
                    child: Image(image: AssetImage(ImageAssets.splashLogo))),
                const SizedBox(
                  height: AppSize.s28,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: Obx(
                    () => TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _loginViewModel.userNameController,
                      decoration: InputDecoration(
                          hintText: AppStrings.username.tr,
                          labelText: AppStrings.username.tr,
                          errorText: _loginViewModel.isUserNameVaild.value
                              ? null
                              : AppStrings.usernameError.tr),
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s28,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: Obx(
                    () => TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: _loginViewModel.userPasswordController,
                      decoration: InputDecoration(
                          hintText: AppStrings.password.tr,
                          labelText: AppStrings.password.tr,
                          errorText: _loginViewModel.isPasswordVaild.value
                              ? null
                              : AppStrings.passwordError.tr),
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s28,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: SizedBox(
                    width: double.infinity,
                    height: AppSize.s40,
                    child: Obx(
                      () => ElevatedButton(
                          onPressed: _loginViewModel.isPasswordVaild.value &&
                                  _loginViewModel.isUserNameVaild.value
                              ? () async {
                                  await _loginViewModel.login();
                                }
                              : null,
                          child: Text(AppStrings.login.tr)),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        top: AppPadding.p8,
                        left: AppPadding.p28,
                        right: AppPadding.p28),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Get.to(() => const ForgotPasswordView());
                          },
                          child: Text(AppStrings.forgotPassword.tr,
                              style: Theme.of(context).textTheme.titleMedium),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(() => const RegisterView());
                          },
                          child: Text(AppStrings.donotHaveAccount.tr,
                              style: Theme.of(context).textTheme.titleMedium),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ));
  }
}
