import 'dart:async';

import 'package:blog_todoapp/custom/ConstantColor.dart';
import 'package:blog_todoapp/screen/todo.dart';

import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TodoScreen()),
      );
    });

    return Scaffold(
      backgroundColor: primarycolor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'asset/applogo/todo.png',
                width: 200,
                height: 200,
              ),
            ),
            SizedBox(height: 40),
            Text(
              'Welcome to Todo',
              style: TextStyle(
                color: customwhite,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
