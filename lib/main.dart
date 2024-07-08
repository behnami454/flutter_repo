import 'package:flutter/material.dart';
import 'package:neuro/screens/home_screen.dart';
import 'package:neuro/screens/create_post_screen.dart';
import 'package:neuro/screens/splash_screen.dart';
import 'package:neuro/widgets/bloc_provider/bloc_providers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBlocProvider(
      child: MaterialApp(
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          '/home': (context) => const HomeScreen(),
          '/createPost': (context) => const CreatePostScreen(),
        },
      ),
    );
  }
}
