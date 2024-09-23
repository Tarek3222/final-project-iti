
import 'package:flutter/material.dart';
import 'package:market_devices/constants/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
  });
  final String text;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient:const LinearGradient(
            colors: [
              Color(0xff5A5A5A),
              AppColors.myGrey,
            ],
            begin: Alignment.centerLeft,
              end: Alignment.centerRight,
          ),
        ),
        child:  Center(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
