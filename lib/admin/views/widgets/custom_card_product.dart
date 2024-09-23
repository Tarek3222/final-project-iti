import 'package:flutter/material.dart';
import 'package:market_devices/constants/colors.dart';
import 'package:market_devices/models/product_model.dart';

class CustomCardProduct extends StatelessWidget {
  const CustomCardProduct(
      {super.key,
      required this.product,
      this.onTap,
      required this.backgroundColor});

  final ProductModel product;
  final void Function(TapUpDetails)? onTap;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: onTap,
      child: Container(
        margin: const EdgeInsetsDirectional.only(
            start: 6, end: 6, bottom: 8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: GridTile(
            footer: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            alignment: AlignmentDirectional.bottomCenter,
            decoration:const BoxDecoration(
              color: Colors.black54,
              borderRadius:  BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Column(
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    color: AppColors.myWhite,
                    height: 1.3,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${product.price}\$',
                      style: const TextStyle(
                        color: AppColors.myWhite,
                        height: 1.3,
                        fontSize: 14.0,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'count: ${product.quantity}',
                      style: const TextStyle(
                        color: AppColors.myWhite,
                        height: 1.3,
                        fontSize: 14.0,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
            child: Hero(
              tag: product.image,
              child: FadeInImage.assetNetwork(
                 placeholder: 'assets/images/loading.gif',
                 image: product.image,
                 fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
