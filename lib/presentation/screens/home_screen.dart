import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:demo_app/presentation/controllers/Theme_controller.dart';
import 'package:demo_app/presentation/controllers/home_controller.dart';
import 'package:demo_app/presentation/controllers/login_controller.dart';
import 'package:demo_app/presentation/routes/app_routes.dart';
import 'package:demo_app/presentation/screens/cart_screen.dart';
import 'package:demo_app/presentation/screens/categories_screen.dart';
import 'package:demo_app/presentation/screens/product_details.dart';
import 'package:demo_app/presentation/screens/product_tile.dart';
import 'package:demo_app/presentation/screens/profile_screen.dart';
import 'package:demo_app/presentation/screens/settings_screen.dart';
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
  final ThemeController themeController = Get.put(ThemeController());  // Initialize the controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade300,
        title: const Text('Home'),
        actions: [
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Menu'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
             Obx(
              () => SwitchListTile(
                title: Text(themeController.isDarkMode.value
                    ? 'Dark Mode'
                    : 'Light Mode'),
                value: themeController.isDarkMode.value,
                onChanged: (value) {
                  themeController.toggleTheme();  // Toggle the theme
                },
              ),
            ),
          ],
        ),
      ),
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
        color: Colors.yellow.shade300,
        buttonBackgroundColor: Colors.yellow.shade700,
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
class Home extends StatelessWidget {
  Home({super.key});
  final HomeController productController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      if (productController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns
            crossAxisSpacing: 5.0, // Horizontal space between cards
            mainAxisSpacing: 5.0, // Vertical space between cards
            childAspectRatio:0.55, // Adjust this to control the card's height and width ratio
          ),
          itemCount: productController.productList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: GestureDetector(
                onTap: () {
                  Get.to(() => ProductDetails(
                        productInfo: productController.productList[index],
                      ),
                      transition: Transition.zoom
                            
                    // Get.toNamed('/product-details', arguments: {
                    //   'productInfo': productController.productList[index],
                    // },
                    
                      );
                },
                child: Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 180,
                              width: double.infinity,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                    color: Colors.transparent,  // Transparent background

                              ),
                              child: Image.network(
                                productController.productList[index].imageLink,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          productController.productList[index].name,
                          maxLines: 2,
                          style: const TextStyle(
                              fontFamily: 'avenir', fontWeight: FontWeight.w800),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        if (productController.productList[index].rating != null)
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 2),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  productController.productList[index].rating
                                      .toString(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        //const SizedBox(height: 8),
                        Text('\$${productController.productList[index].price}',
                            style: const TextStyle(
                                fontSize: 25, fontFamily: 'avenir')),
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
    floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.profile);
        },
        child: const Icon(Icons.add),
      ),
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
