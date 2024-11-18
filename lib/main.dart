import 'package:first/signup.dart';
import 'package:flutter/material.dart';
import 'package:first/login.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'signup',
    routes: {'signup' : (context) => const SignupScreen()},
  ));
}







