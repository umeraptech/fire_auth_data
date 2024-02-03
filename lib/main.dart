import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/firebase_options.dart';
import 'package:flutter_firebase_login/pages/home.dart';
import 'pages/login.dart';

 //void main()=> runApp(MyApp());

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 3, color:Colors.greenAccent
              )
          ),
          hintStyle: TextStyle(color: Colors.black),
          counterStyle: TextStyle(color: Colors.red,fontSize: 12.0),
          border: OutlineInputBorder(),
          labelStyle: TextStyle(color: Colors.black),
          errorStyle: TextStyle(color: Colors.yellow,fontSize: 12.0),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 3, color:Colors.brown
              )
          ),
        ),
      ),
    );
  }
}
