import 'package:advanced_flutter_arabic/domain/model/notification.dart';
import 'package:advanced_flutter_arabic/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:advanced_flutter_arabic/presentation/main/pages/notification/viewModel/notification_view_model.dart';

import 'package:advanced_flutter_arabic/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

var _notificationViewModel = Get.put(NotificationVeiwModel());

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: GetBuilder<NotificationVeiwModel>(
            init: NotificationVeiwModel(),
            builder: (controller) {
              return controller.screenState.getScreenWidget(context,
                  _getContentWidget(_notificationViewModel.notificationData),
                  () {
                controller.getNotificationData();
              });
            }));
  }
}

Widget _getContentWidget(NotificationModel? notificationData) {
  return ListView.separated(
      itemBuilder: (context, index) => _notificationWidget(
            // to avoid null error
            notificationData?.data[index].image ?? '',
            notificationData?.data[index].name ?? '',
            notificationData?.data[index].body ?? '',
            context,
            notificationData?.data[index].time ?? '',
          ),
      separatorBuilder: (context, index) => const Divider(
            height: AppSize.s1,
          ),
      itemCount: notificationData?.data.length ?? 0);
}

Widget _notificationWidget(String imageUrl, String noitificationTitle,
    String notificationText, BuildContext context, String noitificationTime) {
  return Padding(
    padding: const EdgeInsets.all(AppSize.s12),
    child: Row(
      children: [
        CircleAvatar(
          radius: AppSize.s25,
          backgroundImage: NetworkImage(imageUrl),
        ),
        const SizedBox(
          width: AppSize.s18,
        ),
        Column(
          children: [
            Text(
              noitificationTitle,
              style: Theme.of(context).textTheme.titleMedium,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: AppSize.s12,
            ),
            Text(
              noitificationTitle,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
        const Spacer(),
        Text(
          noitificationTime,
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    ),
  );
}
