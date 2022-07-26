import 'package:advanced_flutter_arabic/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:advanced_flutter_arabic/presentation/resources/strings_manager.dart';
import 'package:advanced_flutter_arabic/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../viewModel/home_details_view_model.dart';

var _homeDetailsViewModel = Get.put(HomeDetailsViewModel());

class HomeDetailsView extends StatelessWidget {
  const HomeDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.homeDetails),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: GetBuilder<HomeDetailsViewModel>(
              init: HomeDetailsViewModel(),
              builder: (controller) {
                return controller.screenState
                    .getScreenWidget(context, _getContentWidget(context), () {
                  //  controller.getHomeData();
                });
              }),
        ),
      ),
    );
  }
}

Widget _getContentWidget(BuildContext context) {
  return Column(
    children: [
      _GetImage(context, _homeDetailsViewModel.homeDetailsdata?.image ?? ''),
      _DetailsWidget(
          context, _homeDetailsViewModel.homeDetailsdata?.details ?? ''),
      _ServiceWidget(
          context, _homeDetailsViewModel.homeDetailsdata?.services ?? ''),
      _AboutStoreWidget(
          context, _homeDetailsViewModel.homeDetailsdata?.about ?? ''),
    ],
  );
}

Widget _GetImage(BuildContext context, String imagePath) {
  return SizedBox(
    child: Column(
      children: [
        Image.network(imagePath),
        const SizedBox(
          height: AppSize.s16,
        )
      ],
    ),
  );
}

Widget _DetailsWidget(BuildContext context, String detailsText) {
  return Padding(
    padding: const EdgeInsets.all(AppSize.s12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.details,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: AppSize.s20,
        ),
        Text(
          detailsText,
          style: Theme.of(context).textTheme.caption,
        ),
        const SizedBox(
          height: AppSize.s20,
        ),
      ],
    ),
  );
}

Widget _ServiceWidget(BuildContext context, String serviceText) {
  return Padding(
    padding: const EdgeInsets.all(AppSize.s12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.services,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: AppSize.s20,
        ),
        Text(
          serviceText,
          style: Theme.of(context).textTheme.caption,
        ),
        const SizedBox(
          height: AppSize.s20,
        ),
      ],
    ),
  );
}

Widget _AboutStoreWidget(BuildContext context, String acoutstoreText) {
  return Padding(
    padding: const EdgeInsets.all(AppSize.s12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.aboutStore,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: AppSize.s20,
        ),
        Text(
          acoutstoreText,
          style: Theme.of(context).textTheme.caption,
        ),
        const SizedBox(
          height: AppSize.s20,
        ),
      ],
    ),
  );
}
