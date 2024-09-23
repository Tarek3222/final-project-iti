// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:market_devices/constants/app_assets.dart';
import 'package:market_devices/constants/strings.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    navigateToLoginView();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        AppAssets.splashGif,
      ),
    );
  }
  void navigateToLoginView(){
    Future.delayed(const Duration(seconds: 3), (){
      Navigator.pushReplacementNamed(context, loginView);
    });
  }
}
