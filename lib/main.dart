import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter_app/providers/cart_provider.dart';
import 'package:shop_flutter_app/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        title: 'Shopping App',
        theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(36, 89, 181, 1),
          ),
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            hintStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            prefixIconColor: Color.fromRGBO(119, 119, 119, 1),
          ),
          chipTheme: ChipThemeData(
            labelStyle: const TextStyle(
              color: Color.fromRGBO(36, 89, 181, 1),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              side: const BorderSide(
                color: Color.fromRGBO(36, 89, 181, 1),
              ),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
            titleMedium: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            bodySmall: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
