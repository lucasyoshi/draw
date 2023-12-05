import 'package:draw_app/services/auth.dart';
import 'package:draw_app/views/login.dart';
import 'package:draw_app/views/products_page.dart';
import 'package:draw_app/views/profile.dart';
import 'package:draw_app/views/shopping_cart.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  final bool useDissmissible = false;
  final Auth auth = Auth();
  final TextEditingController textEditingController = TextEditingController();

  Future<void> _handleSignOut() async {
    try {
      await auth.logOut();
      // Navigate back to the login page after successful sign out
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ),
      );
    } catch (error) {
      print(error);
    }
  }

  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    // if (index == 0) {
    //   // if the last item is tapped
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) =>
    //             const ProductsPage()), // navigate to the Profile page
    //   );
    // }
    // //     if (index == 1) { // if the last item is tapped
    // //   Navigator.push(
    // //     context,
    // //     MaterialPageRoute(builder: (context) => ShoppingCart()), // navigate to the Profile page
    // //   );
    // // }
    // if (index == 2) {
    //   // if the last item is tapped
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => Profile()), // navigate to the Profile page
    //   );
    // }
    _pageController.jumpToPage(index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('Home build:');
    String currentUserId = (auth.authInst.currentUser == null
        ? ''
        : auth.authInst.currentUser!.uid);
    String? currentUserName = (auth.authInst.currentUser == null
        ? ''
        : auth.authInst.currentUser!.displayName);

    return Scaffold(
      appBar: AppBar(
        title: Text('user: $currentUserName'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _handleSignOut,
          ),
        ],
      ),
      body: currentUserName != null
          ? PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              children: <Widget>[
                const ProductsPage(),
                const ShoppingCart(),
                Profile(),
                // Add more pages here
              ],
            )
          : Login(),
      bottomNavigationBar: currentUserName != null
          ? BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Dashboard',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  label: 'Cart',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
                // Add more items here
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Theme.of(context).colorScheme.onSecondary,
              onTap: _onItemTapped,
            )
          : null,
    );
  }
}
