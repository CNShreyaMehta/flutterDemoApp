import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      //padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      color: backgroundColor,
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

                Text(
                  'Insta Mart',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '8 minutes',
                  style: GoogleFonts.poppins(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Row(children: [
                  Text(
                    'Action area 1, NewTown, NewYork',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
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
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.person),
                      onPressed: () {},
                    )
                  ),
        ],
      ),
    );
  }
}
