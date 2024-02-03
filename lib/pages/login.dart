import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/pages/home.dart';
import 'package:flutter_firebase_login/pages/register.dart';

import '../dao/authentication_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
      ),
      body: SingleChildScrollView(
       // physics: const NeverScrollableScrollPhysics(),
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/images/background.jpg",
                  ),
                  fit: BoxFit.fill)),
          child: Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(0, 0, 0, 1).withAlpha(5),
                      borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                    ),
                    child: SafeArea(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            const SizedBox(
                              height: 10.0,
                            ),
                            TextFormField(
                              controller: _emailController,
                              // style: TextStyle,
                              maxLength: 30,
                              decoration: const InputDecoration(
                                  labelText: "User Email",
                                  hintText: "Enter User Email"),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter email";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,

                              // style: TextStyle,
                              maxLength: 8,
                              decoration: const InputDecoration(
                                  labelText: "User Password",
                                  hintText: "Enter User Password"),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter password";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              color: Colors.black45,
                              child: TextButton(
                                onPressed: () {
                                  _signInUser();
                                },
                                child: const Text("Login"),
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              color: Colors.black45,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RegisterPage()));
                                },
                                child: const Text("Register Login"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )),
        ),
      )
    );
  }

  void _signInUser() {
    if(_formKey.currentState!.validate()){
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Authentication User")));

      String email = _emailController.value.text;
      String password = _passwordController.value.text;
      //getting email and password from text controller

      //authenticating user
      AuthenticationHelper()
          .signIn(email: email,password: password)
      .then((result){
        if(result==null){
          void user =AuthenticationHelper().user;
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Login Success")));
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
        }else{
          ScaffoldMessenger.of(context)
              .showSnackBar( SnackBar(content: Text(result)));
        }
      });
    }else{
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Input Error")));
    }
  }
}
