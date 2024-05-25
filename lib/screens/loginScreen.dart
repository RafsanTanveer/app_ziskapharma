import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('This is login screen'),
            OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/areasetting");
                },
                child: Text('Login screen'))
          ],
        ),
      )),
    );
  }
}
