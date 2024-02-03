import 'dart:ui';
import 'package:flutter/material.dart';
import '../dao/authentication_helper.dart';
import 'login.dart';
import 'manage_user.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confPassController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confPassController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Register Page"),
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
                              TextFormField(
                                controller: _confPassController,
                                obscureText: true,
                                // style: TextStyle,
                                maxLength: 8,
                                decoration: const InputDecoration(
                                    labelText: "Confirm User Password",
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
                                    _signUpUser();
                                  },
                                  child: const Text("Register Login"),
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                color: Colors.black45,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                                  },
                                  child: const Text("Login"),
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

  //sign up user code
  void _signUpUser() {
    if(_formKey.currentState!.validate()){
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Registering User")));

      String email = _emailController.value.text;
      String password = _passwordController.value.text;
      String conPass = _confPassController.value.text;
      //getting email and password and conf password from text controller

      if(password ==  conPass){
        AuthenticationHelper()
            .signUp(email: email,password: password)
            .then((result){
          if(result==null){
            void user =AuthenticationHelper().user;
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("User Created")));
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
          }else{
            ScaffoldMessenger.of(context)
                .showSnackBar( SnackBar(content: Text(result)));
          }
        });
      }else{
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Password mismatch")));
      }


      //authenticating user
      // AuthenticationHelper()
      //     .signIn(email: email,password: password)
      //     .then((result){
      //   if(result==null){
      //     void user =AuthenticationHelper().user;
      //     ScaffoldMessenger.of(context)
      //         .showSnackBar(SnackBar(content: Text("Login Success")));
      //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
      //   }else{
      //     ScaffoldMessenger.of(context)
      //         .showSnackBar( SnackBar(content: Text(result)));
      //   }
      // });


    }else{
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Input Error")));
    }
  }
}
