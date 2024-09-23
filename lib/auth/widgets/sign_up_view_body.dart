import 'package:flutter/material.dart';
import 'package:market_devices/auth/widgets/back_ground_login.dart';
import 'package:market_devices/auth/widgets/signup_form.dart';
import 'package:market_devices/constants/app_assets.dart';

class SignUpViewBody extends StatelessWidget {
  const SignUpViewBody({super.key,});


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
            children: [
              const BackGroundView(ratio: 0.3,),
              const Positioned(
                top: 89,
                left: 20,
                child: Text(
                  "Sign up",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white),
                ),
              ),
              const Positioned(
                top: 140,
                left: 20,
                child: Text(
                  "Create an account to get started",
                  style: TextStyle(fontSize: 13, color: Colors.white),
                ),
              ),
              Positioned(
                top: 102,
                left: 175,
                child: Image.asset(
                  AppAssets.authImage,
                  width: 180,
                  height: 200,
                ),
              ),
              const Positioned(
                top: 255,
                left: 20,
                right: 20,
                child: SignupForm(),
              ),
            ],
          ),
      ),
    );
  }
}