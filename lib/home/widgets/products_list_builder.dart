import 'package:flutter/material.dart';
import 'package:market_devices/admin/views/widgets/custom_card_product.dart';
import 'package:market_devices/constants/strings.dart';
import 'package:market_devices/models/product_model.dart';
import 'package:market_devices/services/product_services.dart';

class ProductsListBuilder extends StatelessWidget {
  const ProductsListBuilder(
      {super.key,});


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: StoreService().loadProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<ProductModel> productList = [];
          for (var doc in snapshot.data!.docs) {
              productList.add(ProductModel(
                name: doc.get(kProductName),
                price: doc.get(kProductPrice),
                id: doc.id,
                description: doc.get(kProductDescription),
                category: doc.get(kProductCategory),
                quantity: doc.get(kProductQuantity),
                image: doc.get(kProductImage),
              ));      
          }
          return productList.isEmpty
              ? const Center(
                  child: Text(
                    'No Products Found',
                    style: TextStyle(color: Colors.black),
                  ),
                )
              : GridView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 1,
                  childAspectRatio: 2/3,
                ),
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  return CustomCardProduct(
                      onTap: (details) {
                        Navigator.pushNamed(context, productInfo,arguments: productList[index]);
                      },
                      backgroundColor: Colors.black.withOpacity(0.7),
                      product: productList[index]);
                },
              );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
