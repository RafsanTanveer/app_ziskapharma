// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class Loginscreen extends StatefulWidget {
  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  void _loginPressed(BuildContext context) async {
    // Navigator.pushReplacementNamed(context, '/mainmgt');
    print("Login pressed*****************************************************");

    final String userUID = userTxtCntrl.text;
    final String userPws = passTxtCntrl.text;

    final body = json.encode({
      "Table1": [
        {"user_UID": userUID, "user_Pws": userPws}
      ]
    });

    try {
      final url = Uri.parse(
          // 'http://10.0.2.2:65143/api/LogIn/Proc_UserCheckYesNoByApiDataSet');
          // 'http://192.168.0.106:65143/api/LogIn/Proc_UserCheckYesNoByApiDataSet');
      'http://localhost:65143/api/LogIn/Proc_UserCheckYesNoByApiDataSet');

      print(url);

      final response = await http.post(
        url,
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Credentials": 'true',
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Content-Type": "application/json",
          "Access-Control-Allow-Methods": "POST, OPTIONS"
        },
        body: body,
      );

      print('response  ----------------------------------------------------- ');
      print(response.body);

      final responseData = await json.decode(json.encode(response.body));
      print(responseData);


      if (responseData=='true') {
        Navigator.pushReplacementNamed(context, '/mainmgt');
      } else {}
    } catch (e) {
      print('error  ((((((((((((((((((((()))))))))))))))))))))');
      print(e);
    }
  }

  final userTxtCntrl = TextEditingController();
  final passTxtCntrl = TextEditingController();

  @override
  void dispose() {
    userTxtCntrl.dispose();
    passTxtCntrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Galaxy Pharma App',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: MediaQuery.of(context).size.height * .024),
        ),
        backgroundColor: Colors.greenAccent[400],
        actions: [
          IconButton(
            icon: Image.asset('assets/images/alifsoftlogo.jpg'),
            onPressed: () => {},
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              _inputField(context),
              _forgotPassword(context),
              _signup(context),
            ],
          ),
        ),
      ),
    );
  }

  _header(context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      height: height * .13,
      width: width * .3,
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.purple,
        border: Border.all(),
        borderRadius: BorderRadius.all(Radius.circular(11.0)),
      ), //             <--- BoxDecoration here
      child: Text(
        "Galaxy Pharma ERP",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: height * .022,
            color: Colors.white,
            fontWeight: FontWeight.w900),
      ),
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: userTxtCntrl,
          decoration: InputDecoration(
              hintText: "User Id",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
              filled: true,
              prefixIcon: Icon(Icons.person)),
        ),
        SizedBox(height: 10),
        TextField(
          controller: passTxtCntrl,
          decoration: InputDecoration(
            hintText: "Password",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            prefixIcon: Icon(Icons.person),
          ),
          obscureText: true,
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () => _loginPressed(context),
          child: Text(
            "SIGN IN",
            style: TextStyle(fontSize: 20),
          ),
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            padding: EdgeInsets.symmetric(vertical: 16),
          ),
        )
      ],
    );
  }

  _forgotPassword(context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Image.asset(
          'assets/images/ziskaPharmaIcon.png',
          height: width * .3,
          width: width * .3,
        ),
        Text(
          'Ziska Pharmaceuticals Ltd.',
          style:
              TextStyle(fontSize: height * .023, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  _signup(context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/alifsoft.PNG',
          //  height: width * .2,
          //   width: width * .2,
        ),
        Text(
          "Developed By : Alif Soft ",
          style:
              TextStyle(fontSize: height * .023, fontWeight: FontWeight.w500),
        ),
        Text(
          "Mobile No : +88-01817042056 ",
          style:
              TextStyle(fontSize: height * .017, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
