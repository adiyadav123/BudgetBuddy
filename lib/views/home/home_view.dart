// import 'package:budgetbuddy/common/color_extension.dart';
import 'package:budgetbuddy/provider/sign_in_provider.dart';
import 'package:budgetbuddy/utils/next_screen.dart';
import 'package:budgetbuddy/views/login/get_started_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  Future getData() async {
    final sp = context.read<SingInProvider>();
    sp.getDataFromSharedPreferences();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SingInProvider>();
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage("${sp.imageURL}"),
                radius: 50,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Welcome, ${sp.name}",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "${sp.email}",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "${sp.uid}",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "${sp.provider}",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  sp.userSignOut();
                  nextScreenReplace(context, const GetStartedPage());
                },
                child: Text("SignOut"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
