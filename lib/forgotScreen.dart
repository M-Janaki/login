import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'otp.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class forgot extends StatefulWidget {
  static TextEditingController emailController = TextEditingController();
  @override
  State<forgot> createState() => _forgotState();
}

class _forgotState extends State<forgot> {
  final _formKey = GlobalKey<FormState>();

  void ForgotPassword(String email) async {
    try {
      http.Response response = await http.post(
          Uri.parse('https://vinsupinfotech.com/FMS/public/api/forgot'),
          body: {
            'email': email,
          });
      if (response.statusCode == 200) {
        print('Forget Password Sucessfully ');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => OTPPage()));
      } else {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Alert",
                style: TextStyle(
                    color: Colors.purple,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold)),
            content: const Text("Enter Registered mail id"),
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
        print('failed');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        centerTitle: true,
        backgroundColor: Color(0xff856088),
        // automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black38,
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 60, left: 40, right: 40),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xff564256),
          Color(0xff564256),
          Color(0xff281537),
        ])),
        child: ListView(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          width: 200,
                          height: 200,
                          child: Image.asset("assets/forg.png"),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Do not worry !  We Will help you recover your password",
                          style: TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: forgot.emailController,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: "Enter Your E-mail",
                            suffixIcon: Icon(
                              Icons.email,
                              color: Color(0xff9E7BB5),
                            ),
                            labelStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                          ),
                          // style: const TextStyle(fontSize: 20),
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return "* Enter Your Valid Email Id";
                          //   } else {
                          //     return null;
                          //   }
                          // },
                          validator: (email) =>
                              email != null && !EmailValidator.validate(email)
                                  ? 'Enter a valid email'
                                  : null,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 60,
                          alignment: Alignment.centerLeft,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.3, 1],
                              colors: [
                                Color(0xff67032F),
                                Color(0XFFF92B7F),
                              ],
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                          ),
                          child: SizedBox.expand(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff9E7BB5),
                              ),
                              child: Text(
                                "Continue",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  ForgotPassword(
                                    forgot.emailController.text.toString(),
                                  );
                                  print("Submited");
                                }

                                // Navigator.push(
                                //   context,
                                //   PageRouteBuilder(
                                //     pageBuilder: (c, a1, a2) => const OTPPage(),
                                //     transitionsBuilder: (c, anim, a2, child) =>
                                //         FadeTransition(
                                //             opacity: anim, child: child),
                                //     transitionDuration:
                                //         const Duration(milliseconds: 1000),
                                //   ),
                                // );
                              },
                            ),
                          ),
                        ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
