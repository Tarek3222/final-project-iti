// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:market_devices/auth/widgets/custom_button.dart';
import 'package:market_devices/auth/widgets/custom_text_form_field.dart';
import 'package:market_devices/constants/colors.dart';
import 'package:market_devices/constants/strings.dart';
import 'package:market_devices/functions/show_snack_bar.dart';
import 'package:market_devices/models/product_model.dart';
import 'package:market_devices/services/product_services.dart';
class AddProductForm extends StatefulWidget {
  const AddProductForm({super.key});

  @override
  State<AddProductForm> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  String? productName,
      productDescription,
      productImage,
      productPrice,
      productQuantity;
  String productCategory = kCategories[0];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: autovalidateMode,
      key: formKey,
      child: Column(  
        children: [
          const SizedBox(
            height: 50,
          ),
          CustomTextFormField(
            colorTheme: AppColors.myWhite,
            hintText: 'Product Name',
            onChanged: (data) {
              productName = data;
            },
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter product name';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 15,
          ),
          CustomTextFormField(
            colorTheme: AppColors.myWhite,
            inputType: TextInputType.number,
            hintText: 'Product Price',
            onChanged: (data) {
              productPrice = data;
            },
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter product price';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 15,
          ),
          CustomTextFormField(
            colorTheme: AppColors.myWhite,
            hintText: 'Product Description',
            onChanged: (data) {
              productDescription = data;
            },
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter product description';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 15,
          ),
          CustomTextFormField(
            colorTheme: AppColors.myWhite,
            inputType: TextInputType.number,
            hintText: 'Product Quantity',
            onChanged: (data) {
              productQuantity = data;
            },
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter product quantity';
              }
              return null;
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
                    dropdownColor: AppColors.kPrimaryColor,
                    value: productCategory,
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
                      });
                    }),
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                'Image: ',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 80,
              ),
              IconButton(
                onPressed: ()async {
                  final file=await ImagePicker().pickImage(source: ImageSource.gallery);
                  setState(() {
                    isLoading=true;
                  });
                  if(file==null) return;
                  String fileName=DateTime.now().microsecondsSinceEpoch.toString();
                  // Create a reference to the location you want to upload to in Firebase Storage
                  Reference referenceRoot=FirebaseStorage.instance.ref();
                  Reference referenceDirImages=referenceRoot.child('images');
                  // Create a Reference to the file you want to upload
                  Reference referenceImageToUpload=referenceDirImages.child(fileName);
                  // Upload the file to firebase
                  try{
                    await referenceImageToUpload.putFile(File(file.path));
                    productImage=await referenceImageToUpload.getDownloadURL();
                    setState(() {
                      isLoading=false;
                    });
                    showSnackBar(context, 'Image added', Colors.green);
                  }catch(e){
                    showSnackBar(context, e.toString(), Colors.red);
                  }
                },
                icon:isLoading?const CircularProgressIndicator():const  Icon(
                   Icons.add_a_photo_outlined,
                  color: Colors.white,
                  size: 26,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70),
            child: CustomButton(
              text: 'Add Product',
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  if(productImage==null){
                    showSnackBar(context, 'Please add image', Colors.red);
                    return;
                  }
                  addProduct();
                  formKey.currentState!.reset();
                  autovalidateMode = AutovalidateMode.disabled;
                  productImage=null;
                } else {
                  setState(() {
                    autovalidateMode = AutovalidateMode.always;
                  });
                }
              },
            ),
          )
        ],
      ),
    );
  }

  void addProduct() {
    ProductModel productModel = ProductModel(
      name: productName!,
      price: productPrice!,
      description: productDescription!,
      category: productCategory,
      quantity: productQuantity!,
      image: productImage!,
    );
    StoreService().addProduct(product: productModel);
    showSnackBar(context, 'Product added', Colors.green);
  }
}
