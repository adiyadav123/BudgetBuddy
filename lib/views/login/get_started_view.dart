import 'package:budgetbuddy/common/color_extension.dart';
import 'package:budgetbuddy/common_widget/primary_button.dart';
import 'package:budgetbuddy/common_widget/secondary_boutton.dart';
import 'package:budgetbuddy/views/login/sign_in_view.dart';
import 'package:budgetbuddy/views/login/social_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({super.key});

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Image.asset(
            'images/welcome_screen.png',
            height: media.height,
            width: media.width,
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
              child: Column(
                children: [
                  Image.asset(
                    "images/app_logo.png",
                    width: media.width * 0.5,
                    fit: BoxFit.contain,
                  ),
                  Spacer(),
                  Text(
                    "Management made easy. Income made safe.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: TColor.white, fontSize: 14, fontFamily: "Inter"),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  PrimaryButton(
                    title: "Get started",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SocialLoginView(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SecondaryButton(
                      title: "I have an account.",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInView()));
                      })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
