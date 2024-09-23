import 'package:flutter/material.dart';
import 'package:market_devices/auth/widgets/custom_icon.dart';
import 'package:market_devices/constants/colors.dart';

class Headers extends StatelessWidget {
  const Headers({super.key, required this.title, this.isSignOut=false, this.onPressed});
  final String title;
  final bool? isSignOut ;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      height: 110,
      decoration: const BoxDecoration(color: AppColors.myGrey),
      alignment: Alignment.bottomLeft,
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding:const EdgeInsets.only(
              left: 16,
            ),
            child: Text(
              title,
              style:const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
         isSignOut!? Row(
            children: [
              CustomIcon(icon: Icons.logout,iconColor: Colors.white,
              onPressed: onPressed,
              ),
             const SizedBox(
                width: 10,
              ),
            ],
          ):const SizedBox(
            width: 0,)
        ],
      ),
    );
  }
}
