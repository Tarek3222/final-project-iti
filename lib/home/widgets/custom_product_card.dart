import 'package:flutter/material.dart';
import 'package:market_devices/models/product_model.dart';

class CustomProductCard extends StatelessWidget {
  const CustomProductCard({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name),
      subtitle: Text(product.price),
      trailing: Text(product.quantityInCart.toString()),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.network(
          product.image,
          height: 50,
          width: 50,
        ),
      ),
    );
  }
}
