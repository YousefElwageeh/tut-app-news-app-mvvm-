import 'package:advanced_flutter_arabic/app/app_prefs.dart';
import 'package:advanced_flutter_arabic/presentation/login/view/login_view.dart';
import 'package:advanced_flutter_arabic/presentation/resources/assets_manager.dart';
import 'package:advanced_flutter_arabic/presentation/resources/strings_manager.dart';
import 'package:concentric_transition/page_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

final List<PageData> pages = [
  PageData(
    image: ImageAssets.onboardingLogo1,
    title: AppStrings.onBoardingTitle1.tr,
    textColor: Colors.black,
    bgColor: Colors.white,
  ),
  PageData(
    image: ImageAssets.onboardingLogo2,
    title: AppStrings.onBoardingTitle2.tr,
    bgColor: Colors.orange,
  ),
  PageData(
    image: ImageAssets.onboardingLogo3,
    title: AppStrings.onBoardingTitle3.tr,
    bgColor: Colors.deepOrange,
    textColor: Colors.white,
  ),
];

class PageData {
  final String? title;
  final String? image;
  final Color bgColor;
  final Color textColor;

  PageData({
    this.title,
    this.image,
    this.bgColor = Colors.white,
    this.textColor = Colors.black,
  });
}

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  _OnBoardingViewState createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  List<Color> get colors => pages.map((p) => p.bgColor).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
        colors: colors,

        //          opacityFactor: 1.0,
        //          scaleFactor: 0.0,
        radius: 30,
        curve: Curves.ease,
        duration: const Duration(seconds: 2),
        //          verticalPosition: 0.7,
        //          direction: Axis.vertical,
        //          itemCount: pages.length,
        //          physics: NeverScrollableScrollPhysics(),
        itemBuilder: (index) {
          print(index);

          PageData page = pages[index % pages.length];

          // For example scale or transform some widget by [value] param
          //            double scale = (1 - (value.abs() * 0.4)).clamp(0.0, 1.0);
          return Container(
            child: Theme(
              data: ThemeData(
                textTheme: TextTheme(
                  headline6: TextStyle(
                    color: page.textColor,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Helvetica',
                    letterSpacing: 0.0,
                    fontSize: 17,
                  ),
                  subtitle2: TextStyle(
                    color: page.textColor,
                    fontWeight: FontWeight.w300,
                    fontSize: 18,
                  ),
                ),
              ),
              child: PageCard(page: page),
            ),
          );
        },
      ),
    );
  }
}

class PageCard extends StatelessWidget {
  final PageData page;

  const PageCard({
    Key? key,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 30.0,
      ),
      child: Column(
//        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildPicture(context),
          const SizedBox(height: 30),
          _buildText(context),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Align(alignment: Alignment.bottomRight, child: skipButton()),
          ),
        ],
      ),
    );
  }

  Widget _buildText(BuildContext context) {
    return Text(
      page.title!,
      style: Theme.of(context).textTheme.headline6,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildPicture(
    BuildContext context, {
    double size = 190,
    double iconSize = 170,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(60.0)),
        color: page.bgColor
//            .withBlue(page.bgColor.blue - 40)
            .withGreen(page.bgColor.green + 20)
            .withRed(page.bgColor.red - 100)
            .withAlpha(90),
      ),
      margin: const EdgeInsets.only(
        top: 140,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned.fill(
            child: RotatedBox(
              quarterTurns: 2,
              child: SvgPicture.asset(page.image!),
            ),
            right: -5,
            bottom: -5,
          ),
          Positioned.fill(
            child: RotatedBox(
              quarterTurns: 5,
              child: SvgPicture.asset(page.image!),
            ),
          ),
          SvgPicture.asset(page.image!),
        ],
      ),
    );
  }
}

Widget skipButton() {
  return TextButton(
      onPressed: () {
        AppPreferences.setOnBoardingScreenViewed();
        Get.to(() => const LoginView());
      },
      child: const Text('skip'));
}
