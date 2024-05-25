import 'package:flutter/material.dart';

class Areasetting extends StatelessWidget {
  const Areasetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('This is area settins screen'),
            OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/loging");
                },
                child: Text('Login screen'))
          ],
        ),
      )),
    );
  }
}
