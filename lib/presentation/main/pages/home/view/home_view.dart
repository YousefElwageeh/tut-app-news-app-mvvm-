import 'package:advanced_flutter_arabic/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:advanced_flutter_arabic/presentation/main/pages/home/viewModel/home_view_model.dart';

import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

import '../../../../../domain/model/home.dart';
import '../../../../resources/color_manager.dart';
import '../../../../resources/strings_manager.dart';
import '../../../../resources/values_manager.dart';
import '../homeDetails/view/home_detalis.dart';

var _homeViewModel = Get.put(HomeViewModel());

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
      child: GetBuilder<HomeViewModel>(
          init: HomeViewModel(),
          builder: (controller) {
            return controller.screenState
                .getScreenWidget(context, _getContentWidget(context), () {
              controller.getHomeData();
            });
          }),
    ));
  }
}

Widget _getContentWidget(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _getBannerWidget(_homeViewModel.homeData?.data?.banners),
      _getSection(AppStrings.services, context),
      _getServicesWidget(_homeViewModel.homeData?.data?.services, context),
      _getSection(AppStrings.stores, context),
      _getStoresWidget(_homeViewModel.homeData?.data?.stores, context),
    ],
  );
}

Widget _getBannerWidget(List<Banners>? banners) {
  if (banners != null) {
    return CarouselSlider(
        items: banners
            .map((banner) => SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: AppSize.s1_5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.s12),
                        side: BorderSide(
                            color: ColorManager.primary, width: AppSize.s1)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppSize.s12),
                      child: Image.network(banner.image, fit: BoxFit.cover),
                    ),
                  ),
                ))
            .toList(),
        options: CarouselOptions(
            height: AppSize.s190,
            autoPlay: true,
            enableInfiniteScroll: true,
            enlargeCenterPage: true));
  } else {
    return Container();
  }
}

Widget _getSection(String title, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(
        top: AppPadding.p12,
        left: AppPadding.p12,
        right: AppPadding.p12,
        bottom: AppPadding.p2),
    child: Text(
      title,
      style: Theme.of(context).textTheme.titleMedium,
    ),
  );
}

Widget _getServicesWidget(List<Services>? services, BuildContext context) {
  if (services != null) {
    return Padding(
      padding:
          const EdgeInsets.only(left: AppPadding.p12, right: AppPadding.p12),
      child: Container(
        height: AppSize.s160,
        margin: const EdgeInsets.symmetric(vertical: AppMargin.m12),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: services
              .map((service) => Card(
                    elevation: AppSize.s4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.s12),
                        side: BorderSide(
                            color: ColorManager.white, width: AppSize.s1)),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(AppSize.s12),
                          child: Image.network(
                            service.image,
                            fit: BoxFit.cover,
                            width: AppSize.s120,
                            height: AppSize.s120,
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: AppPadding.p8),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                service.title,
                                style: Theme.of(context).textTheme.bodyMedium,
                                textAlign: TextAlign.center,
                              ),
                            ))
                      ],
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  } else {
    return Container();
  }
}

Widget _getStoresWidget(List<Stores>? stores, BuildContext context) {
  if (stores != null) {
    return Padding(
      padding: const EdgeInsets.only(
          left: AppPadding.p12, right: AppPadding.p12, top: AppPadding.p12),
      child: Flex(
        direction: Axis.vertical,
        children: [
          GridView.count(
            crossAxisCount: AppSize.s2.toInt(),
            crossAxisSpacing: AppSize.s8,
            mainAxisSpacing: AppSize.s8,
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            children: List.generate(stores.length, (index) {
              return InkWell(
                onTap: () {
                  Get.to(() => const HomeDetailsView());
                },
                child: Card(
                  elevation: AppSize.s4,
                  child: Image.network(
                    stores[index].image,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }),
          )
        ],
      ),
    );
  } else {
    return Container();
  }
}
