import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:login/LoginScreen.dart';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';

class RegScreen extends StatefulWidget {
  const RegScreen({Key? key}) : super(key: key);

  @override
  State<RegScreen> createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController CpasswordController = TextEditingController();

  // Register(String string) {
  //
  //     'name': nameController.text,
  //     'email': emailController.text,
  //     'password': passwordController.text,
  //     'c_password': CpasswordController.text,
  //
  // }

  void Register(String name, email, password, c_password) async {
    try {
      http.Response response = await http.post(
          Uri.parse('https://vinsupinfotech.com/FMS/public/api/register'),
          body: {
            'name': name,
            'email': email,
            'password': password,
            'c_password': c_password
          });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data['token']);
        print('Registeration successfully');
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          //thanks for watching
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xff564256),
                  Color(0xff281537),
                ]),
              ),
              child: const Padding(
                padding: EdgeInsets.only(top: 60.0, left: 22),
                child: Text(
                  'Create Your\nAccount',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  color: Colors.white,
                ),
                height: double.infinity,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          controller: nameController,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.check,
                                color: Colors.grey,
                              ),
                              label: Text(
                                'Full Name',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff564256),
                                ),
                              )),
                        ),
                        TextFormField(
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Please enter your E-mail';
                          //   }
                          //   return null;
                          // },
                          validator: (email) =>
                              email != null && !EmailValidator.validate(email)
                                  ? 'Enter a valid email'
                                  : null,
                          controller: emailController,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.check,
                                color: Colors.grey,
                              ),
                              label: Text(
                                ' Gmail',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff564256),
                                ),
                              )),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter password';
                            }
                            return null;
                          },
                          controller: passwordController,
                          textAlign: TextAlign.center,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
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
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff564256),
                                ),
                              )),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'retype your password';
                            }
                            return null;
                          },
                          controller: CpasswordController,
                          textAlign: TextAlign.center,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
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
                                'Conform Password',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff564256),
                                ),
                              )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 70,
                        ),
                        Container(
                          height: 55,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(colors: [
                              Color(0xff564256),
                              Color(0xff281537),
                            ]),
                          ),
                          child: Center(
                            child: TextButton(
                              onPressed: () {
                                Register(
                                    nameController.text.toString(),
                                    emailController.text.toString(),
                                    passwordController.text.toString(),
                                    CpasswordController.text.toString());

                                if (_formKey.currentState!.validate() &&
                                    passwordController.text ==
                                        CpasswordController.text) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: Duration(seconds: 1),
                                      content: Text(
                                        'Processing Data',
                                        style: TextStyle(fontSize: 20.0),
                                      ),
                                      backgroundColor: Color(0xff564154),
                                      shape: LinearBorder.start(),
                                    ),
                                  );
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => loginScreen(),
                                    ),
                                  );
                                } else if (passwordController.text !=
                                    CpasswordController.text) {
                                  // you can add your statements here
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      // duration: Duration(seconds: 1),
                                      content: Text(
                                        'Password does not match. Please re-type again.',
                                        style: TextStyle(fontSize: 15.0),
                                      ),
                                      backgroundColor: Color(0xff564154),
                                      shape: LinearBorder.start(),
                                    ),
                                  );
                                }

                                if (_formKey.currentState!.validate()) {
                                  print('form submiitted');
                                }
                              },
                              child: Text(
                                'SIGN IN',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Already have account?",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.grey),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => loginScreen()));
                                },
                                child: Text(
                                  "Sign up",
                                  style: TextStyle(

                                      ///done login page
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
