// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:market_devices/admin/views/add_product_view.dart';
import 'package:market_devices/admin/views/admin_view.dart';
import 'package:market_devices/admin/views/edit_product_view.dart';
import 'package:market_devices/admin/views/manage_product_view.dart';
import 'package:market_devices/auth/views/log_in_view.dart';
import 'package:market_devices/auth/views/sign_up_view.dart';
import 'package:market_devices/constants/strings.dart';

import 'package:market_devices/home/views/card_view.dart';
import 'package:market_devices/home/views/details_product_info.dart';
import 'package:market_devices/home/views/home_view.dart';
import 'package:market_devices/home/views/product_by_category.dart';
import 'package:market_devices/home/views/profile_view.dart';
import 'package:market_devices/models/product_model.dart';
import 'package:market_devices/splash/views/splash_view.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashView:
        return MaterialPageRoute(
          builder: (_) => const SplashView(),
        );
      case loginView:
        return MaterialPageRoute(
          builder: (_) => const LogInView(),
        );
      case signUpView:
        return MaterialPageRoute(
          builder: (_) => const SignUpView(),
        );
      case homeView:
        return MaterialPageRoute(
          builder: (_) => const HomeView(),
        );
      case adminView:
        return MaterialPageRoute(
          builder: (_) => const AdminView(),
        );
      case editProductView:
        ProductModel productModel = settings.arguments as ProductModel;
        return MaterialPageRoute(
          builder: (_) => EditProductView(
            productModel: productModel,
          ),
        );
      case addProductView:
        return MaterialPageRoute(
          builder: (_) => const AddProductView(),
        );
      case manageProductView:
        return MaterialPageRoute(
          builder: (_) => const ManageProductView(),
        );
      case productInfo:
        ProductModel productModel = settings.arguments as ProductModel;
        return MaterialPageRoute(
          builder: (_) => DetailsProductInfo(
            product: productModel,
          ),
        );
      case profileView:
        return MaterialPageRoute(
          builder: (_) => const ProfileView(),
        );
      case productByCategoryView:
        String category = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => ProductByCategory(
            categoryName: category,
          ),
        );
      case cardView:
        return MaterialPageRoute(
          builder: (_) => const CardView(),
        );
    }
  }
}
