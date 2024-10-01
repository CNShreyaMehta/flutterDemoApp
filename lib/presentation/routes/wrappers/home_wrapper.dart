import 'package:demo_app/presentation/modules/home/bindings/home_binding.dart';
import 'package:demo_app/presentation/routes/app_routes.dart';
import 'package:demo_app/presentation/routes/navigation_ids.dart';
import 'package:demo_app/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class HomeWrapper extends StatelessWidget {
  const HomeWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      // !important
      key: Get.nestedKey(nestedNavigationHomeId),
      initialRoute: AppRoutes.home,
      onGenerateRoute: (routeSettings) {
        if (routeSettings.name == AppRoutes.home) {
          return GetPageRoute(
              routeName: AppRoutes.home,
              title: "Home Page",
              page: () => const HomeScreen(),
              binding: HomeBinding());
        } 
        // else if (routeSettings.name == AppRoutes.productDetails) {
        //   return GetPageRoute(
        //       routeName: AppRoutes.productDetails,
        //       title: "Product Details Page",
        //       page: () =>  const ProductDetails(productInfo: null,),
        //       binding: ProductDetailsBinding());
        // }
        return null;
      },
    );
  }
}
