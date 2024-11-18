import 'package:flutter/material.dart';
import 'package:first/myButton.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen ({Key? key}) : super (key:key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: SweepGradient(
                    colors: [ Colors.white, Colors.lightBlue.shade800],
                    center: Alignment.center
                )
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(left: 35, top: 130),
              child: const Text("Welcome\nBack!",
                style: TextStyle(color: Colors.white, fontSize: 36),),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: MediaQuery
                .of(context)
                .size
                .height * 0.5, right: 35, left: 35),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                      fillColor: Colors.blue.shade100,
                      filled: true,
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      fillColor: Colors.blue.shade100,
                      filled: true,
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                ),
                const SizedBox(height: 40),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: MyButton(
                        text: 'Login',
                        imageAsset: 'assets/Button.svg',
                        width: 25,
                        height: 30.0,
                        font: 24,
                      ),
                    ),
                    SizedBox(height: 30,),
                    Center(
                      child: MyButton(
                        text: 'Forgot password',
                        imageAsset: 'assets/Button.svg',
                        width: 25,
                        height: 30.0,
                        font: 24,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}