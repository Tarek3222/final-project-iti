import 'package:flutter/material.dart';
import 'package:market_devices/auth/widgets/custom_button.dart';
import 'package:market_devices/auth/widgets/custom_text_form_field.dart';
import 'package:market_devices/constants/colors.dart';
import 'package:market_devices/constants/strings.dart';
import 'package:market_devices/functions/show_snack_bar.dart';
import 'package:market_devices/models/product_model.dart';
import 'package:market_devices/services/product_services.dart';

class EditProductForm extends StatefulWidget {
  const EditProductForm({super.key, required this.productModel});
  final ProductModel productModel;

  @override
  State<EditProductForm> createState() => _EditProductFormState();
}

class _EditProductFormState extends State<EditProductForm> {
  String? productName,
      productDescription,
      productImageLocation,
      productPrice,
      productQuantity;
  String productCategory = kCategories[0];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          CustomTextFormField(
            colorTheme: AppColors.myWhite,
            hintText: widget.productModel.name,
            onChanged: (data) {
              productName = data;
            },
          ),
          const SizedBox(
            height: 15,
          ),
          CustomTextFormField(
            colorTheme: AppColors.myWhite,
            inputType: TextInputType.number,
            hintText: widget.productModel.price,
            onChanged: (data) {
              productPrice = data;
            },
          ),
          const SizedBox(
            height: 15,
          ),
          CustomTextFormField(
            colorTheme: AppColors.myWhite,
            hintText: widget.productModel.description,
            onChanged: (data) {
              productDescription = data;
            },
          ),
          const SizedBox(
            height: 15,
          ),
          const SizedBox(
            height: 15,
          ),
          CustomTextFormField(
            colorTheme: AppColors.myWhite,
            inputType: TextInputType.number,
            hintText: widget.productModel.quantity,
            onChanged: (data) {
              productQuantity = data;
            },
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'Category : ',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: DropdownButtonFormField(
                    iconEnabledColor: Colors.white,
                    dropdownColor: AppColors.myGrey,
                    value: widget.productModel.category,
                    items: [
                      for (final category in kCategories)
                        DropdownMenuItem(
                          value: category,
                          child: Text(
                            category,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        productCategory = value!;
                        widget.productModel.category = productCategory;
                      });
                    }),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: CustomButton(
              text: 'Submit',
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  update();
                  Navigator.pop(context);
                  showSnackBar(context, 'Product updated', Colors.green);
                } 
              },
            ),
          )
        ],
      ),
    );
  }
  update() async{
    ProductModel productModel = ProductModel(
      name: productName ??widget.productModel.name,
      price: productPrice ??widget.productModel.price,
      description: productDescription ??widget.productModel.description,
      category: productCategory ,
      quantity: productQuantity ??widget.productModel.quantity,
      image: productImageLocation ??widget.productModel.image,
      id: widget.productModel.id
    );
   await StoreService().updateProduct(product: productModel);
  }
}
