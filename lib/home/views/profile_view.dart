// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:market_devices/auth/widgets/custom_button.dart';
import 'package:market_devices/auth/widgets/custom_text_form_field.dart';
import 'package:market_devices/constants/colors.dart';
import 'package:market_devices/constants/strings.dart';
import 'package:market_devices/functions/show_snack_bar.dart';
import 'package:market_devices/models/user_model.dart';
import 'package:market_devices/services/cloud_store_users.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String updateEmail = '';
  String updateName = '';
  String updatePhone = '';
  String updateImage = '';

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    String email = user?.email ?? 'unknown';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: StreamBuilder(
          stream: CloudStoreUsers().getAllUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<UserModel> users = [];
              for (var doc in snapshot.data!.docs) {
                if (doc.get(kEmail) == email) {
                  users.add(UserModel(
                    name: doc.get(kName),
                    email: doc.get(kEmail),
                    password: doc.get(kPassword),
                    phone: doc.get(kPhone),
                    id: doc.id,
                    image: doc.get(kImage),
                  ));
                }
              }
              var all =
                  users.where((element) => element.email == email).toList();
              var userModel = all[0];
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final file = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (file == null) return;
                          String fileName =
                              DateTime.now().microsecondsSinceEpoch.toString();
                          // Create a reference to the location you want to upload to in Firebase Storage
                          Reference referenceRoot =
                              FirebaseStorage.instance.ref();
                          Reference referenceDirImages =
                              referenceRoot.child('images');
                          // Create a Reference to the file you want to upload
                          Reference referenceImageToUpload =
                              referenceDirImages.child(fileName);
                          // Upload the file to firebase
                          try {
                            await referenceImageToUpload
                                .putFile(File(file.path));
                            updateImage =
                                await referenceImageToUpload.getDownloadURL();
                            userModel.image = updateImage;
                            CloudStoreUsers().updateUser(user: userModel);
                            setState(() {});
                            showSnackBar(context, 'Image Updated',
                                AppColors.kPrimaryColor);
                          } catch (e) {
                            showSnackBar(context, e.toString(), Colors.red);
                          }
                        },
                        child: userModel.image != ''
                            ? CircleAvatar(
                              radius: 50,
                                backgroundImage: Image.network(
                                userModel.image,
                              ).image)
                            : const Icon(
                                Icons.person,
                                size: 60,
                              ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        colorTheme: AppColors.myGrey,
                        hintText: userModel.name,
                        inputType: TextInputType.name,
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.edit,
                            color: AppColors.kPrimaryColor,
                          ),
                        ),
                        onChanged: (data) {
                          updateName = data;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        colorTheme: AppColors.myGrey,
                        hintText: userModel.phone,
                        inputType: TextInputType.name,
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.edit,
                            color: AppColors.kPrimaryColor,
                          ),
                        ),
                        onChanged: (data) {
                          updatePhone = data;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        colorTheme: AppColors.myGrey,
                        hintText: userModel.email,
                        inputType: TextInputType.emailAddress,
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.edit,
                            color: AppColors.kPrimaryColor,
                          ),
                        ),
                        onChanged: (data) {
                          updateEmail = data;
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      CustomButton(
                        text: 'Update',
                        onPressed: () {
                          CloudStoreUsers().updateUser(
                            user: UserModel(
                              name: updateName.isNotEmpty?updateName:userModel.name,
                              email: updateEmail.isNotEmpty?updateEmail:userModel.email,
                              password: userModel.password,
                              phone: updatePhone.isNotEmpty?updatePhone:userModel.phone,
                              id: userModel.id,
                              image: updateImage.isNotEmpty?updateImage:userModel.image,
                            ),
                          );
                          showSnackBar(context, 'User data Updated', AppColors.kPrimaryColor);
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
