import 'dart:async';

import 'package:budgetbuddy/provider/sign_in_provider.dart';
import 'package:budgetbuddy/utils/next_screen.dart';
import 'package:budgetbuddy/views/home/home_view.dart';
import 'package:budgetbuddy/views/login/get_started_view.dart';
// import 'package:budgetbuddy/views/login/get_started_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    final sp = context.read<SingInProvider>();
    super.initState();
    Timer(const Duration(seconds: 2), () {
      sp.isSignedIn == false
          ? nextScreen(context, const GetStartedPage())
          : nextScreen(context, const HomePageView());
    });
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          'images/app_logo.png',
          height: 200,
          width: media.width,
        ),
      ),
    );
  }
}
