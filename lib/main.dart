import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_devices/app_router.dart';
import 'package:market_devices/firebase_options.dart';
import 'package:market_devices/home/bussnies_logic/card_cubit/card_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MarketDevicesApp());
}

class MarketDevicesApp extends StatelessWidget {
  const MarketDevicesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CardCubit()..getProducts(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRouter().generateRoute),
    );
  }
}
