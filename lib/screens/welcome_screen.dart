import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:phonelogin/provider/auth_provider.dart';
import 'package:phonelogin/screens/register_screen.dart';
import 'package:phonelogin/widget/custom_button.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 25, horizontal: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/register.json'),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Let's get started",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Never a better time than now to start",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              //custom button
              SizedBox(
                width: double.infinity, //unlimited space is available
                height: 50,
                child: CustomButton(
                  text: 'Get Started',
                  onPressed: () {
                    ap.isSignedIn == true//when true , then fetch shared preferenced data
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()))
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()));
                  },
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
