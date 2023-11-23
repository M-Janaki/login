import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:login/LoginScreen.dart';
import 'package:login/confirm%20password.dart';
import 'forgotScreen.dart';
import 'otp.dart';
import 'get_otp_res_data.dart';

class OTPPage extends StatefulWidget {
  static late var userid;
  const OTPPage({super.key});

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  void OTP(String email, otp) async {
    try {
      var getotpuri = Uri.https('www.vinsupinfotech.com',
          '/FMS/public/api/get_otp', {'email': email, 'otp': otp});
      debugPrint("${getotpuri}");
      http.Response response = await http.post(getotpuri);
      debugPrint("${response.body}");
      if (jsonDecode(response.body) == "OTP Invalid") {
        print('failed');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Color((0xff564256)),
            elevation: 10,
            behavior: SnackBarBehavior.floating,
            content: const Text(
              'Enter Valid Otp',
              style: TextStyle(color: Colors.white, fontSize: 19),
            ),
            action: SnackBarAction(
              label: 'Ok',
              textColor: Colors.yellow,
              onPressed: () {},
            ),
          ),
        );
      } else {
        try {
          var jsonDecodeResponse = jsonDecode(response.body);
          GetOtpResData getOtpResData =
              GetOtpResData.fromJson(jsonDecodeResponse);
          OTPPage.userid = getOtpResData.details?.userId;
          print(OTPPage.userid);
          if (getOtpResData.status == 'OTP Valid') {
            print("Otp Verified");
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => cpass(),
              ),
            );
          }
        } catch (e) {
          debugPrint(e.toString());
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
  //   http.Response response = await http.post(
  //       Uri.parse('https://vinsupinfotech.com/FMS/public/api/get_otp'),
  //       body: {'email': email, 'otp': otp});
  //   debugPrint("${response.body}");
  //   if (response.statusCode == 200) {
  //     var data = jsonDecode(response.body.toString());
  //     print(data['token']);
  //     print('otp verify successfully');
  //     if (response.reasonPhrase == 'OTP Valid') {
  //       print('Correct otp');
  //       Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(
  //           builder: (context) => cpass(),
  //         ),
  //       );
  //     }
  //   } else {
  //     print('failed');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         duration: Duration(seconds: 1),
  //         content: Text(
  //           'Enter a valid OTP',
  //           style: TextStyle(fontSize: 15.0),
  //         ),
  //         backgroundColor: Color(0xff564256),
  //       ),
  //     );
  //   }
  // } catch (e) {
  //   print(e.toString());
  // }

  bool invalidOtp = false;
  int resendTime = 60;
  late Timer countdownTimer;
  TextEditingController txt1 = TextEditingController();
  TextEditingController txt2 = TextEditingController();
  TextEditingController txt3 = TextEditingController();
  TextEditingController txt4 = TextEditingController();
  TextEditingController txt5 = TextEditingController();
  TextEditingController txt6 = TextEditingController();

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  startTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        resendTime = resendTime - 1;
      });
      if (resendTime < 1) {
        countdownTimer.cancel();
      }
    });
  }

  stopTimer() {
    if (countdownTimer.isActive) {
      countdownTimer.cancel();
    }
  }

  String strFormatting(n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff564256),
        centerTitle: true,
        title: Text(
          'OTP Verification',
          style: TextStyle(
              fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xff564256),
          Color(0xff564256),
          Color(0xff281537),
        ])),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Container(
                  width: 200,
                  child: Image(
                      image: AssetImage(
                    'assets/otp.png',
                  )),
                ),
              ),
              Text(
                'Enter the 6 digit verification code received',
                style: TextStyle(fontSize: 30, color: Color(0xFFFFAB91)),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  myInputBox(context, txt1),
                  myInputBox(context, txt2),
                  myInputBox(context, txt3),
                  myInputBox(context, txt4),
                  myInputBox(context, txt5),
                  myInputBox(context, txt6)
                ],
              ),
              SizedBox(height: 0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text(
                  //   "Haven't received OTP yet?",
                  //   style: TextStyle(fontSize: 18, color: Colors.white),
                  // ),
                  // SizedBox(width: 10),
                  // resendTime == 0
                  //     ? InkWell(
                  //         onTap: () {
                  //           // Resend OTP Code
                  //           invalidOtp = false;
                  //           resendTime = 60;
                  //           startTimer();
                  //           //
                  //         },
                  //         child: TextButton(
                  //           onPressed: () {},
                  //           child: Text(
                  //             'Resend',
                  //             style: TextStyle(color: Colors.red, fontSize: 18),
                  //           ),
                  //         ),
                  //       )
                  //     : SizedBox()
                ],
              ),
              // const SizedBox(height: 10),
              // resendTime != 0
              //     ? Text(
              //         'You can resend OTP after ${strFormatting(resendTime)} second(s)',
              //         style: TextStyle(fontSize: 20, color: Colors.white),
              //       )
              //     : SizedBox(),
              // SizedBox(height: 1),
              // Text(
              //   invalidOtp ? 'Invalid otp!' : '',
              //   style: const TextStyle(fontSize: 20, color: Colors.red),
              // ),
              // const SizedBox(height: 0),
              ElevatedButton(
                onPressed: () {
                  if (txt1.text.isEmpty ||
                      txt2.text.isEmpty ||
                      txt3.text.isEmpty ||
                      txt4.text.isEmpty ||
                      txt5.text.isEmpty ||
                      txt6.text.isEmpty) {
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(
                    //     duration: Duration(seconds: 1),
                    //     content: Text(
                    //       'Account not register',
                    //       style: TextStyle(fontSize: 20.0),
                    //     ),
                    //     backgroundColor: Color(0xff7325A3),
                    //   ),
                    // );
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text("Alert",
                            style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold)),
                        content: const Text("Enter OTP"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                            child: Container(
                              // color: Colors.green,
                              height: 70,
                              width: 100,
                              padding: const EdgeInsets.all(14),
                              child: const Text(
                                "okay",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                    print('Enter otp');
                  } else {
                    final otp = (txt1.text +
                        txt2.text +
                        txt3.text +
                        txt4.text +
                        txt5.text +
                        txt6.text);
                    OTP(forgot.emailController.text.toString(), otp.toString());
                  }

                  //
                },
                child: Text(
                  'Verify',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    minimumSize: Size.fromHeight(0),
                    backgroundColor: Colors.redAccent),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget myInputBox(BuildContext context, TextEditingController controller) {
  return Container(
    height: 60,
    width: 50,
    decoration: BoxDecoration(
      border: Border.all(width: 4),
      color: Colors.white,
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
    ),
    child: TextField(
      controller: controller,
      maxLength: 1,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 35),
      decoration: InputDecoration(
        counterText: '',
      ),
      onChanged: (value) {
        if (value.length == 1) {
          FocusScope.of(context).nextFocus();
        }
      },
    ),
  );
}
