// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:market_devices/admin/views/widgets/custom_card_product.dart';
import 'package:market_devices/admin/views/widgets/headers.dart';
import 'package:market_devices/constants/colors.dart';
import 'package:market_devices/constants/strings.dart';
import 'package:market_devices/models/product_model.dart';
import 'package:market_devices/services/product_services.dart';

class ManageProductView extends StatefulWidget {
  const ManageProductView({super.key});

  @override
  State<ManageProductView> createState() => _ManageProductViewState();
}

class _ManageProductViewState extends State<ManageProductView> {
  final List<String> filterCategories = [
    'All Products',
    'Android Mobiles',
    'Ios Mobiles',
    'Laptops',
    'Tablets',
    'Tv'
  ];
  List<ProductModel> filterProducts = [];

  @override
  Widget build(BuildContext context) {
    String productCategory = filterCategories[0];
    return Scaffold(
      backgroundColor: AppColors.myGrey.withOpacity(0.95),
      body: StreamBuilder(
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
            return Column(
              children: [
                const Headers(title: 'Manage Products'),
                productList.isEmpty
                    ? Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'No Products Found',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        child: ListView(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 13),
                              child: DropdownButtonFormField(
                                  iconEnabledColor: Colors.white,
                                  dropdownColor: AppColors.kPrimaryColor,
                                  value: productCategory,
                                  items: [
                                    for (final category in filterCategories)
                                      DropdownMenuItem(
                                        value: category,
                                        child: Text(
                                          category,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      productCategory = value!;
                                      filterProducts = productList
                                          .where((element) =>
                                              element.category ==
                                              productCategory)
                                          .toList();
                                    });
                                  }),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 3,
                                crossAxisSpacing: 1,
                                childAspectRatio: 2 / 3,
                              ),
                              itemCount: filterProducts.isEmpty? productList.length : filterProducts.length,
                              itemBuilder: (context, index) {
                                return CustomCardProduct(
                                  backgroundColor:
                                      AppColors.myWhite.withOpacity(0.3),
                                  product: filterProducts.isEmpty? productList[index] : filterProducts[index],
                                  onTap: (details) async {
                                    double dx = details.globalPosition.dx;
                                    double dy = details.globalPosition.dy;
                                    double dx2 =
                                        MediaQuery.of(context).size.width - dx;
                                    double dy2 =
                                        MediaQuery.of(context).size.height - dy;
                                    await showMenu(
                                        context: context,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        position: RelativeRect.fromLTRB(
                                            dx, dy, dx2, dy2),
                                        items: [
                                          PopupMenuItem(
                                            value: 'Edit',
                                            child: const Text('Edit'),
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, editProductView,
                                                  arguments:
                                                      productList[index]);
                                            },
                                          ),
                                          PopupMenuItem(
                                            value: 'Delete',
                                            child: const Text('Delete'),
                                            onTap: () async {
                                              await StoreService()
                                                  .deleteProduct(
                                                      id: productList[index]
                                                          .id!);
                                            },
                                          ),
                                        ]);
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
