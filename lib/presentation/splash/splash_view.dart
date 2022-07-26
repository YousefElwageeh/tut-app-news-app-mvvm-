import 'dart:async';

import 'package:advanced_flutter_arabic/presentation/login/view/login_view.dart';
import 'package:advanced_flutter_arabic/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//import '../../app/di.dart';
import '../../app/app_prefs.dart';
import '../main/main_view.dart';
import '../onboarding/view/onboarding_view.dart';
import '../resources/assets_manager.dart';
import '../resources/constants_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(const Duration(seconds: AppConstants.splashDelay), _goNext);
  }

  _goNext() async {
    AppPreferences.isUserLoggedIn().then((isUserLoggedIn) => {
          if (isUserLoggedIn)
            {
              // navigate to main screen
              Get.off(() => const MainView()),
            }
          else
            {
              AppPreferences.isOnBoardingScreenViewed()
                  .then((isOnBoardingScreenViewed) => {
                        if (isOnBoardingScreenViewed)
                          {
                            // navigate to login screen

                            Get.off(() => const LoginView()),
                          }
                        else
                          {
                            // navigate to onboarding screen

                            Get.off(() => const OnBoardingView()),
                          }
                      })
            }
        });
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body:
          const Center(child: Image(image: AssetImage(ImageAssets.splashLogo))),
    );
  }
}
