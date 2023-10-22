import 'package:budgetbuddy/provider/internet_provider.dart';
import 'package:budgetbuddy/provider/sign_in_provider.dart';
import 'package:budgetbuddy/utils/next_screen.dart';
import 'package:budgetbuddy/utils/snack_bar.dart';
import 'package:budgetbuddy/views/home/home_view.dart';
import 'package:budgetbuddy/views/login/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../common/color_extension.dart';
import '../../common_widget/secondary_boutton.dart';

class SocialLoginView extends StatefulWidget {
  const SocialLoginView({super.key});

  @override
  State<SocialLoginView> createState() => _SocialLoginViewState();
}

class _SocialLoginViewState extends State<SocialLoginView> {
  final RoundedLoadingButtonController googleController =
      RoundedLoadingButtonController();
  final RoundedLoadingButtonController facebookController =
      RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: TColor.gray,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("images/app_logo.png",
                  width: media.width * 0.5, fit: BoxFit.contain),
              const Spacer(),
              RoundedLoadingButton(
                  controller: googleController,
                  onPressed: () {},
                  successColor: Colors.black,
                  elevation: 0,
                  color: const Color.fromARGB(255, 66, 66, 66),
                  width: media.width * 0.80,
                  child: const Wrap(
                    children: [
                      Icon(
                        FontAwesomeIcons.apple,
                        size: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Sign up with Apple")
                    ],
                  )),
              const SizedBox(
                height: 15,
              ),
              // InkWell(
              //   onTap: () {},
              //   child: Container(
              //     height: 50,
              //     decoration: BoxDecoration(
              //         image: const DecorationImage(
              //           image: AssetImage("images/google_btn.png"),
              //         ),
              //         borderRadius: BorderRadius.circular(30),
              //         boxShadow: [
              //           BoxShadow(
              //               color: Colors.white.withOpacity(0.2),
              //               blurRadius: 8,
              //               offset: const Offset(0, 4))
              //         ]),
              //     alignment: Alignment.center,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Image.asset(
              //           "images/google.png",
              //           width: 15,
              //           height: 15,
              //           color: TColor.gray,
              //         ),
              //         const SizedBox(
              //           width: 8,
              //         ),
              //         Text(
              //           "Sign up with Google",
              //           style: TextStyle(
              //               color: TColor.gray,
              //               fontSize: 14,
              //               fontWeight: FontWeight.w600),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              RoundedLoadingButton(
                controller: googleController,
                onPressed: () {
                  handleGoogleSignIn();
                },
                successColor: Colors.red,
                color: Colors.red,
                elevation: 0,
                width: media.width * 0.80,
                child: const Wrap(
                  children: [
                    Icon(
                      FontAwesomeIcons.google,
                      size: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Sign up with Google")
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              RoundedLoadingButton(
                controller: facebookController,
                onPressed: () {},
                successColor: Colors.blue,
                width: media.width * 0.80,
                elevation: 0,
                color: Colors.blue,
                child: const Wrap(
                  children: [
                    Icon(
                      FontAwesomeIcons.facebook,
                      size: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Sign up with Facebook")
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                "or",
                textAlign: TextAlign.center,
                style: TextStyle(color: TColor.white, fontSize: 14),
              ),
              const SizedBox(
                height: 25,
              ),
              SecondaryButton(
                title: "Sign up with E-mail",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpView()));
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "By registering, you agree to our Terms of Use. Learn how we collect, use and share your data.",
                textAlign: TextAlign.center,
                style: TextStyle(color: TColor.white, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future handleGoogleSignIn() async {
    final sp = context.read<SingInProvider>();
    final ip = context.read<InternetProvider>();

    await ip.checkInternetConnection();

    if (ip.hasInternet == false) {
      openSnackar(context, "Check Your Internet Connections", Colors.red);
      googleController.reset();
    } else {
      await sp.signInWithGoogle().then((value) {
        if (sp.hasError) {
          openSnackar(context, sp.errorCode.toString(), Colors.red);
          googleController.reset();
        } else {
          sp.checkUserExists().then((value) async {
            if (value == true) {
              await sp.getDataFromFirestore(sp.uid).then((value) => sp
                  .saveDataToSharedPreferences()
                  .then((value) => sp.setSignIn().then((value) {
                        googleController.success();
                        handleAfterSignIn();
                      })));
            } else {
              sp.saveDataToFirestore().then((value) => sp
                  .saveDataToSharedPreferences()
                  .then((value) => sp.setSignIn().then((value) {
                        googleController.success();
                        handleAfterSignIn();
                      })));
            }
          });
        }
      });
    }
  }

  handleAfterSignIn() {
    Future.delayed(const Duration(milliseconds: 1000)).then((value) {
      nextScreen(context, const HomePageView());
    });
  }
}
