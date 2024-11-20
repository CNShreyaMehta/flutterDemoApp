import 'package:demo_app/presentation/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatefulWidget {
  final String? title; // Title is optional
  final Color? backgroundColor;
  final bool showBellIcon; // Optional bell icon flag
  const Header({
    super.key,
    this.title,
    this.backgroundColor = Colors.white, // Default background color
    this.showBellIcon = false, // Default is not to show the bell icon
  });

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
    final LoginController loginController = Get.find();

 void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                loginController.logout();
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      //padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      color: widget.backgroundColor,
      child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // Spread items across the row
          children: [
            Row(
              children: [
                // IconButton(
                //   icon: const Icon(Icons.arrow_back),
                //   onPressed: () {
                //     Get.back(); // Navigate to the previous screen
                //   },
                // ),
        
                // if (title != null) // If title is provided, display it
                //   Text(
                //     title!,
                //     style: GoogleFonts.poppins(
                //       fontSize: 20,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.black,
                //     ),
                //   ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      'Insta Mart',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Text(
                    'in 8 minutes',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Row(children: [
                    Text(
                      'Action area 1, NewTown, NewYork',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_drop_down_sharp,
                      color: Colors.black,
                    ),
                  ])
                ]),
              ],
            ),
            Container(
              height: 35,
              width: 35,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.person),
                        iconSize: 18,
                        onPressed: () {},
                      )
                    ),
                    IconButton(
            icon: const Icon(Icons.logout),
            color: Colors.black,
            onPressed: () {
              _showLogoutConfirmation(
                  context); // Show logout confirmation dialog
            },
          )
          ],
        ),
      ),
    );
  }
}
