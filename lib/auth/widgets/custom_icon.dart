import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({super.key, required this.icon, this.onPressed, required this.iconColor});
  final Color iconColor;
  final IconData icon ;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child:  IconButton(onPressed:onPressed,icon: Icon(icon,size: 26,color:iconColor,)),
    );
  }
}