import 'package:flutter/material.dart';
import 'package:market_devices/admin/views/widgets/custom_card_panel.dart';
import 'package:market_devices/admin/views/widgets/headers.dart';
import 'package:market_devices/constants/colors.dart';
import 'package:market_devices/constants/strings.dart';
import 'package:market_devices/services/auth_services.dart';

class AdminView extends StatelessWidget {
  const AdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.myGrey.withOpacity(0.95),
      body: Column(
        children: [
         Headers(title: 'Admin Panal',isSignOut: true,onPressed: (){
          AuthService().signOut();
          Navigator.pushReplacementNamed(context, loginView);
        },),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 4,
                  childAspectRatio: 1.1,
                ),
                children: [
                  CustomCardPanel(
                    title: 'Add Product',
                    icon: Icons.add_shopping_cart,
                    onTap: () {
                      Navigator.pushNamed(context, addProductView);
                    },
                  ),
                  CustomCardPanel(
                    title: 'Manage Product',
                    icon: Icons.mode_edit,
                    onTap: () {
                      Navigator.pushNamed(context, manageProductView);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}