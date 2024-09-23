// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:market_devices/auth/widgets/custom_button.dart';
import 'package:market_devices/auth/widgets/custom_text_form_field.dart';
import 'package:market_devices/constants/colors.dart';
import 'package:market_devices/constants/strings.dart';
import 'package:market_devices/functions/show_snack_bar.dart';
import 'package:market_devices/services/auth_services.dart';
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isObscure = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? email, password;
  String passwordAdmin = 'admin7';
  String emailAdmin='smartdevice7@gmail.com';
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Form(
        key: formKey,
        autovalidateMode: autovalidateMode,
        child: Column(
          children: [
            CustomTextFormField(
              colorTheme: AppColors.myGrey,
              hintText: 'Enter your email',
              label: 'Email',
              inputType: TextInputType.emailAddress,
              suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.email,
                  color: AppColors.kPrimaryColor,
                ),
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter your email';
                }
                return null;
              },
              onChanged: (data) {
                email = data;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              colorTheme: AppColors.myGrey,
              hintText: 'Enter your Password',
              label: 'Password',
              inputType: TextInputType.visiblePassword,
              obscureText: isObscure,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                icon: Icon(
                  isObscure ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.kPrimaryColor,
                ),
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter your password';
                }
                return null;
              },
              onChanged: (data) {
                password = data;
              },
            ),
            const SizedBox(
              height: 40,
            ),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : CustomButton(
                    text: 'Login',
                    onPressed: () async {
                      await validateUser(context);
                    }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don\'t have an account?',
                  style: TextStyle(color: AppColors.kPrimaryColor),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, signUpView);
                    },
                    child: const Text(
                      'SignUp',
                      style: TextStyle(color: Colors.black),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  validateUser(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        setState(() {
          isLoading = true;
        });
        final user = await AuthService()
            .signIn(email: email!.trim(), password: password!.trim());
        
          if (email == emailAdmin && password == passwordAdmin) {
            Navigator.pushReplacementNamed(context, adminView);
          } else {
            Navigator.pushReplacementNamed(context, homeView);
          }
      } on FirebaseAuthException catch (e) {
        showSnackBar(
          context,
          e.message.toString(),
          Colors.red,
        );
      } catch (e) {
        showSnackBar(context, e.toString(), Colors.red);
      }
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });
    }
  }
}
