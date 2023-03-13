import 'package:flutter/material.dart';
import 'package:theming/providers/auth_provider.dart';
import 'package:theming/providers/count_provider.dart';
import 'package:provider/provider.dart';
import 'package:theming/providers/example_one_provider.dart';
import 'package:theming/providers/favorite_provider.dart';
import 'package:theming/screens/count_stless.dart';
import 'package:theming/screens/example_one.dart';
import 'package:theming/screens/favourite/favorite_screen.dart';
import 'package:theming/screens/login_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CountProvider()),
          ChangeNotifierProvider(create: (_) => ExampleOneProvider()),
          ChangeNotifierProvider(create: (_) => FavoriteProvider()),
          ChangeNotifierProvider(create: (_) => AuthProvider())
        ],
        child: MaterialApp(
            title: 'MyApp',
            theme: ThemeData(primarySwatch: Colors.cyan),
            home: const LoginScreen()));
  }
}
