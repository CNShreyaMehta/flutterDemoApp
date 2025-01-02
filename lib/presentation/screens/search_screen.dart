import 'package:demo_app/presentation/controllers/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
    final SearchSController Scontroller = Get.put(SearchSController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search your product'),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            // TextInput(
            //           label: "Email*",
            //           hint: "example@site.com",
            //           controller: Scon.,
            //           obscureText: false,
            //           onTogglePassword: () {}, // Not required for email
            //           errorText: controller.emailError.value.isNotEmpty
            //               ? controller.emailError.value
            //               : null, // Display error if exists
            //         )
          //All Resent search

        ])
      )
   
    );
  }
}