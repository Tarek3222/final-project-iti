import 'package:flutter/material.dart';
import 'package:market_devices/admin/views/widgets/add_product_form.dart';
import 'package:market_devices/admin/views/widgets/headers.dart';
import 'package:market_devices/constants/colors.dart';

class AddProductView extends StatelessWidget {
  const AddProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.myGrey.withOpacity(0.95),
      body:const SingleChildScrollView(
        child: Column(
          children: [
             Headers(title: 'Add Product'),
            Padding(
              padding:  EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: AddProductForm(),
            ),
          ],
        ),
      ),
    );
  }
}
