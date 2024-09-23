import 'package:flutter/material.dart';
import 'package:market_devices/admin/views/widgets/edit_product_form.dart';
import 'package:market_devices/admin/views/widgets/headers.dart';
import 'package:market_devices/constants/colors.dart';
import 'package:market_devices/models/product_model.dart';

class EditProductView extends StatelessWidget {
  const EditProductView({super.key, required this.productModel,});

final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.myGrey.withOpacity(0.95),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Headers(title: 'Edit Product'),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: EditProductForm(productModel: productModel,),
            ),
          ],
        ),
      ),
    );
  }
}