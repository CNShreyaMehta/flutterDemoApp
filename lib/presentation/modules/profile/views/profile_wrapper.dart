import 'package:demo_app/presentation/modules/product_details/views/product_details_view.dart';
import 'package:demo_app/presentation/routes/app_routes.dart';
import 'package:demo_app/presentation/routes/navigation_ids.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../setting/bindings/setting_binding.dart';
import '../bindings/profile_binding.dart';
import 'profile_view.dart';

class ProfileWrapper extends StatelessWidget {
  const ProfileWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      // !important
      key: Get.nestedKey(nestedNavigationProfileId),
      initialRoute: AppRoutes.profile,
      onGenerateRoute: (routeSettings) {
        if (routeSettings.name == AppRoutes.profile) {
          return GetPageRoute(
              routeName: AppRoutes.profile,
              title: "Profile Page",
              page: () => const ProfileView(),
              binding: ProfileBinding());
        } else if (routeSettings.name == AppRoutes.productDetails) {
          return GetPageRoute(
              routeName: AppRoutes.productDetails,
              title: "Settings Page",
              page: () => const ProductDetailsView(),
              binding: SettingBinding());
        }
        return null;
      },
    );
  }
}
