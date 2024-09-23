import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_devices/home/bussnies_logic/card_cubit/card_cubit.dart';
import 'package:market_devices/models/product_model.dart';

class CardView extends StatelessWidget {
  const CardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Purchases'),
      ),
      body: BlocBuilder<CardCubit, CardState>(
        builder: (context, state) {
          if (state is CardLoadedEmptyData) {
           return const Center(
              child: Text('No purchases'),
            );
          } else if (state is CardLoadedData) {
            List<ProductModel> products =
                BlocProvider.of<CardCubit>(context).products;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(products[index].name),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
                      products[index].image,
                      height: 50,
                      width: 50,
                    ),
                  ),
                  subtitle: Text('Quantity to order : ${products[index].quantityInCart}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_shopping_cart),
                    onPressed: () {
                      context.read<CardCubit>().removeProduct(products[index]);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Product removed from cart'),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text('No purchases'),
            );
          }
        },
      ),
    );
  }
}
