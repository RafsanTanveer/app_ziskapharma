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
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('This is login screen',style: TextStyle(backgroundColor: Colors.green),),
              ),
            ),
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
