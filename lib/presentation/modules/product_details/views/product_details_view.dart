import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/product_details_controller.dart';

// we cant use GetView<HomeController> because home controller need to call with Get.put or Get.lazyPut.
// These methods are available in HomeBinding but because we use BottomNavigationBar in BaseView, we can't call the binding methods of BottomNavigationBar's pages.
// So, I setup controller in build method of each BottomNavigationBar's pages
class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    // !!!
    final ProductDetailsController controller = Get.put(ProductDetailsController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details View'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [  
            TextButton(
                onPressed: controller.increment, child: const Text("This is product details page")),
          ],
        ),
      ),
    );
  }
}
