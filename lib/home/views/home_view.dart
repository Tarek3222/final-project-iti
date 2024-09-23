// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:market_devices/constants/app_assets.dart';
import 'package:market_devices/constants/strings.dart';
import 'package:market_devices/home/widgets/products_list_builder.dart';
import 'package:market_devices/services/auth_services.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Electronics Store'),
        leading: IconButton(
          onPressed: () async {
            await AuthService().signOut();
            Navigator.pushReplacementNamed(context, loginView);
          },
          icon: const Icon(Icons.logout),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: const DecorationImage(
                      image: AssetImage(AppAssets.homeIamage),
                      fit: BoxFit.cover,
                    )),
                height: 150,
                child: const Text(
                  'find your dream device here',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Shop by Category',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: 1.5,
                    children: [
                      _categoryTile(context, 'Laptops'),
                      _categoryTile(context, 'Tv'),
                      _categoryTile(context, 'Android Mobiles'),
                      _categoryTile(context, 'Tablets'),
                      _categoryTile(context, 'Ios Mobiles'),
                    ],
                  ),
                ],
              ),
            ),
            const  Padding(
              padding:  EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    'Avilable Products',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                   SizedBox(height: 10),
                 ProductsListBuilder(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Purchases',
          ),
        ],
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, profileView);
          } else if (index == 1) {
            Navigator.pushNamed(context, cardView);
          }
        },
      ),
    );
  }


  Widget _categoryTile(BuildContext context, String categoryName) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, productByCategoryView, arguments: categoryName);
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        color: Colors.grey[300],
        child: Center(
          child: Text(categoryName, textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
