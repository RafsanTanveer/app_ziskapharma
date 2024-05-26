import 'package:flutter/material.dart';

class Userinfoscreen extends StatelessWidget {
  const Userinfoscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Info Edit',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.greenAccent[400],
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 20.0, left: 15, right: 15),
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Text(
                      'User Name : ',
                      textAlign: TextAlign.end,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(), hintText: ''),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Text(
                      'Password : ',
                      textAlign: TextAlign.end,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(), hintText: ''),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
