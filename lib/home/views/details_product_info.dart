import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_devices/auth/widgets/custom_button.dart';
import 'package:market_devices/constants/colors.dart';
import 'package:market_devices/functions/show_snack_bar.dart';
import 'package:market_devices/home/bussnies_logic/card_cubit/card_cubit.dart';
import 'package:market_devices/models/product_model.dart';

class DetailsProductInfo extends StatefulWidget {
  const DetailsProductInfo({super.key, required this.product});
  static const String id = "ProductInfoView";
  final ProductModel product;

  @override
  State<DetailsProductInfo> createState() => _ProductInfoViewState();
}

class _ProductInfoViewState extends State<DetailsProductInfo> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(context),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: const EdgeInsets.only(
                  left: 14,
                  right: 14,
                  top: 16,
                ),
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.product.description,
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black.withOpacity(0.6),
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Price: \$${widget.product.price}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black),
                        ),
                        Container(
                          height: 70,
                          width: 150,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: const Color(0xFF212325),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (count <
                                        int.parse(widget.product.quantity)) {
                                      count++;
                                    } else {
                                      showSnackBar(
                                          context,
                                          'Quantity must be less than or equal to ${widget.product.quantity}',
                                          AppColors.myGrey);
                                    }
                                  });
                                },
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(
                                '$count',
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (count > 1) {
                                      count--;
                                    } else {
                                      showSnackBar(
                                          context,
                                          'Quantity must be greater than or equal to 1',
                                          AppColors.myGrey);
                                    }
                                  });
                                },
                                icon: Icon(
                                  Icons.remove,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Avilable In Stock: ${widget.product.quantity}",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black.withOpacity(0.6),
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 40,),
                    CustomButton(
                      text: "Add To Cart",
                      onPressed: () {
                        setState(() {
                          widget.product.quantityInCart = count.toString();
                          List<ProductModel> cartList = BlocProvider.of<CardCubit>(context).products;
                          if(cartList.contains(widget.product)){
                            showSnackBar(context, 'Product already in cart', AppColors.myGrey);
                          }else{
                            BlocProvider.of<CardCubit>(context).addProduct(widget.product);
                            showSnackBar(context, 'Product added to cart', Colors.green);
                          }
                        });
                      },
                    ),
                    const SizedBox(
                      height: 360,
                    ),
                  ],
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }

  SliverAppBar buildSliverAppBar(context) {
    return SliverAppBar(
      expandedHeight: 550,
      pinned: true,
      stretch: true,
      leading: const BackButton(
        color: AppColors.myWhite,
      ),
      backgroundColor: AppColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          widget.product.name,
          style: const TextStyle(
              color: AppColors.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
        background: Hero(
          tag: widget.product.image,
          child: Image(
            image: NetworkImage(widget.product.image),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
