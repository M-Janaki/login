import 'dart:convert';
import 'dart:ui';
import 'package:login/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:another_flushbar/flushbar.dart';
import 'otp.dart';

class cpass extends StatefulWidget {
  const cpass({Key? key}) : super(key: key);

  @override
  State<cpass> createState() => _cpassState();
}

final _formKey = GlobalKey<FormState>();
// final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class _cpassState extends State<cpass> {
  TextEditingController user_id = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController CpasswordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    user_id = new TextEditingController(text: OTPPage.userid.toString());
  }

  void changepassword(String user_id, password) async {
    try {
      http.Response response = await http.post(
          Uri.parse(
              'https://vinsupinfotech.com/FMS/public/api/change_password'),
          body: {'user_id': user_id, 'password': password});
      if (response.statusCode == 200) {
        print('Password Changed Successfully');
        // Flushbar(
        //   title: 'Success',
        //   message: 'Password changed successful',
        //   backgroundColor: Color(0xff281537),
        //   duration: Duration(seconds: 10),
        // ).show(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(' Password Changed Successful'),
            backgroundColor: Color(0xff5C415D),
            duration: Duration(seconds: 1),
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => loginScreen(),
          ),
        );
      } else {
        print('failed');
        Flushbar(
          title: 'Check',
          message: 'Please check your User ID',
          backgroundColor: Color(0xff281537),
          duration: Duration(seconds: 10),
        ).show(context);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  bool _obscureText = true;
  bool _obscureText2 = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _toggle2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          // key: scaffoldKey,
          backgroundColor: Color(0xff281537),
          body: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Form(
                key: _formKey,
                child: Stack(
                  children: [
                    Positioned(
                      top: 200,
                      left: -100,
                      child: Container(
                        width: 300,
                        height: 300,
                        decoration: const BoxDecoration(
                          color: Color(0xff9E7BB5),
                          borderRadius: BorderRadius.all(
                            Radius.circular(150),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: -10,
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: const BoxDecoration(
                          color: Color(0x30cc33ff),
                          borderRadius: BorderRadius.all(
                            Radius.circular(100),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 80,
                          sigmaY: 80,
                        ),
                        child: Container(),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            _logo(),
                            const SizedBox(
                              height: 70,
                            ),
                            // _loginLabel(),
                            // _labelTextInput('UserID'),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'User ID',
                                  style: GoogleFonts.josefinSans(
                                    textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  controller: user_id,
                                  autovalidateMode: AutovalidateMode.always,
                                  // initialValue: OTPPage.userid.toString(),
                                  readOnly: true,
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                  cursorColor: Color(0xff67032F),
                                  decoration: InputDecoration(
                                    // prefixText: OTPPage.userid.toString(),
                                    // hintText: OTPPage.userid.toString(),
                                    suffixIcon: Icon(
                                      Icons.check,
                                      color: Colors.grey,
                                    ),
                                    hintStyle: GoogleFonts.josefinSans(
                                      textStyle: const TextStyle(
                                        color: Color(0xffc5d2e1),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20,
                                      ),
                                    ),
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xffdfe8f3)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 70,
                            ),
                            // _labelTextInput('Password'),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter password';
                                }
                                return null;
                              },
                              controller: passwordController,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                              cursorColor: Color(0xff67032F),
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xffdfe8f3)),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: _toggle,
                                    icon: Icon(
                                      _obscureText
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      // Icons.visibility_off,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  label: Text(
                                    'Password',
                                    style: GoogleFonts.josefinSans(
                                      textStyle: const TextStyle(
                                        color: Color(0xff8fa1b6),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                      ),
                                    ),
                                    // style: TextStyle(
                                    //   fontWeight: FontWeight.bold,
                                    //   color: Color(0xff564256),
                                    // ),
                                  )),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            // _labelTextInput("Re-typePassword"),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'retype your password';
                                }
                                return null;
                              },
                              cursorColor: Color(0xff67032F),
                              controller: CpasswordController,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                              obscureText: _obscureText2,
                              decoration: InputDecoration(
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xffdfe8f3)),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: _toggle2,
                                    icon: Icon(
                                      _obscureText2
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      // Icons.visibility_off,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  label: Text(
                                    'Conform Password',
                                    style: GoogleFonts.josefinSans(
                                      textStyle: const TextStyle(
                                        color: Color(0xff8fa1b6),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                      ),
                                    ),
                                    // style: TextStyle(
                                    //   fontWeight: FontWeight.bold,
                                    //   color: Color(0xff564256),
                                    // ),
                                  )),
                            ),
                            const SizedBox(
                              height: 90,
                            ),
                            Container(
                              width: double.infinity,
                              height: 60,
                              decoration: const BoxDecoration(
                                color: Color(0xff492352),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    if (passwordController.text !=
                                        (CpasswordController.text)) {
                                      Flushbar(
                                        title: 'Check',
                                        message:
                                            'Password does not match. Please re-type again.',
                                        backgroundColor: Color(0xff281537),
                                        duration: Duration(seconds: 10),
                                      ).show(context);
                                    } else {
                                      changepassword(user_id.text.toString(),
                                          passwordController.text.toString());
                                    }
                                  }
                                },
                                // ScaffoldMessenger.of(context).showSnackBar(
                                // SnackBar(
                                //   // duration: Duration(seconds: 1),
                                //   content: Text(
                                //     'Password does not match. Please re-type again.',
                                //     style: TextStyle(fontSize: 15.0),
                                //   ),
                                //   backgroundColor: Color(0xff5C415D),
                                // ),

                                child: Text(
                                  "Change password",
                                  style: GoogleFonts.josefinSans(
                                    textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 24,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 90,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _signUpLabel(String label, Color textColor) {
  return Text(
    label,
    style: GoogleFonts.josefinSans(
      textStyle: TextStyle(
        color: textColor,
        fontWeight: FontWeight.w800,
        fontSize: 18,
      ),
    ),
  );
}

// Widget _labelTextInput(String label) {
//   return
// }

// Widget _loginLabel() {
//   return Center(
//     child: Text(
//       "Reset Password",
//       style: GoogleFonts.josefinSans(
//         textStyle: const TextStyle(
//           color: Color(0xff9E7BB5),
//           fontWeight: FontWeight.w900,
//           fontSize: 34,
//         ),
//       ),
//     ),
//   );
// }

Widget _logo() {
  return Center(
    child: SizedBox(
      // child: Image.network("https://uilogos.co/img/logomark/kyan.png"),
      child: Image.asset("assets/res.png"),
      height: 250,
    ),
  );
}
