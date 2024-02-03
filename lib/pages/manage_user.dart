import 'dart:ui';

import 'package:flutter/material.dart';
import '../dao/authentication_helper.dart';


class ManageUserPage extends StatefulWidget {
  const ManageUserPage({Key? key}) : super(key: key);

  @override
  State<ManageUserPage> createState() => _ManageUserPageState();
}

class _ManageUserPageState extends State<ManageUserPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _fNameController;
  late TextEditingController _lNameController;
  late TextEditingController _cityController;

@override
  void initState() {
    // TODO: implement initState
    super.initState();

    _fNameController = TextEditingController();
    _lNameController = TextEditingController();
    _cityController = TextEditingController();


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
                                controller: _fNameController,
                                // style: TextStyle,
                                maxLength: 30,
                                decoration: const InputDecoration(
                                    labelText: "User First Name",
                                    hintText: "Enter First Name"),
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
                                controller: _lNameController,
                                // style: TextStyle,
                                maxLength: 30,
                                decoration: const InputDecoration(
                                    labelText: "User Last Name",
                                    hintText: "Enter User Last Name"),
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
                                controller: _cityController,
                                // style: TextStyle,
                                maxLength: 30,
                                decoration: const InputDecoration(
                                    labelText: "User City",
                                    hintText: "Enter User City"),
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
                              Container(
                                color: Colors.black45,
                                child: TextButton(
                                  onPressed: () {

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
}
