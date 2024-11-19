import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:demo_app/presentation/controllers/Theme_controller.dart';
import 'package:demo_app/presentation/controllers/home_controller.dart';
import 'package:demo_app/presentation/controllers/login_controller.dart';
import 'package:demo_app/presentation/custom_widgets/header.dart';
import 'package:demo_app/presentation/model/product2.dart';
import 'package:demo_app/presentation/screens/cart_screen.dart';
import 'package:demo_app/presentation/screens/categories_screen.dart';
import 'package:demo_app/presentation/screens/product_details.dart';
import 'package:demo_app/presentation/screens/product_tile.dart';
import 'package:demo_app/presentation/screens/profile_screen.dart';
import 'package:demo_app/presentation/screens/settings_screen.dart';
import 'package:demo_app/presentation/utils/helpers/static_products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

// List of screens
final List<Widget> _screens = [
  Home(),
  const CategoriesScreen(),
  const CartScreen(),
  const ProfileScreen(),
  const SettingsScreen(),
];

class _HomeScreenState extends State<HomeScreen> {
  final LoginController loginController = Get.find();
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }
  final ThemeController themeController =
      Get.put(ThemeController()); // Initialize the controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.yellow.shade300,
      //   title: const Text('Home'),
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.logout),
      //       color: Colors.black,
      //       onPressed: () {
      //         _showLogoutConfirmation(
      //             context); // Show logout confirmation dialog
      //       },
      //     )
      //   ],
      // ),
      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: <Widget>[
      //       const DrawerHeader(
      //         decoration: BoxDecoration(color: Colors.blue),
      //         child: Text('Menu'),
      //       ),
      //       ListTile(
      //         title: const Text('Item 1'),
      //         onTap: () {
      //           Navigator.pop(context);
      //         },
      //       ),
      //       ListTile(
      //         title: const Text('Item 2'),
      //         onTap: () {
      //           Navigator.pop(context);
      //         },
      //       ),
      //        Obx(
      //         () => SwitchListTile(
      //           title: Text(themeController.isDarkMode.value
      //               ? 'Dark Mode'
      //               : 'Light Mode'),
      //           value: themeController.isDarkMode.value,
      //           onChanged: (value) {
      //             themeController.toggleTheme();  // Toggle the theme
      //           },
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      body: _screens[_page], // Display the current selected screen
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.settings),
      //       label: 'Settings',
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   onTap: _onItemTapped,
      // ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        items: const <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.category, size: 30),
          Icon(Icons.shopping_cart, size: 30),
          Icon(Icons.person, size: 30),
          Icon(Icons.get_app_rounded, size: 30),
        ],
        color: Color.fromARGB(255, 255, 217, 0),
        buttonBackgroundColor: Color.fromARGB(255, 255, 217, 0),
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
      // body: Container(
      //   color: Colors.blueAccent,
      //   child: Center(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: <Widget>[
      //         Text(_page.toString(), style: const TextStyle(fontSize: 160)),
      //         ElevatedButton(
      //           child: const Text('Go To Page of index 1'),
      //           onPressed: () {
      //             final CurvedNavigationBarState? navBarState =
      //                 _bottomNavigationKey.currentState;
      //             navBarState?.setPage(1);
      //           },
      //         )
      //       ],
      //     ),
      //   ),
      // )
    );
  }

  // Show a confirmation dialog for logout
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
}

// Home Screen
class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeController productController = Get.put(HomeController());

  int _selectedIndex2 = 0;

  final List<Widget> _pages = [
    Center(),
    Center(),
    Center(),
    Center(),
    Center(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Scrollable Header Section
            const SliverToBoxAdapter(
              child: Header(
                showBellIcon: true,
                title: "Home",
                backgroundColor: Color.fromARGB(255, 255, 217, 0),
              ),
            ),
            // Sticky Search Bar
            SliverAppBar(
              pinned: true,
              backgroundColor: const Color.fromARGB(255, 255, 217, 0),
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 280,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: const Text(
                          "Search",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        icon: const Icon(Icons.keyboard_voice_rounded),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
              toolbarHeight: 60, // Height of the sticky search bar
            ),
            // Main Scrollable Content
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 255, 217, 0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {
                            print("Button Pressed");
                          },
                          style: TextButton.styleFrom(
                            padding:
                                const EdgeInsets.all(8.0), // Adjust padding
                          ),
                          child: const Column(
                            mainAxisSize:
                                MainAxisSize.min, // Minimize space usage
                            children: [
                              Icon(Icons.paste_rounded,
                                  size: 24,
                                  color: Colors.black54), // Icon widget
                              // Space between icon and text
                              Text(
                                "All",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black), // Text widget
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            print("Button Pressed");
                          },
                          style: TextButton.styleFrom(
                            padding:
                                const EdgeInsets.all(8.0), // Adjust padding
                          ),
                          child: Column(
                            mainAxisSize:
                                MainAxisSize.min, // Minimize space usage
                            children: [
                              Stack(children: [
                                const Icon(Icons.wallet_giftcard_outlined,
                                    size: 24, color: Colors.black54),
                                Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Container(
                                      width: 10,
                                      height: 10,
                                      decoration: const BoxDecoration(
                                        color: Color.fromARGB(255, 255, 17, 0),
                                        shape: BoxShape.circle,
                                      ),
                                    ))
                              ]), // Icon widget
                              // Space between icon and text
                              const Text(
                                "christmas",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black), // Text widget
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            print("Button Pressed");
                          },
                          style: TextButton.styleFrom(
                            padding:
                                const EdgeInsets.all(8.0), // Adjust padding
                          ),
                          child: const Column(
                            mainAxisSize:
                                MainAxisSize.min, // Minimize space usage
                            children: [
                              Icon(Icons.electrical_services_rounded,
                                  size: 24,
                                  color: Colors.black54), // Icon widget
                              // Space between icon and text
                              Text(
                                "Electronics",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black), // Text widget
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            print("Button Pressed");
                          },
                          style: TextButton.styleFrom(
                            padding:
                                const EdgeInsets.all(8.0), // Adjust padding
                          ),
                          child: const Column(
                            mainAxisSize:
                                MainAxisSize.min, // Minimize space usage
                            children: [
                              Icon(Icons.person_2_outlined,
                                  size: 24,
                                  color: Colors.black54), // Icon widget
                              // Space between icon and text
                              Text(
                                "Beauty",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black), // Text widget
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            print("Button Pressed");
                          },
                          style: TextButton.styleFrom(
                            padding:
                                const EdgeInsets.all(8.0), // Adjust padding
                          ),
                          child: const Column(
                            mainAxisSize:
                                MainAxisSize.min, // Minimize space usage
                            children: [
                              Icon(Icons.baby_changing_station_outlined,
                                  size: 24,
                                  color: Colors.black54), // Icon widget
                              // Space between icon and text
                              Text(
                                "Kids",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black), // Text widget
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Dynamic Content
                  Expanded(
                    child: _pages[_selectedIndex2],
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 255, 217, 0),
                    ),
                    child: const Text(
                      "TOP TRADING DEALS",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                    color: Color.fromARGB(255, 255, 217, 0),
                    height: 140,
                    width: double.infinity,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: staticProducts.length,
                      itemBuilder: (context, index) {
                        final product = staticProducts[index];
                        return ProductCard(product: product);
                      },
                    ),
                  ),
 Container(
                    color: Color.fromARGB(255, 255, 217, 0),
                    height: 200,
                    width: double.infinity,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: staticBestSeller.length,
                      itemBuilder: (context, index) {
                        final product = staticBestSeller[index];
                        return my4Card(product: product);
                      },
                    ),
                  ),                  Obx(() {
                    if (productController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 5.0,
                          childAspectRatio: 0.55,
                        ),
                        itemCount: productController.productList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => ProductDetails(
                                    productInfo:
                                        productController.productList[index],
                                  ),
                                  transition: Transition.zoom,
                                );
                              },
                              child: Card(
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            height: 180,
                                            width: double.infinity,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: Colors.transparent,
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Image.network(
                                                productController
                                                    .productList[index]
                                                    .imageLink,
                                                fit: BoxFit.contain,
                                                height: 50,
                                                width: 50,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 10,
                                            right: 10,
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: Colors.green[50],
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Text(
                                                  "ADD",
                                                  style: TextStyle(
                                                      color: Colors.green[900],fontWeight: FontWeight.w900),
                                                )),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        productController
                                            .productList[index].name,
                                        maxLines: 2,
                                        style: const TextStyle(
                                          fontFamily: 'avenir',
                                          fontWeight: FontWeight.w600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 5),
                                      if (productController
                                              .productList[index].rating !=
                                          null)
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4, vertical: 2),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                productController
                                                    .productList[index].rating
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                              const Icon(
                                                Icons.star,
                                                size: 16,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                        ),
                                                                              const SizedBox(height: 5),

                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                                '\₹${productController.productList[index].price}',
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                                const SizedBox(width: 5),
                                            Text(
                                              ' MRP${productController.productList[index].price}',
                                              style: const TextStyle(
                                                decoration: TextDecoration.lineThrough,
                                                  fontSize: 13,
                                                  fontFamily: 'avenir'),
                                            ),
                                          ]),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: Colors.green[50],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              'More Like This',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.green[900],
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_forward,
                                              color: Colors.green[900],
                                              size: 10,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Get.toNamed(AppRoutes.profile);
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}

// Example Tile widget
class Tile extends StatelessWidget {
  final int index;

  const Tile(Product productList, {super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      child: Center(
        child: Text(
          'Tile $index',
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product2 product;

  const ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0), // Add padding to the container
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            color: const Color.fromARGB(255, 14, 81, 226),
            width: 3.0), // Add border
        borderRadius: BorderRadius.circular(8.0), // Rounded corners
      ),
      margin: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0), // Set the desired radius
            child: Image.network(
              product.imageUrl,
              height: 120,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10),
          Positioned(
            bottom: 5,
            left: 10,
            child: Text(
              product.name,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class my4Card extends StatelessWidget {
  final BestSeller product;

  const my4Card({required this.product});

  @override
  Widget build(BuildContext context) {
    return   Container(
                    width: 130,
                    height: 180,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: const BoxDecoration(
                      color:Colors.white24,
                      
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                product.imageList[0],
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Image.network(
                              product.imageList[1],
                              height: 40,
                              width: 40,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                              child: Image.network(
                                product.imageList[2],
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 8, 8),
                              child: Image.network(
                                product.imageList[3],
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                          child: Text(
                            product.name,
                            style: const TextStyle(
                                fontSize: 10,),
                            ),
                        ),
                        Text(
                          product.description,
                          style: const TextStyle(
                              fontSize: 15),
                        )
                      ],
                    ),
                  );
  }
}
