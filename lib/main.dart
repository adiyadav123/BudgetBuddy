import 'package:budgetbuddy/common/color_extension.dart';
import 'package:budgetbuddy/firebase_options.dart';
import 'package:budgetbuddy/provider/internet_provider.dart';
import 'package:budgetbuddy/provider/sign_in_provider.dart';
import 'package:budgetbuddy/views/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SingInProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => InternetProvider(),
        )
      ],
      child: MaterialApp(
        title: 'BudgetBuddy',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Inter",
          colorScheme: ColorScheme.fromSeed(
            seedColor: TColor.primary,
            background: TColor.gray80,
            primary: TColor.primary,
            primaryContainer: TColor.gray60,
            secondary: TColor.secondary,
          ),
          useMaterial3: false,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}