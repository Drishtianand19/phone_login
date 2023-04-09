import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:phonelogin/screens/home_screen.dart';
import 'package:phonelogin/screens/user_info.dart';
import 'package:phonelogin/utils/utils.dart';
import 'package:phonelogin/widget/custom_button.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.verificationId});
  final String verificationId;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? otpcode;
  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
        body: SafeArea(
            child: isLoading == true
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.purple,
                    ),
                  )
                : Center(
                    child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 25, horizontal: 35),
                    child: Column(children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Icon(Icons.arrow_back),
                        ),
                      ),
                      Lottie.asset(
                        'assets/register.json',
                        height: 150,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Verification",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Enter the OTP send to your phone number",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Pinput(
                        length: 6,
                        showCursor: true,
                        defaultPinTheme: PinTheme(
                            width: 60,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.purple.shade100)),
                            textStyle: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            )),
                        onCompleted: (value) {
                          setState(() {
                            otpcode = value;
                          });
                          print(otpcode);
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: CustomButton(
                          text: "Verify",
                          onPressed: () {
                            if (otpcode != null) {
                              verifyOtp(context, otpcode!);
                            } else {
                              showSnackBar(context, "Enter 6-Digit code");
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("Didn't receive any code?",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black38,
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("Resend New Code",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                          ))
                    ]),
                  ))));
  }

  void verifyOtp(BuildContext context, String userOtp) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ap.verifyOtp(
      context: context,
      verificationid: widget.verificationId,
      userOtp: userOtp,
      onSuccess: () {
// checking whether user exists in the database
        ap.checkExistingUser().then((value) async {
          if (value == true) {
            //user exists in our app
            ap.getDataFromFirestore().then(
                  (value) => ap.saveUserDataToSP().then(
                        (value) => ap.setSignIn().then(
                              (value) => Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomeScreen()),
                                  (route) => false),
                            ),
                      ),
                );
          } else {
            //new user
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const UserinfoScreen()),
                (route) => false);
          }
        });
      },
    );
  }
}
