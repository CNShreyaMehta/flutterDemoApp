import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/profile_details_controller.dart';

// In here we can use GetView<ProfileController>, because bindings of ProfileView and SettingView called in ProfileWrapper
class ProfileDetailsView extends GetView<ProfileDetailsController> {
  const ProfileDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfileView'),
        centerTitle: true,
      ),
      body: Center(
        child: TextButton(
          onPressed: controller.goToSettingPage,
          child: const Text("Go to setting"),
        ),
      ),
    );
  }
}
