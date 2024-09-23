import 'package:flutter/material.dart';
import 'package:market_devices/constants/colors.dart';
import 'package:market_devices/splash/widgets/splash_view_body.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.myWhite,
      body:  SplashViewBody(),
    );
  }
}